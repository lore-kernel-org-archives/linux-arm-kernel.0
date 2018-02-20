From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 22:59:49 +0100
Subject: [PATCH 2/7] ARM: LTO: avoid THUMB2_KERNEL+LTO
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
Message-ID: <20180220215954.4092811-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to build an LTO-Enabled kernel with Thumb2 instructions failed
horribly for me, with an endless output of things like

ccVnNycO.s:2665: Error: thumb conditional instruction should be in IT block -- `bxne lr'
ccVnNycO.s:7128: Error: thumb conditional instruction should be in IT block -- `strexeq r5,r2,[r3]'
ccVnNycO.s:7258: Error: thumb conditional instruction should be in IT block -- `strexeq lr,r0,[r3]'
ccVnNycO.s:17380: Error: thumb conditional instruction should be in IT block -- `strexeq r1,r2,[r6]'
ccVnNycO.s:19163: Error: thumb conditional instruction should be in IT block -- `strexeq r8,r6,[r3]'
ccVnNycO.s:22722: Error: thumb conditional instruction should be in IT block -- `strexeq r7,r1,[r0]'
ccVnNycO.s:24105: conditional infixes are deprecated in unified syntax
ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `sbcccs r1,r1,r3'
ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
ccVnNycO.s:24210: conditional infixes are deprecated in unified syntax
ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `sbcccs r2,r2,r3'
ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'

I did not investigate this too much, disabling Thumb2 support when LTO is
set lets me build randconfig kernels.

Since ARM_SINGLE_ARMV7M is Thumb2-only, I have to disallow LTO for V7-M
targets.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8ed0f664f86f..fbf2c3ab9a97 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,7 +18,7 @@ config ARM
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_LTO
+	select ARCH_SUPPORTS_LTO if !ARM_SINGLE_ARMV7M
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_IPC_PARSE_VERSION
@@ -1533,6 +1533,7 @@ config SCHED_HRTICK
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
 	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
+	depends on !LTO
 	default y if CPU_THUMBONLY
 	select ARM_UNWIND
 	help
-- 
2.9.0
