From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:18 +0100
Subject: [PATCH 11/15] ARM: HAVE_VIRT_CPU_ACCOUNTING_GEN requires cmpxchg64
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu time accounting code uses 64-bit nanosecond based
cputime_t if HAVE_VIRT_CPU_ACCOUNTING_GEN is enabled, which
in turn requires working cmpxchg64 support. Trying this
on ARMv7M, ARMv5 and earlier, or OABI will result in a
build error like

  CC      kernel/sched/cputime.o
/tmp/ccVoXzRS.s:127: Error: selected processor does not support Thumb mode `ldrexd r4,r5,[r3]'
/tmp/ccVoXzRS.s:131: Error: selected processor does not support Thumb mode `strexd lr,r8,r9,[r3]'
/tmp/ccVoXzRS.s:148: Error: selected processor does not support Thumb mode `ldrexd r6,r7,[r5]'
/tmp/ccVoXzRS.s:152: Error: selected processor does not support Thumb mode `strexd r4,r0,r1,[r5]'

To work around this problem, make HAVE_VIRT_CPU_ACCOUNTING_GEN
depend on the newer architectures and EABI support. There is
very little use in this feature on older machines, so there
should be no downsides.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 11cc5fa40ff7..04af434c11b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -68,7 +68,7 @@ config ARM
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN if AEABI && (CPU_V6K || CPU_V7)
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_REL
 	select NO_BOOTMEM
-- 
2.1.0.rc2
