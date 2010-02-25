From: wolfgang.mues@auerswald.de (Wolfgang =?iso-8859-15?q?M=FCes?=)
Date: Thu, 25 Feb 2010 15:29:20 +0100
Subject: [PATCH5/5] at91_mci: enable large data blocks
Message-ID: <201002251529.20622.wolfgang.mues@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

this is the last part of my fixes and improvements for the at91_mci driver.

This patch is setting some max_ variables for the IO elevator, so the elevator
will put requests for large data blocks to the driver. This is critical for
a) speed 
and
b) wear leveling of the flash chip controller.

I would ship no product which is treating the SD card with millions of single
4 KByte write command due to the short life cycle of the SD cards.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>

---
diff -ur linux-2.6.33-rc8-readbuf/drivers/mmc/host/at91_mci.c linux-2.6.33-rc8-max/drivers/mmc/host/at91_mci.c
--- linux-2.6.33-rc8-readbuf/drivers/mmc/host/at91_mci.c	2010-02-25 14:42:05.803239154 +0100
+++ linux-2.6.33-rc8-max/drivers/mmc/host/at91_mci.c	2010-02-25 14:48:35.143738415 +0100
@@ -934,6 +934,9 @@
 	mmc->max_blk_size  = MCI_MAXBLKSIZE; 
 	mmc->max_blk_count = MCI_BLKATONCE;
 	mmc->max_req_size  = MCI_BUFSIZE;
+	mmc->max_phys_segs = MCI_BLKATONCE;
+	mmc->max_hw_segs   = MCI_BLKATONCE;
+	mmc->max_seg_size  = MCI_BUFSIZE; 
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
---
best regards
 
i. A. Wolfgang M?es
-- 
Auerswald Gesellschaft f?r Datensysteme mbH
Hardware Development
Telefon: +49 (0)5306 9219 562
Telefax: +49 (0)5306 9219 94 
E-Mail: Wolfgang.Mues at Auerswald.de
Web: http://www.auerswald.de
 
--------------------------------------------------------------
Auerswald Gesellschaft f?r Datensysteme mbH
Vor den Grash?fen 1, 38162 Cremlingen
Registriert beim AG Braunschweig HRB 7499
Gesch?ftsf?hrer: Dipl-Ing. Gerhard Auerswald
