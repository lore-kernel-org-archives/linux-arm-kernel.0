From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:35 -0700
Subject: [PATCH 12/15] ARM: OMAP4: hwmod data: add the OCP-WP IP block
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105135.14753.5020.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beno?t Cousson <b-cousson@ti.com>

Add the OCP-WP hwmod and associated interconnect data.  The OCP-WP,
or OCP watchpoint, can be used to collect interconnect data and
transmit it via the STM port.

Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   51 +++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f48fe77..5c89307 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -262,6 +262,28 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
 };
 
 /*
+ * 'ocp_wp_noc' class
+ * instance(s): ocp_wp_noc
+ */
+static struct omap_hwmod_class omap44xx_ocp_wp_noc_hwmod_class = {
+	.name	= "ocp_wp_noc",
+};
+
+/* ocp_wp_noc */
+static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod = {
+	.name		= "ocp_wp_noc",
+	.class		= &omap44xx_ocp_wp_noc_hwmod_class,
+	.clkdm_name	= "l3_instr_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3INSTR_OCP_WP1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INSTR_OCP_WP1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * Modules omap_hwmod structures
  *
  * The following IPs are excluded for the moment because:
@@ -280,7 +302,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  efuse_ctrl_std
  *  mpu_c0
  *  mpu_c1
- *  ocp_wp_noc
  *  prcm_mpu
  *  prm
  *  scrm
@@ -3494,6 +3515,14 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_3__l3_instr = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* ocp_wp_noc -> l3_instr */
+static struct omap_hwmod_ocp_if omap44xx_ocp_wp_noc__l3_instr = {
+	.master		= &omap44xx_ocp_wp_noc_hwmod,
+	.slave		= &omap44xx_l3_instr_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dsp -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_dsp__l3_main_1 = {
 	.master		= &omap44xx_dsp_hwmod,
@@ -3772,6 +3801,24 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__mpu_private = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_ocp_wp_noc_addrs[] = {
+	{
+		.pa_start	= 0x4a102000,
+		.pa_end		= 0x4a10207f,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> ocp_wp_noc */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_ocp_wp_noc_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_ocp_wp_noc_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
 	{
 		.pa_start	= 0x401f1000,
@@ -5584,6 +5631,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_cfg__emif_fw,
 	&omap44xx_iva__l3_instr,
 	&omap44xx_l3_main_3__l3_instr,
+	&omap44xx_ocp_wp_noc__l3_instr,
 	&omap44xx_dsp__l3_main_1,
 	&omap44xx_dss__l3_main_1,
 	&omap44xx_l3_main_2__l3_main_1,
@@ -5615,6 +5663,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l3_main_2__l4_per,
 	&omap44xx_l4_cfg__l4_wkup,
 	&omap44xx_mpu__mpu_private,
+	&omap44xx_l4_cfg__ocp_wp_noc,
 	&omap44xx_l4_abe__aess,
 	&omap44xx_l4_abe__aess_dma,
 	&omap44xx_l3_main_2__c2c,
