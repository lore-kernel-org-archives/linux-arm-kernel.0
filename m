From: b32955@freescale.com (Huang Shijie)
Date: Fri, 08 Jul 2011 17:38:11 -0000
Subject: [ PATCH V2  5/7] MTD : add GPMI support for imx23
In-Reply-To: <1301048581-21321-1-git-send-email-b32955@freescale.com>
References: <1301048581-21321-1-git-send-email-b32955@freescale.com>
Message-ID: <1301048581-21321-6-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These files contain the code to implement the GPMI in the imx23.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h  |  342 +++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h |  381 ++++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/hal-imx23.c       |  555 +++++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nfc/rom-imx23.c       |  300 +++++++++++++++
 4 files changed, 1578 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h
 create mode 100644 drivers/mtd/nand/gpmi-nfc/hal-imx23.c
 create mode 100644 drivers/mtd/nand/gpmi-nfc/rom-imx23.c

diff --git a/drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h b/drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h
new file mode 100644
index 0000000..7e3dfac
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nfc/bch-regs-imx23.h
@@ -0,0 +1,342 @@
+/*
+ * Freescale GPMI NFC NAND Flash Driver
+ *
+ * Copyright 2008-2011 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifndef __GPMI_NFC_BCH_REGS_H
+#define __GPMI_NFC_BCH_REGS_H
+
+/*============================================================================*/
+#define HW_BCH_CTRL				0x00000000
+#define HW_BCH_CTRL_SET				0x00000004
+#define HW_BCH_CTRL_CLR				0x00000008
+#define HW_BCH_CTRL_TOG				0x0000000c
+
+#define BM_BCH_CTRL_SFTRST			0x80000000
+#define BV_BCH_CTRL_SFTRST__RUN			0x0
+#define BV_BCH_CTRL_SFTRST__RESET		0x1
+#define BM_BCH_CTRL_CLKGATE			0x40000000
+#define BV_BCH_CTRL_CLKGATE__RUN		0x0
+#define BV_BCH_CTRL_CLKGATE__NO_CLKS		0x1
+#define BP_BCH_CTRL_RSVD5			23
+#define BM_BCH_CTRL_RSVD5			0x3F800000
+#define BF_BCH_CTRL_RSVD5(v)		(((v) << 23) & BM_BCH_CTRL_RSVD5)
+#define BM_BCH_CTRL_DEBUGSYNDROME		0x00400000
+#define BP_BCH_CTRL_RSVD4			20
+#define BM_BCH_CTRL_RSVD4			0x00300000
+#define BF_BCH_CTRL_RSVD4(v)		(((v) << 20) & BM_BCH_CTRL_RSVD4)
+#define BP_BCH_CTRL_M2M_LAYOUT			18
+#define BM_BCH_CTRL_M2M_LAYOUT			0x000C0000
+#define BF_BCH_CTRL_M2M_LAYOUT(v)	(((v) << 18) & BM_BCH_CTRL_M2M_LAYOUT)
+#define BM_BCH_CTRL_M2M_ENCODE			0x00020000
+#define BM_BCH_CTRL_M2M_ENABLE			0x00010000
+#define BP_BCH_CTRL_RSVD3			11
+#define BM_BCH_CTRL_RSVD3			0x0000F800
+#define BF_BCH_CTRL_RSVD3(v)		(((v) << 11) & BM_BCH_CTRL_RSVD3)
+#define BM_BCH_CTRL_DEBUG_STALL_IRQ_EN		0x00000400
+#define BM_BCH_CTRL_RSVD2			0x00000200
+#define BM_BCH_CTRL_COMPLETE_IRQ_EN		0x00000100
+#define BP_BCH_CTRL_RSVD1			4
+#define BM_BCH_CTRL_RSVD1			0x000000F0
+#define BF_BCH_CTRL_RSVD1(v)		(((v) << 4) & BM_BCH_CTRL_RSVD1)
+#define BM_BCH_CTRL_BM_ERROR_IRQ		0x00000008
+#define BM_BCH_CTRL_DEBUG_STALL_IRQ		0x00000004
+#define BM_BCH_CTRL_RSVD0			0x00000002
+#define BM_BCH_CTRL_COMPLETE_IRQ		0x00000001
+
+/*============================================================================*/
+#define HW_BCH_STATUS0				0x00000010
+
+#define BP_BCH_STATUS0_HANDLE			20
+#define BM_BCH_STATUS0_HANDLE			0xFFF00000
+#define BF_BCH_STATUS0_HANDLE(v)	(((v) << 20) & BM_BCH_STATUS0_HANDLE)
+#define BP_BCH_STATUS0_COMPLETED_CE		16
+#define BM_BCH_STATUS0_COMPLETED_CE		0x000F0000
+#define BF_BCH_STATUS0_COMPLETED_CE(v)	\
+				(((v) << 16) & BM_BCH_STATUS0_COMPLETED_CE)
+#define BP_BCH_STATUS0_STATUS_BLK0		8
+#define BM_BCH_STATUS0_STATUS_BLK0		0x0000FF00
+#define BF_BCH_STATUS0_STATUS_BLK0(v)	\
+				(((v) << 8) & BM_BCH_STATUS0_STATUS_BLK0)
+#define BV_BCH_STATUS0_STATUS_BLK0__ZERO	0x00
+#define BV_BCH_STATUS0_STATUS_BLK0__ERROR1	0x01
+#define BV_BCH_STATUS0_STATUS_BLK0__ERROR2	0x02
+#define BV_BCH_STATUS0_STATUS_BLK0__ERROR3	0x03
+#define BV_BCH_STATUS0_STATUS_BLK0__ERROR4	0x04
+#define BV_BCH_STATUS0_STATUS_BLK0__UNCORRECTABLE	0xFE
+#define BV_BCH_STATUS0_STATUS_BLK0__ERASED	0xFF
+#define BP_BCH_STATUS0_RSVD1			5
+#define BM_BCH_STATUS0_RSVD1			0x000000E0
+#define BF_BCH_STATUS0_RSVD1(v)		(((v) << 5) & BM_BCH_STATUS0_RSVD1)
+#define BM_BCH_STATUS0_ALLONES			0x00000010
+#define BM_BCH_STATUS0_CORRECTED		0x00000008
+#define BM_BCH_STATUS0_UNCORRECTABLE		0x00000004
+#define BP_BCH_STATUS0_RSVD0			0
+#define BM_BCH_STATUS0_RSVD0			0x00000003
+#define BF_BCH_STATUS0_RSVD0(v)		(((v) << 0) & BM_BCH_STATUS0_RSVD0)
+
+/*============================================================================*/
+#define HW_BCH_MODE				0x00000020
+
+#define BP_BCH_MODE_RSVD			8
+#define BM_BCH_MODE_RSVD			0xFFFFFF00
+#define BF_BCH_MODE_RSVD(v)		(((v) << 8) & BM_BCH_MODE_RSVD)
+#define BP_BCH_MODE_ERASE_THRESHOLD		0
+#define BM_BCH_MODE_ERASE_THRESHOLD		0x000000FF
+#define BF_BCH_MODE_ERASE_THRESHOLD(v)	\
+				(((v) << 0) & BM_BCH_MODE_ERASE_THRESHOLD)
+
+/*============================================================================*/
+#define HW_BCH_ENCODEPTR			0x00000030
+
+#define BP_BCH_ENCODEPTR_ADDR			0
+#define BM_BCH_ENCODEPTR_ADDR			0xFFFFFFFF
+#define BF_BCH_ENCODEPTR_ADDR(v)		(v)
+
+/*============================================================================*/
+#define HW_BCH_DATAPTR				0x00000040
+
+#define BP_BCH_DATAPTR_ADDR			0
+#define BM_BCH_DATAPTR_ADDR			0xFFFFFFFF
+#define BF_BCH_DATAPTR_ADDR(v)			(v)
+
+/*============================================================================*/
+#define HW_BCH_METAPTR				0x00000050
+
+#define BP_BCH_METAPTR_ADDR			0
+#define BM_BCH_METAPTR_ADDR			0xFFFFFFFF
+#define BF_BCH_METAPTR_ADDR(v)			(v)
+
+/*============================================================================*/
+#define HW_BCH_LAYOUTSELECT			0x00000070
+
+#define BP_BCH_LAYOUTSELECT_CS15_SELECT		30
+#define BM_BCH_LAYOUTSELECT_CS15_SELECT		0xC0000000
+#define BF_BCH_LAYOUTSELECT_CS15_SELECT(v)	\
+				(((v) << 30) & BM_BCH_LAYOUTSELECT_CS15_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS14_SELECT		28
+#define BM_BCH_LAYOUTSELECT_CS14_SELECT		0x30000000
+#define BF_BCH_LAYOUTSELECT_CS14_SELECT(v)	\
+				(((v) << 28) & BM_BCH_LAYOUTSELECT_CS14_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS13_SELECT		26
+#define BM_BCH_LAYOUTSELECT_CS13_SELECT		0x0C000000
+#define BF_BCH_LAYOUTSELECT_CS13_SELECT(v)	\
+				(((v) << 26) & BM_BCH_LAYOUTSELECT_CS13_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS12_SELECT		24
+#define BM_BCH_LAYOUTSELECT_CS12_SELECT		0x03000000
+#define BF_BCH_LAYOUTSELECT_CS12_SELECT(v)	\
+				(((v) << 24) & BM_BCH_LAYOUTSELECT_CS12_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS11_SELECT		22
+#define BM_BCH_LAYOUTSELECT_CS11_SELECT		0x00C00000
+#define BF_BCH_LAYOUTSELECT_CS11_SELECT(v)	\
+				(((v) << 22) & BM_BCH_LAYOUTSELECT_CS11_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS10_SELECT		20
+#define BM_BCH_LAYOUTSELECT_CS10_SELECT		0x00300000
+#define BF_BCH_LAYOUTSELECT_CS10_SELECT(v)	\
+				(((v) << 20) & BM_BCH_LAYOUTSELECT_CS10_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS9_SELECT		18
+#define BM_BCH_LAYOUTSELECT_CS9_SELECT		0x000C0000
+#define BF_BCH_LAYOUTSELECT_CS9_SELECT(v)	\
+				(((v) << 18) & BM_BCH_LAYOUTSELECT_CS9_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS8_SELECT		16
+#define BM_BCH_LAYOUTSELECT_CS8_SELECT		0x00030000
+#define BF_BCH_LAYOUTSELECT_CS8_SELECT(v)	\
+				(((v) << 16) & BM_BCH_LAYOUTSELECT_CS8_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS7_SELECT		14
+#define BM_BCH_LAYOUTSELECT_CS7_SELECT		0x0000C000
+#define BF_BCH_LAYOUTSELECT_CS7_SELECT(v)	\
+				(((v) << 14) & BM_BCH_LAYOUTSELECT_CS7_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS6_SELECT		12
+#define BM_BCH_LAYOUTSELECT_CS6_SELECT		0x00003000
+#define BF_BCH_LAYOUTSELECT_CS6_SELECT(v)	\
+				(((v) << 12) & BM_BCH_LAYOUTSELECT_CS6_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS5_SELECT		10
+#define BM_BCH_LAYOUTSELECT_CS5_SELECT		0x00000C00
+#define BF_BCH_LAYOUTSELECT_CS5_SELECT(v)	\
+				(((v) << 10) & BM_BCH_LAYOUTSELECT_CS5_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS4_SELECT		8
+#define BM_BCH_LAYOUTSELECT_CS4_SELECT		0x00000300
+#define BF_BCH_LAYOUTSELECT_CS4_SELECT(v)	\
+				(((v) << 8) & BM_BCH_LAYOUTSELECT_CS4_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS3_SELECT		6
+#define BM_BCH_LAYOUTSELECT_CS3_SELECT		0x000000C0
+#define BF_BCH_LAYOUTSELECT_CS3_SELECT(v)	\
+				(((v) << 6) & BM_BCH_LAYOUTSELECT_CS3_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS2_SELECT		4
+#define BM_BCH_LAYOUTSELECT_CS2_SELECT		0x00000030
+#define BF_BCH_LAYOUTSELECT_CS2_SELECT(v)	\
+				(((v) << 4) & BM_BCH_LAYOUTSELECT_CS2_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS1_SELECT		2
+#define BM_BCH_LAYOUTSELECT_CS1_SELECT		0x0000000C
+#define BF_BCH_LAYOUTSELECT_CS1_SELECT(v)	\
+				(((v) << 2) & BM_BCH_LAYOUTSELECT_CS1_SELECT)
+#define BP_BCH_LAYOUTSELECT_CS0_SELECT		0
+#define BM_BCH_LAYOUTSELECT_CS0_SELECT		0x00000003
+#define BF_BCH_LAYOUTSELECT_CS0_SELECT(v)	\
+				(((v) << 0) & BM_BCH_LAYOUTSELECT_CS0_SELECT)
+
+/*============================================================================*/
+#define HW_BCH_FLASH0LAYOUT0			0x00000080
+
+#define BP_BCH_FLASH0LAYOUT0_NBLOCKS		24
+#define BM_BCH_FLASH0LAYOUT0_NBLOCKS		0xFF000000
+#define BF_BCH_FLASH0LAYOUT0_NBLOCKS(v)		\
+				(((v) << 24) & BM_BCH_FLASH0LAYOUT0_NBLOCKS)
+#define BP_BCH_FLASH0LAYOUT0_META_SIZE		16
+#define BM_BCH_FLASH0LAYOUT0_META_SIZE		0x00FF0000
+#define BF_BCH_FLASH0LAYOUT0_META_SIZE(v)	\
+				(((v) << 16) & BM_BCH_FLASH0LAYOUT0_META_SIZE)
+#define BP_BCH_FLASH0LAYOUT0_ECC0		12
+#define BM_BCH_FLASH0LAYOUT0_ECC0		0x0000F000
+#define BF_BCH_FLASH0LAYOUT0_ECC0(v)		\
+				(((v) << 12) & BM_BCH_FLASH0LAYOUT0_ECC0)
+#define BV_BCH_FLASH0LAYOUT0_ECC0__NONE		0x0
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC2		0x1
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC4		0x2
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC6		0x3
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC8		0x4
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC10	0x5
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC12	0x6
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC14	0x7
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC16	0x8
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC18	0x9
+#define BV_BCH_FLASH0LAYOUT0_ECC0__ECC20	0xA
+#define BP_BCH_FLASH0LAYOUT0_DATA0_SIZE		0
+#define BM_BCH_FLASH0LAYOUT0_DATA0_SIZE		0x00000FFF
+#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v)	\
+				(((v) << 0) & BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)
+
+/*============================================================================*/
+#define HW_BCH_FLASH0LAYOUT1			0x00000090
+
+#define BP_BCH_FLASH0LAYOUT1_PAGE_SIZE		16
+#define BM_BCH_FLASH0LAYOUT1_PAGE_SIZE		0xFFFF0000
+#define BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(v)	\
+				(((v) << 16) & BM_BCH_FLASH0LAYOUT1_PAGE_SIZE)
+#define BP_BCH_FLASH0LAYOUT1_ECCN		12
+#define BM_BCH_FLASH0LAYOUT1_ECCN		0x0000F000
+#define BF_BCH_FLASH0LAYOUT1_ECCN(v)	\
+				(((v) << 12) & BM_BCH_FLASH0LAYOUT1_ECCN)
+#define BV_BCH_FLASH0LAYOUT1_ECCN__NONE		0x0
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC2		0x1
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC4		0x2
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC6		0x3
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC8		0x4
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC10	0x5
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC12	0x6
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC14	0x7
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC16	0x8
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC18	0x9
+#define BV_BCH_FLASH0LAYOUT1_ECCN__ECC20	0xA
+#define BP_BCH_FLASH0LAYOUT1_DATAN_SIZE		0
+#define BM_BCH_FLASH0LAYOUT1_DATAN_SIZE		0x00000FFF
+#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v)	\
+				(((v) << 0) & BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)
+
+/*============================================================================*/
+#define HW_BCH_DEBUG0				0x00000100
+#define HW_BCH_DEBUG0_SET			0x00000104
+#define HW_BCH_DEBUG0_CLR			0x00000108
+#define HW_BCH_DEBUG0_TOG			0x0000010c
+
+#define BP_BCH_DEBUG0_RSVD1			27
+#define BM_BCH_DEBUG0_RSVD1			0xF8000000
+#define BF_BCH_DEBUG0_RSVD1(v)		(((v) << 27) & BM_BCH_DEBUG0_RSVD1)
+#define BM_BCH_DEBUG0_ROM_BIST_ENABLE		0x04000000
+#define BM_BCH_DEBUG0_ROM_BIST_COMPLETE		0x02000000
+#define BP_BCH_DEBUG0_KES_DEBUG_SYNDROME_SYMBOL	16
+#define BM_BCH_DEBUG0_KES_DEBUG_SYNDROME_SYMBOL	0x01FF0000
+#define BF_BCH_DEBUG0_KES_DEBUG_SYNDROME_SYMBOL(v)	\
+			(((v) << 16) & BM_BCH_DEBUG0_KES_DEBUG_SYNDROME_SYMBOL)
+#define BV_BCH_DEBUG0_KES_DEBUG_SYNDROME_SYMBOL__NORMAL		0x0
+#define BV_BCH_DEBUG0_KES_DEBUG_SYNDROME_SYMBOL__TEST_MODE	0x1
+#define BM_BCH_DEBUG0_KES_DEBUG_SHIFT_SYND			0x00008000
+#define BM_BCH_DEBUG0_KES_DEBUG_PAYLOAD_FLAG			0x00004000
+#define BV_BCH_DEBUG0_KES_DEBUG_PAYLOAD_FLAG__DATA		0x1
+#define BV_BCH_DEBUG0_KES_DEBUG_PAYLOAD_FLAG__AUX		0x1
+#define BM_BCH_DEBUG0_KES_DEBUG_MODE4K				0x00002000
+#define BV_BCH_DEBUG0_KES_DEBUG_MODE4K__4k			0x1
+#define BV_BCH_DEBUG0_KES_DEBUG_MODE4K__2k			0x1
+#define BM_BCH_DEBUG0_KES_DEBUG_KICK				0x00001000
+#define BM_BCH_DEBUG0_KES_STANDALONE				0x00000800
+#define BV_BCH_DEBUG0_KES_STANDALONE__NORMAL			0x0
+#define BV_BCH_DEBUG0_KES_STANDALONE__TEST_MODE			0x1
+#define BM_BCH_DEBUG0_KES_DEBUG_STEP				0x00000400
+#define BM_BCH_DEBUG0_KES_DEBUG_STALL				0x00000200
+#define BV_BCH_DEBUG0_KES_DEBUG_STALL__NORMAL			0x0
+#define BV_BCH_DEBUG0_KES_DEBUG_STALL__WAIT			0x1
+#define BM_BCH_DEBUG0_BM_KES_TEST_BYPASS			0x00000100
+#define BV_BCH_DEBUG0_BM_KES_TEST_BYPASS__NORMAL		0x0
+#define BV_BCH_DEBUG0_BM_KES_TEST_BYPASS__TEST_MODE		0x1
+#define BP_BCH_DEBUG0_RSVD0			6
+#define BM_BCH_DEBUG0_RSVD0			0x000000C0
+#define BF_BCH_DEBUG0_RSVD0(v)		(((v) << 6) & BM_BCH_DEBUG0_RSVD0)
+#define BP_BCH_DEBUG0_DEBUG_REG_SELECT		0
+#define BM_BCH_DEBUG0_DEBUG_REG_SELECT		0x0000003F
+#define BF_BCH_DEBUG0_DEBUG_REG_SELECT(v)	\
+				(((v) << 0) & BM_BCH_DEBUG0_DEBUG_REG_SELECT)
+
+/*============================================================================*/
+#define HW_BCH_DBGKESREAD			(0x00000110)
+
+#define BP_BCH_DBGKESREAD_VALUES		0
+#define BM_BCH_DBGKESREAD_VALUES		0xFFFFFFFF
+#define BF_BCH_DBGKESREAD_VALUES(v)		(v)
+
+/*============================================================================*/
+#define HW_BCH_DBGCSFEREAD			0x00000120
+
+#define BP_BCH_DBGCSFEREAD_VALUES		0
+#define BM_BCH_DBGCSFEREAD_VALUES		0xFFFFFFFF
+#define BF_BCH_DBGCSFEREAD_VALUES(v)		(v)
+
+/*============================================================================*/
+#define HW_BCH_DBGSYNDGENREAD			0x00000130
+
+#define BP_BCH_DBGSYNDGENREAD_VALUES		0
+#define BM_BCH_DBGSYNDGENREAD_VALUES		0xFFFFFFFF
+#define BF_BCH_DBGSYNDGENREAD_VALUES(v)		(v)
+
+/*============================================================================*/
+#define HW_BCH_DBGAHBMREAD			0x00000140
+
+#define BP_BCH_DBGAHBMREAD_VALUES		0
+#define BM_BCH_DBGAHBMREAD_VALUES		0xFFFFFFFF
+#define BF_BCH_DBGAHBMREAD_VALUES(v)		(v)
+
+/*============================================================================*/
+#define HW_BCH_BLOCKNAME			0x00000150
+
+#define BP_BCH_BLOCKNAME_NAME			0
+#define BM_BCH_BLOCKNAME_NAME			0xFFFFFFFF
+#define BF_BCH_BLOCKNAME_NAME(v)		(v)
+
+/*============================================================================*/
+#define HW_BCH_VERSION				0x00000160
+
+#define BP_BCH_VERSION_MAJOR			24
+#define BM_BCH_VERSION_MAJOR			0xFF000000
+#define BF_BCH_VERSION_MAJOR(v)		(((v) << 24) & BM_BCH_VERSION_MAJOR)
+#define BP_BCH_VERSION_MINOR			16
+#define BM_BCH_VERSION_MINOR			0x00FF0000
+#define BF_BCH_VERSION_MINOR(v)		(((v) << 16) & BM_BCH_VERSION_MINOR)
+#define BP_BCH_VERSION_STEP			0
+#define BM_BCH_VERSION_STEP			0x0000FFFF
+#define BF_BCH_VERSION_STEP(v)		(((v) << 0) & BM_BCH_VERSION_STEP)
+/*============================================================================*/
+#endif
diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h b/drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h
new file mode 100644
index 0000000..60d774e
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nfc/gpmi-regs-imx23.h
@@ -0,0 +1,381 @@
+/*
+ * Freescale GPMI NFC NAND Flash Driver
+ *
+ * Copyright 2008-2010 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifndef __GPMI_NFC_GPMI_REGS_H
+#define __GPMI_NFC_GPMI_REGS_H
+
+/*============================================================================*/
+#define HW_GPMI_CTRL0					0x00000000
+#define HW_GPMI_CTRL0_SET				0x00000004
+#define HW_GPMI_CTRL0_CLR				0x00000008
+#define HW_GPMI_CTRL0_TOG				0x0000000c
+
+#define BM_GPMI_CTRL0_SFTRST				0x80000000
+#define BV_GPMI_CTRL0_SFTRST__RUN			0x0
+#define BV_GPMI_CTRL0_SFTRST__RESET			0x1
+#define BM_GPMI_CTRL0_CLKGATE				0x40000000
+#define BV_GPMI_CTRL0_CLKGATE__RUN			0x0
+#define BV_GPMI_CTRL0_CLKGATE__NO_CLKS			0x1
+#define BM_GPMI_CTRL0_RUN				0x20000000
+#define BV_GPMI_CTRL0_RUN__IDLE				0x0
+#define BV_GPMI_CTRL0_RUN__BUSY				0x1
+#define BM_GPMI_CTRL0_DEV_IRQ_EN			0x10000000
+#define BM_GPMI_CTRL0_TIMEOUT_IRQ_EN			0x08000000
+#define BM_GPMI_CTRL0_UDMA				0x04000000
+#define BV_GPMI_CTRL0_UDMA__DISABLED			0x0
+#define BV_GPMI_CTRL0_UDMA__ENABLED			0x1
+#define BP_GPMI_CTRL0_COMMAND_MODE			24
+#define BM_GPMI_CTRL0_COMMAND_MODE			0x03000000
+#define BF_GPMI_CTRL0_COMMAND_MODE(v)	\
+				(((v) << 24) & BM_GPMI_CTRL0_COMMAND_MODE)
+#define BV_GPMI_CTRL0_COMMAND_MODE__WRITE		0x0
+#define BV_GPMI_CTRL0_COMMAND_MODE__READ		0x1
+#define BV_GPMI_CTRL0_COMMAND_MODE__READ_AND_COMPARE	0x2
+#define BV_GPMI_CTRL0_COMMAND_MODE__WAIT_FOR_READY	0x3
+#define BM_GPMI_CTRL0_WORD_LENGTH			0x00800000
+#define BV_GPMI_CTRL0_WORD_LENGTH__16_BIT		0x0
+#define BV_GPMI_CTRL0_WORD_LENGTH__8_BIT		0x1
+#define BM_GPMI_CTRL0_LOCK_CS				0x00400000
+#define BV_GPMI_CTRL0_LOCK_CS__DISABLED			0x0
+#define BV_GPMI_CTRL0_LOCK_CS__ENABLED			0x1
+#define BP_GPMI_CTRL0_CS				20
+#define BM_GPMI_CTRL0_CS				0x00300000
+#define BF_GPMI_CTRL0_CS(v)		(((v) << 20) & BM_GPMI_CTRL0_CS)
+#define BP_GPMI_CTRL0_ADDRESS				17
+#define BM_GPMI_CTRL0_ADDRESS				0x000E0000
+#define BF_GPMI_CTRL0_ADDRESS(v)	(((v) << 17) & BM_GPMI_CTRL0_ADDRESS)
+#define BV_GPMI_CTRL0_ADDRESS__NAND_DATA		0x0
+#define BV_GPMI_CTRL0_ADDRESS__NAND_CLE			0x1
+#define BV_GPMI_CTRL0_ADDRESS__NAND_ALE			0x2
+#define BM_GPMI_CTRL0_ADDRESS_INCREMENT			0x00010000
+#define BV_GPMI_CTRL0_ADDRESS_INCREMENT__DISABLED	0x0
+#define BV_GPMI_CTRL0_ADDRESS_INCREMENT__ENABLED	0x1
+#define BP_GPMI_CTRL0_XFER_COUNT			0
+#define BM_GPMI_CTRL0_XFER_COUNT			0x0000FFFF
+#define BF_GPMI_CTRL0_XFER_COUNT(v)	(((v) << 0) & BM_GPMI_CTRL0_XFER_COUNT)
+
+/*============================================================================*/
+#define HW_GPMI_COMPARE					0x00000010
+
+#define BP_GPMI_COMPARE_MASK				16
+#define BM_GPMI_COMPARE_MASK				0xFFFF0000
+#define BF_GPMI_COMPARE_MASK(v)		(((v) << 16) & BM_GPMI_COMPARE_MASK)
+#define BP_GPMI_COMPARE_REFERENCE			0
+#define BM_GPMI_COMPARE_REFERENCE			0x0000FFFF
+#define BF_GPMI_COMPARE_REFERENCE(v)	(((v) << 0) & BM_GPMI_COMPARE_REFERENCE)
+
+/*============================================================================*/
+#define HW_GPMI_ECCCTRL					0x00000020
+#define HW_GPMI_ECCCTRL_SET				0x00000024
+#define HW_GPMI_ECCCTRL_CLR				0x00000028
+#define HW_GPMI_ECCCTRL_TOG				0x0000002c
+
+#define BP_GPMI_ECCCTRL_HANDLE				16
+#define BM_GPMI_ECCCTRL_HANDLE				0xFFFF0000
+#define BF_GPMI_ECCCTRL_HANDLE(v)	(((v) << 16) & BM_GPMI_ECCCTRL_HANDLE)
+#define BM_GPMI_ECCCTRL_RSVD2				0x00008000
+#define BP_GPMI_ECCCTRL_ECC_CMD				13
+#define BM_GPMI_ECCCTRL_ECC_CMD				0x00006000
+#define BF_GPMI_ECCCTRL_ECC_CMD(v)	(((v) << 13) & BM_GPMI_ECCCTRL_ECC_CMD)
+#define BV_GPMI_ECCCTRL_ECC_CMD__DECODE_4_BIT		0x0
+#define BV_GPMI_ECCCTRL_ECC_CMD__ENCODE_4_BIT		0x1
+#define BV_GPMI_ECCCTRL_ECC_CMD__DECODE_8_BIT		0x2
+#define BV_GPMI_ECCCTRL_ECC_CMD__ENCODE_8_BIT		0x3
+#define BV_GPMI_ECCCTRL_ECC_CMD__BCH_DECODE		0x0
+#define BV_GPMI_ECCCTRL_ECC_CMD__BCH_ENCODE		0x1
+#define BM_GPMI_ECCCTRL_ENABLE_ECC			0x00001000
+#define BV_GPMI_ECCCTRL_ENABLE_ECC__ENABLE		0x1
+#define BV_GPMI_ECCCTRL_ENABLE_ECC__DISABLE		0x0
+#define BP_GPMI_ECCCTRL_RSVD1				9
+#define BM_GPMI_ECCCTRL_RSVD1				0x00000E00
+#define BF_GPMI_ECCCTRL_RSVD1(v)	(((v) << 9) & BM_GPMI_ECCCTRL_RSVD1)
+#define BP_GPMI_ECCCTRL_BUFFER_MASK			0
+#define BM_GPMI_ECCCTRL_BUFFER_MASK			0x000001FF
+#define BF_GPMI_ECCCTRL_BUFFER_MASK(v)	\
+				(((v) << 0) & BM_GPMI_ECCCTRL_BUFFER_MASK)
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BCH_AUXONLY	0x100
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BCH_PAGE		0x1FF
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__AUXILIARY		0x100
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BUFFER7		0x080
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BUFFER6		0x040
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BUFFER5		0x020
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BUFFER4		0x010
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BUFFER3		0x008
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BUFFER2		0x004
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BUFFER1		0x002
+#define BV_GPMI_ECCCTRL_BUFFER_MASK__BUFFER0		0x001
+
+/*============================================================================*/
+#define HW_GPMI_ECCCOUNT				0x00000030
+
+#define BP_GPMI_ECCCOUNT_RSVD2				16
+#define BM_GPMI_ECCCOUNT_RSVD2				0xFFFF0000
+#define BF_GPMI_ECCCOUNT_RSVD2(v)	(((v) << 16) & BM_GPMI_ECCCOUNT_RSVD2)
+#define BP_GPMI_ECCCOUNT_COUNT				0
+#define BM_GPMI_ECCCOUNT_COUNT				0x0000FFFF
+#define BF_GPMI_ECCCOUNT_COUNT(v)	(((v) << 0) & BM_GPMI_ECCCOUNT_COUNT)
+
+/*============================================================================*/
+#define HW_GPMI_PAYLOAD					0x00000040
+
+#define BP_GPMI_PAYLOAD_ADDRESS				2
+#define BM_GPMI_PAYLOAD_ADDRESS				0xFFFFFFFC
+#define BF_GPMI_PAYLOAD_ADDRESS(v)	(((v) << 2) & BM_GPMI_PAYLOAD_ADDRESS)
+#define BP_GPMI_PAYLOAD_RSVD0				0
+#define BM_GPMI_PAYLOAD_RSVD0				0x00000003
+#define BF_GPMI_PAYLOAD_RSVD0(v)	(((v) << 0) & BM_GPMI_PAYLOAD_RSVD0)
+
+/*============================================================================*/
+#define HW_GPMI_AUXILIARY				0x00000050
+
+#define BP_GPMI_AUXILIARY_ADDRESS			2
+#define BM_GPMI_AUXILIARY_ADDRESS			0xFFFFFFFC
+#define BF_GPMI_AUXILIARY_ADDRESS(v)	(((v) << 2) & BM_GPMI_AUXILIARY_ADDRESS)
+#define BP_GPMI_AUXILIARY_RSVD0				0
+#define BM_GPMI_AUXILIARY_RSVD0				0x00000003
+#define BF_GPMI_AUXILIARY_RSVD0(v)	(((v) << 0) & BM_GPMI_AUXILIARY_RSVD0)
+
+/*============================================================================*/
+#define HW_GPMI_CTRL1					0x00000060
+#define HW_GPMI_CTRL1_SET				0x00000064
+#define HW_GPMI_CTRL1_CLR				0x00000068
+#define HW_GPMI_CTRL1_TOG				0x0000006c
+
+#define BP_GPMI_CTRL1_RSVD2				24
+#define BM_GPMI_CTRL1_RSVD2				0xFF000000
+#define BF_GPMI_CTRL1_RSVD2(v)		(((v) << 24) & BM_GPMI_CTRL1_RSVD2)
+#define BM_GPMI_CTRL1_CE3_SEL				0x00800000
+#define BM_GPMI_CTRL1_CE2_SEL				0x00400000
+#define BM_GPMI_CTRL1_CE1_SEL				0x00200000
+#define BM_GPMI_CTRL1_CE0_SEL				0x00100000
+#define BM_GPMI_CTRL1_GANGED_RDYBUSY			0x00080000
+#define BM_GPMI_CTRL1_GPMI_MODE				0x00000001
+#define BP_GPMI_CTRL1_GPMI_MODE				0
+#define BM_GPMI_CTRL1_ATA_IRQRDY_POLARITY		0x00000004
+#define BM_GPMI_CTRL1_DEV_RESET				0x00000008
+#define BM_GPMI_CTRL1_TIMEOUT_IRQ			0x00000200
+#define BM_GPMI_CTRL1_DEV_IRQ				0x00000400
+#define BM_GPMI_CTRL1_RDN_DELAY				0x0000F000
+#define BP_GPMI_CTRL1_RDN_DELAY				12
+#define BM_GPMI_CTRL1_BCH_MODE				0x00040000
+#define BP_GPMI_CTRL1_DLL_ENABLE			17
+#define BM_GPMI_CTRL1_DLL_ENABLE			0x00020000
+#define BP_GPMI_CTRL1_HALF_PERIOD			16
+#define BM_GPMI_CTRL1_HALF_PERIOD			0x00010000
+#define BP_GPMI_CTRL1_RDN_DELAY				12
+#define BM_GPMI_CTRL1_RDN_DELAY				0x0000F000
+#define BF_GPMI_CTRL1_RDN_DELAY(v)	(((v) << 12) & BM_GPMI_CTRL1_RDN_DELAY)
+#define BM_GPMI_CTRL1_DMA2ECC_MODE			0x00000800
+#define BM_GPMI_CTRL1_DEV_IRQ				0x00000400
+#define BM_GPMI_CTRL1_TIMEOUT_IRQ			0x00000200
+#define BM_GPMI_CTRL1_BURST_EN				0x00000100
+#define BM_GPMI_CTRL1_ABORT_WAIT_FOR_READY3		0x00000080
+#define BM_GPMI_CTRL1_ABORT_WAIT_FOR_READY2		0x00000040
+#define BM_GPMI_CTRL1_ABORT_WAIT_FOR_READY1		0x00000020
+#define BM_GPMI_CTRL1_ABORT_WAIT_FOR_READY0		0x00000010
+#define BM_GPMI_CTRL1_DEV_RESET				0x00000008
+#define BV_GPMI_CTRL1_DEV_RESET__ENABLED		0x0
+#define BV_GPMI_CTRL1_DEV_RESET__DISABLED		0x1
+#define BM_GPMI_CTRL1_ATA_IRQRDY_POLARITY		0x00000004
+#define BV_GPMI_CTRL1_ATA_IRQRDY_POLARITY__ACTIVELOW	0x0
+#define BV_GPMI_CTRL1_ATA_IRQRDY_POLARITY__ACTIVEHIGH	0x1
+#define BM_GPMI_CTRL1_CAMERA_MODE			0x00000002
+#define BM_GPMI_CTRL1_GPMI_MODE				0x00000001
+#define BV_GPMI_CTRL1_GPMI_MODE__NAND			0x0
+#define BV_GPMI_CTRL1_GPMI_MODE__ATA			0x1
+
+/*============================================================================*/
+#define HW_GPMI_TIMING0					0x00000070
+
+#define BP_GPMI_TIMING0_RSVD1				24
+#define BM_GPMI_TIMING0_RSVD1				0xFF000000
+#define BF_GPMI_TIMING0_RSVD1(v)	(((v) << 24) & BM_GPMI_TIMING0_RSVD1)
+#define BP_GPMI_TIMING0_ADDRESS_SETUP			16
+#define BM_GPMI_TIMING0_ADDRESS_SETUP			0x00FF0000
+#define BF_GPMI_TIMING0_ADDRESS_SETUP(v)	\
+				(((v) << 16) & BM_GPMI_TIMING0_ADDRESS_SETUP)
+#define BP_GPMI_TIMING0_DATA_HOLD			8
+#define BM_GPMI_TIMING0_DATA_HOLD			0x0000FF00
+#define BF_GPMI_TIMING0_DATA_HOLD(v)	(((v) << 8) & BM_GPMI_TIMING0_DATA_HOLD)
+#define BP_GPMI_TIMING0_DATA_SETUP			0
+#define BM_GPMI_TIMING0_DATA_SETUP			0x000000FF
+#define BF_GPMI_TIMING0_DATA_SETUP(v)	\
+				(((v) << 0) & BM_GPMI_TIMING0_DATA_SETUP)
+
+/*============================================================================*/
+#define HW_GPMI_TIMING1					0x00000080
+
+#define BP_GPMI_TIMING1_DEVICE_BUSY_TIMEOUT		16
+#define BM_GPMI_TIMING1_DEVICE_BUSY_TIMEOUT		0xFFFF0000
+#define BF_GPMI_TIMING1_DEVICE_BUSY_TIMEOUT(v)	\
+			(((v) << 16) & BM_GPMI_TIMING1_DEVICE_BUSY_TIMEOUT)
+#define BP_GPMI_TIMING1_RSVD1				0
+#define BM_GPMI_TIMING1_RSVD1				0x0000FFFF
+#define BF_GPMI_TIMING1_RSVD1(v)	(((v) << 0) & BM_GPMI_TIMING1_RSVD1)
+
+/*============================================================================*/
+#define HW_GPMI_TIMING2					0x00000090
+
+#define BP_GPMI_TIMING2_UDMA_TRP			24
+#define BM_GPMI_TIMING2_UDMA_TRP			0xFF000000
+#define BF_GPMI_TIMING2_UDMA_TRP(v)	(((v) << 24) & BM_GPMI_TIMING2_UDMA_TRP)
+#define BP_GPMI_TIMING2_UDMA_ENV			16
+#define BM_GPMI_TIMING2_UDMA_ENV			0x00FF0000
+#define BF_GPMI_TIMING2_UDMA_ENV(v)	(((v) << 16) & BM_GPMI_TIMING2_UDMA_ENV)
+#define BP_GPMI_TIMING2_UDMA_HOLD			8
+#define BM_GPMI_TIMING2_UDMA_HOLD			0x0000FF00
+#define BF_GPMI_TIMING2_UDMA_HOLD(v)	(((v) << 8) & BM_GPMI_TIMING2_UDMA_HOLD)
+#define BP_GPMI_TIMING2_UDMA_SETUP			0
+#define BM_GPMI_TIMING2_UDMA_SETUP			0x000000FF
+#define BF_GPMI_TIMING2_UDMA_SETUP(v)	\
+				(((v) << 0) & BM_GPMI_TIMING2_UDMA_SETUP)
+
+/*============================================================================*/
+#define HW_GPMI_DATA					0x000000a0
+
+#define BP_GPMI_DATA_DATA				0
+#define BM_GPMI_DATA_DATA				0xFFFFFFFF
+#define BF_GPMI_DATA_DATA(v)				(v)
+
+/*============================================================================*/
+#define HW_GPMI_STAT					0x000000b0
+
+#define BM_GPMI_STAT_PRESENT				0x80000000
+#define BV_GPMI_STAT_PRESENT__UNAVAILABLE		0x0
+#define BV_GPMI_STAT_PRESENT__AVAILABLE			0x1
+#define BP_GPMI_STAT_RSVD1				12
+#define BM_GPMI_STAT_RSVD1				0x7FFFF000
+#define BF_GPMI_STAT_RSVD1(v)		(((v) << 12) & BM_GPMI_STAT_RSVD1)
+#define BP_GPMI_STAT_RDY_TIMEOUT			8
+#define BM_GPMI_STAT_RDY_TIMEOUT			0x00000F00
+#define BF_GPMI_STAT_RDY_TIMEOUT(v)	(((v) << 8) & BM_GPMI_STAT_RDY_TIMEOUT)
+#define BM_GPMI_STAT_ATA_IRQ				0x00000080
+#define BM_GPMI_STAT_INVALID_BUFFER_MASK		0x00000040
+#define BM_GPMI_STAT_FIFO_EMPTY				0x00000020
+#define BV_GPMI_STAT_FIFO_EMPTY__NOT_EMPTY		0x0
+#define BV_GPMI_STAT_FIFO_EMPTY__EMPTY			0x1
+#define BM_GPMI_STAT_FIFO_FULL				0x00000010
+#define BV_GPMI_STAT_FIFO_FULL__NOT_FULL		0x0
+#define BV_GPMI_STAT_FIFO_FULL__FULL			0x1
+#define BM_GPMI_STAT_DEV3_ERROR				0x00000008
+#define BM_GPMI_STAT_DEV2_ERROR				0x00000004
+#define BM_GPMI_STAT_DEV1_ERROR				0x00000002
+#define BM_GPMI_STAT_DEERROR				0x00000001
+
+/*============================================================================*/
+#define HW_GPMI_DEBUG					0x000000c0
+
+#define BM_GPMI_DEBUG_READY3				0x80000000
+#define BM_GPMI_DEBUG_READY2				0x40000000
+#define BM_GPMI_DEBUG_READY1				0x20000000
+#define BM_GPMI_DEBUG_READY0				0x10000000
+#define BM_GPMI_DEBUG_WAIT_FOR_READY_END3		0x08000000
+#define BM_GPMI_DEBUG_WAIT_FOR_READY_END2		0x04000000
+#define BM_GPMI_DEBUG_WAIT_FOR_READY_END1		0x02000000
+#define BM_GPMI_DEBUG_WAIT_FOR_READY_END0		0x01000000
+#define BM_GPMI_DEBUG_SENSE3				0x00800000
+#define BM_GPMI_DEBUG_SENSE2				0x00400000
+#define BM_GPMI_DEBUG_SENSE1				0x00200000
+#define BM_GPMI_DEBUG_SENSE0				0x00100000
+#define BM_GPMI_DEBUG_DMAREQ3				0x00080000
+#define BM_GPMI_DEBUG_DMAREQ2				0x00040000
+#define BM_GPMI_DEBUG_DMAREQ1				0x00020000
+#define BM_GPMI_DEBUG_DMAREQ0				0x00010000
+#define BP_GPMI_DEBUG_CMD_END				12
+#define BM_GPMI_DEBUG_CMD_END				0x0000F000
+#define BF_GPMI_DEBUG_CMD_END(v)	(((v) << 12) & BM_GPMI_DEBUG_CMD_END)
+#define BP_GPMI_DEBUG_UDMA_STATE			8
+#define BM_GPMI_DEBUG_UDMA_STATE			0x00000F00
+#define BF_GPMI_DEBUG_UDMA_STATE(v)	(((v) << 8) & BM_GPMI_DEBUG_UDMA_STATE)
+#define BM_GPMI_DEBUG_BUSY				0x00000080
+#define BV_GPMI_DEBUG_BUSY__DISABLED			0x0
+#define BV_GPMI_DEBUG_BUSY__ENABLED			0x1
+#define BP_GPMI_DEBUG_PIN_STATE				4
+#define BM_GPMI_DEBUG_PIN_STATE				0x00000070
+#define BF_GPMI_DEBUG_PIN_STATE(v)	(((v) << 4) & BM_GPMI_DEBUG_PIN_STATE)
+#define BV_GPMI_DEBUG_PIN_STATE__PSM_IDLE		0x0
+#define BV_GPMI_DEBUG_PIN_STATE__PSM_BYTCNT		0x1
+#define BV_GPMI_DEBUG_PIN_STATE__PSM_ADDR		0x2
+#define BV_GPMI_DEBUG_PIN_STATE__PSM_STALL		0x3
+#define BV_GPMI_DEBUG_PIN_STATE__PSM_STROBE		0x4
+#define BV_GPMI_DEBUG_PIN_STATE__PSM_ATARDY		0x5
+#define BV_GPMI_DEBUG_PIN_STATE__PSM_DHOLD		0x6
+#define BV_GPMI_DEBUG_PIN_STATE__PSM_DONE		0x7
+#define BP_GPMI_DEBUG_MAIN_STATE			0
+#define BM_GPMI_DEBUG_MAIN_STATE			0x0000000F
+#define BF_GPMI_DEBUG_MAIN_STATE(v)	(((v) << 0) & BM_GPMI_DEBUG_MAIN_STATE)
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_IDLE		0x0
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_BYTCNT		0x1
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_WAITFE		0x2
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_WAITFR		0x3
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_DMAREQ		0x4
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_DMAACK		0x5
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_WAITFF		0x6
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_LDFIFO		0x7
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_LDDMAR		0x8
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_RDCMP		0x9
+#define BV_GPMI_DEBUG_MAIN_STATE__MSM_DONE		0xA
+
+/*============================================================================*/
+#define HW_GPMI_VERSION					0x000000d0
+
+#define BP_GPMI_VERSION_MAJOR				24
+#define BM_GPMI_VERSION_MAJOR				0xFF000000
+#define BF_GPMI_VERSION_MAJOR(v)	(((v) << 24) & BM_GPMI_VERSION_MAJOR)
+#define BP_GPMI_VERSION_MINOR				16
+#define BM_GPMI_VERSION_MINOR				0x00FF0000
+#define BF_GPMI_VERSION_MINOR(v)	(((v) << 16) & BM_GPMI_VERSION_MINOR)
+#define BP_GPMI_VERSION_STEP				0
+#define BM_GPMI_VERSION_STEP				0x0000FFFF
+#define BF_GPMI_VERSION_STEP(v)		(((v) << 0) & BM_GPMI_VERSION_STEP)
+
+/*============================================================================*/
+#define HW_GPMI_DEBUG2					0x000000e0
+
+#define BP_GPMI_DEBUG2_RSVD1				16
+#define BM_GPMI_DEBUG2_RSVD1				0xFFFF0000
+#define BF_GPMI_DEBUG2_RSVD1(v)		(((v) << 16) & BM_GPMI_DEBUG2_RSVD1)
+#define BP_GPMI_DEBUG2_SYND2GPMI_BE			12
+#define BM_GPMI_DEBUG2_SYND2GPMI_BE			0x0000F000
+#define BF_GPMI_DEBUG2_SYND2GPMI_BE(v)	\
+				(((v) << 12) & BM_GPMI_DEBUG2_SYND2GPMI_BE)
+#define BM_GPMI_DEBUG2_GPMI2SYND_VALID			0x00000800
+#define BM_GPMI_DEBUG2_GPMI2SYND_READY			0x00000400
+#define BM_GPMI_DEBUG2_SYND2GPMI_VALID			0x00000200
+#define BM_GPMI_DEBUG2_SYND2GPMI_READY			0x00000100
+#define BM_GPMI_DEBUG2_VIEW_DELAYED_RDN			0x00000080
+#define BM_GPMI_DEBUG2_UPDATE_WINDOW			0x00000040
+#define BP_GPMI_DEBUG2_RDN_TAP				0
+#define BM_GPMI_DEBUG2_RDN_TAP				0x0000003F
+#define BF_GPMI_DEBUG2_RDN_TAP(v)	(((v) << 0) & BM_GPMI_DEBUG2_RDN_TAP)
+
+/*============================================================================*/
+#define HW_GPMI_DEBUG3					0x000000f0
+
+#define BP_GPMI_DEBUG3_APB_WORD_CNTR			16
+#define BM_GPMI_DEBUG3_APB_WORD_CNTR			0xFFFF0000
+#define BF_GPMI_DEBUG3_APB_WORD_CNTR(v)	\
+				(((v) << 16) & BM_GPMI_DEBUG3_APB_WORD_CNTR)
+#define BP_GPMI_DEBUG3_DEV_WORD_CNTR			0
+#define BM_GPMI_DEBUG3_DEV_WORD_CNTR			0x0000FFFF
+#define BF_GPMI_DEBUG3_DEV_WORD_CNTR(v)	\
+				(((v) << 0) & BM_GPMI_DEBUG3_DEV_WORD_CNTR)
+/*============================================================================*/
+#endif
diff --git a/drivers/mtd/nand/gpmi-nfc/hal-imx23.c b/drivers/mtd/nand/gpmi-nfc/hal-imx23.c
new file mode 100644
index 0000000..7e3bcd8
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nfc/hal-imx23.c
@@ -0,0 +1,555 @@
+/*
+ * Freescale GPMI NFC NAND Flash Driver
+ *
+ * Copyright (C) 2010 Freescale Semiconductor, Inc.
+ * Copyright (C) 2008 Embedded Alley Solutions, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#include "gpmi-nfc.h"
+#include "gpmi-regs-imx23.h"
+#include "bch-regs-imx23.h"
+
+static int init_hal_imx23(struct gpmi_nfc_data *this)
+{
+	struct resources  *resources = &this->resources;
+
+	/* Enable the clock */
+	clk_enable(resources->clock);
+
+	/* Reset the GPMI block. */
+	mxs_reset_block(resources->gpmi_regs);
+
+	/* Choose NAND mode. */
+	__raw_writel(BM_GPMI_CTRL1_GPMI_MODE,
+				resources->gpmi_regs + HW_GPMI_CTRL1_CLR);
+
+	/* Set the IRQ polarity. */
+	__raw_writel(BM_GPMI_CTRL1_ATA_IRQRDY_POLARITY,
+				resources->gpmi_regs + HW_GPMI_CTRL1_SET);
+
+	/* Disable write protection. */
+	__raw_writel(BM_GPMI_CTRL1_DEV_RESET,
+				resources->gpmi_regs + HW_GPMI_CTRL1_SET);
+
+	/* Select BCH ECC. */
+	__raw_writel(BM_GPMI_CTRL1_BCH_MODE,
+				resources->gpmi_regs + HW_GPMI_CTRL1_SET);
+
+	/* Disable the clock. */
+	clk_disable(resources->clock);
+	return 0;
+}
+
+/* Configures the NFC geometry for BCH.  */
+static int set_geometry(struct gpmi_nfc_data *this)
+{
+	struct resources     *resources = &this->resources;
+	struct nfc_geometry  *nfc       = &this->nfc_geometry;
+	unsigned int         block_count;
+	unsigned int         block_size;
+	unsigned int         metadata_size;
+	unsigned int         ecc_strength;
+	unsigned int         page_size;
+
+	if (common_nfc_set_geometry(this))
+		return !0;
+
+	block_count   = nfc->ecc_chunk_count - 1;
+	block_size    = nfc->ecc_chunk_size_in_bytes;
+	metadata_size = nfc->metadata_size_in_bytes;
+	ecc_strength  = nfc->ecc_strength >> 1;
+	page_size     = nfc->page_size_in_bytes;
+
+	clk_enable(resources->clock);
+
+	/*
+	 * Reset the BCH block. Notice that we pass in true for the just_enable
+	 * flag. This is because the soft reset for the version 0 BCH block
+	 * doesn't work. If you try to soft reset the BCH block, it becomes
+	 * unusable until the next hard reset.
+	 */
+	mxs_reset_block(resources->bch_regs);
+
+	/* Configure layout 0. */
+	__raw_writel(
+		BF_BCH_FLASH0LAYOUT0_NBLOCKS(block_count)     |
+		BF_BCH_FLASH0LAYOUT0_META_SIZE(metadata_size) |
+		BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength)       |
+		BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size)   ,
+		resources->bch_regs + HW_BCH_FLASH0LAYOUT0);
+
+	__raw_writel(
+		BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(page_size)   |
+		BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength)     |
+		BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size) ,
+		resources->bch_regs + HW_BCH_FLASH0LAYOUT1);
+
+	/* Set *all* chip selects to use layout 0. */
+	__raw_writel(0, resources->bch_regs + HW_BCH_LAYOUTSELECT);
+
+	/* Enable interrupts. */
+	__raw_writel(BM_BCH_CTRL_COMPLETE_IRQ_EN,
+				resources->bch_regs + HW_BCH_CTRL_SET);
+
+	clk_disable(resources->clock);
+	return 0;
+}
+
+static int set_timing(struct gpmi_nfc_data *this,
+			const struct nand_timing *timing)
+{
+	struct nfc_hal  *nfc = this->nfc;
+
+	nfc->timing = *timing;
+	return 0;
+}
+
+/**
+ * get_timing() - Retrieves the NFC hardware timing.
+ *
+ * @this:                    Per-device data.
+ * @clock_frequency_in_hz:   The clock frequency, in Hz, during the current
+ *                           I/O transaction. If no I/O transaction is in
+ *                           progress, this is the clock frequency during the
+ *                           most recent I/O transaction.
+ * @hardware_timing:         The hardware timing configuration in effect during
+ *                           the current I/O transaction. If no I/O transaction
+ *                           is in progress, this is the hardware timing
+ *                           configuration during the most recent I/O
+ *                           transaction.
+ */
+static void get_timing(struct gpmi_nfc_data *this,
+			unsigned long *clock_frequency_in_hz,
+			struct gpmi_nfc_hardware_timing *hardware_timing)
+{
+	struct resources                 *resources = &this->resources;
+	struct nfc_hal                   *nfc       =  this->nfc;
+	unsigned char                    *gpmi_regs = resources->gpmi_regs;
+	uint32_t                         register_image;
+
+	/* Return the clock frequency. */
+	*clock_frequency_in_hz = nfc->clock_frequency_in_hz;
+
+	/* We'll be reading the hardware, so let's enable the clock. */
+	clk_enable(resources->clock);
+
+	/* Retrieve the hardware timing. */
+	register_image = __raw_readl(gpmi_regs + HW_GPMI_TIMING0);
+
+	hardware_timing->data_setup_in_cycles =
+		(register_image & BM_GPMI_TIMING0_DATA_SETUP) >>
+						BP_GPMI_TIMING0_DATA_SETUP;
+
+	hardware_timing->data_hold_in_cycles =
+		(register_image & BM_GPMI_TIMING0_DATA_HOLD) >>
+						BP_GPMI_TIMING0_DATA_HOLD;
+
+	hardware_timing->address_setup_in_cycles =
+		(register_image & BM_GPMI_TIMING0_ADDRESS_SETUP) >>
+						BP_GPMI_TIMING0_ADDRESS_SETUP;
+
+	register_image = __raw_readl(gpmi_regs + HW_GPMI_CTRL1);
+
+	hardware_timing->use_half_periods =
+		(register_image & BM_GPMI_CTRL1_HALF_PERIOD) >>
+						BP_GPMI_CTRL1_HALF_PERIOD;
+
+	hardware_timing->sample_delay_factor =
+		(register_image & BM_GPMI_CTRL1_RDN_DELAY) >>
+						BP_GPMI_CTRL1_RDN_DELAY;
+
+	/* We're done reading the hardware, so disable the clock. */
+	clk_disable(resources->clock);
+}
+
+static void exit(struct gpmi_nfc_data *this)
+{
+}
+
+/* Begin the I/O */
+static void begin(struct gpmi_nfc_data *this)
+{
+	struct resources                 *resources = &this->resources;
+	struct nfc_hal                   *nfc       =  this->nfc;
+	struct gpmi_nfc_hardware_timing  hw;
+	unsigned char                    *gpmi_regs = resources->gpmi_regs;
+	unsigned int                     clock_period_in_ns;
+	uint32_t                         register_image;
+	unsigned int                     dll_wait_time_in_us;
+
+	/* Enable the clock. */
+	clk_enable(resources->clock);
+
+	/* Get the timing information we need. */
+	nfc->clock_frequency_in_hz = clk_get_rate(resources->clock);
+	clock_period_in_ns = 1000000000 / nfc->clock_frequency_in_hz;
+
+	gpmi_nfc_compute_hardware_timing(this, &hw);
+
+	/* Set up all the simple timing parameters. */
+	register_image =
+		BF_GPMI_TIMING0_ADDRESS_SETUP(hw.address_setup_in_cycles) |
+		BF_GPMI_TIMING0_DATA_HOLD(hw.data_hold_in_cycles)         |
+		BF_GPMI_TIMING0_DATA_SETUP(hw.data_setup_in_cycles)       ;
+
+	__raw_writel(register_image, gpmi_regs + HW_GPMI_TIMING0);
+
+	/*
+	 * HEY - PAY ATTENTION!
+	 *
+	 * DLL_ENABLE must be set to zero when setting RDN_DELAY or HALF_PERIOD.
+	 */
+	__raw_writel(BM_GPMI_CTRL1_DLL_ENABLE, gpmi_regs + HW_GPMI_CTRL1_CLR);
+
+	/* Clear out the DLL control fields. */
+	__raw_writel(BM_GPMI_CTRL1_RDN_DELAY,   gpmi_regs + HW_GPMI_CTRL1_CLR);
+	__raw_writel(BM_GPMI_CTRL1_HALF_PERIOD, gpmi_regs + HW_GPMI_CTRL1_CLR);
+
+	/* If no sample delay is called for, return immediately. */
+	if (!hw.sample_delay_factor)
+		return;
+
+	/* Configure the HALF_PERIOD flag. */
+
+	if (hw.use_half_periods)
+		__raw_writel(BM_GPMI_CTRL1_HALF_PERIOD,
+						gpmi_regs + HW_GPMI_CTRL1_SET);
+
+	/* Set the delay factor. */
+	__raw_writel(BF_GPMI_CTRL1_RDN_DELAY(hw.sample_delay_factor),
+						gpmi_regs + HW_GPMI_CTRL1_SET);
+
+	/* Enable the DLL. */
+	__raw_writel(BM_GPMI_CTRL1_DLL_ENABLE, gpmi_regs + HW_GPMI_CTRL1_SET);
+
+	/*
+	 * After we enable the GPMI DLL, we have to wait 64 clock cycles before
+	 * we can use the GPMI.
+	 *
+	 * Calculate the amount of time we need to wait, in microseconds.
+	 */
+	dll_wait_time_in_us = (clock_period_in_ns * 64) / 1000;
+
+	if (!dll_wait_time_in_us)
+		dll_wait_time_in_us = 1;
+
+	/* Wait for the DLL to settle. */
+	udelay(dll_wait_time_in_us);
+}
+
+static void end(struct gpmi_nfc_data *this)
+{
+	struct resources  *resources = &this->resources;
+	clk_disable(resources->clock);
+}
+
+/* Clears a BCH interrupt. */
+static void clear_bch(struct gpmi_nfc_data *this)
+{
+	struct resources  *r = &this->resources;
+	__raw_writel(BM_BCH_CTRL_COMPLETE_IRQ, r->bch_regs + HW_BCH_CTRL_CLR);
+}
+
+/* Returns the Ready/Busy status of the given chip. */
+static int is_ready(struct gpmi_nfc_data *this, unsigned chip)
+{
+	struct resources  *resources = &this->resources;
+	uint32_t          mask;
+	uint32_t          register_image;
+
+	mask = BM_GPMI_DEBUG_READY0 << chip;
+	register_image = __raw_readl(resources->gpmi_regs + HW_GPMI_DEBUG);
+	return !!(register_image & mask);
+}
+
+static int send_command(struct gpmi_nfc_data *this)
+{
+	struct dma_chan *channel = get_dma_chan(this);
+	struct mil *mil	= &this->mil;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sgl;
+	u32 pio[3];
+
+	/* [1] send out the PIO words */
+	pio[0] = BF_GPMI_CTRL0_COMMAND_MODE(BV_GPMI_CTRL0_COMMAND_MODE__WRITE)
+		| BM_GPMI_CTRL0_WORD_LENGTH
+		| BF_GPMI_CTRL0_CS(mil->current_chip)
+		| BF_GPMI_CTRL0_ADDRESS(BV_GPMI_CTRL0_ADDRESS__NAND_CLE)
+		| BM_GPMI_CTRL0_ADDRESS_INCREMENT
+		| BF_GPMI_CTRL0_XFER_COUNT(mil->command_length);
+	pio[1] = pio[2] = 0;
+	desc = channel->device->device_prep_slave_sg(channel,
+					(struct scatterlist *)pio,
+					ARRAY_SIZE(pio), DMA_NONE, 0);
+	if (!desc) {
+		log("step 1 error");
+		return -1;
+	}
+
+	/* [2] send out the COMMAND + ADDRESS string stored in @buffer */
+	sgl = &mil->cmd_sgl;
+
+	sg_init_one(sgl, mil->cmd_buffer, mil->command_length);
+	dma_map_sg(this->dev, sgl, 1, DMA_TO_DEVICE);
+	desc = channel->device->device_prep_slave_sg(channel,
+					sgl, 1, DMA_TO_DEVICE, 1);
+	if (!desc) {
+		log("error");
+		return -1;
+	}
+
+	/* [3] submit the DMA */
+	this->dma_type = DMA_FOR_COMMAND;
+	start_dma_without_bch_irq(this, desc);
+	return 0;
+}
+
+static int send_data(struct gpmi_nfc_data *this)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *channel = get_dma_chan(this);
+	struct mil *mil	= &this->mil;
+	uint32_t command_mode;
+	uint32_t address;
+	u32 pio[2];
+
+	/* [1] PIO */
+	command_mode = BV_GPMI_CTRL0_COMMAND_MODE__WRITE;
+	address      = BV_GPMI_CTRL0_ADDRESS__NAND_DATA;
+
+	pio[0] =
+		BF_GPMI_CTRL0_COMMAND_MODE(command_mode)	|
+		BM_GPMI_CTRL0_WORD_LENGTH			|
+		BF_GPMI_CTRL0_CS(mil->current_chip)		|
+		BF_GPMI_CTRL0_ADDRESS(address)			|
+		BF_GPMI_CTRL0_XFER_COUNT(mil->upper_len);
+	pio[1] = 0;
+	desc = channel->device->device_prep_slave_sg(channel,
+					(struct scatterlist *)pio,
+					ARRAY_SIZE(pio), DMA_NONE, 0);
+	if (!desc) {
+		log("step 1 error");
+		return -1;
+	}
+
+	/* [2]  send DMA request */
+	prepare_data_dma(this, DMA_TO_DEVICE);
+	desc = channel->device->device_prep_slave_sg(channel, &mil->data_sgl,
+						1, DMA_TO_DEVICE, 1);
+	if (!desc) {
+		log("step 2 error");
+		return -1;
+	}
+	/* [3] submit the DMA */
+	this->dma_type = DMA_FOR_WRITE_DATA;
+	start_dma_without_bch_irq(this, desc);
+	return 0;
+}
+
+static int read_data(struct gpmi_nfc_data *this)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *channel = get_dma_chan(this);
+	struct mil *mil = &this->mil;
+	u32 pio[2];
+
+	/* [1] : send PIO */
+	pio[0] = BF_GPMI_CTRL0_COMMAND_MODE(BV_GPMI_CTRL0_COMMAND_MODE__READ)
+		| BM_GPMI_CTRL0_WORD_LENGTH
+		| BF_GPMI_CTRL0_CS(mil->current_chip)
+		| BF_GPMI_CTRL0_ADDRESS(BV_GPMI_CTRL0_ADDRESS__NAND_DATA)
+		| BF_GPMI_CTRL0_XFER_COUNT(mil->upper_len);
+	pio[1] = 0;
+	desc = channel->device->device_prep_slave_sg(channel,
+					(struct scatterlist *)pio,
+					ARRAY_SIZE(pio), DMA_NONE, 0);
+	if (!desc) {
+		log("step 1 error");
+		return -1;
+	}
+
+	/* [2] : send DMA request */
+	prepare_data_dma(this, DMA_FROM_DEVICE);
+	desc = channel->device->device_prep_slave_sg(channel, &mil->data_sgl,
+						1, DMA_FROM_DEVICE, 1);
+	if (!desc) {
+		log("step 2 error");
+		return -1;
+	}
+
+	/* [3] : submit the DMA */
+	this->dma_type = DMA_FOR_READ_DATA;
+	start_dma_without_bch_irq(this, desc);
+	return 0;
+}
+
+static int send_page(struct gpmi_nfc_data *this,
+			dma_addr_t payload, dma_addr_t auxiliary)
+{
+	struct nfc_geometry  *geo   = &this->nfc_geometry;
+	uint32_t             command_mode;
+	uint32_t             address;
+	uint32_t             ecc_command;
+	uint32_t             buffer_mask;
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *channel = get_dma_chan(this);
+	struct mil *mil = &this->mil;
+	int chip = mil->current_chip;
+	u32 pio[6];
+
+	/* A DMA descriptor that does an ECC page read. */
+	command_mode = BV_GPMI_CTRL0_COMMAND_MODE__WRITE;
+	address      = BV_GPMI_CTRL0_ADDRESS__NAND_DATA;
+	ecc_command  = BV_GPMI_ECCCTRL_ECC_CMD__BCH_ENCODE;
+	buffer_mask  = BV_GPMI_ECCCTRL_BUFFER_MASK__BCH_PAGE |
+				BV_GPMI_ECCCTRL_BUFFER_MASK__BCH_AUXONLY;
+
+	pio[0] =
+		BF_GPMI_CTRL0_COMMAND_MODE(command_mode) |
+		BM_GPMI_CTRL0_WORD_LENGTH                |
+		BF_GPMI_CTRL0_CS(chip)                   |
+		BF_GPMI_CTRL0_ADDRESS(address)           |
+		BF_GPMI_CTRL0_XFER_COUNT(0)              ;
+	pio[1] = 0;
+	pio[2] =
+		BM_GPMI_ECCCTRL_ENABLE_ECC               |
+		BF_GPMI_ECCCTRL_ECC_CMD(ecc_command)     |
+		BF_GPMI_ECCCTRL_BUFFER_MASK(buffer_mask) ;
+	pio[3] = geo->page_size_in_bytes;
+	pio[4] = payload;
+	pio[5] = auxiliary;
+
+	desc = channel->device->device_prep_slave_sg(channel,
+					(struct scatterlist *)pio,
+					ARRAY_SIZE(pio), DMA_NONE, 0);
+	if (!desc) {
+		log("step 2 error");
+		return -1;
+	}
+	this->dma_type = DMA_FOR_WRITE_ECC_PAGE;
+	return start_dma_with_bch_irq(this, desc);
+}
+
+static int read_page(struct gpmi_nfc_data *this,
+				dma_addr_t payload, dma_addr_t auxiliary)
+{
+	struct nfc_geometry *geo = &this->nfc_geometry;
+	uint32_t             command_mode;
+	uint32_t             address;
+	uint32_t             ecc_command;
+	uint32_t             buffer_mask;
+
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *channel = get_dma_chan(this);
+	struct mil *mil = &this->mil;
+	int chip = mil->current_chip;
+	u32 pio[6];
+
+	/* [1] Wait for the chip to report ready. */
+	command_mode = BV_GPMI_CTRL0_COMMAND_MODE__WAIT_FOR_READY;
+	address      = BV_GPMI_CTRL0_ADDRESS__NAND_DATA;
+
+	pio[0] =  BF_GPMI_CTRL0_COMMAND_MODE(command_mode)
+		| BM_GPMI_CTRL0_WORD_LENGTH
+		| BF_GPMI_CTRL0_CS(chip)
+		| BF_GPMI_CTRL0_ADDRESS(address)
+		| BF_GPMI_CTRL0_XFER_COUNT(0);
+	pio[1] = 0;
+	desc = channel->device->device_prep_slave_sg(channel,
+				(struct scatterlist *)pio, 2, DMA_NONE, 0);
+	if (!desc) {
+		log("step 1 error");
+		return -1;
+	}
+
+	/* [2] Enable the BCH block and read. */
+	command_mode = BV_GPMI_CTRL0_COMMAND_MODE__READ;
+	address      = BV_GPMI_CTRL0_ADDRESS__NAND_DATA;
+	ecc_command  = BV_GPMI_ECCCTRL_ECC_CMD__BCH_DECODE;
+	buffer_mask  = BV_GPMI_ECCCTRL_BUFFER_MASK__BCH_PAGE
+			| BV_GPMI_ECCCTRL_BUFFER_MASK__BCH_AUXONLY;
+
+	pio[0] =  BF_GPMI_CTRL0_COMMAND_MODE(command_mode)
+		| BM_GPMI_CTRL0_WORD_LENGTH
+		| BF_GPMI_CTRL0_CS(chip)
+		| BF_GPMI_CTRL0_ADDRESS(address)
+		| BF_GPMI_CTRL0_XFER_COUNT(geo->page_size_in_bytes);
+
+	pio[1] = 0;
+	pio[2] =  BM_GPMI_ECCCTRL_ENABLE_ECC
+		| BF_GPMI_ECCCTRL_ECC_CMD(ecc_command)
+		| BF_GPMI_ECCCTRL_BUFFER_MASK(buffer_mask);
+	pio[3] = geo->page_size_in_bytes;
+	pio[4] = payload;
+	pio[5] = auxiliary;
+	desc = channel->device->device_prep_slave_sg(channel,
+					(struct scatterlist *)pio,
+					ARRAY_SIZE(pio), DMA_NONE, 1);
+	if (!desc) {
+		log("step 2 error");
+		return -1;
+	}
+
+	/* [3] Disable the BCH block */
+	command_mode = BV_GPMI_CTRL0_COMMAND_MODE__WAIT_FOR_READY;
+	address      = BV_GPMI_CTRL0_ADDRESS__NAND_DATA;
+
+	pio[0] =
+		BF_GPMI_CTRL0_COMMAND_MODE(command_mode)              |
+		BM_GPMI_CTRL0_WORD_LENGTH                             |
+		BF_GPMI_CTRL0_CS(chip)                                |
+		BF_GPMI_CTRL0_ADDRESS(address)                        |
+		BF_GPMI_CTRL0_XFER_COUNT(geo->page_size_in_bytes) ;
+	pio[1] = 0;
+	desc = channel->device->device_prep_slave_sg(channel,
+				(struct scatterlist *)pio, 2, DMA_NONE, 1);
+	if (!desc) {
+		log("step 3 error");
+		return -1;
+	}
+
+	/* [4] submit the DMA */
+	this->dma_type = DMA_FOR_READ_ECC_PAGE;
+	return start_dma_with_bch_irq(this, desc);
+}
+
+/* The NFC HAL for IMX23 */
+struct nfc_hal  gpmi_nfc_hal_imx23 = {
+	.version                     = 0,
+	.description                 = "4-chip GPMI and BCH for IMX23",
+	.max_chip_count              = 4,
+	.max_data_setup_cycles       = (BM_GPMI_TIMING0_DATA_SETUP >>
+						BP_GPMI_TIMING0_DATA_SETUP),
+	.internal_data_setup_in_ns   = 0,
+	.max_sample_delay_factor     = (BM_GPMI_CTRL1_RDN_DELAY >>
+						BP_GPMI_CTRL1_RDN_DELAY),
+	.max_dll_clock_period_in_ns  = 32,
+	.max_dll_delay_in_ns         = 16,
+	.init                        = init_hal_imx23,
+	.set_geometry                = set_geometry,
+	.set_timing                  = set_timing,
+	.get_timing                  = get_timing,
+	.exit                        = exit,
+	.begin                       = begin,
+	.end                         = end,
+	.clear_bch                   = clear_bch,
+	.is_ready                    = is_ready,
+	.send_command                = send_command,
+	.read_data                   = read_data,
+	.send_data                   = send_data,
+	.read_page                   = read_page,
+	.send_page                   = send_page,
+};
diff --git a/drivers/mtd/nand/gpmi-nfc/rom-imx23.c b/drivers/mtd/nand/gpmi-nfc/rom-imx23.c
new file mode 100644
index 0000000..8193874
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nfc/rom-imx23.c
@@ -0,0 +1,300 @@
+/*
+ * Freescale GPMI NFC NAND Flash Driver
+ *
+ * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
+ * Copyright (C) 2008 Embedded Alley Solutions, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#include "gpmi-nfc.h"
+
+/* Useful variables for Boot ROM Helper version 0.  */
+static const char  *fingerprint = "STMP";
+
+/* Sets geometry for the Boot ROM Helper. */
+static int set_geometry(struct gpmi_nfc_data *this)
+{
+	struct gpmi_nfc_platform_data	*pdata    =  this->pdata;
+	struct boot_rom_geometry	*geometry = &this->rom_geometry;
+	struct nand_chip		*nand     = &this->mil.nand;
+	int                             error;
+
+	error = gpmi_nfc_rom_helper_set_geometry(this);
+	if (error)
+		return error;
+
+	if (!pdata->boot_area_size_in_bytes) {
+		geometry->boot_area_count         = 0;
+		geometry->boot_area_size_in_bytes = 0;
+		return 0;
+	}
+
+	if (nand->numchips == 1) {
+		geometry->boot_area_count = 1;
+		geometry->boot_area_size_in_bytes =
+					pdata->boot_area_size_in_bytes * 2;
+	} else {
+		geometry->boot_area_count = 2;
+		geometry->boot_area_size_in_bytes =
+					pdata->boot_area_size_in_bytes;
+	}
+	return 0;
+}
+
+static int check_transcription_stamp(struct gpmi_nfc_data *this)
+{
+	struct boot_rom_geometry  *rom_geo  = &this->rom_geometry;
+	struct mil                *mil      = &this->mil;
+	struct mtd_info           *mtd      = &mil->mtd;
+	struct nand_chip          *nand     = &mil->nand;
+	unsigned int              search_area_size_in_strides;
+	unsigned int              stride;
+	unsigned int              page;
+	loff_t                    byte;
+	uint8_t                   *buffer = nand->buffers->databuf;
+	int                       saved_chip_number;
+	int                       found_an_ncb_fingerprint = false;
+
+	/* Compute the number of strides in a search area. */
+	search_area_size_in_strides = 1 << rom_geo->search_area_stride_exponent;
+
+	/* Select chip 0. */
+	saved_chip_number = mil->current_chip;
+	nand->select_chip(mtd, 0);
+
+	/*
+	 * Loop through the first search area, looking for the NCB fingerprint.
+	 */
+	pr_info("Scanning for an NCB fingerprint...\n");
+
+	for (stride = 0; stride < search_area_size_in_strides; stride++) {
+		/* Compute the page and byte addresses. */
+		page = stride * rom_geo->stride_size_in_pages;
+		byte = page   * mtd->writesize;
+
+		pr_info("  Looking for a fingerprint in page 0x%x\n", page);
+
+		/*
+		 * Read the NCB fingerprint. The fingerprint is four bytes long
+		 * and starts in the 12th byte of the page.
+		 */
+		nand->cmdfunc(mtd, NAND_CMD_READ0, 12, page);
+		nand->read_buf(mtd, buffer, strlen(fingerprint));
+
+		/* Look for the fingerprint. */
+		if (!memcmp(buffer, fingerprint, strlen(fingerprint))) {
+			found_an_ncb_fingerprint = true;
+			break;
+		}
+
+	}
+
+	/* Deselect chip 0. */
+	nand->select_chip(mtd, saved_chip_number);
+
+	if (found_an_ncb_fingerprint)
+		pr_info("  Found a fingerprint\n");
+	else
+		pr_info("  No fingerprint found\n");
+	return found_an_ncb_fingerprint;
+}
+
+/* Writes a transcription stamp. */
+static int write_transcription_stamp(struct gpmi_nfc_data *this)
+{
+	struct device             *dev      =  this->dev;
+	struct boot_rom_geometry  *rom_geo  = &this->rom_geometry;
+	struct nand_device_info	  *info     = &this->device_info;
+	struct mil                *mil      = &this->mil;
+	struct mtd_info           *mtd      = &mil->mtd;
+	struct nand_chip          *nand     = &mil->nand;
+	unsigned int              block_size_in_pages;
+	unsigned int              search_area_size_in_strides;
+	unsigned int              search_area_size_in_pages;
+	unsigned int              search_area_size_in_blocks;
+	unsigned int              block;
+	unsigned int              stride;
+	unsigned int              page;
+	loff_t                    byte;
+	uint8_t                   *buffer = nand->buffers->databuf;
+	int                       saved_chip_number;
+	int                       status;
+
+	/* Compute the search area geometry. */
+	block_size_in_pages = info->attr.block_size_in_pages;
+	search_area_size_in_strides = 1 << rom_geo->search_area_stride_exponent;
+	search_area_size_in_pages = search_area_size_in_strides *
+					rom_geo->stride_size_in_pages;
+	search_area_size_in_blocks =
+		  (search_area_size_in_pages + (block_size_in_pages - 1)) /
+				    block_size_in_pages;
+
+	pr_info("-------------------------------------------\n");
+	pr_info("Search Area Geometry\n");
+	pr_info("-------------------------------------------\n");
+	pr_info("Search Area Size in Blocks : %u", search_area_size_in_blocks);
+	pr_info("Search Area Size in Strides: %u", search_area_size_in_strides);
+	pr_info("Search Area Size in Pages  : %u", search_area_size_in_pages);
+
+	/* Select chip 0. */
+	saved_chip_number = mil->current_chip;
+	nand->select_chip(mtd, 0);
+
+	/* Loop over blocks in the first search area, erasing them. */
+	pr_info("Erasing the search area...\n");
+
+	for (block = 0; block < search_area_size_in_blocks; block++) {
+		/* Compute the page address. */
+		page = block * block_size_in_pages;
+
+		/* Erase this block. */
+		pr_info("  Erasing block 0x%x\n", block);
+		nand->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
+		nand->cmdfunc(mtd, NAND_CMD_ERASE2, -1, -1);
+
+		/* Wait for the erase to finish. */
+		status = nand->waitfunc(mtd, nand);
+		if (status & NAND_STATUS_FAIL)
+			dev_err(dev, "[%s] Erase failed.\n", __func__);
+	}
+
+	/* Write the NCB fingerprint into the page buffer. */
+	memset(buffer, ~0, mtd->writesize);
+	memset(nand->oob_poi, ~0, mtd->oobsize);
+	memcpy(buffer + 12, fingerprint, strlen(fingerprint));
+
+	/* Loop through the first search area, writing NCB fingerprints. */
+	pr_info("Writing NCB fingerprints...\n");
+	for (stride = 0; stride < search_area_size_in_strides; stride++) {
+		/* Compute the page and byte addresses. */
+		page = stride * rom_geo->stride_size_in_pages;
+		byte = page   * mtd->writesize;
+
+		/* Write the first page of the current stride. */
+		pr_info("  Writing an NCB fingerprint in page 0x%x\n", page);
+		nand->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
+		nand->ecc.write_page_raw(mtd, nand, buffer);
+		nand->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+
+		/* Wait for the write to finish. */
+		status = nand->waitfunc(mtd, nand);
+		if (status & NAND_STATUS_FAIL)
+			dev_err(dev, "[%s] Write failed.\n", __func__);
+	}
+
+	/* Deselect chip 0. */
+	nand->select_chip(mtd, saved_chip_number);
+	return 0;
+}
+
+static int imx23_rom_extra_init(struct gpmi_nfc_data  *this)
+{
+	struct device             *dev      =  this->dev;
+	struct mil                *mil      = &this->mil;
+	struct nand_chip          *nand     = &mil->nand;
+	struct mtd_info           *mtd      = &mil->mtd;
+	struct nand_device_info	  *info     = &this->device_info;
+	unsigned int              block_count;
+	unsigned int              block;
+	int                       chip;
+	int                       page;
+	loff_t                    byte;
+	uint8_t                   block_mark;
+	int                       error = 0;
+
+	/*
+	 * If control arrives here, we can't use block mark swapping, which
+	 * means we're forced to use transcription. First, scan for the
+	 * transcription stamp. If we find it, then we don't have to do
+	 * anything -- the block marks are already transcribed.
+	 */
+	if (check_transcription_stamp(this))
+		return 0;
+
+	/*
+	 * If control arrives here, we couldn't find a transcription stamp, so
+	 * so we presume the block marks are in the conventional location.
+	 */
+	pr_info("Transcribing bad block marks...\n");
+
+	/* Compute the number of blocks in the entire medium. */
+	block_count = info->attr.chip_size_in_bytes >> nand->phys_erase_shift;
+
+	/*
+	 * Loop over all the blocks in the medium, transcribing block marks as
+	 * we go.
+	 */
+	for (block = 0; block < block_count; block++) {
+		/*
+		 * Compute the chip, page and byte addresses for this block's
+		 * conventional mark.
+		 */
+		chip = block >> (nand->chip_shift - nand->phys_erase_shift);
+		page = block << (nand->phys_erase_shift - nand->page_shift);
+		byte = block <<  nand->phys_erase_shift;
+
+		/* Select the chip. */
+		nand->select_chip(mtd, chip);
+
+		/* Send the command to read the conventional block mark. */
+		nand->cmdfunc(mtd, NAND_CMD_READ0, mtd->writesize, page);
+
+		/* Read the conventional block mark. */
+		block_mark = nand->read_byte(mtd);
+
+		/*
+		 * Check if the block is marked bad. If so, we need to mark it
+		 * again, but this time the result will be a mark in the
+		 * location where we transcribe block marks.
+		 *
+		 * Notice that we have to explicitly set the marking_a_bad_block
+		 * member before we call through the block_markbad function
+		 * pointer in the owning struct nand_chip. If we could call
+		 * though the block_markbad function pointer in the owning
+		 * struct mtd_info, which we have hooked, then this would be
+		 * taken care of for us. Unfortunately, we can't because that
+		 * higher-level code path will do things like consulting the
+		 * in-memory bad block table -- which doesn't even exist yet!
+		 * So, we have to call at a lower level and handle some details
+		 * ourselves.
+		 */
+		if (block_mark != 0xff) {
+			pr_info("Transcribing mark in block %u\n", block);
+			mil->marking_a_bad_block = true;
+			error = nand->block_markbad(mtd, byte);
+			mil->marking_a_bad_block = false;
+			if (error)
+				dev_err(dev, "Failed to mark block bad with "
+							"error %d\n", error);
+		}
+
+		/* Deselect the chip. */
+		nand->select_chip(mtd, -1);
+	}
+
+	/* Write the stamp that indicates we've transcribed the block marks. */
+	write_transcription_stamp(this);
+	return 0;
+}
+
+/* This structure represents the Boot ROM Helper for this version. */
+struct boot_rom_helper  gpmi_nfc_boot_rom_imx23 = {
+	.version                   = 0,
+	.description               = "Single/dual-chip boot area, "
+					"no block mark swapping",
+	.swap_block_mark           = false,
+	.set_geometry              = set_geometry,
+	.rom_extra_init		   = imx23_rom_extra_init,
+};
-- 
1.7.0.4



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
