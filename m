From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:50 +0200
Subject: [PATCH 05/22] ARM: i.MX25 DT: use auxdata to attach
 imxfb_platform_data
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-6-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit is based on the following commit:
  ab2815c3997b179f043a747264d155ab0bc181ad ARM: mxs: use auxdata to attach mxsfb_platform_data

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/mach-imx/Kconfig    |    1 +
 arch/arm/mach-imx/imx25-dt.c |   75 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8f7109e..ed09a63 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -255,6 +255,7 @@ endchoice
 config MACH_IMX25_DT
 	bool "Support i.MX25 platforms from device tree"
 	select SOC_IMX25
+	select IMX_HAVE_PLATFORM_IMX_FB
 	help
 	  Include support for Freescale i.MX25 based platforms
 	  using the device tree for discovery
diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
index 3e1ec5f..dbfac49 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -12,16 +12,89 @@
 #include <linux/irq.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/video-imxfb.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include "common.h"
 #include "mx25.h"
 
+static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
+	 {
+		.mode   = {
+			.name		= "CMO-QVGA",
+			.refresh	= 60,
+			.xres		= 320,
+			.yres		= 240,
+			.pixclock	= KHZ2PICOS(6500),
+			.left_margin	= 30,
+			.right_margin	= 38,
+			.upper_margin	= 20,
+			.lower_margin	= 3,
+			.hsync_len	= 15,
+			.vsync_len	= 4,
+		},
+		.bpp	= 16,
+		.pcr	= 0xCAD08B80,
+	 }, {
+		.mode = {
+			.name		= "DVI-VGA",
+			.refresh	= 60,
+			.xres		= 640,
+			.yres		= 480,
+			.pixclock	= 32000,
+			.hsync_len	= 7,
+			.left_margin	= 100,
+			.right_margin	= 100,
+			.vsync_len	= 7,
+			.upper_margin	= 7,
+			.lower_margin	= 100,
+		},
+		.pcr	= 0xFA208B80,
+		.bpp	= 16,
+	 }, {
+		.mode = {
+			.name		= "DVI-SVGA",
+			.refresh	= 60,
+			.xres		= 800,
+			.yres		= 600,
+			.pixclock	= 25000,
+			.hsync_len	= 7,
+			.left_margin	= 75,
+			.right_margin	= 75,
+			.vsync_len	= 7,
+			.upper_margin	= 7,
+			.lower_margin	= 75,
+		},
+		.pcr	= 0xFA208B80,
+		.bpp	= 16,
+	 },
+};
+
+static struct imx_fb_platform_data imxfb_pdata __initdata;
+
+static struct of_dev_auxdata imx_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("fsl,imx21-lcdif", 0x53fbc000, "imx21-fb", &imxfb_pdata),
+	{ /* sentinel */ }
+};
+
+static void __init eukrea_mximxsd_init(void)
+{
+	imxfb_pdata.mode = eukrea_mximxsd_modes;
+	imxfb_pdata.num_modes = ARRAY_SIZE(eukrea_mximxsd_modes);
+	imxfb_pdata.pwmr	= 0x00A903FF;
+	imxfb_pdata.lscr1	= 0x00120300;
+	imxfb_pdata.dmacr	= 0x00040060;
+}
+
 static void __init imx25_dt_init(void)
 {
 	mxc_arch_reset_init_dt();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	if (of_machine_is_compatible("fsl,eukrea_cpuimx25"))
+		eukrea_mximxsd_init();
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+				imx_auxdata_lookup, NULL);
 }
 
 static const char * const imx25_dt_board_compat[] __initconst = {
-- 
1.7.9.5
