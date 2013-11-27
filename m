From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 27 Nov 2013 21:52:52 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87zjopd240.fsf@natisbad.org> (Arnaud Ebalard's message of "Wed,
 27 Nov 2013 21:24:47 +0100")
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
 <87zjopd240.fsf@natisbad.org>
Message-ID: <87wqjtbm8r.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

arno at natisbad.org (Arnaud Ebalard) writes:

> Well, I guess the bad block the driver put in the bbt are not that bad
> in practice, i.e. they were mistakenly marked that way. I also
> guess^Whope there is a some low level command I could use to simply
> clear the bbt (the NAND had no bad block prior to the test). Any help
> would be appreciated on that point.

Replying to myself w/ the solution: just in case it happens to someone
else, it's as simple as using flash_erase w/ -N option on a kernel
modified (in drivers/mtd/nand/nand_base.c) to allow write to a bad
block w/ the following patch:

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index bd39f7b..e70ef60 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2591,6 +2591,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
        instr->state = MTD_ERASING;
 
        while (len) {
+#if 0
                /* Check if we have a bad block, we do not erase bad blocks! */
                if (nand_block_checkbad(mtd, ((loff_t) page) <<
                                        chip->page_shift, 0, allowbbt)) {
@@ -2599,6 +2600,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
                        instr->state = MTD_ERASE_FAILED;
                        goto erase_exit;
                }
+#endif
 
                /*
                 * Invalidate the page cache, if we erase the block which


After a reboot on that modified kernel, a simple call to flash_erase
using -N option will erase the badblocks:

 # flash_erase -N /dev/mtd4 0 0 

Then, at next reboot an empty bad block table is recreated.

NAND:  (ID 0xf1ad)      128 MiB
Bad block table not found for chip 0
Bad block table not found for chip 0
Bad block table written to 0x000007fe0000, version 0x01
Bad block table written to 0x000007fc0000, version 0x01
FPU not initialized
USB 0: Host Mode
USB 1: Host Mode

Ezequiel, I am back in business to test a v2 ;-)

Cheers,

a+

ps: primary source: http://lists.infradead.org/pipermail/linux-mtd/2012-June/041969.html
