From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:36 -0700
Subject: [PATCH 13/15] ARM: OMAP4: hwmod data: add System Control Module
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105135.14753.35011.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the System Control Module hwmod and associated interconnect data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  134 +++++++++++++++++++++++++++-
 1 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5c89307..ccc1249 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -293,10 +293,6 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod = {
  *
  *  cm_core
  *  cm_core_aon
- *  ctrl_module_core
- *  ctrl_module_pad_core
- *  ctrl_module_pad_wkup
- *  ctrl_module_wkup
  *  debugss
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
@@ -433,6 +429,60 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 };
 
 /*
+ * 'ctrl_module' class
+ * attila core control module + core pad control module + wkup pad control
+ * module + attila wkup control module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_ctrl_module_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_ctrl_module_hwmod_class = {
+	.name	= "ctrl_module",
+	.sysc	= &omap44xx_ctrl_module_sysc,
+};
+
+/* ctrl_module_core */
+static struct omap_hwmod_irq_info omap44xx_ctrl_module_core_irqs[] = {
+	{ .irq = 8 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap44xx_ctrl_module_core_hwmod = {
+	.name		= "ctrl_module_core",
+	.class		= &omap44xx_ctrl_module_hwmod_class,
+	.clkdm_name	= "l4_cfg_clkdm",
+	.mpu_irqs	= omap44xx_ctrl_module_core_irqs,
+};
+
+/* ctrl_module_pad_core */
+static struct omap_hwmod omap44xx_ctrl_module_pad_core_hwmod = {
+	.name		= "ctrl_module_pad_core",
+	.class		= &omap44xx_ctrl_module_hwmod_class,
+	.clkdm_name	= "l4_cfg_clkdm",
+};
+
+/* ctrl_module_wkup */
+static struct omap_hwmod omap44xx_ctrl_module_wkup_hwmod = {
+	.name		= "ctrl_module_wkup",
+	.class		= &omap44xx_ctrl_module_hwmod_class,
+	.clkdm_name	= "l4_wkup_clkdm",
+};
+
+/* ctrl_module_pad_wkup */
+static struct omap_hwmod omap44xx_ctrl_module_pad_wkup_hwmod = {
+	.name		= "ctrl_module_pad_wkup",
+	.class		= &omap44xx_ctrl_module_hwmod_class,
+	.clkdm_name	= "l4_wkup_clkdm",
+};
+
+/*
  * 'dma' class
  * dma controller for data exchange between memory to memory (i.e. internal or
  * external memory) and gp peripherals to memory or memory to gp peripherals
@@ -3881,6 +3931,78 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup__counter_32k = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_core_addrs[] = {
+	{
+		.pa_start	= 0x4a002000,
+		.pa_end		= 0x4a0027ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> ctrl_module_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_core = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_ctrl_module_core_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_ctrl_module_core_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_core_addrs[] = {
+	{
+		.pa_start	= 0x4a100000,
+		.pa_end		= 0x4a1007ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> ctrl_module_pad_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_pad_core = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_ctrl_module_pad_core_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_ctrl_module_pad_core_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_wkup_addrs[] = {
+	{
+		.pa_start	= 0x4a30c000,
+		.pa_end		= 0x4a30c7ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> ctrl_module_wkup */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_wkup = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_ctrl_module_wkup_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_ctrl_module_wkup_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_wkup_addrs[] = {
+	{
+		.pa_start	= 0x4a31e000,
+		.pa_end		= 0x4a31e7ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> ctrl_module_pad_wkup */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_pad_wkup = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_ctrl_module_pad_wkup_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_ctrl_module_pad_wkup_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x4a056000,
@@ -5668,6 +5790,10 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_abe__aess_dma,
 	&omap44xx_l3_main_2__c2c,
 	&omap44xx_l4_wkup__counter_32k,
+	&omap44xx_l4_cfg__ctrl_module_core,
+	&omap44xx_l4_cfg__ctrl_module_pad_core,
+	&omap44xx_l4_wkup__ctrl_module_wkup,
+	&omap44xx_l4_wkup__ctrl_module_pad_wkup,
 	&omap44xx_l4_cfg__dma_system,
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_l4_abe__dmic_dma,
