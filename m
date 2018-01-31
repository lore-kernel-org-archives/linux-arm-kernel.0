From: anders.roxell@linaro.org (Anders Roxell)
Date: Wed, 31 Jan 2018 21:19:11 +0100
Subject: [PATCHv2] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
In-Reply-To: <20180129234900.11121-1-anders.roxell@linaro.org>
References: <20180129234900.11121-1-anders.roxell@linaro.org>
Message-ID: <20180131201911.19253-1-anders.roxell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While testing multi_v7_defconfig with LOCKDEP enabled, the kernel
fails to load simple modules, as reported by kselftest:

[   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
28 out of range (0xbf046044 -> 0xc109f720)
selftests: printf.sh [FAIL]

The problem that is seen when LOCKDEP is enabled without
ARM_MODULE_PLTS, is that LOCKDEP eats so much memory that the top of the
kernel gets out of reach from the bottom of the module area.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 51c8df561077..8014c8c322df 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1702,6 +1702,7 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARM_MODULE_PLTS
 	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	depends on MODULES
+	default y
 	help
 	  Allocate PLTs when loading modules so that jumps and calls whose
 	  targets are too far away for their relative offsets to be encoded
-- 
2.11.0
