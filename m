From: anders.roxell@linaro.org (Anders Roxell)
Date: Tue, 30 Jan 2018 00:49:00 +0100
Subject: [PATCH] arch/arm/Kconfig: enable ARM_MODULE_PLTS when LOCKDEP=y
Message-ID: <20180129234900.11121-1-anders.roxell@linaro.org>
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
index 51c8df561077..a339157497c6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -20,6 +20,7 @@ config ARM
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARM_MODULE_PLTS if LOCKDEP
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
-- 
2.11.0
