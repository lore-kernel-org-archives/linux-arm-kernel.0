From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:34 -0700
Subject: [PATCH 10/15] ARM: OMAP4: hwmod data: add remaining USB-related IP
 blocks
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105133.14753.73322.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beno?t Cousson <b-cousson@ti.com>

Add the OCP2SCP IP block and interconnect data.  The OCP2SCP can be
used in conjunction with the on-chip embedded USB PHY, associated with
the OTG controller.

Add the on-chip full-speed USB host controller IP block and
interconnect data.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  120 +++++++++++++++++++++++++++-
 1 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 8d3a7c1..968feb0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -281,15 +281,11 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  mpu_c0
  *  mpu_c1
  *  ocmc_ram
- *  ocp2scp_usb_phy
  *  ocp_wp_noc
  *  prcm_mpu
  *  prm
  *  scrm
- *  usb_host_fs
- *  usb_host_hs
  *  usb_phy_cm
- *  usb_tll_hs
  *  usim
  */
 
@@ -2360,6 +2356,36 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 };
 
 /*
+ * 'ocp2scp' class
+ * bridge to transform ocp interface protocol to scp (serial control port)
+ * protocol
+ */
+
+static struct omap_hwmod_class omap44xx_ocp2scp_hwmod_class = {
+	.name	= "ocp2scp",
+};
+
+/* ocp2scp_usb_phy */
+static struct omap_hwmod_opt_clk ocp2scp_usb_phy_opt_clks[] = {
+	{ .role = "phy_48m", .clk = "ocp2scp_usb_phy_phy_48m" },
+};
+
+static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
+	.name		= "ocp2scp_usb_phy",
+	.class		= &omap44xx_ocp2scp_hwmod_class,
+	.clkdm_name	= "l3_init_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INIT_USBPHYOCP2SCP_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+	.opt_clks	= ocp2scp_usb_phy_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
+};
+
+/*
  * 'sl2if' class
  * shared level 2 memory interface
  */
@@ -3042,6 +3068,55 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 };
 
 /*
+ * 'usb_host_fs' class
+ * full-speed usb host controller
+ */
+
+/* The IP is not compliant to type1 / type2 scheme */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs = {
+	.midle_shift	= 4,
+	.sidle_shift	= 2,
+	.srst_shift	= 1,
+};
+
+static struct omap_hwmod_class_sysconfig omap44xx_usb_host_fs_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0210,
+	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type_usb_host_fs,
+};
+
+static struct omap_hwmod_class omap44xx_usb_host_fs_hwmod_class = {
+	.name	= "usb_host_fs",
+	.sysc	= &omap44xx_usb_host_fs_sysc,
+};
+
+/* usb_host_fs */
+static struct omap_hwmod_irq_info omap44xx_usb_host_fs_irqs[] = {
+	{ .name = "std", .irq = 89 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "smi", .irq = 90 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap44xx_usb_host_fs_hwmod = {
+	.name		= "usb_host_fs",
+	.class		= &omap44xx_usb_host_fs_hwmod_class,
+	.clkdm_name	= "l3_init_clkdm",
+	.mpu_irqs	= omap44xx_usb_host_fs_irqs,
+	.main_clk	= "usb_host_fs_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3INIT_USB_HOST_FS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INIT_USB_HOST_FS_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'usb_host_hs' class
  * high-speed multi-port usb host controller
  */
@@ -3554,6 +3629,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* usb_host_fs -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_usb_host_fs__l3_main_2 = {
+	.master		= &omap44xx_usb_host_fs_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* usb_host_hs -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 = {
 	.master		= &omap44xx_usb_host_hs_hwmod,
@@ -4840,6 +4923,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_cfg -> ocp2scp_usb_phy */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp2scp_usb_phy = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_ocp2scp_usb_phy_hwmod,
+	.clk		= "l4_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_2 -> sl2if */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if = {
 	.master		= &omap44xx_l3_main_2_hwmod,
@@ -5316,6 +5407,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__uart4 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_usb_host_fs_addrs[] = {
+	{
+		.pa_start	= 0x4a0a9000,
+		.pa_end		= 0x4a0a93ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> usb_host_fs */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_fs = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_usb_host_fs_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_usb_host_fs_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] = {
 	{
 		.name		= "uhh",
@@ -5463,6 +5572,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_iva__l3_main_2,
 	&omap44xx_l3_main_1__l3_main_2,
 	&omap44xx_l4_cfg__l3_main_2,
+	&omap44xx_usb_host_fs__l3_main_2,
 	&omap44xx_usb_host_hs__l3_main_2,
 	&omap44xx_usb_otg_hs__l3_main_2,
 	&omap44xx_l3_main_1__l3_main_3,
@@ -5544,6 +5654,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l4_cfg__ocp2scp_usb_phy,
 	&omap44xx_l3_main_2__sl2if,
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,
@@ -5571,6 +5682,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__uart2,
 	&omap44xx_l4_per__uart3,
 	&omap44xx_l4_per__uart4,
+	&omap44xx_l4_cfg__usb_host_fs,
 	&omap44xx_l4_cfg__usb_host_hs,
 	&omap44xx_l4_cfg__usb_otg_hs,
 	&omap44xx_l4_cfg__usb_tll_hs,
