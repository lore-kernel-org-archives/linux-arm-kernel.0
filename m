From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:31 -0700
Subject: [PATCH 06/15] ARM: OMAP4: hwmod data: add GPU
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105130.14753.7993.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the GPU hwmod and associated interconnect data.  The GPU is a
graphics accelerator.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   70 ++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 812c990..adacc09 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -260,7 +260,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
- *  gpu
  *  mcasp
  *  mpu_c0
  *  mpu_c1
@@ -1158,6 +1157,47 @@ static struct omap_hwmod omap44xx_gpmc_hwmod = {
 };
 
 /*
+ * 'gpu' class
+ * 2d/3d graphics accelerator
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_gpu_sysc = {
+	.rev_offs	= 0x1fc00,
+	.sysc_offs	= 0x1fc10,
+	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_gpu_hwmod_class = {
+	.name	= "gpu",
+	.sysc	= &omap44xx_gpu_sysc,
+};
+
+/* gpu */
+static struct omap_hwmod_irq_info omap44xx_gpu_irqs[] = {
+	{ .irq = 21 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap44xx_gpu_hwmod = {
+	.name		= "gpu",
+	.class		= &omap44xx_gpu_hwmod_class,
+	.clkdm_name	= "l3_gfx_clkdm",
+	.mpu_irqs	= omap44xx_gpu_irqs,
+	.main_clk	= "gpu_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_GFX_GFX_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_GFX_GFX_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'hdq1w' class
  * hdq / 1-wire serial interface controller
  */
@@ -3138,6 +3178,14 @@ static struct omap_hwmod_ocp_if omap44xx_fdif__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* gpu -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_gpu__l3_main_2 = {
+	.master		= &omap44xx_gpu_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* hsi -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_hsi__l3_main_2 = {
 	.master		= &omap44xx_hsi_hwmod,
@@ -3868,6 +3916,24 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpmc = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_gpu_addrs[] = {
+	{
+		.pa_start	= 0x56000000,
+		.pa_end		= 0x5600ffff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l3_main_2 -> gpu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpu = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_gpu_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_gpu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] = {
 	{
 		.pa_start	= 0x480b2000,
@@ -4936,6 +5002,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_fdif__l3_main_2,
+	&omap44xx_gpu__l3_main_2,
 	&omap44xx_hsi__l3_main_2,
 	&omap44xx_ipu__l3_main_2,
 	&omap44xx_iss__l3_main_2,
@@ -4987,6 +5054,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__gpio5,
 	&omap44xx_l4_per__gpio6,
 	&omap44xx_l3_main_2__gpmc,
+	&omap44xx_l3_main_2__gpu,
 	&omap44xx_l4_per__hdq1w,
 	&omap44xx_l4_cfg__hsi,
 	&omap44xx_l4_per__i2c1,
