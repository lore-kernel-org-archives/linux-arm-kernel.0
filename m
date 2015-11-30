From: axboe@fb.com (Jens Axboe)
Date: Mon, 30 Nov 2015 14:49:50 -0700
Subject: [PATCH] null_blk: use sector_div instead of do_div
In-Reply-To: <4449032.oPBtpzlXyB@wuerfel>
References: <3768541.ja0r6f0Odi@wuerfel>
 <CA+55aFy=JjwmtNysByu822S2Av0sv_KUCLfa86tAz5K5Unwsmw@mail.gmail.com>
 <4449032.oPBtpzlXyB@wuerfel>
Message-ID: <565CC47E.9020209@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2015 02:31 PM, Arnd Bergmann wrote:
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

We can use the shift, but honestly, it's just setup code. For hot paths, 
avoiding the div is definitely of higher priority. And for the sake of 
people copy/pasting or similar, making it a shift is probably a good idea.

-- 
Jens Axboe
