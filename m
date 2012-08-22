From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 15:19:11 +0000
Subject: [PATCH 4/4] ARM: kprobes: make more tests conditional
In-Reply-To: <alpine.LFD.2.02.1208221040250.1754@xanadu.home>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-5-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.02.1208221040250.1754@xanadu.home>
Message-ID: <201208221519.12056.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 August 2012, Nicolas Pitre wrote:
> On Wed, 22 Aug 2012, Arnd Bergmann wrote:
> 
> > The mls instruction is not available in ARMv6K or below, so we
> > should make the test conditional on at least ARMv7. ldrex/strex
> > are available in ARMv6K or ARMv7, which we can test by checking
> > the CONFIG_CPU_32v6K symbol. Just testing for ARMv6 is not enough.
> 
> The ldrex/strex instructions are available on ARMv6.  It's only the d 
> variants (strexd/ldrexd) which are only available from ARMv6k.

Ok. How is the version below then? I haven't tested this one yet.

	Arnd

8<---
>From d878ab212cf0ac1957be83ad80dc734ace2b476c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Aug 2012 07:49:31 +0000
Subject: [PATCH] ARM: kprobes: make more tests conditional

The mls instruction is not available in ARMv6K or below, so we
should make the test conditional on at least ARMv7. ldrexd/strexd
are available in ARMv6K or ARMv7, which we can test by checking
the CONFIG_CPU_32v6K symbol. Just testing for ARMv6 is not enough.

/tmp/ccuMTZ8D.s: Assembler messages:
/tmp/ccuMTZ8D.s:22188: Error: selected processor does not support ARM mode `mls r0,r1,r2,r3'
/tmp/ccuMTZ8D.s:22222: Error: selected processor does not support ARM mode `mlshi r7,r8,r9,r10'
/tmp/ccuMTZ8D.s:22252: Error: selected processor does not support ARM mode `mls lr,r1,r2,r13'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Medhurst <tixy@yxit.co.uk>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Leif Lindholm <leif.lindholm@arm.com>
---
 arch/arm/kernel/kprobes-test-arm.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
index 38c1a3b..fc9f6e0 100644
--- a/arch/arm/kernel/kprobes-test-arm.c
+++ b/arch/arm/kernel/kprobes-test-arm.c
@@ -367,9 +367,11 @@ void kprobe_arm_test_cases(void)
 	TEST_UNSUPPORTED(".word 0xe0500090 @ undef")
 	TEST_UNSUPPORTED(".word 0xe05fff9f @ undef")
 
+#if __LINUX_ARM_ARCH__ >= 7
 	TEST_RRR(  "mls		r0, r",1, VAL1,", r",2, VAL2,", r",3,  VAL3,"")
 	TEST_RRR(  "mlshi	r7, r",8, VAL3,", r",9, VAL1,", r",10, VAL2,"")
 	TEST_RR(   "mls		lr, r",1, VAL2,", r",2, VAL3,", r13")
+#endif
 	TEST_UNSUPPORTED(".word 0xe06f3291 @ mls pc, r1, r2, r3")
 	TEST_UNSUPPORTED(".word 0xe060329f @ mls r0, pc, r2, r3")
 	TEST_UNSUPPORTED(".word 0xe0603f91 @ mls r0, r1, pc, r3")
@@ -456,8 +458,10 @@ void kprobe_arm_test_cases(void)
 	TEST_UNSUPPORTED(".word	0xe1700090") /* Unallocated space */
 #if __LINUX_ARM_ARCH__ >= 6
 	TEST_UNSUPPORTED("ldrex	r2, [sp]")
+#ifdef CONFIG_CPU_32v6K
 	TEST_UNSUPPORTED("strexd	r0, r2, r3, [sp]")
 	TEST_UNSUPPORTED("ldrexd	r2, r3, [sp]")
+#endif
 	TEST_UNSUPPORTED("strexb	r0, r2, [sp]")
 	TEST_UNSUPPORTED("ldrexb	r2, [sp]")
 	TEST_UNSUPPORTED("strexh	r0, r2, [sp]")
-- 
1.7.10
