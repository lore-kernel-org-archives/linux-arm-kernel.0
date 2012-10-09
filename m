From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:22:55 +0200
Subject: [PATCH 1/9] ARM: kprobes: make more tests conditional
In-Reply-To: <1349796183-30648-1-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
Message-ID: <1349796183-30648-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mls instruction is not available in ARMv6K or below, so we
should make the test conditional on at least ARMv7. ldrexd/strexd
are available in ARMv6K or ARMv7, which we can test by checking
the CONFIG_CPU_32v6K symbol.

/tmp/ccuMTZ8D.s: Assembler messages:
/tmp/ccuMTZ8D.s:22188: Error: selected processor does not support ARM mode `mls r0,r1,r2,r3'
/tmp/ccuMTZ8D.s:22222: Error: selected processor does not support ARM mode `mlshi r7,r8,r9,r10'
/tmp/ccuMTZ8D.s:22252: Error: selected processor does not support ARM mode `mls lr,r1,r2,r13'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jon Medhurst <tixy@yxit.co.uk>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Leif Lindholm <leif.lindholm@arm.com>
---
 arch/arm/kernel/kprobes-test-arm.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
index 38c1a3b..8393129 100644
--- a/arch/arm/kernel/kprobes-test-arm.c
+++ b/arch/arm/kernel/kprobes-test-arm.c
@@ -366,7 +366,9 @@ void kprobe_arm_test_cases(void)
 	TEST_UNSUPPORTED(".word 0xe04f0392 @ umaal r0, pc, r2, r3")
 	TEST_UNSUPPORTED(".word 0xe0500090 @ undef")
 	TEST_UNSUPPORTED(".word 0xe05fff9f @ undef")
+#endif
 
+#if __LINUX_ARM_ARCH__ >= 7
 	TEST_RRR(  "mls		r0, r",1, VAL1,", r",2, VAL2,", r",3,  VAL3,"")
 	TEST_RRR(  "mlshi	r7, r",8, VAL3,", r",9, VAL1,", r",10, VAL2,"")
 	TEST_RR(   "mls		lr, r",1, VAL2,", r",2, VAL3,", r13")
@@ -456,6 +458,8 @@ void kprobe_arm_test_cases(void)
 	TEST_UNSUPPORTED(".word	0xe1700090") /* Unallocated space */
 #if __LINUX_ARM_ARCH__ >= 6
 	TEST_UNSUPPORTED("ldrex	r2, [sp]")
+#endif
+#if (__LINUX_ARM_ARCH__ >= 7) || defined(CONFIG_CPU_32v6K)
 	TEST_UNSUPPORTED("strexd	r0, r2, r3, [sp]")
 	TEST_UNSUPPORTED("ldrexd	r2, r3, [sp]")
 	TEST_UNSUPPORTED("strexb	r0, r2, [sp]")
-- 
1.7.10
