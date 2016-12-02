From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:43 +0000
Subject: [RFC v3 PATCH 25/25] ARM: Allow ARCH_MULTIPLATFORM to be selected for
 NOMMU
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-26-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch applied potentially any platform can be built in NOMMU
configurations if CONFIG_EXPERT is selected. However, there is no
guarantee that platform can successfully run such Image. So the main
motivation behind of this patch:
- bring build coverage for NOMMU configurations
- allow known working NOMMU platforms (like R-class) to be used
- pave a way to add support for single address space (aka 1:1 mapping)
  for MMU platforms, so they can be usable in NOMMU configurations

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b3fa6e9..9c90b81 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -327,9 +327,9 @@ choice
 
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
-	depends on MMU
+	depends on MMU || EXPERT
 	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if MMU
 	select AUTO_ZRELADDR
 	select CLKSRC_OF
 	select COMMON_CLK
@@ -339,6 +339,23 @@ config ARCH_MULTIPLATFORM
 	select PCI_DOMAINS if PCI
 	select SPARSE_IRQ
 	select USE_OF
+	help
+	  Please, read carefully if you've selected CONFIG_MMU=n!
+
+	  Multiplatform with !MMU configuration *is not* meant that
+	  kernel built to support every platform will boot on them. It
+	  is because physical address space layouts (particularly where
+	  RAM is located) are different between platforms and there is
+	  no MMU to work that around.
+
+	  You must specify where RAM start (via DRAM_BASE config
+	  option) and appropriate size of RAM (via DRAM_SIZE config
+	  option) which are valid for the platform you are building
+	  for.
+
+	  This feature is *EXPERIMENTAL*, please, consider building
+	  with CONFIG_MMU=y unless you know what you do or want to
+	  help with testing.
 
 config ARM_SINGLE_ARMV7M
 	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
-- 
1.7.9.5
