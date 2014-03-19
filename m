From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:25 +0100
Subject: [PATCH 28/62] ARM: pxa: FB_W100 must be built-in
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-29-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa platform code directly calls into the W100 framebuffer
driver for eseries. This means it cannot be a loadable module
and we also have to ensure that the core framebuffer code
is built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/Kconfig | 1 +
 drivers/video/Kconfig     | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 96100db..562b17f 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -556,6 +556,7 @@ config MACH_ICONTROL
 config ARCH_PXA_ESERIES
 	bool "PXA based Toshiba e-series PDAs"
 	select FB_W100
+	select FB
 	select PXA25x
 
 config MACH_E330
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index dade5b7..86873ff 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1996,8 +1996,8 @@ config FB_FSL_DIU
 	  Framebuffer driver for the Freescale SoC DIU
 
 config FB_W100
-	tristate "W100 frame buffer support"
-	depends on FB && ARCH_PXA
+	bool "W100 frame buffer support"
+	depends on FB=y && ARCH_PXA
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-- 
1.8.3.2
