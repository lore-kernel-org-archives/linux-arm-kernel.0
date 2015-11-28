From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Sat, 28 Nov 2015 09:05:56 +0100
Subject: [PATCH] null_blk: use sector_div instead of do_div
In-Reply-To: <4449032.oPBtpzlXyB@wuerfel>
References: <3768541.ja0r6f0Odi@wuerfel>
 <CA+55aFy=JjwmtNysByu822S2Av0sv_KUCLfa86tAz5K5Unwsmw@mail.gmail.com>
 <4449032.oPBtpzlXyB@wuerfel>
Message-ID: <56596064.2070306@bjorling.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2015 10:31 PM, Arnd Bergmann wrote:
> On Friday 27 November 2015 10:07:54 Linus Torvalds wrote:
>> On Fri, Nov 27, 2015 at 5:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> -       do_div(size, bs); /* convert size to pages */
>>> -       do_div(size, 256); /* concert size to pgs pr blk */
>>> +       sector_div(size, bs); /* convert size to pages */
>>> +       sector_div(size, 256); /* concert size to pgs pr blk */
>>
>> Ugh.
>>
>> Dividing by 256 should never be done with do_div() *or* sector-div.
>
> You are right, I missed what should have been an obvious simplification.
> FWIW, the division by 256 should now be optimized automatically when the
> new asm-generic do_div() implementation is used (which in turn caused
> the type mismatch warning that I'm trying to avoid). Of course that
> is no excuse for writing silly code like that, and it doesn't catch the
> cases where the argument is a power-of-two variable number.
>
> The first do_div() is also questionable: 'bs' is a global variable
> from a module parameter that defaults to 512 and is fixed to 4096
> when the device is used for lightnvm. I would guess that we run into
> bugs if this is ever set to a number that is not a power of two,
> smaller than 512, or larger than PAGE_SIZE.
>
>> Same goes for this, which is just obnoxiously idiotic:
>>
>>> -       do_div(size, (1 << 16));
>>> +       sector_div(size, (1 << 16));
>>
>> WTF? It explicitly divides by a particular power-of-two?
>>
>> Has nobody ever heard of expensive divide operations? Sure, for the
>> cases where we *don't* do this with inline asm etc because it's
>> already fairly cheap, the compiler will DTRT. But that "divide by (1
>> << 16)" is just a sign of insanity.
>>
>> Why is that not just
>>
>>      size >>= 16;
>>
>> instead, which is certainly not any less legible, and won't generate
>> potentially crap code?
>
> I'll wait for Matias or Jens to comment on the blocksize, but can
> do a new patch unless they beat me to it.
>
> 	Arnd
>

Thanks Arnd and Linus.

I had my head around the original code and kept references to the device 
layout I had in mind. 256 being number of pages in a block, and the 2^16 
being number of blocks in a lun and wanted to communicate that part.. 
which led to producing silly code in the mean time.

Similarly, the bs is always fixed to 4k for lightnvm, until other bs 
sizes are supported. We could optimize it out, I left it in for the same 
reasons.

diff --git i/drivers/block/null_blk.c w/drivers/block/null_blk.c
index 5c8ba54..97c02fe 100644
--- i/drivers/block/null_blk.c
+++ w/drivers/block/null_blk.c
@@ -510,17 +510,17 @@ static int null_lnvm_id(struct request_queue *q, 
struct nvm_id *id)
  	id->ppaf.ch_offset = 56;
  	id->ppaf.ch_len = 8;

-	do_div(size, bs); /* convert size to pages */
-	do_div(size, 256); /* concert size to pgs pr blk */
+	sector_div(size, bs); /* convert size to pages */
+	size >>= 8; /* convert size to pgs pr blk */
  	grp = &id->groups[0];
  	grp->mtype = 0;
  	grp->fmtype = 0;
  	grp->num_ch = 1;
  	grp->num_pg = 256;
  	blksize = size;
-	do_div(size, (1 << 16));
+	size >>= 16; /* convert size to num luns */
  	grp->num_lun = size + 1;
-	do_div(blksize, grp->num_lun);
+	sector_div(blksize, grp->num_lun);
  	grp->num_blk = blksize;
  	grp->num_pln = 1;
