From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:37 -0700
Subject: [PATCH 14/15] ARM: OMAP4: hwmod data: add PRCM and related IP blocks
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105136.14753.4296.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PRCM, CM, PRM, and related hwmod and associated interconnect
data.  These IP blocks handle most of the on-chip power, reset, and clock
control.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  167 +++++++++++++++++++++++++++-
 1 files changed, 162 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ccc1249..a01d91f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -291,16 +291,11 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod = {
  * - They still need to be validated with the driver
  *   properly adapted to omap_hwmod / omap_device
  *
- *  cm_core
- *  cm_core_aon
  *  debugss
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  mpu_c0
  *  mpu_c1
- *  prcm_mpu
- *  prm
- *  scrm
  *  usb_phy_cm
  *  usim
  */
@@ -2478,6 +2473,73 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 };
 
 /*
+ * 'prcm' class
+ * power and reset manager (part of the prcm infrastructure) + clock manager 2
+ * + clock manager 1 (in always on power domain) + local prm in mpu
+ */
+
+static struct omap_hwmod_class omap44xx_prcm_hwmod_class = {
+	.name	= "prcm",
+};
+
+/* prcm_mpu */
+static struct omap_hwmod omap44xx_prcm_mpu_hwmod = {
+	.name		= "prcm_mpu",
+	.class		= &omap44xx_prcm_hwmod_class,
+	.clkdm_name	= "l4_wkup_clkdm",
+};
+
+/* cm_core_aon */
+static struct omap_hwmod omap44xx_cm_core_aon_hwmod = {
+	.name		= "cm_core_aon",
+	.class		= &omap44xx_prcm_hwmod_class,
+	.clkdm_name	= "cm_clkdm",
+};
+
+/* cm_core */
+static struct omap_hwmod omap44xx_cm_core_hwmod = {
+	.name		= "cm_core",
+	.class		= &omap44xx_prcm_hwmod_class,
+	.clkdm_name	= "cm_clkdm",
+};
+
+/* prm */
+static struct omap_hwmod_irq_info omap44xx_prm_irqs[] = {
+	{ .irq = 11 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_rst_info omap44xx_prm_resets[] = {
+	{ .name = "rst_global_warm_sw", .rst_shift = 0 },
+	{ .name = "rst_global_cold_sw", .rst_shift = 1 },
+};
+
+static struct omap_hwmod omap44xx_prm_hwmod = {
+	.name		= "prm",
+	.class		= &omap44xx_prcm_hwmod_class,
+	.clkdm_name	= "prm_clkdm",
+	.mpu_irqs	= omap44xx_prm_irqs,
+	.rst_lines	= omap44xx_prm_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
+};
+
+/*
+ * 'scrm' class
+ * system clock and reset manager
+ */
+
+static struct omap_hwmod_class omap44xx_scrm_hwmod_class = {
+	.name	= "scrm",
+};
+
+/* scrm */
+static struct omap_hwmod omap44xx_scrm_hwmod = {
+	.name		= "scrm",
+	.class		= &omap44xx_scrm_hwmod_class,
+	.clkdm_name	= "l4_wkup_clkdm",
+};
+
+/*
  * 'sl2if' class
  * shared level 2 memory interface
  */
@@ -5129,6 +5191,96 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp2scp_usb_phy = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_prcm_mpu_addrs[] = {
+	{
+		.pa_start	= 0x48243000,
+		.pa_end		= 0x48243fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* mpu_private -> prcm_mpu */
+static struct omap_hwmod_ocp_if omap44xx_mpu_private__prcm_mpu = {
+	.master		= &omap44xx_mpu_private_hwmod,
+	.slave		= &omap44xx_prcm_mpu_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_prcm_mpu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_cm_core_aon_addrs[] = {
+	{
+		.pa_start	= 0x4a004000,
+		.pa_end		= 0x4a004fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> cm_core_aon */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__cm_core_aon = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_cm_core_aon_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_cm_core_aon_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_cm_core_addrs[] = {
+	{
+		.pa_start	= 0x4a008000,
+		.pa_end		= 0x4a009fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> cm_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__cm_core = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_cm_core_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_cm_core_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_prm_addrs[] = {
+	{
+		.pa_start	= 0x4a306000,
+		.pa_end		= 0x4a307fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> prm */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__prm = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_prm_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_prm_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_scrm_addrs[] = {
+	{
+		.pa_start	= 0x4a30a000,
+		.pa_end		= 0x4a30a7ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> scrm */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__scrm = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_scrm_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_scrm_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_2 -> sl2if */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if = {
 	.master		= &omap44xx_l3_main_2_hwmod,
@@ -5860,6 +6012,11 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__mmc5,
 	&omap44xx_l3_main_2__ocmc_ram,
 	&omap44xx_l4_cfg__ocp2scp_usb_phy,
+	&omap44xx_mpu_private__prcm_mpu,
+	&omap44xx_l4_wkup__cm_core_aon,
+	&omap44xx_l4_cfg__cm_core,
+	&omap44xx_l4_wkup__prm,
+	&omap44xx_l4_wkup__scrm,
 	&omap44xx_l3_main_2__sl2if,
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,
