From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:30 -0700
Subject: [PATCH 05/15] ARM: OMAP4: hwmod data: add EMIF1 and 2
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105129.14753.7319.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the EMIF1 and 2 hwmods and associated interconnect data.  The EMIFs
are SDRAM interface IP blocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   98 +++++++++++++++++++++++++++-
 1 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6a7e26e..812c990 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -260,8 +260,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
- *  emif1
- *  emif2
  *  gpu
  *  mcasp
  *  mpu_c0
@@ -812,6 +810,64 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 };
 
 /*
+ * 'emif' class
+ * external memory interface no1
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_emif_sysc = {
+	.rev_offs	= 0x0000,
+};
+
+static struct omap_hwmod_class omap44xx_emif_hwmod_class = {
+	.name	= "emif",
+	.sysc	= &omap44xx_emif_sysc,
+};
+
+/* emif1 */
+static struct omap_hwmod_irq_info omap44xx_emif1_irqs[] = {
+	{ .irq = 110 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap44xx_emif1_hwmod = {
+	.name		= "emif1",
+	.class		= &omap44xx_emif_hwmod_class,
+	.clkdm_name	= "l3_emif_clkdm",
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.mpu_irqs	= omap44xx_emif1_irqs,
+	.main_clk	= "ddrphy_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_MEMIF_EMIF_1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/* emif2 */
+static struct omap_hwmod_irq_info omap44xx_emif2_irqs[] = {
+	{ .irq = 111 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap44xx_emif2_hwmod = {
+	.name		= "emif2",
+	.class		= &omap44xx_emif_hwmod_class,
+	.clkdm_name	= "l3_emif_clkdm",
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.mpu_irqs	= omap44xx_emif2_irqs,
+	.main_clk	= "ddrphy_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_MEMIF_EMIF_2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'fdif' class
  * face detection hw accelerator module
  */
@@ -3632,6 +3688,42 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_addr_space omap44xx_emif1_addrs[] = {
+	{
+		.pa_start	= 0x4c000000,
+		.pa_end		= 0x4c0000ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* emif_fw -> emif1 */
+static struct omap_hwmod_ocp_if omap44xx_emif_fw__emif1 = {
+	.master		= &omap44xx_emif_fw_hwmod,
+	.slave		= &omap44xx_emif1_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_emif1_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_emif2_addrs[] = {
+	{
+		.pa_start	= 0x4d000000,
+		.pa_end		= 0x4d0000ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* emif_fw -> emif2 */
+static struct omap_hwmod_ocp_if omap44xx_emif_fw__emif2 = {
+	.master		= &omap44xx_emif_fw_hwmod,
+	.slave		= &omap44xx_emif2_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_emif2_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] = {
 	{
 		.pa_start	= 0x4a10a000,
@@ -4885,6 +4977,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__dss_rfbi,
 	&omap44xx_l3_main_2__dss_venc,
 	&omap44xx_l4_per__dss_venc,
+	&omap44xx_emif_fw__emif1,
+	&omap44xx_emif_fw__emif2,
 	&omap44xx_l4_cfg__fdif,
 	&omap44xx_l4_wkup__gpio1,
 	&omap44xx_l4_per__gpio2,
