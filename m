From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:35 -0700
Subject: [PATCH 11/15] ARM: OMAP4: hwmod data: add OCM RAM IP block
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105134.14753.63101.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the OCM RAM IP block and interconnect data.  This is an oh-chip
block of SRAM connected directly to the L3 bus.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   32 +++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 968feb0..f48fe77 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -280,7 +280,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  efuse_ctrl_std
  *  mpu_c0
  *  mpu_c1
- *  ocmc_ram
  *  ocp_wp_noc
  *  prcm_mpu
  *  prm
@@ -2356,6 +2355,28 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 };
 
 /*
+ * 'ocmc_ram' class
+ * top-level core on-chip ram
+ */
+
+static struct omap_hwmod_class omap44xx_ocmc_ram_hwmod_class = {
+	.name	= "ocmc_ram",
+};
+
+/* ocmc_ram */
+static struct omap_hwmod omap44xx_ocmc_ram_hwmod = {
+	.name		= "ocmc_ram",
+	.class		= &omap44xx_ocmc_ram_hwmod_class,
+	.clkdm_name	= "l3_2_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3_2_OCMC_RAM_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3_2_OCMC_RAM_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'ocp2scp' class
  * bridge to transform ocp interface protocol to scp (serial control port)
  * protocol
@@ -4923,6 +4944,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_2 -> ocmc_ram */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ocmc_ram = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_ocmc_ram_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_cfg -> ocp2scp_usb_phy */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp2scp_usb_phy = {
 	.master		= &omap44xx_l4_cfg_hwmod,
@@ -5654,6 +5683,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l3_main_2__ocmc_ram,
 	&omap44xx_l4_cfg__ocp2scp_usb_phy,
 	&omap44xx_l3_main_2__sl2if,
 	&omap44xx_l4_abe__slimbus1,
