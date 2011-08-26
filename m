From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Fri, 26 Aug 2011 10:46:15 +0530
Subject: [PATCH] mtd: Replace DEBUG with MTD_DBG
In-Reply-To: <CAMPhdO_qVn8JaX6orfnHHXjmi8pTQFb1SzMe2RQM9xMdTvimaQ@mail.gmail.com>
References: <CAMPhdO_qVn8JaX6orfnHHXjmi8pTQFb1SzMe2RQM9xMdTvimaQ@mail.gmail.com>
Message-ID: <1314335775-3384-2-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defining macro 'DEBUG' for debug prints conflicts with other
subsystem where defining 'DEBUG' means enable debug code including
debug prints and others. So, replaced DEBUG with MTD_DBG for MTD

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c |   24 +++++++++---------
 drivers/mtd/chips/fwh_lock.h        |    2 +-
 drivers/mtd/chips/jedec_probe.c     |   29 +++++++++++----------
 drivers/mtd/devices/doc2000.c       |    8 +++---
 drivers/mtd/devices/doc2001.c       |    4 +-
 drivers/mtd/devices/doc2001plus.c   |    4 +-
 drivers/mtd/devices/m25p80.c        |   20 +++++++-------
 drivers/mtd/devices/mtd_dataflash.c |   44 ++++++++++++++++----------------
 drivers/mtd/devices/sst25l.c        |    4 +-
 drivers/mtd/ftl.c                   |   41 ++++++++++++++++---------------
 drivers/mtd/inftlcore.c             |   41 ++++++++++++++++---------------
 drivers/mtd/inftlmount.c            |   12 ++++----
 drivers/mtd/mtdblock.c              |   18 +++++++-------
 drivers/mtd/mtdchar.c               |   10 ++++----
 drivers/mtd/mtdcore.c               |    2 +-
 drivers/mtd/mtdsuper.c              |   21 ++++++++-------
 drivers/mtd/nand/mxc_nand.c         |   12 ++++----
 drivers/mtd/nand/nand_base.c        |   46 +++++++++++++++++-----------------
 drivers/mtd/nand/nand_bbt.c         |    4 +-
 drivers/mtd/nand/nand_bch.c         |    2 +-
 drivers/mtd/nand/omap2.c            |    8 +++---
 drivers/mtd/nand/rtc_from4.c        |    3 +-
 drivers/mtd/nftlcore.c              |   33 ++++++++++++++----------
 drivers/mtd/onenand/onenand_base.c  |   18 +++++++-------
 drivers/mtd/onenand/onenand_bbt.c   |    4 +-
 drivers/mtd/ssfdc.c                 |   32 ++++++++++++------------
 include/linux/mtd/mtd.h             |    4 +-
 27 files changed, 230 insertions(+), 220 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 23175ed..fafb6af 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -145,7 +145,7 @@ static void fixup_amd_bootblock(struct mtd_info *mtd)
 	if (((major << 8) | minor) < 0x3131) {
 		/* CFI version 1.0 => don't trust bootloc */
 
-		DEBUG(MTD_DEBUG_LEVEL1,
+		MTD_DBG(MTD_DEBUG_LEVEL1,
 			"%s: JEDEC Vendor ID is 0x%02X Device ID is 0x%02X\n",
 			map->name, cfi->mfr, cfi->id);
 
@@ -166,7 +166,7 @@ static void fixup_amd_bootblock(struct mtd_info *mtd)
 			 * the 8-bit device ID.
 			 */
 			(cfi->mfr == CFI_MFR_MACRONIX)) {
-			DEBUG(MTD_DEBUG_LEVEL1,
+			MTD_DBG(MTD_DEBUG_LEVEL1,
 				"%s: Macronix MX29LV400C with bottom boot block"
 				" detected\n", map->name);
 			extp->TopBottom = 2;	/* bottom boot */
@@ -178,7 +178,7 @@ static void fixup_amd_bootblock(struct mtd_info *mtd)
 			extp->TopBottom = 2;	/* bottom boot */
 		}
 
-		DEBUG(MTD_DEBUG_LEVEL1,
+		MTD_DBG(MTD_DEBUG_LEVEL1,
 			"%s: AMD CFI PRI V%c.%c has no boot block field;"
 			" deduced %s from Device ID\n", map->name, major, minor,
 			extp->TopBottom == 2 ? "bottom" : "top");
@@ -191,7 +191,7 @@ static void fixup_use_write_buffers(struct mtd_info *mtd)
 	struct map_info *map = mtd->priv;
 	struct cfi_private *cfi = map->fldrv_priv;
 	if (cfi->cfiq->BufWriteTimeoutTyp) {
-		DEBUG(MTD_DEBUG_LEVEL1, "Using buffer write method\n" );
+		MTD_DBG(MTD_DEBUG_LEVEL1, "Using buffer write method\n");
 		mtd->write = cfi_amdstd_write_buffers;
 	}
 }
@@ -443,7 +443,7 @@ struct mtd_info *cfi_cmdset_0002(struct map_info *map, int primary)
 	mtd->writesize = 1;
 	mtd->writebufsize = cfi_interleave(cfi) << cfi->cfiq->MaxBufWriteSize;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "MTD %s(): write buffer size %d\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): write buffer size %d\n",
 		__func__, mtd->writebufsize);
 
 	mtd->reboot_notifier.notifier_call = cfi_amdstd_reboot;
@@ -1163,7 +1163,7 @@ static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
 		return ret;
 	}
 
-	DEBUG( MTD_DEBUG_LEVEL3, "MTD %s(): WRITE 0x%.8lx(0x%.8lx)\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): WRITE 0x%.8lx(0x%.8lx)\n",
 	       __func__, adr, datum.x[0] );
 
 	/*
@@ -1174,7 +1174,7 @@ static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
 	 */
 	oldd = map_read(map, adr);
 	if (map_word_equal(map, oldd, datum)) {
-		DEBUG( MTD_DEBUG_LEVEL3, "MTD %s(): NOP\n",
+		MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): NOP\n",
 		       __func__);
 		goto op_done;
 	}
@@ -1400,7 +1400,7 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 
 	datum = map_word_load(map, buf);
 
-	DEBUG( MTD_DEBUG_LEVEL3, "MTD %s(): WRITE 0x%.8lx(0x%.8lx)\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): WRITE 0x%.8lx(0x%.8lx)\n",
 	       __func__, adr, datum.x[0] );
 
 	XIP_INVAL_CACHED_RANGE(map, adr, len);
@@ -1587,7 +1587,7 @@ static int __xipram do_erase_chip(struct map_info *map, struct flchip *chip)
 		return ret;
 	}
 
-	DEBUG( MTD_DEBUG_LEVEL3, "MTD %s(): ERASE 0x%.8lx\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): ERASE 0x%.8lx\n",
 	       __func__, chip->start );
 
 	XIP_INVAL_CACHED_RANGE(map, adr, map->size);
@@ -1675,7 +1675,7 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 		return ret;
 	}
 
-	DEBUG( MTD_DEBUG_LEVEL3, "MTD %s(): ERASE 0x%.8lx\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): ERASE 0x%.8lx\n",
 	       __func__, adr );
 
 	XIP_INVAL_CACHED_RANGE(map, adr, len);
@@ -1801,7 +1801,7 @@ static int do_atmel_lock(struct map_info *map, struct flchip *chip,
 		goto out_unlock;
 	chip->state = FL_LOCKING;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "MTD %s(): LOCK 0x%08lx len %d\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): LOCK 0x%08lx len %d\n",
 	      __func__, adr, len);
 
 	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi,
@@ -1837,7 +1837,7 @@ static int do_atmel_unlock(struct map_info *map, struct flchip *chip,
 		goto out_unlock;
 	chip->state = FL_UNLOCKING;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "MTD %s(): LOCK 0x%08lx len %d\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): LOCK 0x%08lx len %d\n",
 	      __func__, adr, len);
 
 	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi,
diff --git a/drivers/mtd/chips/fwh_lock.h b/drivers/mtd/chips/fwh_lock.h
index 5e3cc80..af8e3df 100644
--- a/drivers/mtd/chips/fwh_lock.h
+++ b/drivers/mtd/chips/fwh_lock.h
@@ -34,7 +34,7 @@ static int fwh_xxlock_oneblock(struct map_info *map, struct flchip *chip,
 
 	/* Refuse the operation if the we cannot look behind the chip */
 	if (chip->start < 0x400000) {
-		DEBUG( MTD_DEBUG_LEVEL3,
+		MTD_DBG(MTD_DEBUG_LEVEL3,
 			"MTD %s(): chip->start: %lx wanted >= 0x400000\n",
 			__func__, chip->start );
 		return -EIO;
diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index ea832ea..c1af256 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1917,7 +1917,7 @@ static void jedec_reset(u32 base, struct map_info *map, struct cfi_private *cfi)
 	 * as they will ignore the writes and dont care what address
 	 * the F0 is written to */
 	if (cfi->addr_unlock1) {
-		DEBUG( MTD_DEBUG_LEVEL3,
+		MTD_DBG(MTD_DEBUG_LEVEL3,
 		       "reset unlock called %x %x \n",
 		       cfi->addr_unlock1,cfi->addr_unlock2);
 		cfi_send_gen_cmd(0xaa, cfi->addr_unlock1, base, map, cfi, cfi->device_type, NULL);
@@ -1941,8 +1941,9 @@ static int cfi_jedec_setup(struct map_info *map, struct cfi_private *cfi, int in
 	uint8_t uaddr;
 
 	if (!(jedec_table[index].devtypes & cfi->device_type)) {
-		DEBUG(MTD_DEBUG_LEVEL1, "Rejecting potential %s with incompatible %d-bit device type\n",
-		      jedec_table[index].name, 4 * (1<<cfi->device_type));
+		MTD_DBG(MTD_DEBUG_LEVEL1, "Rejecting potential %s with "
+			"incompatible %d-bit device type\n",
+			jedec_table[index].name, 4 * (1<<cfi->device_type));
 		return 0;
 	}
 
@@ -2021,7 +2022,7 @@ static inline int jedec_match( uint32_t base,
 		 * there aren't.
 		 */
 		if (finfo->dev_id > 0xff) {
-			DEBUG( MTD_DEBUG_LEVEL3, "%s(): ID is not 8bit\n",
+			MTD_DBG(MTD_DEBUG_LEVEL3, "%s(): ID is not 8bit\n",
 			       __func__);
 			goto match_done;
 		}
@@ -2045,11 +2046,11 @@ static inline int jedec_match( uint32_t base,
 	}
 
 	/* the part size must fit in the memory window */
-	DEBUG( MTD_DEBUG_LEVEL3,
+	MTD_DBG(MTD_DEBUG_LEVEL3,
 	       "MTD %s(): Check fit 0x%.8x + 0x%.8x = 0x%.8x\n",
 	       __func__, base, 1 << finfo->dev_size, base + (1 << finfo->dev_size) );
 	if ( base + cfi_interleave(cfi) * ( 1 << finfo->dev_size ) > map->size ) {
-		DEBUG( MTD_DEBUG_LEVEL3,
+		MTD_DBG(MTD_DEBUG_LEVEL3,
 		       "MTD %s(): 0x%.4x 0x%.4x %dKiB doesn't fit\n",
 		       __func__, finfo->mfr_id, finfo->dev_id,
 		       1 << finfo->dev_size );
@@ -2061,12 +2062,12 @@ static inline int jedec_match( uint32_t base,
 
 	uaddr = finfo->uaddr;
 
-	DEBUG( MTD_DEBUG_LEVEL3, "MTD %s(): check unlock addrs 0x%.4x 0x%.4x\n",
-	       __func__, cfi->addr_unlock1, cfi->addr_unlock2 );
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): check unlock addrs 0x%.4x 0x%.4x"
+	       "\n", __func__, cfi->addr_unlock1, cfi->addr_unlock2);
 	if ( MTD_UADDR_UNNECESSARY != uaddr && MTD_UADDR_DONT_CARE != uaddr
 	     && ( unlock_addrs[uaddr].addr1 / cfi->device_type != cfi->addr_unlock1 ||
 		  unlock_addrs[uaddr].addr2 / cfi->device_type != cfi->addr_unlock2 ) ) {
-		DEBUG( MTD_DEBUG_LEVEL3,
+		MTD_DBG(MTD_DEBUG_LEVEL3,
 			"MTD %s(): 0x%.4x 0x%.4x did not match\n",
 			__func__,
 			unlock_addrs[uaddr].addr1,
@@ -2083,14 +2084,14 @@ static inline int jedec_match( uint32_t base,
 	 * FIXME - write a driver that takes all of the chip info as
 	 * module parameters, doesn't probe but forces a load.
 	 */
-	DEBUG( MTD_DEBUG_LEVEL3,
+	MTD_DBG(MTD_DEBUG_LEVEL3,
 	       "MTD %s(): check ID's disappear when not in ID mode\n",
 	       __func__ );
 	jedec_reset( base, map, cfi );
 	mfr = jedec_read_mfr( map, base, cfi );
 	id = jedec_read_id( map, base, cfi );
 	if ( mfr == cfi->mfr && id == cfi->id ) {
-		DEBUG( MTD_DEBUG_LEVEL3,
+		MTD_DBG(MTD_DEBUG_LEVEL3,
 		       "MTD %s(): ID 0x%.2x:0x%.2x did not change after reset:\n"
 		       "You might need to manually specify JEDEC parameters.\n",
 			__func__, cfi->mfr, cfi->id );
@@ -2104,7 +2105,7 @@ static inline int jedec_match( uint32_t base,
 	 * Put the device back in ID mode - only need to do this if we
 	 * were truly frobbing a real device.
 	 */
-	DEBUG( MTD_DEBUG_LEVEL3, "MTD %s(): return to ID mode\n", __func__ );
+	MTD_DBG(MTD_DEBUG_LEVEL3, "MTD %s(): return to ID mode\n", __func__);
 	if (cfi->addr_unlock1) {
 		cfi_send_gen_cmd(0xaa, cfi->addr_unlock1, base, map, cfi, cfi->device_type, NULL);
 		cfi_send_gen_cmd(0x55, cfi->addr_unlock2, base, map, cfi, cfi->device_type, NULL);
@@ -2167,12 +2168,12 @@ static int jedec_probe_chip(struct map_info *map, __u32 base,
 
 		cfi->mfr = jedec_read_mfr(map, base, cfi);
 		cfi->id = jedec_read_id(map, base, cfi);
-		DEBUG(MTD_DEBUG_LEVEL3,
+		MTD_DBG(MTD_DEBUG_LEVEL3,
 		      "Search for id:(%02x %02x) interleave(%d) type(%d)\n",
 			cfi->mfr, cfi->id, cfi_interleave(cfi), cfi->device_type);
 		for (i = 0; i < ARRAY_SIZE(jedec_table); i++) {
 			if ( jedec_match( base, map, cfi, &jedec_table[i] ) ) {
-				DEBUG( MTD_DEBUG_LEVEL3,
+				MTD_DBG(MTD_DEBUG_LEVEL3,
 				       "MTD %s(): matched device 0x%x,0x%x unlock_addrs: 0x%.4x 0x%.4x\n",
 				       __func__, cfi->mfr, cfi->id,
 				       cfi->addr_unlock1, cfi->addr_unlock2 );
diff --git a/drivers/mtd/devices/doc2000.c b/drivers/mtd/devices/doc2000.c
index f7fbf60..989f672 100644
--- a/drivers/mtd/devices/doc2000.c
+++ b/drivers/mtd/devices/doc2000.c
@@ -82,7 +82,7 @@ static int _DoC_WaitReady(struct DiskOnChip *doc)
 	void __iomem *docptr = doc->virtadr;
 	unsigned long timeo = jiffies + (HZ * 10);
 
-	DEBUG(MTD_DEBUG_LEVEL3,
+	MTD_DBG(MTD_DEBUG_LEVEL3,
 	      "_DoC_WaitReady called for out-of-line wait\n");
 
 	/* Out-of-line routine to wait for chip response */
@@ -92,7 +92,7 @@ static int _DoC_WaitReady(struct DiskOnChip *doc)
 		DoC_Delay(doc, 2);
 
 		if (time_after(jiffies, timeo)) {
-			DEBUG(MTD_DEBUG_LEVEL2, "_DoC_WaitReady timed out.\n");
+			MTD_DBG(MTD_DEBUG_LEVEL2, "_DoC_WaitReady timed out\n");
 			return -EIO;
 		}
 		udelay(1);
@@ -323,7 +323,7 @@ static int DoC_IdentChip(struct DiskOnChip *doc, int floor, int chip)
 
 	/* Reset the chip */
 	if (DoC_Command(doc, NAND_CMD_RESET, CDSN_CTRL_WP)) {
-		DEBUG(MTD_DEBUG_LEVEL2,
+		MTD_DBG(MTD_DEBUG_LEVEL2,
 		      "DoC_Command (reset) for %d,%d returned true\n",
 		      floor, chip);
 		return 0;
@@ -332,7 +332,7 @@ static int DoC_IdentChip(struct DiskOnChip *doc, int floor, int chip)
 
 	/* Read the NAND chip ID: 1. Send ReadID command */
 	if (DoC_Command(doc, NAND_CMD_READID, CDSN_CTRL_WP)) {
-		DEBUG(MTD_DEBUG_LEVEL2,
+		MTD_DBG(MTD_DEBUG_LEVEL2,
 		      "DoC_Command (ReadID) for %d,%d returned true\n",
 		      floor, chip);
 		return 0;
diff --git a/drivers/mtd/devices/doc2001.c b/drivers/mtd/devices/doc2001.c
index 241192f..c334997 100644
--- a/drivers/mtd/devices/doc2001.c
+++ b/drivers/mtd/devices/doc2001.c
@@ -55,7 +55,7 @@ static int _DoC_WaitReady(void __iomem * docptr)
 {
 	unsigned short c = 0xffff;
 
-	DEBUG(MTD_DEBUG_LEVEL3,
+	MTD_DBG(MTD_DEBUG_LEVEL3,
 	      "_DoC_WaitReady called for out-of-line wait\n");
 
 	/* Out-of-line routine to wait for chip response */
@@ -63,7 +63,7 @@ static int _DoC_WaitReady(void __iomem * docptr)
 		;
 
 	if (c == 0)
-		DEBUG(MTD_DEBUG_LEVEL2, "_DoC_WaitReady timed out.\n");
+		MTD_DBG(MTD_DEBUG_LEVEL2, "_DoC_WaitReady timed out.\n");
 
 	return (c == 0);
 }
diff --git a/drivers/mtd/devices/doc2001plus.c b/drivers/mtd/devices/doc2001plus.c
index 09ae0ad..05bb0e0 100644
--- a/drivers/mtd/devices/doc2001plus.c
+++ b/drivers/mtd/devices/doc2001plus.c
@@ -61,7 +61,7 @@ static int _DoC_WaitReady(void __iomem * docptr)
 {
 	unsigned int c = 0xffff;
 
-	DEBUG(MTD_DEBUG_LEVEL3,
+	MTD_DBG(MTD_DEBUG_LEVEL3,
 	      "_DoC_WaitReady called for out-of-line wait\n");
 
 	/* Out-of-line routine to wait for chip response */
@@ -69,7 +69,7 @@ static int _DoC_WaitReady(void __iomem * docptr)
 		;
 
 	if (c == 0)
-		DEBUG(MTD_DEBUG_LEVEL2, "_DoC_WaitReady timed out.\n");
+		MTD_DBG(MTD_DEBUG_LEVEL2, "_DoC_WaitReady timed out.\n");
 
 	return (c == 0);
 }
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 35180e4..0b592fb 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -209,7 +209,7 @@ static int wait_till_ready(struct m25p *flash)
  */
 static int erase_chip(struct m25p *flash)
 {
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: %s %lldKiB\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: %s %lldKiB\n",
 	      dev_name(&flash->spi->dev), __func__,
 	      (long long)(flash->mtd.size >> 10));
 
@@ -250,7 +250,7 @@ static int m25p_cmdsz(struct m25p *flash)
  */
 static int erase_sector(struct m25p *flash, u32 offset)
 {
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: %s %dKiB at 0x%08x\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: %s %dKiB at 0x%08x\n",
 			dev_name(&flash->spi->dev), __func__,
 			flash->mtd.erasesize / 1024, offset);
 
@@ -286,7 +286,7 @@ static int m25p80_erase(struct mtd_info *mtd, struct erase_info *instr)
 	u32 addr,len;
 	uint32_t rem;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%llx, len %lld\n",
+	MTD_DBG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%llx, len %lld\n",
 	      dev_name(&flash->spi->dev), __func__, "at",
 	      (long long)instr->addr, (long long)instr->len);
 
@@ -348,7 +348,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 	struct spi_transfer t[2];
 	struct spi_message m;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
+	MTD_DBG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
 			dev_name(&flash->spi->dev), __func__, "from",
 			(u32)from, len);
 
@@ -417,7 +417,7 @@ static int m25p80_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct spi_transfer t[2];
 	struct spi_message m;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
+	MTD_DBG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
 			dev_name(&flash->spi->dev), __func__, "to",
 			(u32)to, len);
 
@@ -510,7 +510,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	size_t actual;
 	int cmd_sz, ret;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
+	MTD_DBG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
 			dev_name(&flash->spi->dev), __func__, "to",
 			(u32)to, len);
 
@@ -788,7 +788,7 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
 	 */
 	tmp = spi_write_then_read(spi, &code, 1, id, 5);
 	if (tmp < 0) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: error %d reading JEDEC ID\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: error %d reading JEDEC ID\n",
 			dev_name(&spi->dev), tmp);
 		return ERR_PTR(tmp);
 	}
@@ -945,7 +945,7 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	dev_info(&spi->dev, "%s (%lld Kbytes)\n", id->name,
 			(long long)flash->mtd.size >> 10);
 
-	DEBUG(MTD_DEBUG_LEVEL2,
+	MTD_DBG(MTD_DEBUG_LEVEL2,
 		"mtd .name = %s, .size = 0x%llx (%lldMiB) "
 			".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
 		flash->mtd.name,
@@ -955,7 +955,7 @@ static int __devinit m25p_probe(struct spi_device *spi)
 
 	if (flash->mtd.numeraseregions)
 		for (i = 0; i < flash->mtd.numeraseregions; i++)
-			DEBUG(MTD_DEBUG_LEVEL2,
+			MTD_DBG(MTD_DEBUG_LEVEL2,
 				"mtd.eraseregions[%d] = { .offset = 0x%llx, "
 				".erasesize = 0x%.8x (%uKiB), "
 				".numblocks = %d }\n",
@@ -990,7 +990,7 @@ static int __devinit m25p_probe(struct spi_device *spi)
 
 	if (nr_parts > 0) {
 		for (i = 0; i < nr_parts; i++) {
-			DEBUG(MTD_DEBUG_LEVEL2, "partitions[%d] = "
+			MTD_DBG(MTD_DEBUG_LEVEL2, "partitions[%d] = "
 			      "{.name = %s, .offset = 0x%llx, "
 			      ".size = 0x%llx (%lldKiB) }\n",
 			      i, parts[i].name,
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 13749d4..e86e1b4 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -122,7 +122,7 @@ static int dataflash_waitready(struct spi_device *spi)
 	for (;;) {
 		status = dataflash_status(spi);
 		if (status < 0) {
-			DEBUG(MTD_DEBUG_LEVEL1, "%s: status %d?\n",
+			MTD_DBG(MTD_DEBUG_LEVEL1, "%s: status %d?\n",
 					dev_name(&spi->dev), status);
 			status = 0;
 		}
@@ -149,7 +149,7 @@ static int dataflash_erase(struct mtd_info *mtd, struct erase_info *instr)
 	uint8_t			*command;
 	uint32_t		rem;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "%s: erase addr=0x%llx len 0x%llx\n",
+	MTD_DBG(MTD_DEBUG_LEVEL2, "%s: erase addr=0x%llx len 0x%llx\n",
 	      dev_name(&spi->dev), (long long)instr->addr,
 	      (long long)instr->len);
 
@@ -187,7 +187,7 @@ static int dataflash_erase(struct mtd_info *mtd, struct erase_info *instr)
 		command[2] = (uint8_t)(pageaddr >> 8);
 		command[3] = 0;
 
-		DEBUG(MTD_DEBUG_LEVEL3, "ERASE %s: (%x) %x %x %x [%i]\n",
+		MTD_DBG(MTD_DEBUG_LEVEL3, "ERASE %s: (%x) %x %x %x [%i]\n",
 			do_block ? "block" : "page",
 			command[0], command[1], command[2], command[3],
 			pageaddr);
@@ -238,7 +238,7 @@ static int dataflash_read(struct mtd_info *mtd, loff_t from, size_t len,
 	uint8_t			*command;
 	int			status;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "%s: read 0x%x..0x%x\n",
+	MTD_DBG(MTD_DEBUG_LEVEL2, "%s: read 0x%x..0x%x\n",
 		dev_name(&priv->spi->dev), (unsigned)from, (unsigned)(from + len));
 
 	*retlen = 0;
@@ -255,7 +255,7 @@ static int dataflash_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 	command = priv->command;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "READ: (%x) %x %x %x\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "READ: (%x) %x %x %x\n",
 		command[0], command[1], command[2], command[3]);
 
 	spi_message_init(&msg);
@@ -287,7 +287,7 @@ static int dataflash_read(struct mtd_info *mtd, loff_t from, size_t len,
 		*retlen = msg.actual_length - 8;
 		status = 0;
 	} else
-		DEBUG(MTD_DEBUG_LEVEL1, "%s: read %x..%x --> %d\n",
+		MTD_DBG(MTD_DEBUG_LEVEL1, "%s: read %x..%x --> %d\n",
 			dev_name(&priv->spi->dev),
 			(unsigned)from, (unsigned)(from + len),
 			status);
@@ -314,7 +314,7 @@ static int dataflash_write(struct mtd_info *mtd, loff_t to, size_t len,
 	int			status = -EINVAL;
 	uint8_t			*command;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "%s: write 0x%x..0x%x\n",
+	MTD_DBG(MTD_DEBUG_LEVEL2, "%s: write 0x%x..0x%x\n",
 		dev_name(&spi->dev), (unsigned)to, (unsigned)(to + len));
 
 	*retlen = 0;
@@ -340,7 +340,7 @@ static int dataflash_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	mutex_lock(&priv->lock);
 	while (remaining > 0) {
-		DEBUG(MTD_DEBUG_LEVEL3, "write @ %i:%i len=%i\n",
+		MTD_DBG(MTD_DEBUG_LEVEL3, "write @ %i:%i len=%i\n",
 			pageaddr, offset, writelen);
 
 		/* REVISIT:
@@ -368,13 +368,13 @@ static int dataflash_write(struct mtd_info *mtd, loff_t to, size_t len,
 			command[2] = (addr & 0x0000FF00) >> 8;
 			command[3] = 0;
 
-			DEBUG(MTD_DEBUG_LEVEL3, "TRANSFER: (%x) %x %x %x\n",
+			MTD_DBG(MTD_DEBUG_LEVEL3, "TRANSFER: (%x) %x %x %x\n",
 				command[0], command[1], command[2], command[3]);
 
 			status = spi_sync(spi, &msg);
 			if (status < 0)
-				DEBUG(MTD_DEBUG_LEVEL1, "%s: xfer %u -> %d \n",
-					dev_name(&spi->dev), addr, status);
+				MTD_DBG(MTD_DEBUG_LEVEL1, "%s: xfer %u -> %d \n"
+					, dev_name(&spi->dev), addr, status);
 
 			(void) dataflash_waitready(priv->spi);
 		}
@@ -386,7 +386,7 @@ static int dataflash_write(struct mtd_info *mtd, loff_t to, size_t len,
 		command[2] = (addr & 0x0000FF00) >> 8;
 		command[3] = (addr & 0x000000FF);
 
-		DEBUG(MTD_DEBUG_LEVEL3, "PROGRAM: (%x) %x %x %x\n",
+		MTD_DBG(MTD_DEBUG_LEVEL3, "PROGRAM: (%x) %x %x %x\n",
 			command[0], command[1], command[2], command[3]);
 
 		x[1].tx_buf = writebuf;
@@ -395,7 +395,7 @@ static int dataflash_write(struct mtd_info *mtd, loff_t to, size_t len,
 		status = spi_sync(spi, &msg);
 		spi_transfer_del(x + 1);
 		if (status < 0)
-			DEBUG(MTD_DEBUG_LEVEL1, "%s: pgm %u/%u -> %d \n",
+			MTD_DBG(MTD_DEBUG_LEVEL1, "%s: pgm %u/%u -> %d \n",
 				dev_name(&spi->dev), addr, writelen, status);
 
 		(void) dataflash_waitready(priv->spi);
@@ -410,12 +410,12 @@ static int dataflash_write(struct mtd_info *mtd, loff_t to, size_t len,
 		command[2] = (addr & 0x0000FF00) >> 8;
 		command[3] = 0;
 
-		DEBUG(MTD_DEBUG_LEVEL3, "COMPARE: (%x) %x %x %x\n",
+		MTD_DBG(MTD_DEBUG_LEVEL3, "COMPARE: (%x) %x %x %x\n",
 			command[0], command[1], command[2], command[3]);
 
 		status = spi_sync(spi, &msg);
 		if (status < 0)
-			DEBUG(MTD_DEBUG_LEVEL1, "%s: compare %u -> %d \n",
+			MTD_DBG(MTD_DEBUG_LEVEL1, "%s: compare %u -> %d \n",
 				dev_name(&spi->dev), addr, status);
 
 		status = dataflash_waitready(priv->spi);
@@ -787,7 +787,7 @@ static struct flash_info *__devinit jedec_probe(struct spi_device *spi)
 	 */
 	tmp = spi_write_then_read(spi, &code, 1, id, 3);
 	if (tmp < 0) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: error %d reading JEDEC ID\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: error %d reading JEDEC ID\n",
 			dev_name(&spi->dev), tmp);
 		return ERR_PTR(tmp);
 	}
@@ -804,7 +804,7 @@ static struct flash_info *__devinit jedec_probe(struct spi_device *spi)
 			tmp < ARRAY_SIZE(dataflash_data);
 			tmp++, info++) {
 		if (info->jedec_id == jedec) {
-			DEBUG(MTD_DEBUG_LEVEL1, "%s: OTP, sector protect%s\n",
+			MTD_DBG(MTD_DEBUG_LEVEL1, "%s: OTP, sector protect%s\n",
 				dev_name(&spi->dev),
 				(info->flags & SUP_POW2PS)
 					? ", binary pagesize" : ""
@@ -812,7 +812,7 @@ static struct flash_info *__devinit jedec_probe(struct spi_device *spi)
 			if (info->flags & SUP_POW2PS) {
 				status = dataflash_status(spi);
 				if (status < 0) {
-					DEBUG(MTD_DEBUG_LEVEL1,
+					MTD_DBG(MTD_DEBUG_LEVEL1,
 						"%s: status error %d\n",
 						dev_name(&spi->dev), status);
 					return ERR_PTR(status);
@@ -878,7 +878,7 @@ static int __devinit dataflash_probe(struct spi_device *spi)
 	 */
 	status = dataflash_status(spi);
 	if (status <= 0 || status == 0xff) {
-		DEBUG(MTD_DEBUG_LEVEL1, "%s: status error %d\n",
+		MTD_DBG(MTD_DEBUG_LEVEL1, "%s: status error %d\n",
 				dev_name(&spi->dev), status);
 		if (status == 0 || status == 0xff)
 			status = -ENODEV;
@@ -914,13 +914,13 @@ static int __devinit dataflash_probe(struct spi_device *spi)
 		break;
 	/* obsolete AT45DB1282 not (yet?) supported */
 	default:
-		DEBUG(MTD_DEBUG_LEVEL1, "%s: unsupported device (%x)\n",
+		MTD_DBG(MTD_DEBUG_LEVEL1, "%s: unsupported device (%x)\n",
 				dev_name(&spi->dev), status & 0x3c);
 		status = -ENODEV;
 	}
 
 	if (status < 0)
-		DEBUG(MTD_DEBUG_LEVEL1, "%s: add_dataflash --> %d\n",
+		MTD_DBG(MTD_DEBUG_LEVEL1, "%s: add_dataflash --> %d\n",
 				dev_name(&spi->dev), status);
 
 	return status;
@@ -931,7 +931,7 @@ static int __devexit dataflash_remove(struct spi_device *spi)
 	struct dataflash	*flash = dev_get_drvdata(&spi->dev);
 	int			status;
 
-	DEBUG(MTD_DEBUG_LEVEL1, "%s: remove\n", dev_name(&spi->dev));
+	MTD_DBG(MTD_DEBUG_LEVEL1, "%s: remove\n", dev_name(&spi->dev));
 
 	status = mtd_device_unregister(&flash->mtd);
 	if (status == 0) {
diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index 83e80c6..b085bf3 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -414,7 +414,7 @@ static int __devinit sst25l_probe(struct spi_device *spi)
 	dev_info(&spi->dev, "%s (%lld KiB)\n", flash_info->name,
 		 (long long)flash->mtd.size >> 10);
 
-	DEBUG(MTD_DEBUG_LEVEL2,
+	MTD_DBG(MTD_DEBUG_LEVEL2,
 	      "mtd .name = %s, .size = 0x%llx (%lldMiB) "
 	      ".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
 	      flash->mtd.name,
@@ -438,7 +438,7 @@ static int __devinit sst25l_probe(struct spi_device *spi)
 
 	if (nr_parts > 0) {
 		for (i = 0; i < nr_parts; i++) {
-			DEBUG(MTD_DEBUG_LEVEL2, "partitions[%d] = "
+			MTD_DBG(MTD_DEBUG_LEVEL2, "partitions[%d] = "
 			      "{.name = %s, .offset = 0x%llx, "
 			      ".size = 0x%llx (%lldKiB) }\n",
 			      i, parts[i].name,
diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index 037b399..640b0ce 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -339,7 +339,7 @@ static int erase_xfer(partition_t *part,
     struct erase_info *erase;
 
     xfer = &part->XferInfo[xfernum];
-    DEBUG(1, "ftl_cs: erasing xfer unit at 0x%x\n", xfer->Offset);
+    MTD_DBG(1, "ftl_cs: erasing xfer unit at 0x%x\n", xfer->Offset);
     xfer->state = XFER_ERASING;
 
     /* Is there a free erase slot? Always in MTD. */
@@ -415,7 +415,7 @@ static int prepare_xfer(partition_t *part, int i)
     xfer = &part->XferInfo[i];
     xfer->state = XFER_FAILED;
 
-    DEBUG(1, "ftl_cs: preparing xfer unit at 0x%x\n", xfer->Offset);
+    MTD_DBG(1, "ftl_cs: preparing xfer unit at 0x%x\n", xfer->Offset);
 
     /* Write the transfer unit header */
     header = part->header;
@@ -476,7 +476,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
 
     eun = &part->EUNInfo[srcunit];
     xfer = &part->XferInfo[xferunit];
-    DEBUG(2, "ftl_cs: copying block 0x%x to 0x%x\n",
+    MTD_DBG(2, "ftl_cs: copying block 0x%x to 0x%x\n",
 	  eun->Offset, xfer->Offset);
 
 
@@ -609,8 +609,8 @@ static int reclaim_block(partition_t *part)
     uint32_t best;
     int queued, ret;
 
-    DEBUG(0, "ftl_cs: reclaiming space...\n");
-    DEBUG(3, "NumTransferUnits == %x\n", part->header.NumTransferUnits);
+    MTD_DBG(0, "ftl_cs: reclaiming space...\n");
+    MTD_DBG(3, "NumTransferUnits == %x\n", part->header.NumTransferUnits);
     /* Pick the least erased transfer unit */
     best = 0xffffffff; xfer = 0xffff;
     do {
@@ -618,35 +618,36 @@ static int reclaim_block(partition_t *part)
 	for (i = 0; i < part->header.NumTransferUnits; i++) {
 	    int n=0;
 	    if (part->XferInfo[i].state == XFER_UNKNOWN) {
-		DEBUG(3,"XferInfo[%d].state == XFER_UNKNOWN\n",i);
+		MTD_DBG(3, "XferInfo[%d].state == XFER_UNKNOWN\n", i);
 		n=1;
 		erase_xfer(part, i);
 	    }
 	    if (part->XferInfo[i].state == XFER_ERASING) {
-		DEBUG(3,"XferInfo[%d].state == XFER_ERASING\n",i);
+		MTD_DBG(3, "XferInfo[%d].state == XFER_ERASING\n", i);
 		n=1;
 		queued = 1;
 	    }
 	    else if (part->XferInfo[i].state == XFER_ERASED) {
-		DEBUG(3,"XferInfo[%d].state == XFER_ERASED\n",i);
+		MTD_DBG(3, "XferInfo[%d].state == XFER_ERASED\n", i);
 		n=1;
 		prepare_xfer(part, i);
 	    }
 	    if (part->XferInfo[i].state == XFER_PREPARED) {
-		DEBUG(3,"XferInfo[%d].state == XFER_PREPARED\n",i);
+		MTD_DBG(3, "XferInfo[%d].state == XFER_PREPARED\n", i);
 		n=1;
 		if (part->XferInfo[i].EraseCount <= best) {
 		    best = part->XferInfo[i].EraseCount;
 		    xfer = i;
 		}
 	    }
-		if (!n)
-		    DEBUG(3,"XferInfo[%d].state == %x\n",i, part->XferInfo[i].state);
+	    if (!n)
+		MTD_DBG(3, "XferInfo[%d].state == %x\n", i,
+			part->XferInfo[i].state);
 
 	}
 	if (xfer == 0xffff) {
 	    if (queued) {
-		DEBUG(1, "ftl_cs: waiting for transfer "
+		MTD_DBG(1, "ftl_cs: waiting for transfer "
 		      "unit to be prepared...\n");
 		if (part->mbd.mtd->sync)
 			part->mbd.mtd->sync(part->mbd.mtd);
@@ -656,7 +657,7 @@ static int reclaim_block(partition_t *part)
 		    printk(KERN_NOTICE "ftl_cs: reclaim failed: no "
 			   "suitable transfer units!\n");
 		else
-		    DEBUG(1, "ftl_cs: reclaim failed: no "
+		    MTD_DBG(1, "ftl_cs: reclaim failed: no "
 			  "suitable transfer units!\n");
 
 		return -EIO;
@@ -666,7 +667,7 @@ static int reclaim_block(partition_t *part)
 
     eun = 0;
     if ((jiffies % shuffle_freq) == 0) {
-	DEBUG(1, "ftl_cs: recycling freshest block...\n");
+	MTD_DBG(1, "ftl_cs: recycling freshest block...\n");
 	best = 0xffffffff;
 	for (i = 0; i < part->DataUnits; i++)
 	    if (part->EUNInfo[i].EraseCount <= best) {
@@ -686,7 +687,7 @@ static int reclaim_block(partition_t *part)
 		printk(KERN_NOTICE "ftl_cs: reclaim failed: "
 		       "no free blocks!\n");
 	    else
-		DEBUG(1,"ftl_cs: reclaim failed: "
+		MTD_DBG(1, "ftl_cs: reclaim failed: "
 		       "no free blocks!\n");
 
 	    return -EIO;
@@ -771,7 +772,7 @@ static uint32_t find_free(partition_t *part)
 	printk(KERN_NOTICE "ftl_cs: bad free list!\n");
 	return 0;
     }
-    DEBUG(2, "ftl_cs: found free block at %d in %d\n", blk, eun);
+    MTD_DBG(2, "ftl_cs: found free block@%d in %d\n", blk, eun);
     return blk;
 
 } /* find_free */
@@ -791,7 +792,7 @@ static int ftl_read(partition_t *part, caddr_t buffer,
     int ret;
     size_t offset, retlen;
 
-    DEBUG(2, "ftl_cs: ftl_read(0x%p, 0x%lx, %ld)\n",
+    MTD_DBG(2, "ftl_cs: ftl_read(0x%p, 0x%lx, %ld)\n",
 	  part, sector, nblocks);
     if (!(part->state & FTL_FORMATTED)) {
 	printk(KERN_NOTICE "ftl_cs: bad partition\n");
@@ -840,7 +841,7 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
     int ret;
     size_t retlen, offset;
 
-    DEBUG(2, "ftl_cs: set_bam_entry(0x%p, 0x%x, 0x%x)\n",
+    MTD_DBG(2, "ftl_cs: set_bam_entry(0x%p, 0x%x, 0x%x)\n",
 	  part, log_addr, virt_addr);
     bsize = 1 << part->header.EraseUnitSize;
     eun = log_addr / bsize;
@@ -905,7 +906,7 @@ static int ftl_write(partition_t *part, caddr_t buffer,
     int ret;
     size_t retlen, offset;
 
-    DEBUG(2, "ftl_cs: ftl_write(0x%p, %ld, %ld)\n",
+    MTD_DBG(2, "ftl_cs: ftl_write(0x%p, %ld, %ld)\n",
 	  part, sector, nblocks);
     if (!(part->state & FTL_FORMATTED)) {
 	printk(KERN_NOTICE "ftl_cs: bad partition\n");
@@ -1011,7 +1012,7 @@ static int ftl_discardsect(struct mtd_blktrans_dev *dev,
 	partition_t *part = (void *)dev;
 	uint32_t bsize = 1 << part->header.EraseUnitSize;
 
-	DEBUG(1, "FTL erase sector %ld for %d sectors\n",
+	MTD_DBG(1, "FTL erase sector %ld for %d sectors\n",
 	      sector, nr_sects);
 
 	while (nr_sects) {
diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index d7592e6..3e0dd42 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -63,7 +63,7 @@ static void inftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 		return;
 	}
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: add_mtd for %s\n", mtd->name);
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: add_mtd for %s\n", mtd->name);
 
 	inftl = kzalloc(sizeof(*inftl), GFP_KERNEL);
 
@@ -133,7 +133,7 @@ static void inftl_remove_dev(struct mtd_blktrans_dev *dev)
 {
 	struct INFTLrecord *inftl = (void *)dev;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: remove_dev (i=%d)\n", dev->devnum);
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: remove_dev (i=%d)\n", dev->devnum);
 
 	del_mtd_blktrans_dev(dev);
 
@@ -215,7 +215,7 @@ static u16 INFTL_findfreeblock(struct INFTLrecord *inftl, int desperate)
 	u16 pot = inftl->LastFreeEUN;
 	int silly = inftl->nb_blocks;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_findfreeblock(inftl=%p,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_findfreeblock(inftl=%p,"
 		"desperate=%d)\n", inftl, desperate);
 
 	/*
@@ -223,7 +223,7 @@ static u16 INFTL_findfreeblock(struct INFTLrecord *inftl, int desperate)
 	 * blocks completely.
 	 */
 	if (!desperate && inftl->numfreeEUNs < 2) {
-		DEBUG(MTD_DEBUG_LEVEL1, "INFTL: there are too few free "
+		MTD_DBG(MTD_DEBUG_LEVEL1, "INFTL: there are too few free "
 			"EUNs (%d)\n", inftl->numfreeEUNs);
 		return BLOCK_NIL;
 	}
@@ -259,7 +259,7 @@ static u16 INFTL_foldchain(struct INFTLrecord *inftl, unsigned thisVUC, unsigned
 	struct inftl_oob oob;
 	size_t retlen;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_foldchain(inftl=%p,thisVUC=%d,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_foldchain(inftl=%p,thisVUC=%d,"
 		"pending=%d)\n", inftl, thisVUC, pendingblock);
 
 	memset(BlockMap, 0xff, sizeof(BlockMap));
@@ -323,7 +323,7 @@ static u16 INFTL_foldchain(struct INFTLrecord *inftl, unsigned thisVUC, unsigned
 	 * Chain, and the Erase Unit into which we are supposed to be copying.
 	 * Go for it.
 	 */
-	DEBUG(MTD_DEBUG_LEVEL1, "INFTL: folding chain %d into unit %d\n",
+	MTD_DBG(MTD_DEBUG_LEVEL1, "INFTL: folding chain %d into unit %d\n",
 		thisVUC, targetEUN);
 
 	for (block = 0; block < inftl->EraseSize/SECTORSIZE ; block++) {
@@ -355,7 +355,7 @@ static u16 INFTL_foldchain(struct INFTLrecord *inftl, unsigned thisVUC, unsigned
 					(block * SECTORSIZE), SECTORSIZE,
 					&retlen, movebuf);
 			if (ret != -EIO)
-				DEBUG(MTD_DEBUG_LEVEL1, "INFTL: error went "
+				MTD_DBG(MTD_DEBUG_LEVEL1, "INFTL: error went "
 				      "away on retry?\n");
 		}
 		memset(&oob, 0xff, sizeof(struct inftl_oob));
@@ -372,7 +372,7 @@ static u16 INFTL_foldchain(struct INFTLrecord *inftl, unsigned thisVUC, unsigned
 	 * is important, by doing oldest first if we crash/reboot then it
 	 * it is relatively simple to clean up the mess).
 	 */
-	DEBUG(MTD_DEBUG_LEVEL1, "INFTL: want to erase virtual chain %d\n",
+	MTD_DBG(MTD_DEBUG_LEVEL1, "INFTL: want to erase virtual chain %d\n",
 		thisVUC);
 
 	for (;;) {
@@ -421,7 +421,7 @@ static u16 INFTL_makefreeblock(struct INFTLrecord *inftl, unsigned pendingblock)
 	u16 ChainLength = 0, thislen;
 	u16 chain, EUN;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_makefreeblock(inftl=%p,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_makefreeblock(inftl=%p,"
 		"pending=%d)\n", inftl, pendingblock);
 
 	for (chain = 0; chain < inftl->nb_blocks; chain++) {
@@ -484,7 +484,7 @@ static inline u16 INFTL_findwriteunit(struct INFTLrecord *inftl, unsigned block)
 	size_t retlen;
 	int silly, silly2 = 3;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_findwriteunit(inftl=%p,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_findwriteunit(inftl=%p,"
 		"block=%d)\n", inftl, block);
 
 	do {
@@ -501,8 +501,8 @@ static inline u16 INFTL_findwriteunit(struct INFTLrecord *inftl, unsigned block)
 				       blockofs, 8, &retlen, (char *)&bci);
 
 			status = bci.Status | bci.Status1;
-			DEBUG(MTD_DEBUG_LEVEL3, "INFTL: status of block %d in "
-				"EUN %d is %x\n", block , writeEUN, status);
+			MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: status of block %d in"
+				" EUN %d is %x\n", block , writeEUN, status);
 
 			switch(status) {
 			case SECTOR_FREE:
@@ -555,7 +555,7 @@ hitused:
 			 * Hopefully we free something, lets try again.
 			 * This time we are desperate...
 			 */
-			DEBUG(MTD_DEBUG_LEVEL1, "INFTL: using desperate==1 "
+			MTD_DBG(MTD_DEBUG_LEVEL1, "INFTL: using desperate==1 "
 				"to find free EUN to accommodate write to "
 				"VUC %d\n", thisVUC);
 			writeEUN = INFTL_findfreeblock(inftl, 1);
@@ -647,7 +647,7 @@ static void INFTL_trydeletechain(struct INFTLrecord *inftl, unsigned thisVUC)
 	struct inftl_bci bci;
 	size_t retlen;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_trydeletechain(inftl=%p,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_trydeletechain(inftl=%p,"
 		"thisVUC=%d)\n", inftl, thisVUC);
 
 	memset(BlockUsed, 0, sizeof(BlockUsed));
@@ -711,7 +711,7 @@ static void INFTL_trydeletechain(struct INFTLrecord *inftl, unsigned thisVUC)
 	 * For each block in the chain free it and make it available
 	 * for future use. Erase from the oldest unit first.
 	 */
-	DEBUG(MTD_DEBUG_LEVEL1, "INFTL: deleting empty VUC %d\n", thisVUC);
+	MTD_DBG(MTD_DEBUG_LEVEL1, "INFTL: deleting empty VUC %d\n", thisVUC);
 
 	for (;;) {
 		u16 *prevEUN = &inftl->VUtable[thisVUC];
@@ -719,7 +719,8 @@ static void INFTL_trydeletechain(struct INFTLrecord *inftl, unsigned thisVUC)
 
 		/* If the chain is all gone already, we're done */
 		if (thisEUN == BLOCK_NIL) {
-			DEBUG(MTD_DEBUG_LEVEL2, "INFTL: Empty VUC %d for deletion was already absent\n", thisEUN);
+			MTD_DBG(MTD_DEBUG_LEVEL2, "INFTL: Empty VUC %d for "
+				"deletion was already absent\n", thisEUN);
 			return;
 		}
 
@@ -731,7 +732,7 @@ static void INFTL_trydeletechain(struct INFTLrecord *inftl, unsigned thisVUC)
 			thisEUN = *prevEUN;
 		}
 
-		DEBUG(MTD_DEBUG_LEVEL3, "Deleting EUN %d from VUC %d\n",
+		MTD_DBG(MTD_DEBUG_LEVEL3, "Deleting EUN %d from VUC %d\n",
 		      thisEUN, thisVUC);
 
 		if (INFTL_formatblock(inftl, thisEUN) < 0) {
@@ -767,7 +768,7 @@ static int INFTL_deleteblock(struct INFTLrecord *inftl, unsigned block)
 	size_t retlen;
 	struct inftl_bci bci;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_deleteblock(inftl=%p,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_deleteblock(inftl=%p,"
 		"block=%d)\n", inftl, block);
 
 	while (thisEUN < inftl->nb_blocks) {
@@ -826,7 +827,7 @@ static int inftl_writeblock(struct mtd_blktrans_dev *mbd, unsigned long block,
 	struct inftl_oob oob;
 	char *p, *pend;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: inftl_writeblock(inftl=%p,block=%ld,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: inftl_writeblock(inftl=%p,block=%ld,"
 		"buffer=%p)\n", inftl, block, buffer);
 
 	/* Is block all zero? */
@@ -876,7 +877,7 @@ static int inftl_readblock(struct mtd_blktrans_dev *mbd, unsigned long block,
 	struct inftl_bci bci;
 	size_t retlen;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: inftl_readblock(inftl=%p,block=%ld,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: inftl_readblock(inftl=%p,block=%ld,"
 		"buffer=%p)\n", inftl, block, buffer);
 
 	while (thisEUN < inftl->nb_blocks) {
diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
index 104052e..e1fbc5a 100644
--- a/drivers/mtd/inftlmount.c
+++ b/drivers/mtd/inftlmount.c
@@ -53,7 +53,7 @@ static int find_boot_record(struct INFTLrecord *inftl)
 	struct INFTLPartition *ip;
 	size_t retlen;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: find_boot_record(inftl=%p)\n", inftl);
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: find_boot_record(inftl=%p)\n", inftl);
 
         /*
 	 * Assume logical EraseSize == physical erasesize for starting the
@@ -385,7 +385,7 @@ int INFTL_formatblock(struct INFTLrecord *inftl, int block)
 	struct mtd_info *mtd = inftl->mbd.mtd;
 	int physblock;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_formatblock(inftl=%p,"
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_formatblock(inftl=%p,"
 		"block=%d)\n", inftl, block);
 
 	memset(instr, 0, sizeof(struct erase_info));
@@ -555,7 +555,7 @@ int INFTL_mount(struct INFTLrecord *s)
 	int i;
 	u8 *ANACtable, ANAC;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_mount(inftl=%p)\n", s);
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_mount(inftl=%p)\n", s);
 
 	/* Search for INFTL MediaHeader and Spare INFTL Media Header */
 	if (find_boot_record(s) < 0) {
@@ -585,7 +585,7 @@ int INFTL_mount(struct INFTLrecord *s)
 	 * NOTEXPLORED state. Then@the end we will try to format it and
 	 * mark it as free.
 	 */
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: pass 1, explore each unit\n");
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: pass 1, explore each unit\n");
 	for (first_block = s->firstEUN; first_block <= s->lastEUN; first_block++) {
 		if (s->PUtable[first_block] != BLOCK_NOTEXPLORED)
 			continue;
@@ -727,7 +727,7 @@ int INFTL_mount(struct INFTLrecord *s)
 	 * possible because we don't update the previous pointers when
 	 * we fold chains. No big deal, just fix them up in PUtable.
 	 */
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: pass 2, validate virtual chains\n");
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: pass 2, validate virtual chains\n");
 	for (logical_block = 0; logical_block < s->numvunits; logical_block++) {
 		block = s->VUtable[logical_block];
 		last_block = BLOCK_NIL;
@@ -785,7 +785,7 @@ int INFTL_mount(struct INFTLrecord *s)
 	s->numfreeEUNs = 0;
 	s->LastFreeEUN = BLOCK_NIL;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: pass 3, format unused blocks\n");
+	MTD_DBG(MTD_DEBUG_LEVEL3, "INFTL: pass 3, format unused blocks\n");
 	for (block = s->firstEUN; block <= s->lastEUN; block++) {
 		if (s->PUtable[block] == BLOCK_NOTEXPLORED) {
 			printk("INFTL: unreferenced block %d, formatting it\n",
diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index 3326615..51c6290 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -119,7 +119,7 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
 	if (mtdblk->cache_state != STATE_DIRTY)
 		return 0;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "mtdblock: writing cached data for \"%s\" "
+	MTD_DBG(MTD_DEBUG_LEVEL2, "mtdblock: writing cached data for \"%s\" "
 			"at 0x%lx, size 0x%x\n", mtd->name,
 			mtdblk->cache_offset, mtdblk->cache_size);
 
@@ -148,8 +148,8 @@ static int do_cached_write (struct mtdblk_dev *mtdblk, unsigned long pos,
 	size_t retlen;
 	int ret;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "mtdblock: write on \"%s\" at 0x%lx, size 0x%x\n",
-		mtd->name, pos, len);
+	MTD_DBG(MTD_DEBUG_LEVEL2, "mtdblock: write on \"%s\" at 0x%lx, size "
+		"0x%x\n", mtd->name, pos, len);
 
 	if (!sect_size)
 		return mtd->write(mtd, pos, len, &retlen, buf);
@@ -218,8 +218,8 @@ static int do_cached_read (struct mtdblk_dev *mtdblk, unsigned long pos,
 	size_t retlen;
 	int ret;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "mtdblock: read on \"%s\" at 0x%lx, size 0x%x\n",
-			mtd->name, pos, len);
+	MTD_DBG(MTD_DEBUG_LEVEL2, "mtdblock: read on \"%s\" at 0x%lx, size "
+			"0x%x\n", mtd->name, pos, len);
 
 	if (!sect_size)
 		return mtd->read(mtd, pos, len, &retlen, buf);
@@ -283,7 +283,7 @@ static int mtdblock_open(struct mtd_blktrans_dev *mbd)
 {
 	struct mtdblk_dev *mtdblk = container_of(mbd, struct mtdblk_dev, mbd);
 
-	DEBUG(MTD_DEBUG_LEVEL1,"mtdblock_open\n");
+	MTD_DBG(MTD_DEBUG_LEVEL1, "mtdblock_open\n");
 
 	mutex_lock(&mtdblks_lock);
 	if (mtdblk->count) {
@@ -303,7 +303,7 @@ static int mtdblock_open(struct mtd_blktrans_dev *mbd)
 
 	mutex_unlock(&mtdblks_lock);
 
-	DEBUG(MTD_DEBUG_LEVEL1, "ok\n");
+	MTD_DBG(MTD_DEBUG_LEVEL1, "ok\n");
 
 	return 0;
 }
@@ -312,7 +312,7 @@ static int mtdblock_release(struct mtd_blktrans_dev *mbd)
 {
 	struct mtdblk_dev *mtdblk = container_of(mbd, struct mtdblk_dev, mbd);
 
-   	DEBUG(MTD_DEBUG_LEVEL1, "mtdblock_release\n");
+	MTD_DBG(MTD_DEBUG_LEVEL1, "mtdblock_release\n");
 
 	mutex_lock(&mtdblks_lock);
 
@@ -329,7 +329,7 @@ static int mtdblock_release(struct mtd_blktrans_dev *mbd)
 
 	mutex_unlock(&mtdblks_lock);
 
-	DEBUG(MTD_DEBUG_LEVEL1, "ok\n");
+	MTD_DBG(MTD_DEBUG_LEVEL1, "ok\n");
 
 	return 0;
 }
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index f1af222..6e6d1dc 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -86,7 +86,7 @@ static int mtd_open(struct inode *inode, struct file *file)
 	struct mtd_file_info *mfi;
 	struct inode *mtd_ino;
 
-	DEBUG(MTD_DEBUG_LEVEL0, "MTD_open\n");
+	MTD_DBG(MTD_DEBUG_LEVEL0, "MTD_open\n");
 
 	/* You can't open the RO devices RW */
 	if ((file->f_mode & FMODE_WRITE) && (minor & 1))
@@ -151,7 +151,7 @@ static int mtd_close(struct inode *inode, struct file *file)
 	struct mtd_file_info *mfi = file->private_data;
 	struct mtd_info *mtd = mfi->mtd;
 
-	DEBUG(MTD_DEBUG_LEVEL0, "MTD_close\n");
+	MTD_DBG(MTD_DEBUG_LEVEL0, "MTD_close\n");
 
 	/* Only sync if opened RW */
 	if ((file->f_mode & FMODE_WRITE) && mtd->sync)
@@ -195,7 +195,7 @@ static ssize_t mtd_read(struct file *file, char __user *buf, size_t count,loff_t
 	size_t size = count;
 	char *kbuf;
 
-	DEBUG(MTD_DEBUG_LEVEL0,"MTD_read\n");
+	MTD_DBG(MTD_DEBUG_LEVEL0, "MTD_read\n");
 
 	if (*ppos + count > mtd->size)
 		count = mtd->size - *ppos;
@@ -278,7 +278,7 @@ static ssize_t mtd_write(struct file *file, const char __user *buf, size_t count
 	int ret=0;
 	int len;
 
-	DEBUG(MTD_DEBUG_LEVEL0,"MTD_write\n");
+	MTD_DBG(MTD_DEBUG_LEVEL0, "MTD_write\n");
 
 	if (*ppos == mtd->size)
 		return -ENOSPC;
@@ -553,7 +553,7 @@ static int mtd_ioctl(struct file *file, u_int cmd, u_long arg)
 	u_long size;
 	struct mtd_info_user info;
 
-	DEBUG(MTD_DEBUG_LEVEL0, "MTD_ioctl\n");
+	MTD_DBG(MTD_DEBUG_LEVEL0, "MTD_ioctl\n");
 
 	size = (cmd & IOCSIZE_MASK) >> IOCSIZE_SHIFT;
 	if (cmd & IOC_IN) {
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index c510aff..ad9a567 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -362,7 +362,7 @@ int add_mtd_device(struct mtd_info *mtd)
 			      MTD_DEVT(i) + 1,
 			      NULL, "mtd%dro", i);
 
-	DEBUG(0, "mtd: Giving out device %d to %s\n", i, mtd->name);
+	MTD_DBG(0, "mtd: Giving out device %d to %s\n", i, mtd->name);
 	/* No need to get a refcount on the module containing
 	   the notifier, since we hold the mtd_table_mutex */
 	list_for_each_entry(not, &mtd_notifiers, list)
diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index 16b02a1..b4e6fbd 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -26,12 +26,12 @@ static int get_sb_mtd_compare(struct super_block *sb, void *_mtd)
 	struct mtd_info *mtd = _mtd;
 
 	if (sb->s_mtd == mtd) {
-		DEBUG(2, "MTDSB: Match on device %d (\"%s\")\n",
+		MTD_DBG(2, "MTDSB: Match on device %d (\"%s\")\n",
 		      mtd->index, mtd->name);
 		return 1;
 	}
 
-	DEBUG(2, "MTDSB: No match, device %d (\"%s\"), device %d (\"%s\")\n",
+	MTD_DBG(2, "MTDSB: No match, device %d (\"%s\"), device %d (\"%s\")\n",
 	      sb->s_mtd->index, sb->s_mtd->name, mtd->index, mtd->name);
 	return 0;
 }
@@ -70,7 +70,7 @@ static struct dentry *mount_mtd_aux(struct file_system_type *fs_type, int flags,
 		goto already_mounted;
 
 	/* fresh new superblock */
-	DEBUG(1, "MTDSB: New superblock for device %d (\"%s\")\n",
+	MTD_DBG(1, "MTDSB: New superblock for device %d (\"%s\")\n",
 	      mtd->index, mtd->name);
 
 	sb->s_flags = flags;
@@ -87,7 +87,7 @@ static struct dentry *mount_mtd_aux(struct file_system_type *fs_type, int flags,
 
 	/* new mountpoint for an already mounted superblock */
 already_mounted:
-	DEBUG(1, "MTDSB: Device %d (\"%s\") is already mounted\n",
+	MTD_DBG(1, "MTDSB: Device %d (\"%s\") is already mounted\n",
 	      mtd->index, mtd->name);
 	put_mtd_device(mtd);
 	return dget(sb->s_root);
@@ -108,7 +108,8 @@ static struct dentry *mount_mtd_nr(struct file_system_type *fs_type, int flags,
 
 	mtd = get_mtd_device(NULL, mtdnr);
 	if (IS_ERR(mtd)) {
-		DEBUG(0, "MTDSB: Device #%u doesn't appear to exist\n", mtdnr);
+		MTD_DBG(0, "MTDSB: Device #%u doesn't appear to exist\n",
+			mtdnr);
 		return ERR_CAST(mtd);
 	}
 
@@ -131,7 +132,7 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 	if (!dev_name)
 		return ERR_PTR(-EINVAL);
 
-	DEBUG(2, "MTDSB: dev_name \"%s\"\n", dev_name);
+	MTD_DBG(2, "MTDSB: dev_name \"%s\"\n", dev_name);
 
 	/* the preferred way of mounting in future; especially when
 	 * CONFIG_BLOCK=n - we specify the underlying MTD device by number or
@@ -142,7 +143,7 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 			struct mtd_info *mtd;
 
 			/* mount by MTD device name */
-			DEBUG(1, "MTDSB: mtd:%%s, name \"%s\"\n",
+			MTD_DBG(1, "MTDSB: mtd:%%s, name \"%s\"\n",
 			      dev_name + 4);
 
 			mtd = get_mtd_device_nm(dev_name + 4);
@@ -163,7 +164,7 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 			mtdnr = simple_strtoul(dev_name + 3, &endptr, 0);
 			if (!*endptr) {
 				/* It was a valid number */
-				DEBUG(1, "MTDSB: mtd%%d, mtdnr %d\n",
+				MTD_DBG(1, "MTDSB: mtd%%d, mtdnr %d\n",
 				      mtdnr);
 				return mount_mtd_nr(fs_type, flags,
 						     dev_name, data,
@@ -179,10 +180,10 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 	bdev = lookup_bdev(dev_name);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
-		DEBUG(1, "MTDSB: lookup_bdev() returned %d\n", ret);
+		MTD_DBG(1, "MTDSB: lookup_bdev() returned %d\n", ret);
 		return ERR_PTR(ret);
 	}
-	DEBUG(1, "MTDSB: lookup_bdev() returned 0\n");
+	MTD_DBG(1, "MTDSB: lookup_bdev() returned 0\n");
 
 	ret = -EINVAL;
 
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 90df34c..891ab0d 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -350,7 +350,7 @@ static void wait_op_done(struct mxc_nand_host *host, int useirq)
 			udelay(1);
 		}
 		if (max_retries < 0)
-			DEBUG(MTD_DEBUG_LEVEL0, "%s: INT not set\n",
+			MTD_DBG(MTD_DEBUG_LEVEL0, "%s: INT not set\n",
 			      __func__);
 	}
 }
@@ -371,7 +371,7 @@ static void send_cmd_v3(struct mxc_nand_host *host, uint16_t cmd, int useirq)
  * waits for completion. */
 static void send_cmd_v1_v2(struct mxc_nand_host *host, uint16_t cmd, int useirq)
 {
-	DEBUG(MTD_DEBUG_LEVEL3, "send_cmd(host, 0x%x, %d)\n", cmd, useirq);
+	MTD_DBG(MTD_DEBUG_LEVEL3, "send_cmd(host, 0x%x, %d)\n", cmd, useirq);
 
 	writew(cmd, NFC_V1_V2_FLASH_CMD);
 	writew(NFC_CMD, NFC_V1_V2_CONFIG2);
@@ -387,7 +387,7 @@ static void send_cmd_v1_v2(struct mxc_nand_host *host, uint16_t cmd, int useirq)
 			udelay(1);
 		}
 		if (max_retries < 0)
-			DEBUG(MTD_DEBUG_LEVEL0, "%s: RESET failed\n",
+			MTD_DBG(MTD_DEBUG_LEVEL0, "%s: RESET failed\n",
 			      __func__);
 	} else {
 		/* Wait for operation to complete */
@@ -411,7 +411,7 @@ static void send_addr_v3(struct mxc_nand_host *host, uint16_t addr, int islast)
  * a NAND command. */
 static void send_addr_v1_v2(struct mxc_nand_host *host, uint16_t addr, int islast)
 {
-	DEBUG(MTD_DEBUG_LEVEL3, "send_addr(host, 0x%x %d)\n", addr, islast);
+	MTD_DBG(MTD_DEBUG_LEVEL3, "send_addr(host, 0x%x %d)\n", addr, islast);
 
 	writew(addr, NFC_V1_V2_FLASH_ADDR);
 	writew(NFC_ADDR, NFC_V1_V2_CONFIG2);
@@ -561,7 +561,7 @@ static int mxc_nand_correct_data_v1(struct mtd_info *mtd, u_char *dat,
 	uint16_t ecc_status = readw(NFC_V1_V2_ECC_STATUS_RESULT);
 
 	if (((ecc_status & 0x3) == 2) || ((ecc_status >> 2) == 2)) {
-		DEBUG(MTD_DEBUG_LEVEL0,
+		MTD_DBG(MTD_DEBUG_LEVEL0,
 		      "MXC_NAND: HWECC uncorrectable 2-bit ECC error\n");
 		return -1;
 	}
@@ -932,7 +932,7 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 	struct nand_chip *nand_chip = mtd->priv;
 	struct mxc_nand_host *host = nand_chip->priv;
 
-	DEBUG(MTD_DEBUG_LEVEL3,
+	MTD_DBG(MTD_DEBUG_LEVEL3,
 	      "mxc_nand_command (cmd = 0x%x, col = 0x%x, page = 0x%x)\n",
 	      command, column, page_addr);
 
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index a46e9bb..7d35277 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -113,20 +113,20 @@ static int check_offs_len(struct mtd_info *mtd,
 
 	/* Start address must align on block boundary */
 	if (ofs & ((1 << chip->phys_erase_shift) - 1)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Unaligned address\n", __func__);
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Unaligned address\n", __func__);
 		ret = -EINVAL;
 	}
 
 	/* Length must align on block boundary */
 	if (len & ((1 << chip->phys_erase_shift) - 1)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Length not block aligned\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Length not block aligned\n",
 					__func__);
 		ret = -EINVAL;
 	}
 
 	/* Do not allow past end of device */
 	if (ofs + len > mtd->size) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Past end of device\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Past end of device\n",
 					__func__);
 		ret = -EINVAL;
 	}
@@ -922,7 +922,7 @@ static int __nand_unlock(struct mtd_info *mtd, loff_t ofs,
 	udelay(1000);
 	/* See if device thinks it succeeded */
 	if (status & 0x01) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Error status = 0x%08x\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Error status = 0x%08x\n",
 					__func__, status);
 		ret = -EIO;
 	}
@@ -945,7 +945,7 @@ int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	int chipnr;
 	struct nand_chip *chip = mtd->priv;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: start = 0x%012llx, len = %llu\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: start = 0x%012llx, len = %llu\n",
 			__func__, (unsigned long long)ofs, len);
 
 	if (check_offs_len(mtd, ofs, len))
@@ -964,7 +964,7 @@ int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 
 	/* Check, if it is write protected */
 	if (nand_check_wp(mtd)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Device is write protected!!!\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Device is write protected!!!\n",
 					__func__);
 		ret = -EIO;
 		goto out;
@@ -1000,7 +1000,7 @@ int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	int chipnr, status, page;
 	struct nand_chip *chip = mtd->priv;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: start = 0x%012llx, len = %llu\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: start = 0x%012llx, len = %llu\n",
 			__func__, (unsigned long long)ofs, len);
 
 	if (check_offs_len(mtd, ofs, len))
@@ -1015,7 +1015,7 @@ int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 
 	/* Check, if it is write protected */
 	if (nand_check_wp(mtd)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Device is write protected!!!\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Device is write protected!!!\n",
 					__func__);
 		status = MTD_ERASE_FAILED;
 		ret = -EIO;
@@ -1031,7 +1031,7 @@ int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	udelay(1000);
 	/* See if device thinks it succeeded */
 	if (status & 0x01) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Error status = 0x%08x\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Error status = 0x%08x\n",
 					__func__, status);
 		ret = -EIO;
 		goto out;
@@ -1766,7 +1766,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 	int len;
 	uint8_t *buf = ops->oobbuf;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08Lx, len = %i\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08Lx, len = %i\n",
 			__func__, (unsigned long long)from, readlen);
 
 	if (ops->mode == MTD_OOB_AUTO)
@@ -1775,7 +1775,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 		len = mtd->oobsize;
 
 	if (unlikely(ops->ooboffs >= len)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt to start read "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Attempt to start read "
 					"outside oob\n", __func__);
 		return -EINVAL;
 	}
@@ -1784,7 +1784,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 	if (unlikely(from >= mtd->size ||
 		     ops->ooboffs + readlen > ((mtd->size >> chip->page_shift) -
 					(from >> chip->page_shift)) * len)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt read beyond end "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Attempt read beyond end "
 					"of device\n", __func__);
 		return -EINVAL;
 	}
@@ -1859,7 +1859,7 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 
 	/* Do not allow reads past end of device */
 	if (ops->datbuf && (from + ops->len) > mtd->size) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt read "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Attempt read "
 				"beyond end of device\n", __func__);
 		return -EINVAL;
 	}
@@ -2348,7 +2348,7 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 	int chipnr, page, status, len;
 	struct nand_chip *chip = mtd->priv;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: to = 0x%08x, len = %i\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: to = 0x%08x, len = %i\n",
 			 __func__, (unsigned int)to, (int)ops->ooblen);
 
 	if (ops->mode == MTD_OOB_AUTO)
@@ -2358,13 +2358,13 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 
 	/* Do not allow write past end of page */
 	if ((ops->ooboffs + ops->ooblen) > len) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt to write "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Attempt to write "
 				"past end of page\n", __func__);
 		return -EINVAL;
 	}
 
 	if (unlikely(ops->ooboffs >= len)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt to start "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Attempt to start "
 				"write outside oob\n", __func__);
 		return -EINVAL;
 	}
@@ -2374,7 +2374,7 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 		     ops->ooboffs + ops->ooblen >
 			((mtd->size >> chip->page_shift) -
 			 (to >> chip->page_shift)) * len)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt write beyond "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Attempt write beyond "
 				"end of device\n", __func__);
 		return -EINVAL;
 	}
@@ -2430,7 +2430,7 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 
 	/* Do not allow writes past end of device */
 	if (ops->datbuf && (to + ops->len) > mtd->size) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt write beyond "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Attempt write beyond "
 				"end of device\n", __func__);
 		return -EINVAL;
 	}
@@ -2521,7 +2521,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 	unsigned int bbt_masked_page = 0xffffffff;
 	loff_t len;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: start = 0x%012llx, len = %llu\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: start = 0x%012llx, len = %llu\n",
 				__func__, (unsigned long long)instr->addr,
 				(unsigned long long)instr->len);
 
@@ -2545,7 +2545,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 
 	/* Check, if it is write protected */
 	if (nand_check_wp(mtd)) {
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: Device is write protected!!!\n",
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Device is write protected!!!\n",
 					__func__);
 		instr->state = MTD_ERASE_FAILED;
 		goto erase_exit;
@@ -2599,7 +2599,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 
 		/* See if block erase succeeded */
 		if (status & NAND_STATUS_FAIL) {
-			DEBUG(MTD_DEBUG_LEVEL0, "%s: Failed erase, "
+			MTD_DBG(MTD_DEBUG_LEVEL0, "%s: Failed erase, "
 					"page 0x%08x\n", __func__, page);
 			instr->state = MTD_ERASE_FAILED;
 			instr->fail_addr =
@@ -2660,7 +2660,7 @@ erase_exit:
 		if (!rewrite_bbt[chipnr])
 			continue;
 		/* update the BBT for chip */
-		DEBUG(MTD_DEBUG_LEVEL0, "%s: nand_update_bbt "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "%s: nand_update_bbt "
 			"(%d:0x%0llx 0x%0x)\n", __func__, chipnr,
 			rewrite_bbt[chipnr], chip->bbt_td->pages[chipnr]);
 		nand_update_bbt(mtd, rewrite_bbt[chipnr]);
@@ -2680,7 +2680,7 @@ static void nand_sync(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd->priv;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: called\n", __func__);
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: called\n", __func__);
 
 	/* Grab the lock and see if the device is available */
 	nand_get_device(chip, mtd, FL_SYNCING);
diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index ccbeaa1..ed318c6 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -1432,8 +1432,8 @@ int nand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt)
 	block = (int)(offs >> (this->bbt_erase_shift - 1));
 	res = (this->bbt[block >> 3] >> (block & 0x06)) & 0x03;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "nand_isbad_bbt(): bbt info for offs 0x%08x: (block %d) 0x%02x\n",
-	      (unsigned int)offs, block >> 1, res);
+	MTD_DBG(MTD_DEBUG_LEVEL2, "nand_isbad_bbt(): bbt info for offs 0x%08x: "
+		"(block %d) 0x%02x\n", (unsigned int)offs, block >> 1, res);
 
 	switch ((int)res) {
 	case 0x00:
diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index 0f931e7..349c920 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -93,7 +93,7 @@ int nand_bch_correct_data(struct mtd_info *mtd, unsigned char *buf,
 				buf[errloc[i] >> 3] ^= (1 << (errloc[i] & 7));
 			/* else error in ecc, no action needed */
 
-			DEBUG(MTD_DEBUG_LEVEL0, "%s: corrected bitflip %u\n",
+			MTD_DBG(MTD_DEBUG_LEVEL0, "%s: corrected bitflip %u\n",
 			      __func__, errloc[i]);
 		}
 	} else if (count < 0) {
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 0db2c0e..aa56580 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -744,12 +744,12 @@ static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
 
 	case 1:
 		/* Uncorrectable error */
-		DEBUG(MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR 1\n");
+		MTD_DBG(MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR 1\n");
 		return -1;
 
 	case 11:
 		/* UN-Correctable error */
-		DEBUG(MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR B\n");
+		MTD_DBG(MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR B\n");
 		return -1;
 
 	case 12:
@@ -766,7 +766,7 @@ static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
 
 		find_bit = (ecc_bit[5] << 2) + (ecc_bit[3] << 1) + ecc_bit[1];
 
-		DEBUG(MTD_DEBUG_LEVEL0, "Correcting single bit ECC error at "
+		MTD_DBG(MTD_DEBUG_LEVEL0, "Correcting single bit ECC error@"
 				"offset: %d, bit: %d\n", find_byte, find_bit);
 
 		page_data[find_byte] ^= (1 << find_bit);
@@ -779,7 +779,7 @@ static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
 			    ecc_data2[2] == 0)
 				return 0;
 		}
-		DEBUG(MTD_DEBUG_LEVEL0, "UNCORRECTED_ERROR default\n");
+		MTD_DBG(MTD_DEBUG_LEVEL0, "UNCORRECTED_ERROR default\n");
 		return -1;
 	}
 }
diff --git a/drivers/mtd/nand/rtc_from4.c b/drivers/mtd/nand/rtc_from4.c
index c9f9127..af6f1d3 100644
--- a/drivers/mtd/nand/rtc_from4.c
+++ b/drivers/mtd/nand/rtc_from4.c
@@ -380,7 +380,8 @@ static int rtc_from4_correct_data(struct mtd_info *mtd, const u_char *buf, u_cha
 	/* Let the library code do its magic. */
 	res = decode_rs8(rs_decoder, (uint8_t *) buf, par, 512, syn, 0, NULL, 0xff, NULL);
 	if (res > 0) {
-		DEBUG(MTD_DEBUG_LEVEL0, "rtc_from4_correct_data: " "ECC corrected %d errors on read\n", res);
+		MTD_DBG(MTD_DEBUG_LEVEL0, "rtc_from4_correct_data: "
+			"ECC corrected %d errors on read\n", res);
 	}
 	return res;
 }
diff --git a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
index b155666..541f98f 100644
--- a/drivers/mtd/nftlcore.c
+++ b/drivers/mtd/nftlcore.c
@@ -63,7 +63,7 @@ static void nftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 		return;
 	}
 
-	DEBUG(MTD_DEBUG_LEVEL1, "NFTL: add_mtd for %s\n", mtd->name);
+	MTD_DBG(MTD_DEBUG_LEVEL1, "NFTL: add_mtd for %s\n", mtd->name);
 
 	nftl = kzalloc(sizeof(struct NFTLrecord), GFP_KERNEL);
 
@@ -132,7 +132,7 @@ static void nftl_remove_dev(struct mtd_blktrans_dev *dev)
 {
 	struct NFTLrecord *nftl = (void *)dev;
 
-	DEBUG(MTD_DEBUG_LEVEL1, "NFTL: remove_dev (i=%d)\n", dev->devnum);
+	MTD_DBG(MTD_DEBUG_LEVEL1, "NFTL: remove_dev (i=%d)\n", dev->devnum);
 
 	del_mtd_blktrans_dev(dev);
 	kfree(nftl->ReplUnitTable);
@@ -220,7 +220,8 @@ static u16 NFTL_findfreeblock(struct NFTLrecord *nftl, int desperate )
 
 	/* Normally, we force a fold to happen before we run out of free blocks completely */
 	if (!desperate && nftl->numfreeEUNs < 2) {
-		DEBUG(MTD_DEBUG_LEVEL1, "NFTL_findfreeblock: there are too few free EUNs\n");
+		MTD_DBG(MTD_DEBUG_LEVEL1, "NFTL_findfreeblock: there are too "
+				"few free EUNs\n");
 		return BLOCK_NIL;
 	}
 
@@ -291,7 +292,7 @@ static u16 NFTL_foldchain (struct NFTLrecord *nftl, unsigned thisVUC, unsigned p
 			if (block == 2) {
 				foldmark = oob.u.c.FoldMark | oob.u.c.FoldMark1;
 				if (foldmark == FOLD_MARK_IN_PROGRESS) {
-					DEBUG(MTD_DEBUG_LEVEL1,
+					MTD_DBG(MTD_DEBUG_LEVEL1,
 					      "Write Inhibited on EUN %d\n", thisEUN);
 					inplace = 0;
 				} else {
@@ -357,8 +358,8 @@ static u16 NFTL_foldchain (struct NFTLrecord *nftl, unsigned thisVUC, unsigned p
 			if (BlockLastState[block] != SECTOR_FREE &&
 			    BlockMap[block] != BLOCK_NIL &&
 			    BlockMap[block] != targetEUN) {
-				DEBUG(MTD_DEBUG_LEVEL1, "Setting inplace to 0. VUC %d, "
-				      "block %d was %x lastEUN, "
+				MTD_DBG(MTD_DEBUG_LEVEL1, "Setting inplace to 0"
+				      ". VUC %d, block %d was %x lastEUN, "
 				      "and is in EUN %d (%s) %d\n",
 				      thisVUC, block, BlockLastState[block],
 				      BlockMap[block],
@@ -373,15 +374,15 @@ static u16 NFTL_foldchain (struct NFTLrecord *nftl, unsigned thisVUC, unsigned p
 		    pendingblock < ((thisVUC + 1)* (nftl->EraseSize / 512)) &&
 		    BlockLastState[pendingblock - (thisVUC * (nftl->EraseSize / 512))] !=
 		    SECTOR_FREE) {
-			DEBUG(MTD_DEBUG_LEVEL1, "Pending write not free in EUN %d. "
-			      "Folding out of place.\n", targetEUN);
+			MTD_DBG(MTD_DEBUG_LEVEL1, "Pending write not free in "
+			      "EUN %d. Folding out of place.\n", targetEUN);
 			inplace = 0;
 		}
 	}
 
 	if (!inplace) {
-		DEBUG(MTD_DEBUG_LEVEL1, "Cannot fold Virtual Unit Chain %d in place. "
-		      "Trying out-of-place\n", thisVUC);
+		MTD_DBG(MTD_DEBUG_LEVEL1, "Cannot fold Virtual Unit Chain %d "
+		      "in place. Trying out-of-place\n", thisVUC);
 		/* We need to find a targetEUN to fold into. */
 		targetEUN = NFTL_findfreeblock(nftl, 1);
 		if (targetEUN == BLOCK_NIL) {
@@ -410,7 +411,8 @@ static u16 NFTL_foldchain (struct NFTLrecord *nftl, unsigned thisVUC, unsigned p
 	   and the Erase Unit into which we are supposed to be copying.
 	   Go for it.
 	*/
-	DEBUG(MTD_DEBUG_LEVEL1,"Folding chain %d into unit %d\n", thisVUC, targetEUN);
+	MTD_DBG(MTD_DEBUG_LEVEL1, "Folding chain %d into unit %d\n", thisVUC,
+		targetEUN);
 	for (block = 0; block < nftl->EraseSize / 512 ; block++) {
 		unsigned char movebuf[512];
 		int ret;
@@ -457,7 +459,7 @@ static u16 NFTL_foldchain (struct NFTLrecord *nftl, unsigned thisVUC, unsigned p
 	   has duplicate chains, we need to free one of the chains because it's not necessary any more.
 	*/
 	thisEUN = nftl->EUNtable[thisVUC];
-	DEBUG(MTD_DEBUG_LEVEL1,"Want to erase\n");
+	MTD_DBG(MTD_DEBUG_LEVEL1, "Want to erase\n");
 
 	/* For each block in the old chain (except the targetEUN of course),
 	   free it and make it available for future use */
@@ -570,7 +572,8 @@ static inline u16 NFTL_findwriteunit(struct NFTLrecord *nftl, unsigned block)
 				      (writeEUN * nftl->EraseSize) + blockofs,
 				      8, &retlen, (char *)&bci);
 
-			DEBUG(MTD_DEBUG_LEVEL2, "Status of block %d in EUN %d is %x\n",
+			MTD_DBG(MTD_DEBUG_LEVEL2, "Status of block %d in EUN %d"
+				" is %x\n",
 			      block , writeEUN, le16_to_cpu(bci.Status));
 
 			status = bci.Status | bci.Status1;
@@ -623,7 +626,9 @@ static inline u16 NFTL_findwriteunit(struct NFTLrecord *nftl, unsigned block)
 				   but they are reserved for when we're
 				   desperate. Well, now we're desperate.
 				*/
-				DEBUG(MTD_DEBUG_LEVEL1, "Using desperate==1 to find free EUN to accommodate write to VUC %d\n", thisVUC);
+				MTD_DBG(MTD_DEBUG_LEVEL1, "Using desperate==1 "
+					"to find free EUN to accommodate write"
+					" to VUC %d\n", thisVUC);
 				writeEUN = NFTL_findfreeblock(nftl, 1);
 			}
 			if (writeEUN == BLOCK_NIL) {
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index ac9e959..d97ad75 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -1122,7 +1122,7 @@ static int onenand_mlc_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 	int ret = 0;
 	int writesize = this->writesize;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %i\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %i\n",
 	      __func__, (unsigned int) from, (int) len);
 
 	if (ops->mode == MTD_OOB_AUTO)
@@ -1226,7 +1226,7 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 	int ret = 0, boundary = 0;
 	int writesize = this->writesize;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %i\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %i\n",
 			__func__, (unsigned int) from, (int) len);
 
 	if (ops->mode == MTD_OOB_AUTO)
@@ -1357,7 +1357,7 @@ static int onenand_read_oob_nolock(struct mtd_info *mtd, loff_t from,
 
 	from += ops->ooboffs;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %i\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %i\n",
 		__func__, (unsigned int) from, (int) len);
 
 	/* Initialize return length value */
@@ -1576,7 +1576,7 @@ int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,
 	size_t len = ops->ooblen;
 	u_char *buf = ops->oobbuf;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %zi\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %zi\n",
 		__func__, (unsigned int) from, len);
 
 	/* Initialize return value */
@@ -1750,7 +1750,7 @@ static int onenand_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
 	/* Wait for any existing operation to clear */
 	onenand_panic_wait(mtd);
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: to = 0x%08x, len = %i\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: to = 0x%08x, len = %i\n",
 		__func__, (unsigned int) to, (int) len);
 
 	/* Initialize retlen, in case of early exit */
@@ -1883,7 +1883,7 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 	u_char *oobbuf;
 	int ret = 0, cmd;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: to = 0x%08x, len = %i\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: to = 0x%08x, len = %i\n",
 		__func__, (unsigned int) to, (int) len);
 
 	/* Initialize retlen, in case of early exit */
@@ -2078,7 +2078,7 @@ static int onenand_write_oob_nolock(struct mtd_info *mtd, loff_t to,
 
 	to += ops->ooboffs;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: to = 0x%08x, len = %i\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: to = 0x%08x, len = %i\n",
 		__func__, (unsigned int) to, (int) len);
 
 	/* Initialize retlen, in case of early exit */
@@ -2489,7 +2489,7 @@ static int onenand_erase(struct mtd_info *mtd, struct erase_info *instr)
 	struct mtd_erase_region_info *region = NULL;
 	loff_t region_offset = 0;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: start=0x%012llx, len=%llu\n", __func__,
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: start=0x%012llx, len=%llu\n", __func__,
 	      (unsigned long long) instr->addr, (unsigned long long) instr->len);
 
 	/* Do not allow erase past end of device */
@@ -2558,7 +2558,7 @@ static int onenand_erase(struct mtd_info *mtd, struct erase_info *instr)
  */
 static void onenand_sync(struct mtd_info *mtd)
 {
-	DEBUG(MTD_DEBUG_LEVEL3, "%s: called\n", __func__);
+	MTD_DBG(MTD_DEBUG_LEVEL3, "%s: called\n", __func__);
 
 	/* Grab the lock and see if the device is available */
 	onenand_get_device(mtd, FL_SYNCING);
diff --git a/drivers/mtd/onenand/onenand_bbt.c b/drivers/mtd/onenand/onenand_bbt.c
index fc2c16a..f9294d7 100644
--- a/drivers/mtd/onenand/onenand_bbt.c
+++ b/drivers/mtd/onenand/onenand_bbt.c
@@ -153,8 +153,8 @@ static int onenand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt)
 	block = (int) (onenand_block(this, offs) << 1);
 	res = (bbm->bbt[block >> 3] >> (block & 0x06)) & 0x03;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "onenand_isbad_bbt: bbt info for offs 0x%08x: (block %d) 0x%02x\n",
-		(unsigned int) offs, block >> 1, res);
+	MTD_DBG(MTD_DEBUG_LEVEL2, "onenand_isbad_bbt: bbt info for offs 0x%08x:"
+		" (block %d) 0x%02x\n", (unsigned int) offs, block >> 1, res);
 
 	switch ((int) res) {
 	case 0x00:	return 0;
diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 5cd1897..0c093ab 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -135,7 +135,7 @@ static int get_valid_cis_sector(struct mtd_info *mtd)
 				/* Found */
 				cis_sector = (int)(offset >> SECTOR_SHIFT);
 			} else {
-				DEBUG(MTD_DEBUG_LEVEL1,
+				MTD_DBG(MTD_DEBUG_LEVEL1,
 					"SSFDC_RO: CIS/IDI sector not found"
 					" on %s (mtd%d)\n", mtd->name,
 					mtd->index);
@@ -221,7 +221,7 @@ static int get_logical_address(uint8_t *oob_buf)
 			block_address >>= 1;
 
 			if (get_parity(block_address, 10) != parity) {
-				DEBUG(MTD_DEBUG_LEVEL0,
+				MTD_DBG(MTD_DEBUG_LEVEL0,
 					"SSFDC_RO: logical address field%d"
 					"parity error(0x%04X)\n", j+1,
 					block_address);
@@ -235,7 +235,7 @@ static int get_logical_address(uint8_t *oob_buf)
 	if (!ok)
 		block_address = -2;
 
-	DEBUG(MTD_DEBUG_LEVEL3, "SSFDC_RO: get_logical_address() %d\n",
+	MTD_DBG(MTD_DEBUG_LEVEL3, "SSFDC_RO: get_logical_address() %d\n",
 		block_address);
 
 	return block_address;
@@ -249,8 +249,8 @@ static int build_logical_block_map(struct ssfdcr_record *ssfdc)
 	int ret, block_address, phys_block;
 	struct mtd_info *mtd = ssfdc->mbd.mtd;
 
-	DEBUG(MTD_DEBUG_LEVEL1, "SSFDC_RO: build_block_map() nblks=%d (%luK)\n",
-	      ssfdc->map_len,
+	MTD_DBG(MTD_DEBUG_LEVEL1, "SSFDC_RO: build_block_map() nblks=%d (%luK)"
+	      "\n", ssfdc->map_len,
 	      (unsigned long)ssfdc->map_len * ssfdc->erase_size / 1024);
 
 	/* Scan every physical block, skip CIS block */
@@ -262,7 +262,7 @@ static int build_logical_block_map(struct ssfdcr_record *ssfdc)
 
 		ret = read_raw_oob(mtd, offset, oob_buf);
 		if (ret < 0) {
-			DEBUG(MTD_DEBUG_LEVEL0,
+			MTD_DBG(MTD_DEBUG_LEVEL0,
 				"SSFDC_RO: mtd read_oob() failed@%lu\n",
 				offset);
 			return -1;
@@ -279,7 +279,7 @@ static int build_logical_block_map(struct ssfdcr_record *ssfdc)
 			ssfdc->logic_block_map[block_address] =
 				(unsigned short)phys_block;
 
-			DEBUG(MTD_DEBUG_LEVEL2,
+			MTD_DBG(MTD_DEBUG_LEVEL2,
 				"SSFDC_RO: build_block_map() phys_block=%d,"
 				"logic_block_addr=%d, zone=%d\n",
 				phys_block, block_address, zone_index);
@@ -319,7 +319,7 @@ static void ssfdcr_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	ssfdc->erase_size = mtd->erasesize;
 	ssfdc->map_len = (u32)mtd->size / mtd->erasesize;
 
-	DEBUG(MTD_DEBUG_LEVEL1,
+	MTD_DBG(MTD_DEBUG_LEVEL1,
 		"SSFDC_RO: cis_block=%d,erase_size=%d,map_len=%d,n_zones=%d\n",
 		ssfdc->cis_block, ssfdc->erase_size, ssfdc->map_len,
 		DIV_ROUND_UP(ssfdc->map_len, MAX_PHYS_BLK_PER_ZONE));
@@ -331,8 +331,8 @@ static void ssfdcr_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	ssfdc->cylinders = (unsigned short)(((u32)mtd->size >> SECTOR_SHIFT) /
 			((long)ssfdc->sectors * (long)ssfdc->heads));
 
-	DEBUG(MTD_DEBUG_LEVEL1, "SSFDC_RO: using C:%d H:%d S:%d == %ld sects\n",
-		ssfdc->cylinders, ssfdc->heads , ssfdc->sectors,
+	MTD_DBG(MTD_DEBUG_LEVEL1, "SSFDC_RO: using C:%d H:%d S:%d == %ld sects"
+		"\n", ssfdc->cylinders, ssfdc->heads , ssfdc->sectors,
 		(long)ssfdc->cylinders * (long)ssfdc->heads *
 		(long)ssfdc->sectors);
 
@@ -371,7 +371,7 @@ static void ssfdcr_remove_dev(struct mtd_blktrans_dev *dev)
 {
 	struct ssfdcr_record *ssfdc = (struct ssfdcr_record *)dev;
 
-	DEBUG(MTD_DEBUG_LEVEL1, "SSFDC_RO: remove_dev (i=%d)\n", dev->devnum);
+	MTD_DBG(MTD_DEBUG_LEVEL1, "SSFDC_RO: remove_dev (i=%d)\n", dev->devnum);
 
 	del_mtd_blktrans_dev(dev);
 	kfree(ssfdc->logic_block_map);
@@ -387,7 +387,7 @@ static int ssfdcr_readsect(struct mtd_blktrans_dev *dev,
 	offset = (int)(logic_sect_no % sectors_per_block);
 	block_address = (int)(logic_sect_no / sectors_per_block);
 
-	DEBUG(MTD_DEBUG_LEVEL3,
+	MTD_DBG(MTD_DEBUG_LEVEL3,
 		"SSFDC_RO: ssfdcr_readsect(%lu) sec_per_blk=%d, ofst=%d,"
 		" block_addr=%d\n", logic_sect_no, sectors_per_block, offset,
 		block_address);
@@ -397,7 +397,7 @@ static int ssfdcr_readsect(struct mtd_blktrans_dev *dev,
 
 	block_address = ssfdc->logic_block_map[block_address];
 
-	DEBUG(MTD_DEBUG_LEVEL3,
+	MTD_DBG(MTD_DEBUG_LEVEL3,
 		"SSFDC_RO: ssfdcr_readsect() phys_block_addr=%d\n",
 		block_address);
 
@@ -407,7 +407,7 @@ static int ssfdcr_readsect(struct mtd_blktrans_dev *dev,
 		sect_no = (unsigned long)block_address * sectors_per_block +
 				offset;
 
-		DEBUG(MTD_DEBUG_LEVEL3,
+		MTD_DBG(MTD_DEBUG_LEVEL3,
 			"SSFDC_RO: ssfdcr_readsect() phys_sect_no=%lu\n",
 			sect_no);
 
@@ -424,8 +424,8 @@ static int ssfdcr_getgeo(struct mtd_blktrans_dev *dev,  struct hd_geometry *geo)
 {
 	struct ssfdcr_record *ssfdc = (struct ssfdcr_record *)dev;
 
-	DEBUG(MTD_DEBUG_LEVEL1, "SSFDC_RO: ssfdcr_getgeo() C=%d, H=%d, S=%d\n",
-			ssfdc->cylinders, ssfdc->heads, ssfdc->sectors);
+	MTD_DBG(MTD_DEBUG_LEVEL1, "SSFDC_RO: ssfdcr_getgeo() C=%d, H=%d, S=%d\n"
+			, ssfdc->cylinders, ssfdc->heads, ssfdc->sectors);
 
 	geo->heads = ssfdc->heads;
 	geo->sectors = ssfdc->sectors;
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 2541fb8..9c7e440 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -364,13 +364,13 @@ void mtd_erase_callback(struct erase_info *instr);
 #define MTD_DEBUG_LEVEL3	(3)	/* Noisy   */
 
 #ifdef CONFIG_MTD_DEBUG
-#define DEBUG(n, args...)				\
+#define MTD_DBG(n, args...)				\
 	do {						\
 		if (n <= CONFIG_MTD_DEBUG_VERBOSE)	\
 			printk(KERN_INFO args);		\
 	} while(0)
 #else /* CONFIG_MTD_DEBUG */
-#define DEBUG(n, args...)				\
+#define MTD_DBG(n, args...)				\
 	do {						\
 		if (0)					\
 			printk(KERN_INFO args);		\
-- 
1.7.0.4
