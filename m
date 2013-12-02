From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 2 Dec 2013 07:33:06 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87bo12kcyt.fsf@natisbad.org>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
 <87zjopd240.fsf@natisbad.org> <87wqjtbm8r.fsf@natisbad.org>
 <20131128185040.GA13182@localhost> <87bo12kcyt.fsf@natisbad.org>
Message-ID: <20131202103305.GB2466@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

First of all: thanks for such great testings!

On Sat, Nov 30, 2013 at 12:25:14AM +0100, Arnaud Ebalard wrote:
> Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:
> 
> >> Ezequiel, I am back in business to test a v2 ;-)
> >
> > Well, I'm not sure yet what's going on. Do you have any spare NAND partition
> > to run some destructive testings?
> >
> > In that case, please run:
> >
> > $ nandtest /dev/mtd{X}
> 
> Here is the nandtest run:
> 
>   nandtest /dev/mtd4
>   ECC corrections: 0
>   ECC failures   : 0
>   Bad blocks     : 8
>   BBT blocks     : 0
>   Bad block at 0x06700000
>   Bad block at 0x06720000
>   Bad block at 0x06740000
>   Bad block at 0x06760000
>   Bad block at 0x06780000
>   Bad block at 0x067a0000
>   Bad block at 0x067c0000
>   Bad block at 0x067e0000
>   
>   Finished pass 1 successfully
> 

Hm, so something *is* working properly. Notice that mtd4 has its 8 last blocks
marked 'bad' becuase it holds the bad block table.

If you don't mind running a few more rounds, then it would be nice to do:

  $ nandtest --passes {N}

So we run the test a few more times, just to be sure.

> 
> Then, doing a simple read and copying back the data:
> 
>   root at mood:~# dd if=/dev/mtd4 of=/tmp/toto 
>   212992+0 records in
>   212992+0 records out
>   109051904 bytes (109 MB) copied, 10.8671 s, 10.0 MB/s
>   
>   root at mood:~# flash_erase /dev/mtd4 0 0
>   
>   root at mood:~# nandwrite -p /dev/mtd4 /tmp/toto
>   ...
>   Writing data to block 795 at offset 0x6360000
>   Writing data to block 796 at offset 0x6380000
>   Writing data to block 797 at offset 0x63a0000
>   Writing data to block 798 at offset 0x63c0000
>   Writing data to block 799 at offset 0x63e0000
>   Writing data to block 800 at offset 0x6400000
>   [ 1509.210395] pxa3xx-nand d00d0000.nand: Ready time out!!!
>   libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 800, offset 0)
>           error 5 (Input/output error)
[..]

>   [ 1513.810387] pxa3xx-nand d00d0000.nand: Ready time out!!!
>   libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 823, offset 0)
>           error 5 (Input/output error)
>   Erasing failed write from 0x66e0000 to 0x66fffff

Hm.. so you get errors when writing to mtd4 blocks from 800 to 823.

Is that completely reproducible, IOW do you get always the error
on those blocks?

And what happens if you write directly to those blocks only?
(you can use nandwrite --offset)

>   Writing data to block 824 at offset 0x6700000
>   Bad block at 6700000, 1 block(s) from 6700000 will be skipped
>   Writing data to block 825 at offset 0x6720000
>   Bad block at 6720000, 1 block(s) from 6720000 will be skipped
>   Writing data to block 826 at offset 0x6740000
>   Bad block at 6740000, 1 block(s) from 6740000 will be skipped
>   Writing data to block 827 at offset 0x6760000
>   Bad block at 6760000, 1 block(s) from 6760000 will be skipped
>   Writing data to block 828 at offset 0x6780000
>   Bad block at 6780000, 1 block(s) from 6780000 will be skipped
>   Writing data to block 829 at offset 0x67a0000
>   Bad block at 67a0000, 1 block(s) from 67a0000 will be skipped
>   Writing data to block 830 at offset 0x67c0000
>   Bad block at 67c0000, 1 block(s) from 67c0000 will be skipped
>   Writing data to block 831 at offset 0x67e0000
>   Bad block at 67e0000, 1 block(s) from 67e0000 will be skipped
>   Writing data to block 832 at offset 0x6800000
>   libmtd: error!: bad eraseblock number 832, mtd4 has 832 eraseblocks
>   nandwrite: error!: /dev/mtd4: MTD get bad block failed
>              error 22 (Invalid argument)
>   nandwrite: error!: Data was only partially written due to error
>              error 22 (Invalid argument)
>   

These 8 blocks (824-832) that has been skipped are the ones marked
as 'bad' because they hold the bad block table.

> This is the kind of errors I got last time but I think am starting to
> understand the root cause now. Tell me if I get it right: what is
> understood as bad blocks above (and in nandtest) is in fact the two bad
> block tables reported during boot:
> 
>  NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix H27U1G8F2BTR-BC)
>  NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
>  Bad block table found at page 65472, version 0x01
>  Bad block table found at page 65408, version 0x01
> 

Yes and no :-) The bad block table consists of 8 blocks at the end
of the flash device. These blocks are marked as 'reserved' and nandtest
or any other userspace writing/erasing tool will skip them.

Hence, the bad block table is what explains the skipping of the group
of blocks [824..832]. However, you're getting errors when writing
data to [800..823], and it's a "Ready timeout" condition. I'm not sure
exactly what's going on, but we can say that:

  * Either the waiting time is not enough, or ...

  * The commands (maybe some race) were badly issued so there's nothing
    to wait at all.

To check the former, you only need to hack the driver like this, and
then re-try the nandwrite:

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 3d143fe..9bb7d35 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -39,7 +39,7 @@
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #define NAND_DEV_READY_TIMEOUT  50
-#define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
+#define	CHIP_DELAY_TIMEOUT	(10 * HZ/10)
 #define NAND_STOP_DELAY		(2 * HZ/50)
 #define PAGE_CHUNK_SIZE		(2048)
 
It's just a test.

To check about the latter, I cannot think of anything but adding printk
all over the place and inspect the command sequence.

Brian: Do you have any better idea?

Thanks again for these tests and for your patience!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
