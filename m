From: anders.roxell@linaro.org (Anders Roxell)
Date: Mon,  5 Mar 2018 15:34:05 +0100
Subject: [PATCH v3] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
Message-ID: <20180305143405.12187-1-anders.roxell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While testing multi_v7_defconfig with config fragments that makes the
kernel size to grow. The kernel fails to load simple modules, as
reported by kselftest:

[   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
28 out of range (0xbf046044 -> 0xc109f720)
selftests: printf.sh [FAIL]

The problem that is seen when enabling too much in the kernel without
enabling ARM_MODULE_PLTS, is that the top of the kernel gets out of
reach from the bottom of the module area.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e3d53575486..6831f2d4ee75 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1701,6 +1701,7 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARM_MODULE_PLTS
 	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	depends on MODULES
+	default y
 	help
 	  Allocate PLTs when loading modules so that jumps and calls whose
 	  targets are too far away for their relative offsets to be encoded
@@ -1711,7 +1712,8 @@ config ARM_MODULE_PLTS
 	  rounding up to page size, the actual memory footprint is usually
 	  the same.
 
-	  Say y if you are getting out of memory errors while loading modules
+	  Disabling this is usually safe for small single-platform
+	  configurations. If unsure, say y.
 
 source "mm/Kconfig"
 
-- 
2.11.0
