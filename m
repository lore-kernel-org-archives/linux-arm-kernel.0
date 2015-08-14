From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 14 Aug 2015 01:11:03 +0000
Subject: [PATCH 2/2] clk: atlas7: fix noc/socket disconnect/reconnect for unit
 clks
In-Reply-To: <1439514663-23979-1-git-send-email-21cnbao@gmail.com>
References: <1439514663-23979-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1439514663-23979-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

Power management on of NoC(Notwork On Chip) requires that disconnect
and reconnect routine should been done during clk disable/enable.

also there are different types of clocks,
For NoC Macro clocks, write idle_bit and wait for hardward ACK;
For Socket clocks, write idle_bit;
For others, do nothing.

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 334 ++++++++++++++++++++++++------------------
 1 file changed, 188 insertions(+), 146 deletions(-)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index d34d1b3..957aae6 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -205,6 +205,11 @@
 #define SIRFSOC_CLKC_LEAF_CLK_EN7_SET        0x0530
 #define SIRFSOC_CLKC_LEAF_CLK_EN8_SET        0x0548
 
+#define SIRFSOC_NOC_CLK_IDLEREQ_SET		0x02D0
+#define SIRFSOC_NOC_CLK_IDLEREQ_CLR		0x02D4
+#define SIRFSOC_NOC_CLK_SLVRDY_SET		0x02E8
+#define SIRFSOC_NOC_CLK_SLVRDY_CLR		0x02EC
+#define SIRFSOC_NOC_CLK_IDLE_STATUS		0x02F4
 
 struct clk_pll {
 	struct clk_hw hw;
@@ -219,10 +224,18 @@ struct clk_dto {
 };
 #define to_dtoclk(_hw) container_of(_hw, struct clk_dto, hw)
 
+enum clk_unit_type {
+	CLK_UNIT_NOC_OTHER,
+	CLK_UNIT_NOC_CLOCK,
+	CLK_UNIT_NOC_SOCKET,
+};
+
 struct clk_unit {
 	struct clk_hw hw;
 	u16 regofs;
 	u16 bit;
+	u32 type;
+	u8 idle_bit;
 	spinlock_t *lock;
 };
 #define to_unitclk(_hw) container_of(_hw, struct clk_unit, hw)
@@ -260,6 +273,8 @@ struct atlas7_unit_init_data {
 	unsigned long flags;
 	u32 regofs;
 	u8 bit;
+	u32 type;
+	u8 idle_bit;
 	spinlock_t *lock;
 };
 
@@ -1040,148 +1055,148 @@ static struct atlas7_mux_init_data mux_list[] __initdata = {
 	/* new unit should add start from the tail of list */
 static struct atlas7_unit_init_data unit_list[] __initdata = {
 	/* unit_name, parent_name, flags, regofs, bit, lock */
-	{ 0, "audmscm_kas", "kas_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 0, &root0_gate_lock },
-	{ 1, "gnssm_gnss", "gnss_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 1, &root0_gate_lock },
-	{ 2, "gpum_gpu", "gpu_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 2, &root0_gate_lock },
-	{ 3, "mediam_g2d", "g2d_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 3, &root0_gate_lock },
-	{ 4, "mediam_jpenc", "jpenc_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 4, &root0_gate_lock },
-	{ 5, "vdifm_disp0", "disp0_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 5, &root0_gate_lock },
-	{ 6, "vdifm_disp1", "disp1_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 6, &root0_gate_lock },
-	{ 7, "audmscm_i2s", "i2s_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 8, &root0_gate_lock },
-	{ 8, "audmscm_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 11, &root0_gate_lock },
-	{ 9, "vdifm_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 12, &root0_gate_lock },
-	{ 10, "gnssm_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 13, &root0_gate_lock },
-	{ 11, "mediam_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 14, &root0_gate_lock },
-	{ 12, "btm_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 17, &root0_gate_lock },
-	{ 13, "mediam_sdphy01", "sdphy01_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 18, &root0_gate_lock },
-	{ 14, "vdifm_sdphy23", "sdphy23_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 19, &root0_gate_lock },
-	{ 15, "vdifm_sdphy45", "sdphy45_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 20, &root0_gate_lock },
-	{ 16, "vdifm_sdphy67", "sdphy67_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 21, &root0_gate_lock },
-	{ 17, "audmscm_xin", "xin", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 22, &root0_gate_lock },
-	{ 18, "mediam_nand", "nand_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 27, &root0_gate_lock },
-	{ 19, "gnssm_sec", "sec_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 28, &root0_gate_lock },
-	{ 20, "cpum_cpu", "cpu_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 29, &root0_gate_lock },
-	{ 21, "gnssm_xin", "xin", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 30, &root0_gate_lock },
-	{ 22, "vdifm_vip", "vip_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 31, &root0_gate_lock },
-	{ 23, "btm_btss", "btss_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 0, &root1_gate_lock },
-	{ 24, "mediam_usbphy", "usbphy_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 1, &root1_gate_lock },
-	{ 25, "rtcm_kas", "kas_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 2, &root1_gate_lock },
-	{ 26, "audmscm_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 3, &root1_gate_lock },
-	{ 27, "vdifm_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 4, &root1_gate_lock },
-	{ 28, "gnssm_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 5, &root1_gate_lock },
-	{ 29, "mediam_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 6, &root1_gate_lock },
-	{ 30, "cpum_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 8, &root1_gate_lock },
-	{ 31, "gpum_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 9, &root1_gate_lock },
-	{ 32, "audmscm_nocr", "nocr_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 11, &root1_gate_lock },
-	{ 33, "vdifm_nocr", "nocr_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 12, &root1_gate_lock },
-	{ 34, "gnssm_nocr", "nocr_mux", CLK_IGNORE_UNUSED, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 13, &root1_gate_lock },
-	{ 35, "mediam_nocr", "nocr_mux", CLK_IGNORE_UNUSED, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 14, &root1_gate_lock },
-	{ 36, "ddrm_nocr", "nocr_mux", CLK_IGNORE_UNUSED, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 15, &root1_gate_lock },
-	{ 37, "cpum_tpiu", "tpiu_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 16, &root1_gate_lock },
-	{ 38, "gpum_nocr", "nocr_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 17, &root1_gate_lock },
-	{ 39, "gnssm_rgmii", "rgmii_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 20, &root1_gate_lock },
-	{ 40, "mediam_vdec", "vdec_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 21, &root1_gate_lock },
-	{ 41, "gpum_sdr", "sdr_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 22, &root1_gate_lock },
-	{ 42, "vdifm_deint", "deint_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 23, &root1_gate_lock },
-	{ 43, "gnssm_can", "can_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 26, &root1_gate_lock },
-	{ 44, "mediam_usb", "usb_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 28, &root1_gate_lock },
-	{ 45, "gnssm_gmac", "gmac_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 29, &root1_gate_lock },
-	{ 46, "cvd_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 0, &leaf1_gate_lock },
-	{ 47, "timer_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 1, &leaf1_gate_lock },
-	{ 48, "pulse_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 2, &leaf1_gate_lock },
-	{ 49, "tsc_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 3, &leaf1_gate_lock },
-	{ 50, "tsc_xin", "audmscm_xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 21, &leaf1_gate_lock },
-	{ 51, "ioctop_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 4, &leaf1_gate_lock },
-	{ 52, "rsc_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 5, &leaf1_gate_lock },
-	{ 53, "dvm_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 6, &leaf1_gate_lock },
-	{ 54, "lvds_xin", "audmscm_xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 7, &leaf1_gate_lock },
-	{ 55, "kas_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 8, &leaf1_gate_lock },
-	{ 56, "ac97_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 9, &leaf1_gate_lock },
-	{ 57, "usp0_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 10, &leaf1_gate_lock },
-	{ 58, "usp1_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 11, &leaf1_gate_lock },
-	{ 59, "usp2_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 12, &leaf1_gate_lock },
-	{ 60, "dmac2_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 13, &leaf1_gate_lock },
-	{ 61, "dmac3_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 14, &leaf1_gate_lock },
-	{ 62, "audioif_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 15, &leaf1_gate_lock },
-	{ 63, "i2s1_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 17, &leaf1_gate_lock },
-	{ 64, "thaudmscm_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 22, &leaf1_gate_lock },
-	{ 65, "analogtest_xin", "audmscm_xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 23, &leaf1_gate_lock },
-	{ 66, "sys2pci_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 0, &leaf2_gate_lock },
-	{ 67, "pciarb_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 1, &leaf2_gate_lock },
-	{ 68, "pcicopy_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 2, &leaf2_gate_lock },
-	{ 69, "rom_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 3, &leaf2_gate_lock },
-	{ 70, "sdio23_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 4, &leaf2_gate_lock },
-	{ 71, "sdio45_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 5, &leaf2_gate_lock },
-	{ 72, "sdio67_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 6, &leaf2_gate_lock },
-	{ 73, "vip1_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 7, &leaf2_gate_lock },
-	{ 74, "vip1_vip", "vdifm_vip", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 16, &leaf2_gate_lock },
-	{ 75, "sdio23_sdphy23", "vdifm_sdphy23", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 8, &leaf2_gate_lock },
-	{ 76, "sdio45_sdphy45", "vdifm_sdphy45", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 9, &leaf2_gate_lock },
-	{ 77, "sdio67_sdphy67", "vdifm_sdphy67", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 10, &leaf2_gate_lock },
-	{ 78, "vpp0_disp0", "vdifm_disp0", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 11, &leaf2_gate_lock },
-	{ 79, "lcd0_disp0", "vdifm_disp0", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 12, &leaf2_gate_lock },
-	{ 80, "vpp1_disp1", "vdifm_disp1", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 13, &leaf2_gate_lock },
-	{ 81, "lcd1_disp1", "vdifm_disp1", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 14, &leaf2_gate_lock },
-	{ 82, "dcu_deint", "vdifm_deint", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 15, &leaf2_gate_lock },
-	{ 83, "vdifm_dapa_r_nocr", "vdifm_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 17, &leaf2_gate_lock },
-	{ 84, "gpio1_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 18, &leaf2_gate_lock },
-	{ 85, "thvdifm_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 19, &leaf2_gate_lock },
-	{ 86, "gmac_rgmii", "gnssm_rgmii", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 0, &leaf3_gate_lock },
-	{ 87, "gmac_gmac", "gnssm_gmac", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 1, &leaf3_gate_lock },
-	{ 88, "uart1_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 2, &leaf3_gate_lock },
-	{ 89, "dmac0_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 3, &leaf3_gate_lock },
-	{ 90, "uart0_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 4, &leaf3_gate_lock },
-	{ 91, "uart2_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 5, &leaf3_gate_lock },
-	{ 92, "uart3_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 6, &leaf3_gate_lock },
-	{ 93, "uart4_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 7, &leaf3_gate_lock },
-	{ 94, "uart5_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 8, &leaf3_gate_lock },
-	{ 95, "spi1_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 9, &leaf3_gate_lock },
-	{ 96, "gnss_gnss", "gnssm_gnss", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 10, &leaf3_gate_lock },
-	{ 97, "canbus1_can", "gnssm_can", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 12, &leaf3_gate_lock },
-	{ 98, "ccsec_sec", "gnssm_sec", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 15, &leaf3_gate_lock },
-	{ 99,  "ccpub_sec", "gnssm_sec", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 16, &leaf3_gate_lock },
-	{ 100, "gnssm_dapa_r_nocr", "gnssm_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 13, &leaf3_gate_lock },
-	{ 101, "thgnssm_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 14, &leaf3_gate_lock },
-	{ 102, "media_vdec", "mediam_vdec", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 0, &leaf4_gate_lock },
-	{ 103, "media_jpenc", "mediam_jpenc", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 1, &leaf4_gate_lock },
-	{ 104, "g2d_g2d", "mediam_g2d", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 2, &leaf4_gate_lock },
-	{ 105, "i2c0_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 3, &leaf4_gate_lock },
-	{ 106, "i2c1_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 4, &leaf4_gate_lock },
-	{ 107, "gpio0_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 5, &leaf4_gate_lock },
-	{ 108, "nand_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 6, &leaf4_gate_lock },
-	{ 109, "sdio01_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 7, &leaf4_gate_lock },
-	{ 110, "sys2pci2_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 8, &leaf4_gate_lock },
-	{ 111, "sdio01_sdphy01", "mediam_sdphy01", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 9, &leaf4_gate_lock },
-	{ 112, "nand_nand", "mediam_nand", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 10, &leaf4_gate_lock },
-	{ 113, "usb0_usb", "mediam_usb", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 11, &leaf4_gate_lock },
-	{ 114, "usb1_usb", "mediam_usb", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 12, &leaf4_gate_lock },
-	{ 115, "usbphy0_usbphy", "mediam_usbphy", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 13, &leaf4_gate_lock },
-	{ 116, "usbphy1_usbphy", "mediam_usbphy", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 14, &leaf4_gate_lock },
-	{ 117, "thmediam_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 15, &leaf4_gate_lock },
-	{ 118, "memc_mem", "mempll_clk1", CLK_IGNORE_UNUSED, SIRFSOC_CLKC_LEAF_CLK_EN5_SET, 0, &leaf5_gate_lock },
-	{ 119, "dapa_mem", "mempll_clk1", 0, SIRFSOC_CLKC_LEAF_CLK_EN5_SET, 1, &leaf5_gate_lock },
-	{ 120, "nocddrm_nocr", "ddrm_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN5_SET, 2, &leaf5_gate_lock },
-	{ 121, "thddrm_nocr", "ddrm_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN5_SET, 3, &leaf5_gate_lock },
-	{ 122, "spram1_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 0, &leaf6_gate_lock },
-	{ 123, "spram2_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 1, &leaf6_gate_lock },
-	{ 124, "coresight_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 2, &leaf6_gate_lock },
-	{ 125, "coresight_tpiu", "cpum_tpiu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 3, &leaf6_gate_lock },
-	{ 126, "graphic_gpu", "gpum_gpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 0, &leaf7_gate_lock },
-	{ 127, "vss_sdr", "gpum_sdr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 1, &leaf7_gate_lock },
-	{ 128, "thgpum_nocr", "gpum_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 2, &leaf7_gate_lock },
-	{ 129, "a7ca_btss", "btm_btss", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 1, &leaf8_gate_lock },
-	{ 130, "dmac4_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 2, &leaf8_gate_lock },
-	{ 131, "uart6_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 3, &leaf8_gate_lock },
-	{ 132, "usp3_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 4, &leaf8_gate_lock },
-	{ 133, "a7ca_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 5, &leaf8_gate_lock },
-	{ 134, "noc_btm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 6, &leaf8_gate_lock },
-	{ 135, "thbtm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 7, &leaf8_gate_lock },
-	{ 136, "btslow", "xinw_fixdiv_btslow", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 25, &root1_gate_lock },
-	{ 137, "a7ca_btslow", "btslow", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 0, &leaf8_gate_lock },
-	{ 138, "pwm_io", "io_mux", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 0, &leaf0_gate_lock },
-	{ 139, "pwm_xin", "xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 1, &leaf0_gate_lock },
-	{ 140, "pwm_xinw", "xinw", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 2, &leaf0_gate_lock },
-	{ 141, "thcgum_sys", "sys_mux", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 3, &leaf0_gate_lock },
+	{ 0, "audmscm_kas", "kas_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 0, 0, 0, &root0_gate_lock },
+	{ 1, "gnssm_gnss", "gnss_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 1, 0, 0, &root0_gate_lock },
+	{ 2, "gpum_gpu", "gpu_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 2, 0, 0, &root0_gate_lock },
+	{ 3, "mediam_g2d", "g2d_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 3, 0, 0, &root0_gate_lock },
+	{ 4, "mediam_jpenc", "jpenc_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 4, 0, 0, &root0_gate_lock },
+	{ 5, "vdifm_disp0", "disp0_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 5, 0, 0, &root0_gate_lock },
+	{ 6, "vdifm_disp1", "disp1_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 6, 0, 0, &root0_gate_lock },
+	{ 7, "audmscm_i2s", "i2s_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 8, 0, 0, &root0_gate_lock },
+	{ 8, "audmscm_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 11, 0, 0, &root0_gate_lock },
+	{ 9, "vdifm_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 12, 0, 0, &root0_gate_lock },
+	{ 10, "gnssm_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 13, 0, 0, &root0_gate_lock },
+	{ 11, "mediam_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 14, 0, 0, &root0_gate_lock },
+	{ 12, "btm_io", "io_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 17, 0, 0, &root0_gate_lock },
+	{ 13, "mediam_sdphy01", "sdphy01_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 18, 0, 0, &root0_gate_lock },
+	{ 14, "vdifm_sdphy23", "sdphy23_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 19, 0, 0, &root0_gate_lock },
+	{ 15, "vdifm_sdphy45", "sdphy45_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 20, 0, 0, &root0_gate_lock },
+	{ 16, "vdifm_sdphy67", "sdphy67_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 21, 0, 0, &root0_gate_lock },
+	{ 17, "audmscm_xin", "xin", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 22, 0, 0, &root0_gate_lock },
+	{ 18, "mediam_nand", "nand_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 27, 0, 0, &root0_gate_lock },
+	{ 19, "gnssm_sec", "sec_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 28, 0, 0, &root0_gate_lock },
+	{ 20, "cpum_cpu", "cpu_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 29, 0, 0, &root0_gate_lock },
+	{ 21, "gnssm_xin", "xin", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 30, 0, 0, &root0_gate_lock },
+	{ 22, "vdifm_vip", "vip_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 31, 0, 0, &root0_gate_lock },
+	{ 23, "btm_btss", "btss_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 0, 0, 0, &root1_gate_lock },
+	{ 24, "mediam_usbphy", "usbphy_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 1, 0, 0, &root1_gate_lock },
+	{ 25, "rtcm_kas", "kas_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 2, 0, 0, &root1_gate_lock },
+	{ 26, "audmscm_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 3, 0, 0, &root1_gate_lock },
+	{ 27, "vdifm_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 4, 0, 0, &root1_gate_lock },
+	{ 28, "gnssm_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 5, 0, 0, &root1_gate_lock },
+	{ 29, "mediam_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 6, 0, 0, &root1_gate_lock },
+	{ 30, "cpum_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 8, 0, 0, &root1_gate_lock },
+	{ 31, "gpum_nocd", "nocd_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 9, 0, 0, &root1_gate_lock },
+	{ 32, "audmscm_nocr", "nocr_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 11, 0, 0, &root1_gate_lock },
+	{ 33, "vdifm_nocr", "nocr_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 12, 0, 0, &root1_gate_lock },
+	{ 34, "gnssm_nocr", "nocr_mux", CLK_IGNORE_UNUSED, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 13, 0, 0, &root1_gate_lock },
+	{ 35, "mediam_nocr", "nocr_mux", CLK_IGNORE_UNUSED, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 14, 0, 0, &root1_gate_lock },
+	{ 36, "ddrm_nocr", "nocr_mux", CLK_IGNORE_UNUSED, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 15, 0, 0, &root1_gate_lock },
+	{ 37, "cpum_tpiu", "tpiu_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 16, 0, 0, &root1_gate_lock },
+	{ 38, "gpum_nocr", "nocr_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 17, 0, 0, &root1_gate_lock },
+	{ 39, "gnssm_rgmii", "rgmii_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 20, 0, 0, &root1_gate_lock },
+	{ 40, "mediam_vdec", "vdec_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 21, 0, 0, &root1_gate_lock },
+	{ 41, "gpum_sdr", "sdr_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 22, 0, 0, &root1_gate_lock },
+	{ 42, "vdifm_deint", "deint_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 23, 0, 0, &root1_gate_lock },
+	{ 43, "gnssm_can", "can_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 26, 0, 0, &root1_gate_lock },
+	{ 44, "mediam_usb", "usb_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 28, 0, 0, &root1_gate_lock },
+	{ 45, "gnssm_gmac", "gmac_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 29, 0, 0, &root1_gate_lock },
+	{ 46, "cvd_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 0, CLK_UNIT_NOC_CLOCK, 4, &leaf1_gate_lock },
+	{ 47, "timer_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 1, 0, 0, &leaf1_gate_lock },
+	{ 48, "pulse_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 2, 0, 0, &leaf1_gate_lock },
+	{ 49, "tsc_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 3, 0, 0, &leaf1_gate_lock },
+	{ 50, "tsc_xin", "audmscm_xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 21, 0, 0, &leaf1_gate_lock },
+	{ 51, "ioctop_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 4, 0, 0, &leaf1_gate_lock },
+	{ 52, "rsc_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 5, 0, 0, &leaf1_gate_lock },
+	{ 53, "dvm_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 6, CLK_UNIT_NOC_SOCKET, 7, &leaf1_gate_lock },
+	{ 54, "lvds_xin", "audmscm_xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 7, CLK_UNIT_NOC_SOCKET, 8, &leaf1_gate_lock },
+	{ 55, "kas_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 8, CLK_UNIT_NOC_CLOCK, 2, &leaf1_gate_lock },
+	{ 56, "ac97_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 9, 0, 0, &leaf1_gate_lock },
+	{ 57, "usp0_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 10, CLK_UNIT_NOC_SOCKET, 4, &leaf1_gate_lock },
+	{ 58, "usp1_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 11, CLK_UNIT_NOC_SOCKET, 5, &leaf1_gate_lock },
+	{ 59, "usp2_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 12, CLK_UNIT_NOC_SOCKET, 6, &leaf1_gate_lock },
+	{ 60, "dmac2_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 13, CLK_UNIT_NOC_SOCKET, 1, &leaf1_gate_lock },
+	{ 61, "dmac3_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 14, CLK_UNIT_NOC_SOCKET, 2, &leaf1_gate_lock },
+	{ 62, "audioif_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 15, CLK_UNIT_NOC_SOCKET, 0, &leaf1_gate_lock },
+	{ 63, "i2s1_kas", "audmscm_kas", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 17, CLK_UNIT_NOC_CLOCK, 2, &leaf1_gate_lock },
+	{ 64, "thaudmscm_io", "audmscm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 22, 0, 0, &leaf1_gate_lock },
+	{ 65, "analogtest_xin", "audmscm_xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN1_SET, 23, 0, 0, &leaf1_gate_lock },
+	{ 66, "sys2pci_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 0, CLK_UNIT_NOC_CLOCK, 20, &leaf2_gate_lock },
+	{ 67, "pciarb_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 1, 0, 0, &leaf2_gate_lock },
+	{ 68, "pcicopy_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 2, 0, 0, &leaf2_gate_lock },
+	{ 69, "rom_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 3, 0, 0, &leaf2_gate_lock },
+	{ 70, "sdio23_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 4, 0, 0, &leaf2_gate_lock },
+	{ 71, "sdio45_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 5, 0, 0, &leaf2_gate_lock },
+	{ 72, "sdio67_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 6, 0, 0, &leaf2_gate_lock },
+	{ 73, "vip1_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 7, 0, 0, &leaf2_gate_lock },
+	{ 74, "vip1_vip", "vdifm_vip", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 16, CLK_UNIT_NOC_CLOCK, 21, &leaf2_gate_lock },
+	{ 75, "sdio23_sdphy23", "vdifm_sdphy23", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 8, 0, 0, &leaf2_gate_lock },
+	{ 76, "sdio45_sdphy45", "vdifm_sdphy45", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 9, 0, 0, &leaf2_gate_lock },
+	{ 77, "sdio67_sdphy67", "vdifm_sdphy67", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 10, 0, 0, &leaf2_gate_lock },
+	{ 78, "vpp0_disp0", "vdifm_disp0", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 11, CLK_UNIT_NOC_CLOCK, 22, &leaf2_gate_lock },
+	{ 79, "lcd0_disp0", "vdifm_disp0", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 12, CLK_UNIT_NOC_CLOCK, 18, &leaf2_gate_lock },
+	{ 80, "vpp1_disp1", "vdifm_disp1", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 13, CLK_UNIT_NOC_CLOCK, 23, &leaf2_gate_lock },
+	{ 81, "lcd1_disp1", "vdifm_disp1", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 14, CLK_UNIT_NOC_CLOCK, 19, &leaf2_gate_lock },
+	{ 82, "dcu_deint", "vdifm_deint", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 15,  CLK_UNIT_NOC_CLOCK, 17, &leaf2_gate_lock },
+	{ 83, "vdifm_dapa_r_nocr", "vdifm_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 17, 0, 0, &leaf2_gate_lock },
+	{ 84, "gpio1_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 18, 0, 0, &leaf2_gate_lock },
+	{ 85, "thvdifm_io", "vdifm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN2_SET, 19, 0, 0, &leaf2_gate_lock },
+	{ 86, "gmac_rgmii", "gnssm_rgmii", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 0, 0, 0, &leaf3_gate_lock },
+	{ 87, "gmac_gmac", "gnssm_gmac", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 1, CLK_UNIT_NOC_CLOCK, 10, &leaf3_gate_lock },
+	{ 88, "uart1_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 2, CLK_UNIT_NOC_SOCKET, 14, &leaf3_gate_lock },
+	{ 89, "dmac0_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 3, CLK_UNIT_NOC_SOCKET, 11, &leaf3_gate_lock },
+	{ 90, "uart0_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 4, CLK_UNIT_NOC_SOCKET, 13, &leaf3_gate_lock },
+	{ 91, "uart2_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 5, CLK_UNIT_NOC_SOCKET, 15, &leaf3_gate_lock },
+	{ 92, "uart3_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 6, CLK_UNIT_NOC_SOCKET, 16, &leaf3_gate_lock },
+	{ 93, "uart4_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 7, CLK_UNIT_NOC_SOCKET, 17, &leaf3_gate_lock },
+	{ 94, "uart5_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 8, CLK_UNIT_NOC_SOCKET, 18, &leaf3_gate_lock },
+	{ 95, "spi1_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 9, CLK_UNIT_NOC_SOCKET, 12, &leaf3_gate_lock },
+	{ 96, "gnss_gnss", "gnssm_gnss", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 10, 0, 0, &leaf3_gate_lock },
+	{ 97, "canbus1_can", "gnssm_can", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 12, CLK_UNIT_NOC_CLOCK, 7, &leaf3_gate_lock },
+	{ 98, "ccsec_sec", "gnssm_sec", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 15, CLK_UNIT_NOC_CLOCK, 9, &leaf3_gate_lock },
+	{ 99,  "ccpub_sec", "gnssm_sec", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 16, CLK_UNIT_NOC_CLOCK, 8, &leaf3_gate_lock },
+	{ 100, "gnssm_dapa_r_nocr", "gnssm_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 13, 0, 0, &leaf3_gate_lock },
+	{ 101, "thgnssm_io", "gnssm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN3_SET, 14, 0, 0, &leaf3_gate_lock },
+	{ 102, "media_vdec", "mediam_vdec", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 0, CLK_UNIT_NOC_CLOCK, 3, &leaf4_gate_lock },
+	{ 103, "media_jpenc", "mediam_jpenc", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 1, CLK_UNIT_NOC_CLOCK, 1, &leaf4_gate_lock },
+	{ 104, "g2d_g2d", "mediam_g2d", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 2, CLK_UNIT_NOC_CLOCK, 12, &leaf4_gate_lock },
+	{ 105, "i2c0_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 3, CLK_UNIT_NOC_SOCKET, 21, &leaf4_gate_lock },
+	{ 106, "i2c1_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 4, CLK_UNIT_NOC_SOCKET, 20, &leaf4_gate_lock },
+	{ 107, "gpio0_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 5, CLK_UNIT_NOC_SOCKET, 19,  &leaf4_gate_lock },
+	{ 108, "nand_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 6, 0, 0, &leaf4_gate_lock },
+	{ 109, "sdio01_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 7, 0, 0, &leaf4_gate_lock },
+	{ 110, "sys2pci2_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 8, CLK_UNIT_NOC_CLOCK, 13, &leaf4_gate_lock },
+	{ 111, "sdio01_sdphy01", "mediam_sdphy01", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 9, 0, 0, &leaf4_gate_lock },
+	{ 112, "nand_nand", "mediam_nand", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 10, CLK_UNIT_NOC_CLOCK, 14, &leaf4_gate_lock },
+	{ 113, "usb0_usb", "mediam_usb", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 11, CLK_UNIT_NOC_CLOCK, 15, &leaf4_gate_lock },
+	{ 114, "usb1_usb", "mediam_usb", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 12,  CLK_UNIT_NOC_CLOCK, 16, &leaf4_gate_lock },
+	{ 115, "usbphy0_usbphy", "mediam_usbphy", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 13, 0, 0, &leaf4_gate_lock },
+	{ 116, "usbphy1_usbphy", "mediam_usbphy", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 14, 0, 0, &leaf4_gate_lock },
+	{ 117, "thmediam_io", "mediam_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN4_SET, 15, 0, 0, &leaf4_gate_lock },
+	{ 118, "memc_mem", "mempll_clk1", CLK_IGNORE_UNUSED, SIRFSOC_CLKC_LEAF_CLK_EN5_SET, 0, 0, 0, &leaf5_gate_lock },
+	{ 119, "dapa_mem", "mempll_clk1", 0, SIRFSOC_CLKC_LEAF_CLK_EN5_SET, 1, 0, 0, &leaf5_gate_lock },
+	{ 120, "nocddrm_nocr", "ddrm_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN5_SET, 2, 0, 0, &leaf5_gate_lock },
+	{ 121, "thddrm_nocr", "ddrm_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN5_SET, 3, 0, 0, &leaf5_gate_lock },
+	{ 122, "spram1_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 0, CLK_UNIT_NOC_SOCKET, 9, &leaf6_gate_lock },
+	{ 123, "spram2_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 1, CLK_UNIT_NOC_SOCKET, 10, &leaf6_gate_lock },
+	{ 124, "coresight_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 2, 0, 0, &leaf6_gate_lock },
+	{ 125, "coresight_tpiu", "cpum_tpiu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 3, 0, 0, &leaf6_gate_lock },
+	{ 126, "graphic_gpu", "gpum_gpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 0, CLK_UNIT_NOC_CLOCK, 0, &leaf7_gate_lock },
+	{ 127, "vss_sdr", "gpum_sdr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 1, CLK_UNIT_NOC_CLOCK, 11, &leaf7_gate_lock },
+	{ 128, "thgpum_nocr", "gpum_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 2, 0, 0, &leaf7_gate_lock },
+	{ 129, "a7ca_btss", "btm_btss", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 1, 0, 0, &leaf8_gate_lock },
+	{ 130, "dmac4_io", "a7ca_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 2, 0, 0, &leaf8_gate_lock },
+	{ 131, "uart6_io", "dmac4_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 3, 0, 0, &leaf8_gate_lock },
+	{ 132, "usp3_io", "dmac4_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 4, 0, 0, &leaf8_gate_lock },
+	{ 133, "a7ca_io", "noc_btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 5, 0, 0, &leaf8_gate_lock },
+	{ 134, "noc_btm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 6, 0, 0, &leaf8_gate_lock },
+	{ 135, "thbtm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 7, 0, 0, &leaf8_gate_lock },
+	{ 136, "btslow", "xinw_fixdiv_btslow", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 25, 0, 0, &root1_gate_lock },
+	{ 137, "a7ca_btslow", "btslow", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 0, 0, 0, &leaf8_gate_lock },
+	{ 138, "pwm_io", "io_mux", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 0, 0, 0, &leaf0_gate_lock },
+	{ 139, "pwm_xin", "xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 1, 0, 0, &leaf0_gate_lock },
+	{ 140, "pwm_xinw", "xinw", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 2, 0, 0, &leaf0_gate_lock },
+	{ 141, "thcgum_sys", "sys_mux", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 3, 0, 0, &leaf0_gate_lock },
 };
 
 static struct clk *atlas7_clks[ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list)];
@@ -1206,20 +1221,44 @@ static int unit_clk_enable(struct clk_hw *hw)
 
 	spin_lock_irqsave(clk->lock, flags);
 	clkc_writel(BIT(clk->bit), reg);
+	if (clk->type == CLK_UNIT_NOC_CLOCK)
+		clkc_writel(BIT(clk->idle_bit), SIRFSOC_NOC_CLK_IDLEREQ_CLR);
+	else if (clk->type == CLK_UNIT_NOC_SOCKET)
+		clkc_writel(BIT(clk->idle_bit), SIRFSOC_NOC_CLK_SLVRDY_SET);
+
 	spin_unlock_irqrestore(clk->lock, flags);
 	return 0;
 }
 
 static void unit_clk_disable(struct clk_hw *hw)
 {
-	u32  reg;
+	u32 reg;
+	u32 i = 0;
 	struct clk_unit *clk = to_unitclk(hw);
 	unsigned long flags;
 
 	reg = clk->regofs + SIRFSOC_CLKC_ROOT_CLK_EN0_CLR - SIRFSOC_CLKC_ROOT_CLK_EN0_SET;
-
 	spin_lock_irqsave(clk->lock, flags);
+	if (clk->type == CLK_UNIT_NOC_CLOCK) {
+		clkc_writel(BIT(clk->idle_bit), SIRFSOC_NOC_CLK_IDLEREQ_SET);
+		while (!(clkc_readl(SIRFSOC_NOC_CLK_IDLE_STATUS) &
+				BIT(clk->idle_bit)) && (i++ < 100)) {
+			cpu_relax();
+			udelay(10);
+		}
+
+		if (i == 100) {
+			pr_err("unit NoC Clock disconnect Error:timeout\n");
+			/*once timeout, undo idlereq by CLR*/
+			clkc_writel(BIT(clk->idle_bit), SIRFSOC_NOC_CLK_IDLEREQ_CLR);
+			goto err;
+		}
+
+	} else if (clk->type == CLK_UNIT_NOC_SOCKET)
+		clkc_writel(BIT(clk->idle_bit), SIRFSOC_NOC_CLK_SLVRDY_CLR);
+
 	clkc_writel(BIT(clk->bit), reg);
+err:
 	spin_unlock_irqrestore(clk->lock, flags);
 }
 
@@ -1232,7 +1271,7 @@ static const struct clk_ops unit_clk_ops = {
 static struct clk * __init
 atlas7_unit_clk_register(struct device *dev, const char *name,
 		 const char * const parent_name, unsigned long flags,
-		 u32 regofs, u8 bit, spinlock_t *lock)
+		 u32 regofs, u8 bit, u32 type, u8 idle_bit, spinlock_t *lock)
 {
 	struct clk *clk;
 	struct clk_unit *unit;
@@ -1251,6 +1290,9 @@ atlas7_unit_clk_register(struct device *dev, const char *name,
 	unit->hw.init = &init;
 	unit->regofs = regofs;
 	unit->bit = bit;
+
+	unit->type = type;
+	unit->idle_bit = idle_bit;
 	unit->lock = lock;
 
 	clk = clk_register(dev, &unit->hw);
@@ -1624,7 +1666,7 @@ static void __init atlas7_clk_init(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(unit_list); i++) {
 		unit = &unit_list[i];
 		atlas7_clks[i] = atlas7_unit_clk_register(NULL, unit->unit_name, unit->parent_name,
-				unit->flags, unit->regofs, unit->bit, unit->lock);
+				unit->flags, unit->regofs, unit->bit, unit->type, unit->idle_bit, unit->lock);
 		BUG_ON(!atlas7_clks[i]);
 	}
 
-- 
1.9.1
