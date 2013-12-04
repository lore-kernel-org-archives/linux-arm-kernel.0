From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 4 Dec 2013 11:20:10 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87iov5aapx.fsf@natisbad.org>
References: <20131126124003.GA2344@localhost> <87zjopd240.fsf@natisbad.org>
 <87wqjtbm8r.fsf@natisbad.org> <20131128185040.GA13182@localhost>
 <87bo12kcyt.fsf@natisbad.org> <20131202103305.GB2466@localhost>
 <87siubneuf.fsf@natisbad.org> <20131203002225.GA5333@localhost>
 <87ob4xbs8l.fsf@natisbad.org> <87iov5aapx.fsf@natisbad.org>
Message-ID: <20131204142009.GB2486@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

Thanks a lot for the patience!


On Tue, Dec 03, 2013 at 10:25:14PM +0100, Arnaud Ebalard wrote:
> Hi Ezequiel,
> 
> arno at natisbad.org (Arnaud Ebalard) writes:
> 
> > So I guess, if you have any (non hardware destructive ;-) ) idea, I now
> > have a platform on which the problem is reproducible. Meanwhile, I will
> > try and do the same on my RN104 (should be the same as the RN102).
> 
> Well, on the RN104 (same chip, same kernel and same SoC as the RN102), I
> have the following (I get the same with a patched driver to increase the
> timeout):
> 
> root at humble:~# flash_erase /dev/mtd4 0 0 
> Erasing 128 Kibyte @ 72e0000 -- 99 % complete flash_erase: Skipping bad block at 07300000
> flash_erase: Skipping bad block at 07320000
> flash_erase: Skipping bad block at 07340000
> flash_erase: Skipping bad block at 07360000
> flash_erase: Skipping bad block at 07380000
> flash_erase: Skipping bad block at 073a0000
> flash_erase: Skipping bad block at 073c0000
> flash_erase: Skipping bad block at 073e0000
> Erasing 128 Kibyte @ 73e0000 -- 100 % complete 
> 
> root at humble:~# nandwrite -p /dev/mtd4 mtd4ro 
> Writing data to block 0 at offset 0x0
> [  449.915173] pxa3xx-nand d00d0000.nand: Ready time out!!!
> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 0, offset 2048)
>         error 5 (Input/output error)
> Erasing failed write from 00000000 to 0x01ffff
> Writing data to block 1 at offset 0x20000
> [  450.115172] pxa3xx-nand d00d0000.nand: Ready time out!!!
> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 1, offset 2048)
>         error 5 (Input/output error)
> Erasing failed write from 0x020000 to 0x03ffff
> Writing data to block 2 at offset 0x40000
> [  450.315171] pxa3xx-nand d00d0000.nand: Ready time out!!!
> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 2, offset 2048)
>         error 5 (Input/output error)
> Erasing failed write from 0x040000 to 0x05ffff
> Writing data to block 3 at offset 0x60000
> [  450.515171] pxa3xx-nand d00d0000.nand: Ready time out!!!
> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 3, offset 2048)
>         error 5 (Input/output error)
> Erasing failed write from 0x060000 to 0x07ffff
> Writing data to block 4 at offset 0x80000
> [  450.715169] pxa3xx-nand d00d0000.nand: Ready time out!!!
> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 4, offset 2048)
>         error 5 (Input/output error)
> Erasing failed write from 0x080000 to 0x09ffff
> Writing data to block 5 at offset 0xa0000
> [  450.915171] pxa3xx-nand d00d0000.nand: Ready time out!!!
> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 5, offset 2048)
>         error 5 (Input/output error)
> Erasing failed write from 0x0a0000 to 0x0bffff
> Writing data to block 6 at offset 0xc0000
> [  451.115171] pxa3xx-nand d00d0000.nand: Ready time out!!!
> libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 6, offset 2048)
>         error 5 (Input/output error)
> Erasing failed write from 0x0c0000 to 0x0dffff
> Writing data to block 7 at offset 0xe0000
> 
> 

So, let me confirm this: you have systematically obtained a "Ready
timeout" when writing to the device, on every single write to a page,
correct?

I'll prepare a patch against the branch we're working that adds lots of
pr_info(). It'll be very annoying for you, but it's the only way I can
think of, to get the driver's dirty inner sequence and to see *where*
is failing.

However, before that patch, please do a quick test for me. It's just a
shot in the dark. The below diff removes the NDCB0_AUTO_RS flag from
the PAGE_PROG command when the page size is 2048 byte (or less).

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index fd0ef93..038cf5d 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -831,7 +831,6 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 			}
 		} else {
 			info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
-					| NDCB0_AUTO_RS
 					| NDCB0_ST_ROW_EN
 					| NDCB0_DBC
 					| (NAND_CMD_PAGEPROG << 8)

Please apply this diff, and then try to write@least one page. If at
all possible you might try different approaches:

  $ flash_erase /dev/mtd2 0 1
  $ dd if=page.raw of=/dev/mtd2 bs=2048 count=1

  $ flash_erase /dev/mtd2 0 1
  $ nandwrite page.raw /dev/mtd2

Where page.raw is some 2048B file, which you can create with random junk in it.

Regards,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
