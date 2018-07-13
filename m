From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Fri, 13 Jul 2018 17:12:42 +0200
Subject: [PATCH] ARM: axxia: Fix Kconfig circular dependency
Message-ID: <20180713151242.1950-1-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Strict ARM_LPAE requirement causes following circular dependency:
arch/arm/Kconfig:1910:error: recursive dependency detected!
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/Kconfig:1910:  symbol ATAGS depends on USE_OF
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/Kconfig:1902:  symbol USE_OF is selected by ARCH_AXXIA
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/mach-axxia/Kconfig:1:  symbol ARCH_AXXIA depends on ARM_LPAE
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/mm/Kconfig:634:        symbol ARM_LPAE depends on CPU_32v7
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/mm/Kconfig:454:        symbol CPU_32v7 is selected by CPU_V7
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/mm/Kconfig:387:        symbol CPU_V7 is selected by CPU_PJ4
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/mm/Kconfig:350:        symbol CPU_PJ4 is selected by CPU_MMP2
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/mach-mmp/Kconfig:145:  symbol CPU_MMP2 is selected by MACH_BROWNSTONE
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/arm/mach-mmp/Kconfig:57:   symbol MACH_BROWNSTONE depends on ATAGS

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/mach-axxia/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
index d3eae6037913..d243c2dc22db 100644
--- a/arch/arm/mach-axxia/Kconfig
+++ b/arch/arm/mach-axxia/Kconfig
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 config ARCH_AXXIA
 	bool "LSI Axxia platforms"
-	depends on ARCH_MULTI_V7 && ARM_LPAE
+	depends on ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER
 	select MFD_SYSCON
-	select ZONE_DMA
+	select ZONE_DMA if ARM_LPAE
 	help
 	  This enables support for the LSI Axxia devices.
 
-- 
2.18.0
