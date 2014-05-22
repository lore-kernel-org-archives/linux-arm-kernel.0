From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 May 2014 16:47:12 +0200
Subject: [PATCH v2] pinctrl: sunxi: Fix recursive dependency
Message-ID: <1400770032-8774-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following configuration error:
drivers/pinctrl/sunxi/Kconfig:3:error: recursive dependency detected!
drivers/pinctrl/sunxi/Kconfig:3:	symbol PINCTRL_SUNXI is selected by PINCTRL_SUN4I_A10
drivers/pinctrl/sunxi/Kconfig:9:	symbol PINCTRL_SUN4I_A10 default value contains PINCTRL_SUNXI

Add a new intermedia PINCTRL_SUNXI_COMMON, that superseeds the PINCTRL_SUNXI
one.

We still need to keep PINCTRL_SUNXI at the moment in order to preserve
bisectability. Indeed, during that merge window, we also introduced the
MACH_SUN* symbols. Since it's going through different trees, we can't rely on
the fact that the options will be there, while ARCH_SUNXI still select
PINCTRL_SUNXI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/sunxi/Kconfig  | 27 +++++++++++++++------------
 drivers/pinctrl/sunxi/Makefile |  2 +-
 2 files changed, 16 insertions(+), 13 deletions(-)

Changes from v1:
  - introduce PINCTRL_SUNXI_COMMON in order to ease the cleanup once everything
    will be merged.

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 2007327e0c48..da1e83035789 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -2,31 +2,34 @@ if ARCH_SUNXI
 
 config PINCTRL_SUNXI
 	bool
+
+config PINCTRL_SUNXI_COMMON
+	bool
 	select PINMUX
 	select GENERIC_PINCONF
 
 config PINCTRL_SUN4I_A10
-       def_bool PINCTRL_SUNXI || MACH_SUN4I
-       select PINCTRL_SUNXI
+	def_bool PINCTRL_SUNXI || MACH_SUN4I
+	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN5I_A10S
-       def_bool PINCTRL_SUNXI || MACH_SUN5I
-       select PINCTRL_SUNXI
+	def_bool PINCTRL_SUNXI || MACH_SUN5I
+	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN5I_A13
-       def_bool PINCTRL_SUNXI || MACH_SUN5I
-       select PINCTRL_SUNXI
+	def_bool PINCTRL_SUNXI || MACH_SUN5I
+	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN6I_A31
-       def_bool PINCTRL_SUNXI || MACH_SUN6I
-       select PINCTRL_SUNXI
+	def_bool PINCTRL_SUNXI || MACH_SUN6I
+	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN6I_A31_R
-       def_bool PINCTRL_SUNXI || MACH_SUN6I
-       select PINCTRL_SUNXI
+	def_bool PINCTRL_SUNXI || MACH_SUN6I
+	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN7I_A20
-       def_bool PINCTRL_SUNXI || MACH_SUN7I
-       select PINCTRL_SUNXI
+	def_bool PINCTRL_SUNXI || MACH_SUN7I
+	select PINCTRL_SUNXI_COMMON
 
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index 8e23a15e695d..0f4461cbe11d 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -1,5 +1,5 @@
 # Core
-obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sunxi.o
+obj-$(CONFIG_PINCTRL_SUNXI_COMMON)	+= pinctrl-sunxi.o
 
 # SoC Drivers
 obj-$(CONFIG_PINCTRL_SUN4I_A10)		+= pinctrl-sun4i-a10.o
-- 
1.9.3
