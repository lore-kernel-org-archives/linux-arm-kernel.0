From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 12 Jun 2012 17:37:54 +0530
Subject: [PATCH] kprobes: only test 'sub pc, pc, #1b-2b+8-2' on ARMv6
Message-ID: <1339502874-9104-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'sub pc, pc, #1b-2b+8-2' results in address<1:0> == '10'.

sub pc, pc, #const (== ADR pc, #const) performs an interworking branch
(BXWritePC()) on ARMv7+ and a simple branch (BranchWritePC()) on earlier
versions.

In ARM state, BXWritePC() is UNPREDICTABLE when address<1:0> == '10'.

In ARM state on ARMv6+, BranchWritePC() ignores address<1:0>.  Before
ARMv6, BranchWritePC() is UNPREDICTABLE if address<1:0> != '00'

So the instruction is UNPREDICTABLE both before and after v6.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/kernel/kprobes-test-arm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
index ba32b39..6c926d5 100644
--- a/arch/arm/kernel/kprobes-test-arm.c
+++ b/arch/arm/kernel/kprobes-test-arm.c
@@ -187,8 +187,8 @@ void kprobe_arm_test_cases(void)
 	TEST_BF_R ("mov	pc, r",0,2f,"")
 	TEST_BF_RR("mov	pc, r",0,2f,", asl r",1,0,"")
 	TEST_BB(   "sub	pc, pc, #1b-2b+8")
-#if __LINUX_ARM_ARCH__ >= 6
-	TEST_BB(   "sub	pc, pc, #1b-2b+8-2") /* UNPREDICTABLE before ARMv6 */
+#if __LINUX_ARM_ARCH__ == 6
+	TEST_BB(   "sub	pc, pc, #1b-2b+8-2") /* UNPREDICTABLE before and after ARMv6 */
 #endif
 	TEST_BB_R( "sub	pc, pc, r",14, 1f-2f+8,"")
 	TEST_BB_R( "rsb	pc, r",14,1f-2f+8,", pc")
-- 
1.7.9.5
