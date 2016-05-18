From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 18 May 2016 15:40:30 +0000
Subject: [PATCH-V2 6/6] memory: bcm2835: expose register ranges via debugfs
In-Reply-To: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
References: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463586030-2778-7-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Expose the assigned register ranges via debugfs.

For some reason these register ranges are reading as 0
when running with the binary firmware - this may be a limitation
introduced by the firmware or it may be something that
the SOC is blocking.

This is there just to allow/document those registers,
that are visible on the VC4/GPU side.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/memory/bcm2835-sdram.c | 336 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 336 insertions(+)

diff --git a/drivers/memory/bcm2835-sdram.c b/drivers/memory/bcm2835-sdram.c
index ce985ee..9d8cce2 100644
--- a/drivers/memory/bcm2835-sdram.c
+++ b/drivers/memory/bcm2835-sdram.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -26,6 +27,140 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 
+/* the set of registers of the sdram controller */
+#define BCM2835_SD_CS		0x000
+#define BCM2835_SD_SA		0x004
+#define BCM2835_SD_SB		0x008
+#define BCM2835_SD_SC		0x00c
+#define BCM2835_SD_PT2		0x010
+#define BCM2835_SD_PT1		0x014
+#define BCM2835_SD_SECSRT0	0x03c
+#define BCM2835_SD_SECEND0	0x040
+#define BCM2835_SD_SECSRT1	0x044
+#define BCM2835_SD_SECEND1	0x048
+#define BCM2835_SD_SECSRT2	0x04c
+#define BCM2835_SD_SECEND2	0x050
+#define BCM2835_SD_SECSRT3	0x054
+#define BCM2835_SD_SECEND3	0x058
+#define BCM2835_SD_PHYC		0x060
+#define BCM2835_SD_MRT		0x064
+#define BCM2835_SD_TMC		0x07c
+#define BCM2835_SD_RWC		0x080
+#define BCM2835_SD_VIN		0x088
+#define BCM2835_SD_MR		0x090
+#define BCM2835_SD_SD		0x094
+#define BCM2835_SD_SE		0x098
+#define BCM2835_SD_STALL	0x0a0
+#define BCM2835_SD_SF		0x0b4
+#define BCM2835_SD_CARCRC	0x100
+#define BCM2835_SD_DMRCRC0	0x104
+#define BCM2835_SD_DMRCRC1	0x108
+#define BCM2835_SD_DQRCRC0	0x10c
+#define BCM2835_SD_DQRCRC1	0x110
+#define BCM2835_SD_DQRCRC2	0x114
+#define BCM2835_SD_DQRCRC3	0x118
+#define BCM2835_SD_DQRCRC4	0x11c
+#define BCM2835_SD_DQRCRC5	0x120
+#define BCM2835_SD_DQRCRC6	0x124
+#define BCM2835_SD_DQRCRC7	0x128
+#define BCM2835_SD_DQRCRC8	0x12c
+#define BCM2835_SD_DQRCRC9	0x130
+#define BCM2835_SD_DQRCRC10	0x134
+#define BCM2835_SD_DQRCRC11	0x138
+#define BCM2835_SD_DQRCRC12	0x13c
+#define BCM2835_SD_DQRCRC13	0x140
+#define BCM2835_SD_DQRCRC14	0x144
+#define BCM2835_SD_DQRCRC15	0x148
+#define BCM2835_SD_DQLCRC0	0x14c
+#define BCM2835_SD_DQLCRC1	0x150
+#define BCM2835_SD_DQLCRC2	0x154
+#define BCM2835_SD_DQLCRC3	0x158
+#define BCM2835_SD_DQLCRC4	0x15c
+#define BCM2835_SD_DQLCRC5	0x160
+#define BCM2835_SD_DQLCRC6	0x164
+#define BCM2835_SD_DQLCRC7	0x168
+#define BCM2835_SD_DQLCRC8	0x16c
+#define BCM2835_SD_DQLCRC9	0x170
+#define BCM2835_SD_DQLCRC10	0x174
+#define BCM2835_SD_DQLCRC11	0x178
+#define BCM2835_SD_DQLCRC12	0x17c
+#define BCM2835_SD_DQLCRC13	0x180
+#define BCM2835_SD_DQLCRC14	0x184
+#define BCM2835_SD_DQLCRC15	0x188
+
+/* the set of registers of the APHY_CSR, which also contains the pll */
+#define APHY_CSR_ADDR_REV_ID			0x000
+#define APHY_CSR_GLBL_ADDR_DLL_RESET		0x004
+#define APHY_CSR_GLBL_ADDR_DLL_RECAL		0x008
+#define APHY_CSR_GLBL_ADDR_DLL_CNTRL		0x00c
+#define APHY_CSR_GLBL_ADDR_DLL_PH_LD_VAL	0x010
+#define APHY_CSR_ADDR_MASTER_DLL_OUTPUT		0x014
+#define APHY_CSR_ADDR_SLAVE_DLL_OFFSET		0x018
+#define APHY_CSR_GLBL_ADR_MSTR_DLL_BYPEN	0x01c
+#define APHY_CSR_GLBL_ADR_DLL_LOCK_STAT		0x020
+#define APHY_CSR_DDR_PLL_GLOBAL_RESET		0x024
+#define APHY_CSR_DDR_PLL_POST_DIV_RESET		0x028
+#define APHY_CSR_DDR_PLL_VCO_FREQ_CNTRL0	0x02c
+#define APHY_CSR_DDR_PLL_VCO_FREQ_CNTRL1	0x030
+#define APHY_CSR_DDR_PLL_MDIV_VALUE		0x034
+#define APHY_CSR_DDR_PLL_CONFIG_CNTRL		0x038
+#define APHY_CSR_DDR_PLL_MISC_CNTRL		0x03c
+#define APHY_CSR_DDR_PLL_SPRDSPECT_CTRL0	0x040
+#define APHY_CSR_DDR_PLL_SPRDSPECT_CTRL1	0x044
+#define APHY_CSR_DDR_PLL_LOCK_STATUS		0x048
+#define APHY_CSR_DDR_PLL_HOLD_CH		0x04c
+#define APHY_CSR_DDR_PLL_ENABLE_CH		0x050
+#define APHY_CSR_DDR_PLL_BYPASS			0x054
+#define APHY_CSR_DDR_PLL_PWRDWN			0x058
+#define APHY_CSR_DDR_PLL_CH0_DESKEW_CTRL	0x05c
+#define APHY_CSR_DDR_PLL_CH1_DESKEW_CTRL	0x060
+#define APHY_CSR_DDR_PLL_DESKEW_STATUS		0x064
+#define APHY_CSR_ADDR_PAD_DRV_SLEW_CTRL		0x068
+#define APHY_CSR_ADDR_PAD_MISC_CTRL		0x06c
+#define APHY_CSR_ADDR_PVT_COMP_CTRL		0x070
+#define APHY_CSR_ADDR_PVT_COMP_OVRD_CTRL	0x074
+#define APHY_CSR_ADDR_PVT_COMP_STATUS		0x078
+#define APHY_CSR_ADDR_PVT_COMP_DEBUG		0x07c
+#define APHY_CSR_PHY_BIST_CNTRL_SPR		0x080
+#define APHY_CSR_PHY_BIST_CA_CRC_SPR		0x084
+#define APHY_CSR_ADDR_SPR0_RW			0x088
+#define APHY_CSR_ADDR_SPR1_RO			0x08c
+#define APHY_CSR_ADDR_SPR_RO			0x090
+
+/* the set of registers of the DPHY_CSR */
+#define DPHY_CSR_DQ_REV_ID			0x000
+#define DPHY_CSR_GLBL_DQ_DLL_RESET		0x004
+#define DPHY_CSR_GLBL_DQ_DLL_RECALIBRATE	0x008
+#define DPHY_CSR_GLBL_DQ_DLL_CNTRL		0x00c
+#define DPHY_CSR_GLBL_DQ_DLL_PHASE_LD_VL	0x010
+#define DPHY_CSR_GLBL_DQ_MSTR_DLL_BYP_EN	0x014
+#define DPHY_CSR_GLBL_MSTR_DLL_LOCK_STAT	0x018
+#define DPHY_CSR_BYTE0_SLAVE_DLL_OFFSET		0x01c
+#define DPHY_CSR_BYTE1_SLAVE_DLL_OFFSET		0x020
+#define DPHY_CSR_BYTE2_SLAVE_DLL_OFFSET		0x024
+#define DPHY_CSR_BYTE3_SLAVE_DLL_OFFSET		0x028
+#define DPHY_CSR_BYTE0_MASTER_DLL_OUTPUT	0x02c
+#define DPHY_CSR_BYTE1_MASTER_DLL_OUTPUT	0x030
+#define DPHY_CSR_BYTE2_MASTER_DLL_OUTPUT	0x034
+#define DPHY_CSR_BYTE3_MASTER_DLL_OUTPUT	0x038
+#define DPHY_CSR_NORM_READ_DQS_GATE_CTRL	0x03c
+#define DPHY_CSR_BOOT_READ_DQS_GATE_CTRL	0x040
+#define DPHY_CSR_PHY_FIFO_PNTRS			0x044
+#define DPHY_CSR_DQ_PHY_MISC_CTRL		0x048
+#define DPHY_CSR_DQ_PAD_DRV_SLEW_CTRL		0x04c
+#define DPHY_CSR_DQ_PAD_MISC_CTRL		0x050
+#define DPHY_CSR_DQ_PVT_COMP_CTRL		0x054
+#define DPHY_CSR_DQ_PVT_COMP_OVERRD_CTRL	0x058
+#define DPHY_CSR_DQ_PVT_COMP_STATUS		0x05c
+#define DPHY_CSR_DQ_PVT_COMP_DEBUG		0x060
+#define DPHY_CSR_DQ_PHY_READ_CTRL		0x064
+#define DPHY_CSR_DQ_PHY_READ_STATUS		0x068
+#define DPHY_CSR_DQ_SPR_RW			0x06c
+#define DPHY_CSR_DQ_SPR1_RO			0x070
+#define DPHY_CSR_DQ_SPR_RO			0x074
+#define DPHY_CSR_CRC_CTRL			0x800
+#define DPHY_CSR_CRC_DATA			0x804
+
 struct bcm2835_sdram_data {
 	void __iomem	*sdram_regs;
 	void __iomem	*aphy_csr_regs;
@@ -33,8 +168,196 @@ struct bcm2835_sdram_data {
 
 	struct clk	*clk_lv;
 	struct clk	*clk_pll_parent;
+
+	struct dentry	*debugfsdir;
+};
+
+#define R(n, o) { .name = n, .offset = o }
+static const struct debugfs_reg32 bcm2835_sdram_regs[] = {
+	R("cs",		BCM2835_SD_CS),
+	R("sa",		BCM2835_SD_SA),
+	R("sb",		BCM2835_SD_SB),
+	R("sc",		BCM2835_SD_SC),
+	R("pt2",	BCM2835_SD_PT2),
+	R("pt1",	BCM2835_SD_PT1),
+	R("secsrt0",	BCM2835_SD_SECSRT0),
+	R("secend0",	BCM2835_SD_SECEND0),
+	R("secsrt1",	BCM2835_SD_SECSRT1),
+	R("secend1",	BCM2835_SD_SECEND1),
+	R("secsrt2",	BCM2835_SD_SECSRT2),
+	R("secend2",	BCM2835_SD_SECEND2),
+	R("secsrt3",	BCM2835_SD_SECSRT3),
+	R("secend3",	BCM2835_SD_SECEND3),
+	R("phyc",	BCM2835_SD_PHYC),
+	R("mrt",	BCM2835_SD_MRT),
+	R("tmc",	BCM2835_SD_TMC),
+	R("rwc",	BCM2835_SD_RWC),
+	R("vin",	BCM2835_SD_VIN),
+	/*
+	 * this is not exposed as this may result in races with
+	 * a parallel read - possibly by the firmware:
+	 * R("mr",		BCM2835_SD_MR),
+	 */
+	R("sd",		BCM2835_SD_SD),
+	R("se",		BCM2835_SD_SE),
+	R("stall",	BCM2835_SD_STALL),
+	R("sf",		BCM2835_SD_SF),
+	R("carcrc",	BCM2835_SD_CARCRC),
+	R("dmrcrc0",	BCM2835_SD_DMRCRC0),
+	R("dmrcrc1",	BCM2835_SD_DMRCRC1),
+	R("dqrcrc0",	BCM2835_SD_DQRCRC0),
+	R("dqrcrc1",	BCM2835_SD_DQRCRC1),
+	R("dqrcrc2",	BCM2835_SD_DQRCRC2),
+	R("dqrcrc3",	BCM2835_SD_DQRCRC3),
+	R("dqrcrc4",	BCM2835_SD_DQRCRC4),
+	R("dqrcrc5",	BCM2835_SD_DQRCRC5),
+	R("dqrcrc6",	BCM2835_SD_DQRCRC6),
+	R("dqrcrc7",	BCM2835_SD_DQRCRC7),
+	R("dqrcrc8",	BCM2835_SD_DQRCRC8),
+	R("dqrcrc9",	BCM2835_SD_DQRCRC9),
+	R("dqrcrc10",	BCM2835_SD_DQRCRC10),
+	R("dqrcrc11",	BCM2835_SD_DQRCRC11),
+	R("dqrcrc12",	BCM2835_SD_DQRCRC12),
+	R("dqrcrc13",	BCM2835_SD_DQRCRC13),
+	R("dqrcrc14",	BCM2835_SD_DQRCRC14),
+	R("dqrcrc15",	BCM2835_SD_DQRCRC15),
+	R("dqlcrc0",	BCM2835_SD_DQLCRC0),
+	R("dqlcrc1",	BCM2835_SD_DQLCRC1),
+	R("dqlcrc2",	BCM2835_SD_DQLCRC2),
+	R("dqlcrc3",	BCM2835_SD_DQLCRC3),
+	R("dqlcrc4",	BCM2835_SD_DQLCRC4),
+	R("dqlcrc5",	BCM2835_SD_DQLCRC5),
+	R("dqlcrc6",	BCM2835_SD_DQLCRC6),
+	R("dqlcrc7",	BCM2835_SD_DQLCRC7),
+	R("dqlcrc8",	BCM2835_SD_DQLCRC8),
+	R("dqlcrc9",	BCM2835_SD_DQLCRC9),
+	R("dqlcrc10",	BCM2835_SD_DQLCRC10),
+	R("dqlcrc11",	BCM2835_SD_DQLCRC11),
+	R("dqlcrc12",	BCM2835_SD_DQLCRC12),
+	R("dqlcrc13",	BCM2835_SD_DQLCRC13),
+	R("dqlcrc14",	BCM2835_SD_DQLCRC14),
+	R("dqlcrc15",	BCM2835_SD_DQLCRC15)
+};
+
+static const struct debugfs_reg32 bcm2835_aphy_csr_regs[] = {
+	R("addr_rev_id",		APHY_CSR_ADDR_REV_ID),
+	R("glbl_addr_dll_reset",	APHY_CSR_GLBL_ADDR_DLL_RESET),
+	R("glbl_addr_dll_recal",	APHY_CSR_GLBL_ADDR_DLL_RECAL),
+	R("glbl_addr_dll_cntrl",	APHY_CSR_GLBL_ADDR_DLL_CNTRL),
+	R("glbl_addr_dll_ph_ld_val",	APHY_CSR_GLBL_ADDR_DLL_PH_LD_VAL),
+	R("addr_master_dll_output",	APHY_CSR_ADDR_MASTER_DLL_OUTPUT),
+	R("addr_slave_dll_offset",	APHY_CSR_ADDR_SLAVE_DLL_OFFSET),
+	R("glbl_adr_mstr_dll_bypen",	APHY_CSR_GLBL_ADR_MSTR_DLL_BYPEN),
+	R("glbl_adr_dll_lock_stat",	APHY_CSR_GLBL_ADR_DLL_LOCK_STAT),
+	R("ddr_pll_global_reset",	APHY_CSR_DDR_PLL_GLOBAL_RESET),
+	R("ddr_pll_post_div_reset",	APHY_CSR_DDR_PLL_POST_DIV_RESET),
+	R("ddr_pll_vco_freq_cntrl0",	APHY_CSR_DDR_PLL_VCO_FREQ_CNTRL0),
+	R("ddr_pll_vco_freq_cntrl1",	APHY_CSR_DDR_PLL_VCO_FREQ_CNTRL1),
+	R("ddr_pll_mdiv_value",		APHY_CSR_DDR_PLL_MDIV_VALUE),
+	R("ddr_pll_config_cntrl",	APHY_CSR_DDR_PLL_CONFIG_CNTRL),
+	R("ddr_pll_misc_cntrl",		APHY_CSR_DDR_PLL_MISC_CNTRL),
+	R("ddr_pll_sprdspect_ctrl0",	APHY_CSR_DDR_PLL_SPRDSPECT_CTRL0),
+	R("ddr_pll_sprdspect_ctrl1",	APHY_CSR_DDR_PLL_SPRDSPECT_CTRL1),
+	R("ddr_pll_lock_status",	APHY_CSR_DDR_PLL_LOCK_STATUS),
+	R("ddr_pll_hold_ch",		APHY_CSR_DDR_PLL_HOLD_CH),
+	R("ddr_pll_enable_ch",		APHY_CSR_DDR_PLL_ENABLE_CH),
+	R("ddr_pll_bypass",		APHY_CSR_DDR_PLL_BYPASS),
+	R("ddr_pll_pwrdwn",		APHY_CSR_DDR_PLL_PWRDWN),
+	R("ddr_pll_ch0_deskew_ctrl",	APHY_CSR_DDR_PLL_CH0_DESKEW_CTRL),
+	R("ddr_pll_ch1_deskew_ctrl",	APHY_CSR_DDR_PLL_CH1_DESKEW_CTRL),
+	R("ddr_pll_deskew_status",	APHY_CSR_DDR_PLL_DESKEW_STATUS),
+	R("addr_pad_drv_slew_ctrl",	APHY_CSR_ADDR_PAD_DRV_SLEW_CTRL),
+	R("addr_pad_misc_ctrl",		APHY_CSR_ADDR_PAD_MISC_CTRL),
+	R("addr_pvt_comp_ctrl",		APHY_CSR_ADDR_PVT_COMP_CTRL),
+	R("addr_pvt_comp_ovrd_ctrl",	APHY_CSR_ADDR_PVT_COMP_OVRD_CTRL),
+	R("addr_pvt_comp_status",	APHY_CSR_ADDR_PVT_COMP_STATUS),
+	R("addr_pvt_comp_debug",	APHY_CSR_ADDR_PVT_COMP_DEBUG),
+	R("phy_bist_cntrl_spr",		APHY_CSR_PHY_BIST_CNTRL_SPR),
+	R("phy_bist_ca_crc_spr",	APHY_CSR_PHY_BIST_CA_CRC_SPR),
+	R("addr_spr0_rw",		APHY_CSR_ADDR_SPR0_RW),
+	R("addr_spr1_ro",		APHY_CSR_ADDR_SPR1_RO),
+	R("addr_spr_ro",		APHY_CSR_ADDR_SPR_RO)
+};
+
+static const struct debugfs_reg32 bcm2835_dphy_csr_regs[] = {
+	R("dq_rev_id",			DPHY_CSR_DQ_REV_ID),
+	R("glbl_dq_dll_reset",		DPHY_CSR_GLBL_DQ_DLL_RESET),
+	R("glbl_dq_dll_recalibrate",	DPHY_CSR_GLBL_DQ_DLL_RECALIBRATE),
+	R("glbl_dq_dll_cntrl",		DPHY_CSR_GLBL_DQ_DLL_CNTRL),
+	R("glbl_dq_dll_phase_ld_vl",	DPHY_CSR_GLBL_DQ_DLL_PHASE_LD_VL),
+	R("glbl_dq_mstr_dll_byp_en",	DPHY_CSR_GLBL_DQ_MSTR_DLL_BYP_EN),
+	R("glbl_mstr_dll_lock_stat",	DPHY_CSR_GLBL_MSTR_DLL_LOCK_STAT),
+	R("byte0_slave_dll_offset",	DPHY_CSR_BYTE0_SLAVE_DLL_OFFSET),
+	R("byte1_slave_dll_offset",	DPHY_CSR_BYTE1_SLAVE_DLL_OFFSET),
+	R("byte2_slave_dll_offset",	DPHY_CSR_BYTE2_SLAVE_DLL_OFFSET),
+	R("byte3_slave_dll_offset",	DPHY_CSR_BYTE3_SLAVE_DLL_OFFSET),
+	R("byte0_master_dll_output",	DPHY_CSR_BYTE0_MASTER_DLL_OUTPUT),
+	R("byte1_master_dll_output",	DPHY_CSR_BYTE1_MASTER_DLL_OUTPUT),
+	R("byte2_master_dll_output",	DPHY_CSR_BYTE2_MASTER_DLL_OUTPUT),
+	R("byte3_master_dll_output",	DPHY_CSR_BYTE3_MASTER_DLL_OUTPUT),
+	R("norm_read_dqs_gate_ctrl",	DPHY_CSR_NORM_READ_DQS_GATE_CTRL),
+	R("boot_read_dqs_gate_ctrl",	DPHY_CSR_BOOT_READ_DQS_GATE_CTRL),
+	R("phy_fifo_pntrs",		DPHY_CSR_PHY_FIFO_PNTRS),
+	R("dq_phy_misc_ctrl",		DPHY_CSR_DQ_PHY_MISC_CTRL),
+	R("dq_pad_drv_slew_ctrl",	DPHY_CSR_DQ_PAD_DRV_SLEW_CTRL),
+	R("dq_pad_misc_ctrl",		DPHY_CSR_DQ_PAD_MISC_CTRL),
+	R("dq_pvt_comp_ctrl",		DPHY_CSR_DQ_PVT_COMP_CTRL),
+	R("dq_pvt_comp_overrd_ctrl",	DPHY_CSR_DQ_PVT_COMP_OVERRD_CTRL),
+	R("dq_pvt_comp_status",		DPHY_CSR_DQ_PVT_COMP_STATUS),
+	R("dq_pvt_comp_debug",		DPHY_CSR_DQ_PVT_COMP_DEBUG),
+	R("dq_phy_read_ctrl",		DPHY_CSR_DQ_PHY_READ_CTRL),
+	R("dq_phy_read_status",		DPHY_CSR_DQ_PHY_READ_STATUS),
+	R("dq_spr_rw",			DPHY_CSR_DQ_SPR_RW),
+	R("dq_spr1_ro",			DPHY_CSR_DQ_SPR1_RO),
+	R("dq_spr_ro",			DPHY_CSR_DQ_SPR_RO),
+	R("crc_ctrl",			DPHY_CSR_CRC_CTRL),
+	R("crc_data",			DPHY_CSR_CRC_DATA),
 };
 
+static void bcm2835_sdram_debugfs_regset(struct platform_device *pdev,
+					 const char *name,
+					 const struct debugfs_reg32 *reg32,
+					 size_t size,
+					 void *base)
+{
+	struct bcm2835_sdram_data *data = platform_get_drvdata(pdev);
+	struct debugfs_regset32 *regset;
+
+	regset = devm_kzalloc(&pdev->dev, sizeof(*regset),
+			      GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->regs = reg32;
+	regset->nregs = size;
+	regset->base = base;
+
+	debugfs_create_regset32(name, S_IRUGO,
+				data->debugfsdir, regset);
+}
+
+static void bcm2835_sdram_debugfs(struct platform_device *pdev)
+{
+	struct bcm2835_sdram_data *data = platform_get_drvdata(pdev);
+
+	data->debugfsdir = debugfs_create_dir("bcm2835_sdram", NULL);
+	if (!data->debugfsdir)
+		return;
+
+	bcm2835_sdram_debugfs_regset(pdev, "sdram-regset",
+				     bcm2835_sdram_regs,
+				     ARRAY_SIZE(bcm2835_sdram_regs),
+				     data->sdram_regs);
+	bcm2835_sdram_debugfs_regset(pdev, "aphy_csr-regset",
+				     bcm2835_aphy_csr_regs,
+				     ARRAY_SIZE(bcm2835_aphy_csr_regs),
+				     data->aphy_csr_regs);
+	bcm2835_sdram_debugfs_regset(pdev, "dphy_csr-regset",
+				     bcm2835_dphy_csr_regs,
+				     ARRAY_SIZE(bcm2835_dphy_csr_regs),
+				     data->dphy_csr_regs);
+}
+
 static int bcm2835_sdram_probe_reg(struct platform_device *pdev,
 				   const char *name,
 				   void __iomem **ptr)
@@ -105,6 +428,18 @@ static int bcm2835_sdram_probe(struct platform_device *pdev)
 	clk_prepare_enable(data->clk_lv);
 	clk_prepare_enable(data->clk_pll_parent);
 
+	/* setup debugfs */
+	bcm2835_sdram_debugfs(pdev);
+
+	return 0;
+}
+
+static int bcm2835_sdram_remove(struct platform_device *pdev)
+{
+	struct bcm2835_sdram_data *data = platform_get_drvdata(pdev);
+
+	debugfs_remove_recursive(data->debugfsdir);
+
 	return 0;
 }
 
@@ -116,6 +451,7 @@ MODULE_DEVICE_TABLE(of, bcm2835_sdram_of_match_table);
 
 static struct platform_driver bcm2835_sdram_driver = {
 	.probe = bcm2835_sdram_probe,
+	.remove = bcm2835_sdram_remove,
 	.driver = {
 		.name = "bcm2835_sdram",
 		.of_match_table = bcm2835_sdram_of_match_table,
-- 
2.1.4
