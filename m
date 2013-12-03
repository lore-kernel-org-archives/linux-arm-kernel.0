From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 2 Dec 2013 21:22:26 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87siubneuf.fsf@natisbad.org>
References: <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
 <87zjopd240.fsf@natisbad.org> <87wqjtbm8r.fsf@natisbad.org>
 <20131128185040.GA13182@localhost> <87bo12kcyt.fsf@natisbad.org>
 <20131202103305.GB2466@localhost> <87siubneuf.fsf@natisbad.org>
Message-ID: <20131203002225.GA5333@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

I'll try to explain the numbers you're observing. If I say something stupid
along the way, feel free to correct me.

When I wrote this driver I got puzzled by the same questions you're asking
so rest assured I completely understand your confusion ;-)

Let me being by writing your NAND layout, just for reference.

0x000000000000-0x000000180000 : "u-boot"
0x000000180000-0x0000001a0000 : "u-boot-env"
0x000000200000-0x000000800000 : "uImage"
0x000000800000-0x000001800000 : "minirootfs"
0x000001800000-0x000008000000 : "jffs2"

Your NAND device has page size 2048 byte. Therefore, the following message:

> 
>   >>  Bad block table found at page 65472, version 0x01
>   >>  Bad block table found at page 65408, version 0x01
> 

Is telling us that there are two bad block tables (the table and its so-called
mirror): one at page 65472 and another at page 65408.
These page numbers correspond to offset 0x7fe0000 and 0x7fc0000 respectively.

Then, considering the mtd4 (aka "jffs2") partition starts at 0x1800000, we can
say the bad block tables start at offsets 0x67e0000 and 0x67c0000, from the
start of mtd4.

And since you run 'nandtest' on a partition and not on the entire
device you get the bad block locations at mtd4 offset:

>   >>   Bad block at 0x06700000
>   >>   Bad block at 0x06720000
>   >>   Bad block at 0x06740000
>   >>   Bad block at 0x06760000
>   >>   Bad block at 0x06780000
>   >>   Bad block at 0x067a0000
>   >>   Bad block at 0x067c0000 <-- Mirror bad block table
>   >>   Bad block at 0x067e0000 <-- Bad block table
> 

The reason the numbers appear as "upside-down" is because the pxa3xx-nand
driver uses this BBT options:

.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
	 | NAND_BBT_2BIT | NAND_BBT_VERSION,

So, the NAND core code writes the table to the last block (as per
NAND_BBT_LASTBLOCK option). Of course, it must write the bad block
table *inside* the flash (before the end of its last partition) and
to prevent any user I/O operation from losing the BBT the NAND core
marks as bad using a special 'reserved' mark.

Now, why does NAND reserve eight blocks, if there are only two tables?
Well, you'll be able to find this in the driver:

static struct nand_bbt_descr bbt_main_descr = {
	/* stuff */
	.maxblocks = 8,         /* Last 8 blocks in each chip */
};

The snippet above asks the NAND core to scan the last 8 blocks when searching
for the in-flash bad block table. The NAND core will also reserve these
8 blocks as the maximum amount of blocks that can be used to store a bad
block table (I guess that's in case one block gets 'really' bad).

In conclusion, answering your question, yes, this is correct:

> it's expected that the partition definition (start address and length)
> *includes* the bbt pages/blocks.
> 

The flash stores 8 x 128 KiB = 1 MiB for the bad block table and so
whenever you prepare your filesystem, you must now that the last
partition is actually 1 MiB smaller.

On the other issue, about the timeout...

> root at mood:~# nandwrite -p /dev/mtd4 /tmp/toto
> Writing data to block 0 at offset 0x0
> Writing data to block 1 at offset 0x20000
> Writing data to block 2 at offset 0x40000
> Writing data to block 3 at offset 0x60000
> Writing data to block 4 at offset 0x80000
> Writing data to block 5 at offset 0xa0000
> Writing data to block 6 at offset 0xc0000
> Writing data to block 7 at offset 0xe0000
> ...
> Writing data to block 818 at offset 0x6640000
> Writing data to block 819 at offset 0x6660000
> Writing data to block 820 at offset 0x6680000
> Writing data to block 821 at offset 0x66a0000
> Writing data to block 822 at offset 0x66c0000
> Writing data to block 823 at offset 0x66e0000
> Writing data to block 824 at offset 0x6700000
> Bad block at 6700000, 1 block(s) from 6700000 will be skipped
> Writing data to block 825 at offset 0x6720000
> Bad block at 6720000, 1 block(s) from 6720000 will be skipped
> Writing data to block 826 at offset 0x6740000
> Bad block at 6740000, 1 block(s) from 6740000 will be skipped
> Writing data to block 827 at offset 0x6760000
> Bad block at 6760000, 1 block(s) from 6760000 will be skipped
> Writing data to block 828 at offset 0x6780000
> Bad block at 6780000, 1 block(s) from 6780000 will be skipped
> Writing data to block 829 at offset 0x67a0000
> Bad block at 67a0000, 1 block(s) from 67a0000 will be skipped
> Writing data to block 830 at offset 0x67c0000
> Bad block at 67c0000, 1 block(s) from 67c0000 will be skipped
> Writing data to block 831 at offset 0x67e0000
> Bad block at 67e0000, 1 block(s) from 67e0000 will be skipped
> Writing data to block 832 at offset 0x6800000
> libmtd: error!: bad eraseblock number 832, mtd4 has 832 eraseblocks
> nandwrite: error!: /dev/mtd4: MTD get bad block failed
>            error 22 (Invalid argument)
> nandwrite: error!: Data was only partially written due to error
>            error 22 (Invalid argument)
> root at mood:~# 
> 

OK... Then I guess the driver works fine but you're trying to write
an image bigger than possible. Where did you get such filesystem?

Maybe reserving 8 blocks is *a lot* (I personally think it is a lot,
but maybe it's more robust that way).

> > Hence, the bad block table is what explains the skipping of the group
> > of blocks [824..832]. However, you're getting errors when writing
> > data to [800..823], and it's a "Ready timeout" condition. I'm not sure
> > exactly what's going on, but we can say that:
> >
> >   * Either the waiting time is not enough, or ...
> >
> >   * The commands (maybe some race) were badly issued so there's nothing
> >     to wait at all.
> 
> As I can not reproduce previous behavior (I am on the exact same
> kernel), I guess it's difficult to go any further yet.
> 

Hm.. that's not cool. The fact that you got those timeouts, but now
you don't have them anymore only worries me even more.

Feel free to ask any more questions about the NAND stuff, although I've
shared with you pretty much all I could collect from my readings to the code.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
