From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:14 +0100
Subject: [PATCH 07/15] ARM: disable some options on ARMv7-M
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kprobes, irqflags tracing and kexec don't currently build on
kernels targetting ARMv7-M, so for now, we should just disallow
those combinations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b9b68b467584..11cc5fa40ff7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -55,7 +55,7 @@ config ARM
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
-	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_32v3
+	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_32v3 && !CPU_V7M
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
@@ -169,7 +169,7 @@ config LOCKDEP_SUPPORT
 
 config TRACE_IRQFLAGS_SUPPORT
 	bool
-	default y
+	default !CPU_V7M
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
@@ -1990,6 +1990,7 @@ config XIP_PHYS_ADDR
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
 	depends on (!SMP || PM_SLEEP_SMP)
+	depends on !CPU_V7M
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-- 
2.1.0.rc2
