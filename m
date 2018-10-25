From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 25 Oct 2018 11:36:58 +0530
Subject: [PATCH v10 3/6] edac: synopsys: Add macro defines for ZynqMP DDRC
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1540447621-22870-4-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macro defines for ZynqMP DDR controller. These macros will be used
for ZynqMP ECC operations.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 168 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0005ef3..d1999e0 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -97,6 +97,174 @@
 #define SCRUB_MODE_MASK			0x7
 #define SCRUB_MODE_SECDED		0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT		BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST			0x70
+#define ECC_CFG1_OFST			0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST			0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST			0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST			0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST		0x84
+#define ECC_CEADDR1_OFST		0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST			0x8C
+#define ECC_CSYND1_OFST			0x90
+#define ECC_CSYND2_OFST			0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST		0x98
+#define ECC_BITMASK1_OFST		0x9C
+#define ECC_BITMASK2_OFST		0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST		0xA4
+#define ECC_UEADDR1_OFST		0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST		0xAC
+#define ECC_UESYND1_OFST		0xB0
+#define ECC_UESYND2_OFST		0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST		0xB8
+#define ECC_POISON1_OFST		0xBC
+
+#define ECC_ADDRMAP0_OFFSET		0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK		0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT		12
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16			2
+#define DDRCTL_EWDTH_32			1
+#define DDRCTL_EWDTH_64			0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK		0xF0000
+#define ECC_STAT_UECNT_SHIFT		16
+#define ECC_STAT_CECNT_MASK		0xF00
+#define ECC_STAT_CECNT_SHIFT		8
+#define ECC_STAT_BITNUM_MASK		0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST		0x20200
+#define DDR_QOSUE_MASK			0x4
+#define	DDR_QOSCE_MASK			0x2
+#define	ECC_CE_UE_INTR_MASK		0x6
+#define DDR_QOS_IRQ_EN_OFST		0x20208
+#define DDR_QOS_IRQ_DB_OFST		0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK		0x3FFFF
+#define ECC_CEADDR0_RNK_MASK		BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
+#define ECC_CEADDR1_BNKNR_MASK		0x70000
+#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT		16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT		24
+#define ECC_POISON0_RANK_MASK		BIT(24)
+#define ECC_POISON0_COLUMN_SHIFT	0
+#define ECC_POISON0_COLUMN_MASK		0xFFF
+#define ECC_POISON1_BG_SHIFT		28
+#define ECC_POISON1_BG_MASK		0x30000000
+#define ECC_POISON1_BANKNR_SHIFT	24
+#define ECC_POISON1_BANKNR_MASK		0x7000000
+#define ECC_POISON1_ROW_SHIFT		0
+#define ECC_POISON1_ROW_MASK		0x3FFFF
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3			0x1
+#define MEM_TYPE_LPDDR3			0x8
+#define MEM_TYPE_DDR2			0x4
+#define MEM_TYPE_DDR4			0x10
+#define MEM_TYPE_LPDDR4			0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL			0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK		0x3
+#define ECC_UEPOISON_MASK		0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_CFG_MASK		0xC0000000
+#define DDRC_MSTR_CFG_SHIFT		30
+#define DDRC_MSTR_CFG_X4_MASK		0x0
+#define DDRC_MSTR_CFG_X8_MASK		0x1
+#define DDRC_MSTR_CFG_X16_MASK		0x2
+#define DDRC_MSTR_CFG_X32_MASK		0x3
+
+#define DDR_MAX_ROW_SHIFT		18
+#define DDR_MAX_COL_SHIFT		14
+#define DDR_MAX_BANK_SHIFT		3
+#define DDR_MAX_BANKGRP_SHIFT		2
+
+#define ROW_MAX_VAL_MASK		0xF
+#define COL_MAX_VAL_MASK		0xF
+#define BANK_MAX_VAL_MASK		0x1F
+#define BANKGRP_MAX_VAL_MASK		0x1F
+#define RANK_MAX_VAL_MASK		0x1F
+
+#define ROW_B0_BASE			6
+#define ROW_B1_BASE			7
+#define ROW_B2_BASE			8
+#define ROW_B3_BASE			9
+#define ROW_B4_BASE			10
+#define ROW_B5_BASE			11
+#define ROW_B6_BASE			12
+#define ROW_B7_BASE			13
+#define ROW_B8_BASE			14
+#define ROW_B9_BASE			15
+#define ROW_B10_BASE			16
+#define ROW_B11_BASE			17
+#define ROW_B12_BASE			18
+#define ROW_B13_BASE			19
+#define ROW_B14_BASE			20
+#define ROW_B15_BASE			21
+#define ROW_B16_BASE			22
+#define ROW_B17_BASE			23
+
+#define COL_B2_BASE			2
+#define COL_B3_BASE			3
+#define COL_B4_BASE			4
+#define COL_B5_BASE			5
+#define COL_B6_BASE			6
+#define COL_B7_BASE			7
+#define COL_B8_BASE			8
+#define COL_B9_BASE			9
+#define COL_B10_BASE			10
+#define COL_B11_BASE			11
+#define COL_B12_BASE			12
+#define COL_B13_BASE			13
+
+#define BANK_B0_BASE			2
+#define BANK_B1_BASE			3
+#define BANK_B2_BASE			4
+
+#define BANKGRP_B0_BASE			2
+#define BANKGRP_B1_BASE			3
+
+#define RANK_B0_BASE			6
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
-- 
2.1.1
