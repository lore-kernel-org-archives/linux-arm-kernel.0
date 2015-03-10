From: computersforpeace@gmail.com (Brian Norris)
Date: Mon,  9 Mar 2015 23:59:58 -0700
Subject: [PATCH] ARM: at91: force CPU selection
Message-ID: <1425970798-14015-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach-at91 build does not force the user to make a CPU selection.
This can yield a build failure when SOC_SAM_V7 is used, but neither
SOC_SAMA5D4 nor SOC_SAMA5D3 are defined:

    arch/arm/include/asm/glue-pf.h:54:2: error: #error Unknown prefetch abort handler type
     #error Unknown prefetch abort handler type
      ^
    make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1

The forced default selection is completely arbitrary.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/arm/mach-at91/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c74a44324e5b..afbf03e96746 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -114,6 +114,12 @@ config SOC_AT91SAM9
 	    AT91SAM9XE
 endif # SOC_SAM_V4_V5
 
+config MACH_AT91_AUTO
+	def_bool y
+	depends on !SOC_AT91SAM9 && !SOC_SAMA5D4
+	select SOC_SAMA5D3 if SOC_SAM_V7
+	select SOC_AT91RM9200 if SOC_SAM_V4_V5
+
 comment "AT91 Feature Selections"
 
 config AT91_SLOW_CLOCK
-- 
2.3.2
