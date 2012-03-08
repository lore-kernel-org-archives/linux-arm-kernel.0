From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:37 -0700
Subject: [PATCH 15/15] ARM: OMAP4: hwmod data: add DEBUGSS skeleton
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105137.14753.19864.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beno?t Cousson <b-cousson@ti.com>

Add a skeleton hwmod for the DEBUGSS and associated interconnect data.
This is a basic set of data that will need further additions as
further DEBUGSS information becomes available.

Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   59 +++++++++++++++++++++++++---
 1 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index a01d91f..2044c80 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -291,13 +291,7 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod = {
  * - They still need to be validated with the driver
  *   properly adapted to omap_hwmod / omap_device
  *
- *  debugss
- *  efuse_ctrl_cust
- *  efuse_ctrl_std
- *  mpu_c0
- *  mpu_c1
- *  usb_phy_cm
- *  usim
+ * usim
  */
 
 /*
@@ -478,6 +472,29 @@ static struct omap_hwmod omap44xx_ctrl_module_pad_wkup_hwmod = {
 };
 
 /*
+ * 'debugss' class
+ * debug and emulation sub system
+ */
+
+static struct omap_hwmod_class omap44xx_debugss_hwmod_class = {
+	.name	= "debugss",
+};
+
+/* debugss */
+static struct omap_hwmod omap44xx_debugss_hwmod = {
+	.name		= "debugss",
+	.class		= &omap44xx_debugss_hwmod_class,
+	.clkdm_name	= "emu_sys_clkdm",
+	.main_clk	= "trace_clk_div_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_EMU_DEBUGSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_EMU_DEBUGSS_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'dma' class
  * dma controller for data exchange between memory to memory (i.e. internal or
  * external memory) and gp peripherals to memory or memory to gp peripherals
@@ -3709,6 +3726,14 @@ static struct omap_hwmod_ocp_if omap44xx_c2c_target_fw__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* debugss -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_debugss__l3_main_2 = {
+	.master		= &omap44xx_debugss_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "dbgclk_mux_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dma_system -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
 	.master		= &omap44xx_dma_system_hwmod,
@@ -4065,6 +4090,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_pad_wkup = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] = {
+	{
+		.pa_start	= 0x54160000,
+		.pa_end		= 0x54167fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l3_instr -> debugss */
+static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss = {
+	.master		= &omap44xx_l3_instr_hwmod,
+	.slave		= &omap44xx_debugss_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_debugss_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x4a056000,
@@ -5914,6 +5957,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_mmc2__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_c2c_target_fw__l3_main_2,
+	&omap44xx_debugss__l3_main_2,
 	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_fdif__l3_main_2,
 	&omap44xx_gpu__l3_main_2,
@@ -5946,6 +5990,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_cfg__ctrl_module_pad_core,
 	&omap44xx_l4_wkup__ctrl_module_wkup,
 	&omap44xx_l4_wkup__ctrl_module_pad_wkup,
+	&omap44xx_l3_instr__debugss,
 	&omap44xx_l4_cfg__dma_system,
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_l4_abe__dmic_dma,
