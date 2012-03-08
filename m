From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:27 -0700
Subject: [PATCH 02/15] ARM: OMAP4: hwmod data: introduce fdif(face detect
 module) hwmod
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105125.14753.82086.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <ming.lei@canonical.com>

Add hwmod data for the OMAP4 FDIF IP block.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
Acked-by: Beno?t Cousson <b-cousson@ti.com>
[paul at pwsan.com: rearranged to match script output; fixed FDIF end address to
 match script data; wrote trivial changelog]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   70 ++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9180714..7f42431 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -262,7 +262,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  elm
  *  emif1
  *  emif2
- *  fdif
  *  gpmc
  *  gpu
  *  hdq1w
@@ -815,6 +814,47 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 };
 
 /*
+ * 'fdif' class
+ * face detection hw accelerator module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_fdif_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_fdif_hwmod_class = {
+	.name	= "fdif",
+	.sysc	= &omap44xx_fdif_sysc,
+};
+
+/* fdif */
+static struct omap_hwmod_irq_info omap44xx_fdif_irqs[] = {
+	{ .irq = 69 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap44xx_fdif_hwmod = {
+	.name		= "fdif",
+	.class		= &omap44xx_fdif_hwmod_class,
+	.clkdm_name	= "iss_clkdm",
+	.mpu_irqs	= omap44xx_fdif_irqs,
+	.main_clk	= "fdif_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_CAM_FDIF_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_CAM_FDIF_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'gpio' class
  * general purpose io module
  */
@@ -2948,6 +2988,14 @@ static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* fdif -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_fdif__l3_main_2 = {
+	.master		= &omap44xx_fdif_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* hsi -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_hsi__l3_main_2 = {
 	.master		= &omap44xx_hsi_hwmod,
@@ -3498,6 +3546,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] = {
+	{
+		.pa_start	= 0x4a10a000,
+		.pa_end		= 0x4a10a1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> fdif */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_fdif_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_fdif_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] = {
 	{
 		.pa_start	= 0x4a310000,
@@ -4655,6 +4721,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_mmc2__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_dma_system__l3_main_2,
+	&omap44xx_fdif__l3_main_2,
 	&omap44xx_hsi__l3_main_2,
 	&omap44xx_ipu__l3_main_2,
 	&omap44xx_iss__l3_main_2,
@@ -4696,6 +4763,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__dss_rfbi,
 	&omap44xx_l3_main_2__dss_venc,
 	&omap44xx_l4_per__dss_venc,
+	&omap44xx_l4_cfg__fdif,
 	&omap44xx_l4_wkup__gpio1,
 	&omap44xx_l4_per__gpio2,
 	&omap44xx_l4_per__gpio3,
