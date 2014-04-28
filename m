From: b32955@freescale.com (Huang Shijie)
Date: Mon, 28 Apr 2014 11:53:47 +0800
Subject: [PATCH v2 10/10] mtd: fsl-quadspi: add DDR quad read support for
 Micron
In-Reply-To: <1398657227-20721-1-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
Message-ID: <1398657227-20721-11-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DDR quad read opcode and LUT sequence for Micron N25Q256A.

The performace :
    =================================================
    mtd_speedtest: MTD device: 1
    mtd_speedtest: not NAND flash, assume page size is 512 bytes.
    mtd_speedtest: MTD device size 33554432, eraseblock size 65536,
                   page size 512, count of eraseblocks 512, pages per eraseblock 128, OOB size 0
    mtd_speedtest: testing eraseblock write speed
    mtd_speedtest: eraseblock write speed is 2426 KiB/s
    mtd_speedtest: testing eraseblock read speed
    mtd_speedtest: eraseblock read speed is 32157 KiB/s
    mtd_speedtest: testing page write speed
    mtd_speedtest: page write speed is 2362 KiB/s
    mtd_speedtest: testing page read speed
    mtd_speedtest: page read speed is 17741 KiB/s
    mtd_speedtest: testing 2 page write speed
    mtd_speedtest: 2 page write speed is 2384 KiB/s
    mtd_speedtest: testing 2 page read speed
    mtd_speedtest: 2 page read speed is 24058 KiB/s
    mtd_speedtest: Testing erase speed
    mtd_speedtest: erase speed is 1927529 KiB/s
    mtd_speedtest: Testing 2x multi-block erase speed
    mtd_speedtest: 2x multi-block erase speed is 2184533 KiB/s
    mtd_speedtest: Testing 4x multi-block erase speed
    mtd_speedtest: 4x multi-block erase speed is 2184533 KiB/s
    mtd_speedtest: Testing 8x multi-block erase speed
    mtd_speedtest: 8x multi-block erase speed is 2340571 KiB/s
    mtd_speedtest: Testing 16x multi-block erase speed
    mtd_speedtest: 16x multi-block erase speed is 2340571 KiB/s
    mtd_speedtest: Testing 32x multi-block erase speed
    mtd_speedtest: 32x multi-block erase speed is 2340571 KiB/s
    mtd_speedtest: Testing 64x multi-block erase speed
    mtd_speedtest: 64x multi-block erase speed is 2340571 KiB/s
    mtd_speedtest: finished
    =================================================

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index a5dbc62..08944cb 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -325,6 +325,18 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 			writel(LUT0(READ_DDR, PAD4, rxfifo)
 				| LUT1(JMP_ON_CS, PAD1, 0),
 				base + QUADSPI_LUT(lut_base + 2));
+		} else if (op == SPINOR_OP_READ_1_1_4_D) {
+			/* read mode : 1-1-4, such as Micron N25Q256A. */
+			writel(LUT0(CMD, PAD1, op)
+				| LUT1(ADDR_DDR, PAD1, addrlen),
+				base + QUADSPI_LUT(lut_base));
+
+			writel(LUT0(DUMMY, PAD1, dm)
+				| LUT1(READ_DDR, PAD4, rxfifo),
+				base + QUADSPI_LUT(lut_base + 1));
+
+			writel(LUT0(JMP_ON_CS, PAD1, 0),
+				base + QUADSPI_LUT(lut_base + 2));
 		} else {
 			dev_err(nor->dev, "Unsupported opcode : 0x%.2x\n", op);
 		}
@@ -389,6 +401,7 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 {
 	switch (cmd) {
+	case SPINOR_OP_READ_1_1_4_D:
 	case SPINOR_OP_READ_1_4_4_D:
 	case SPINOR_OP_READ4_1_4_4_D:
 	case SPINOR_OP_READ4_1_1_4:
-- 
1.7.2.rc3
