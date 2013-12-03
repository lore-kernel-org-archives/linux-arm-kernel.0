From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 03 Dec 2013 21:21:30 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
References: <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
 <87zjopd240.fsf@natisbad.org> <87wqjtbm8r.fsf@natisbad.org>
 <20131128185040.GA13182@localhost> <87bo12kcyt.fsf@natisbad.org>
 <20131202103305.GB2466@localhost> <87siubneuf.fsf@natisbad.org>
 <20131203002225.GA5333@localhost>
Message-ID: <87ob4xbs8l.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

> I'll try to explain the numbers you're observing. If I say something stupid
> along the way, feel free to correct me.
>
> When I wrote this driver I got puzzled by the same questions you're asking
> so rest assured I completely understand your confusion ;-)

Thanks. Unless ones spends the time being taught that or reading the code,
the logic of BBT mapping and reservation is not exactly straightforward.
Thanks for the explanation.

More news below.


> The reason the numbers appear as "upside-down" is because the pxa3xx-nand
> driver uses this BBT options:
>
> .options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
> 	 | NAND_BBT_2BIT | NAND_BBT_VERSION,
>
> So, the NAND core code writes the table to the last block (as per
> NAND_BBT_LASTBLOCK option). Of course, it must write the bad block
> table *inside* the flash (before the end of its last partition) and
> to prevent any user I/O operation from losing the BBT the NAND core
> marks as bad using a special 'reserved' mark.

ok.


> Now, why does NAND reserve eight blocks, if there are only two tables?
> Well, you'll be able to find this in the driver:
>
> static struct nand_bbt_descr bbt_main_descr = {
> 	/* stuff */
> 	.maxblocks = 8,         /* Last 8 blocks in each chip */
> };
>
> The snippet above asks the NAND core to scan the last 8 blocks when searching
> for the in-flash bad block table. The NAND core will also reserve these
> 8 blocks as the maximum amount of blocks that can be used to store a bad
> block table (I guess that's in case one block gets 'really' bad).
>
> In conclusion, answering your question, yes, this is correct:
>
>> it's expected that the partition definition (start address and length)
>> *includes* the bbt pages/blocks.
>> 
>
> The flash stores 8 x 128 KiB = 1 MiB for the bad block table and so
> whenever you prepare your filesystem, you must now that the last
> partition is actually 1 MiB smaller.

ok. Will put a comment in the .dts about that.


> On the other issue, about the timeout...
>
>> root at mood:~# nandwrite -p /dev/mtd4 /tmp/toto
>> Writing data to block 0 at offset 0x0
>> Writing data to block 1 at offset 0x20000
>> Writing data to block 2 at offset 0x40000
>> Writing data to block 3 at offset 0x60000
>> Writing data to block 4 at offset 0x80000
>> Writing data to block 5 at offset 0xa0000
>> Writing data to block 6 at offset 0xc0000
>> Writing data to block 7 at offset 0xe0000
>> ...
>> Writing data to block 818 at offset 0x6640000
>> Writing data to block 819 at offset 0x6660000
>> Writing data to block 820 at offset 0x6680000
>> Writing data to block 821 at offset 0x66a0000
>> Writing data to block 822 at offset 0x66c0000
>> Writing data to block 823 at offset 0x66e0000
>> Writing data to block 824 at offset 0x6700000
>> Bad block at 6700000, 1 block(s) from 6700000 will be skipped
>> Writing data to block 825 at offset 0x6720000
>> Bad block at 6720000, 1 block(s) from 6720000 will be skipped
>> Writing data to block 826 at offset 0x6740000
>> Bad block at 6740000, 1 block(s) from 6740000 will be skipped
>> Writing data to block 827 at offset 0x6760000
>> Bad block at 6760000, 1 block(s) from 6760000 will be skipped
>> Writing data to block 828 at offset 0x6780000
>> Bad block at 6780000, 1 block(s) from 6780000 will be skipped
>> Writing data to block 829 at offset 0x67a0000
>> Bad block at 67a0000, 1 block(s) from 67a0000 will be skipped
>> Writing data to block 830 at offset 0x67c0000
>> Bad block at 67c0000, 1 block(s) from 67c0000 will be skipped
>> Writing data to block 831 at offset 0x67e0000
>> Bad block at 67e0000, 1 block(s) from 67e0000 will be skipped
>> Writing data to block 832 at offset 0x6800000
>> libmtd: error!: bad eraseblock number 832, mtd4 has 832 eraseblocks
>> nandwrite: error!: /dev/mtd4: MTD get bad block failed
>>            error 22 (Invalid argument)
>> nandwrite: error!: Data was only partially written due to error
>>            error 22 (Invalid argument)
>> root at mood:~# 
>> 
>
> OK... Then I guess the driver works fine but you're trying to write
> an image bigger than possible. Where did you get such filesystem?

The image is a dd from the partition itself. Trying to put it back will
obviously not work for the reason you provide above, i.e. because dd
reads to the end of the partition (including the BBT) but then during
the write operation the reserved block cannot be written back.


> Maybe reserving 8 blocks is *a lot* (I personally think it is a lot,
> but maybe it's more robust that way).
>
>> > Hence, the bad block table is what explains the skipping of the group
>> > of blocks [824..832]. However, you're getting errors when writing
>> > data to [800..823], and it's a "Ready timeout" condition. I'm not sure
>> > exactly what's going on, but we can say that:
>> >
>> >   * Either the waiting time is not enough, or ...
>> >
>> >   * The commands (maybe some race) were badly issued so there's nothing
>> >     to wait at all.
>> 
>> As I can not reproduce previous behavior (I am on the exact same
>> kernel), I guess it's difficult to go any further yet.
>> 
>
> Hm.. that's not cool. The fact that you got those timeouts, but now
> you don't have them anymore only worries me even more.

Well, before submitting the patches for armada-based ReadyNAS .dts
files, I decided to give each of them a try on their respective hardware
and I was somewhat lucky (if I can say so) on my RN2120 and got the
following. Note that the NAND chip is the same but the SoC on the NAS
is different (dual-core armada Xp mv78230 on RN2120 instead of Armada
370 on RN102). The same tree is used in each case with the same MTD
related config options:


root at thin:~# flash_erase /dev/mtd4 0 0
...

root at thin:~# nandwrite -p /dev/mtd4 /tmp/mtd4ro 
Writing data to block 0 at offset 0x0
[  782.766892] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 00000000 to 0x01ffff
Writing data to block 1 at offset 0x20000
[  782.966891] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x020000 to 0x03ffff
Writing data to block 2 at offset 0x40000
[  783.166891] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 2, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x040000 to 0x05ffff
Writing data to block 3 at offset 0x60000
[  783.366889] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 3, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x060000 to 0x07ffff
Writing data to block 4 at offset 0x80000
[  783.566890] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 4, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x080000 to 0x09ffff
Writing data to block 5 at offset 0xa0000
[  783.766890] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 5, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x0a0000 to 0x0bffff
Writing data to block 6 at offset 0xc0000
[  783.966890] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 6, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x0c0000 to 0x0dffff
Writing data to block 7 at offset 0xe0000
[  784.166890] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 7, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x0e0000 to 0x0fffff
Writing data to block 8 at offset 0x100000
[  784.366889] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 8, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x100000 to 0x11ffff
Writing data to block 9 at offset 0x120000
^C[  784.566889] pxa3xx-nand d00d0000.nand: Ready time out!!!


So I decided to increase CHIP_DELAY_TIMEOUT in the driver as you
suggested in a previous email (HZ instead of 2*HZ/10):

root at thin:~# nandwrite -p /dev/mtd4 mtd4ro 
Writing data to block 0 at offset 0x0
[  273.917098] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 00000000 to 0x01ffff
Writing data to block 1 at offset 0x20000
[  274.917094] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x020000 to 0x03ffff
Writing data to block 2 at offset 0x40000
[  275.917094] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 2, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x040000 to 0x05ffff
Writing data to block 3 at offset 0x60000
^C[  276.917094] pxa3xx-nand d00d0000.nand: Ready time out!!!


And then to 25*HZ/10 (I know it's a lot):

root at thin:~# nandwrite /dev/mtd4 mtd4ro 
Writing data to block 0 at offset 0x0
[  192.118574] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 00000000 to 0x01ffff
Writing data to block 1 at offset 0x20000
[  194.618569] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
        error 5 (Input/output error)
Erasing failed write from 0x020000 to 0x03ffff
Writing data to block 2 at offset 0x40000
^C[  197.118570] pxa3xx-nand d00d0000.nand: Ready time out!!!


So I guess, if you have any (non hardware destructive ;-) ) idea, I now
have a platform on which the problem is reproducible. Meanwhile, I will
try and do the same on my RN104 (should be the same as the RN102).

Cheers,

a+
