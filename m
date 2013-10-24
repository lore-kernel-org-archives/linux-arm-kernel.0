From: denis@eukrea.com (Denis Carikli)
Date: Thu, 24 Oct 2013 10:01:01 +0200
Subject: [PATCHv6][ 3/7] ARM: imx{25,
 27} DT: Permit the selection of the imxfb framebuffer driver.
In-Reply-To: <1382601665-6830-1-git-send-email-denis@eukrea.com>
References: <1382601665-6830-1-git-send-email-denis@eukrea.com>
Message-ID: <1382601665-6830-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without that patch, a user can't select the imxfb driver when the i.MX25 and/or
  the i.MX27 device tree board are selected and that no boards that selects
  IMX_HAVE_PLATFORM_IMX_FB are compiled in.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Eric B?nard <eric@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
- Reworked the patch not to make DT boards depend on IMX_HAVE_PLATFORM_IMX_FB. 
- Added better explanations of why that patch is needed in the commit message.
---
 arch/arm/mach-imx/Kconfig         |    5 +++++
 arch/arm/mach-imx/devices/Kconfig |    1 +
 drivers/video/Kconfig             |    2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 9f67338..3ccb5d5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -64,6 +64,9 @@ config ARCH_HAS_RNGA
 config HAVE_IMX_ANATOP
 	bool
 
+config HAVE_IMX_FB
+       bool
+
 config HAVE_IMX_GPC
 	bool
 
@@ -254,6 +257,7 @@ endchoice
 config MACH_IMX25_DT
 	bool "Support i.MX25 platforms from device tree"
 	select SOC_IMX25
+	select HAVE_IMX_FB
 	help
 	  Include support for Freescale i.MX25 based platforms
 	  using the device tree for discovery
@@ -442,6 +446,7 @@ config MACH_IMX27IPCAM
 config MACH_IMX27_DT
 	bool "Support i.MX27 platforms from device tree"
 	select SOC_IMX27
+	select HAVE_IMX_FB
 	help
 	  Include support for Freescale i.MX27 based platforms
 	  using the device tree for discovery
diff --git a/arch/arm/mach-imx/devices/Kconfig b/arch/arm/mach-imx/devices/Kconfig
index 68c74fb..a7af9f4 100644
--- a/arch/arm/mach-imx/devices/Kconfig
+++ b/arch/arm/mach-imx/devices/Kconfig
@@ -26,6 +26,7 @@ config IMX_HAVE_PLATFORM_IMXDI_RTC
 	bool
 
 config IMX_HAVE_PLATFORM_IMX_FB
+	select HAVE_IMX_FB
 	bool
 
 config IMX_HAVE_PLATFORM_IMX_I2C
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 14317b7..a97529f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -363,7 +363,7 @@ config FB_SA1100
 
 config FB_IMX
 	tristate "Freescale i.MX1/21/25/27 LCD support"
-	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
+	depends on FB && HAVE_IMX_FB
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.7.9.5
