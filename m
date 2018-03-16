From: david@lechnology.com (David Lechner)
Date: Thu, 15 Mar 2018 21:52:45 -0500
Subject: [PATCH v8 29/42] ARM: davinci: remove CONFIG_DAVINCI_RESET_CLOCKS
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
Message-ID: <1521168778-27236-30-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clock framework will take care of disabling unused clocks when
we switch from the legacy davinci clocks and having this enabled will
cause compile errors after we switch, so remove it now.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v8 changes:
- none

v7 changes:
- none

v6 changes:
- none

 arch/arm/mach-davinci/Kconfig               | 12 ------------
 arch/arm/mach-davinci/common.c              |  1 -
 arch/arm/mach-davinci/include/mach/common.h |  6 ------
 3 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 05c3eecf..ba9912b 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -231,18 +231,6 @@ config DAVINCI_MUX_WARNINGS
 	  to change the pin multiplexing setup. When there are no warnings
 	  printed, it's safe to deselect DAVINCI_MUX for your product.
 
-config DAVINCI_RESET_CLOCKS
-	bool "Reset unused clocks during boot"
-	depends on ARCH_DAVINCI
-	help
-	  Say Y if you want to reset unused clocks during boot.
-	  This option saves power, but assumes all drivers are
-	  using the clock framework. Broken drivers that do not
-	  yet use clock framework may not work with this option.
-	  If you are booting from another operating system, you
-	  probably do not want this option enabled until your
-	  device drivers work properly.
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index bcb6a7b..e03f95c 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -118,5 +118,4 @@ void __init davinci_common_init(const struct davinci_soc_info *soc_info)
 void __init davinci_init_late(void)
 {
 	davinci_cpufreq_init();
-	davinci_clk_disable_unused();
 }
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 5f45d0a..ded8f5f 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -83,12 +83,6 @@ extern void davinci_common_init(const struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
 void davinci_init_late(void);
 
-#ifdef CONFIG_DAVINCI_RESET_CLOCKS
-int davinci_clk_disable_unused(void);
-#else
-static inline int davinci_clk_disable_unused(void) { return 0; }
-#endif
-
 #ifdef CONFIG_CPU_FREQ
 int davinci_cpufreq_init(void);
 #else
-- 
2.7.4
