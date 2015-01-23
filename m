From: apw@canonical.com (Andy Whitcroft)
Date: Fri, 23 Jan 2015 17:31:54 +0000
Subject: arm64 -- psci tell the compiler in which registers we are expecting
 arguments
Message-ID: <1422034314-27084-1-git-send-email-apw@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling the kernel with very recent gcc-4.9 compilers we see the
following errors:

    /tmp/ccEayz7S.s: Assembler messages:
    /tmp/ccEayz7S.s:41: Error: .err encountered
    /tmp/ccEayz7S.s:42: Error: .err encountered
    /tmp/ccEayz7S.s:43: Error: .err encountered
    /tmp/ccEayz7S.s:101: Error: .err encountered
    /tmp/ccEayz7S.s:102: Error: .err encountered
    /tmp/ccEayz7S.s:103: Error: .err encountered

This is due to assumptions about the register assignments made by gcc on
function entry.  The errors above occur when these assignments are not
as expected.  It turns out that when you enable mcount preables (-pg)
these are altered and the compilation failed.

Inform the compiler of these register requirements.

BugLink: http://bugs.launchpad.net/bugs/1414002
Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 arch/arm64/kernel/psci.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index f1dbca7..425cf78 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -113,9 +113,14 @@ static void psci_power_state_unpack(u32 power_state,
  * The following two functions are invoked via the invoke_psci_fn pointer
  * and will not be inlined, allowing us to piggyback on the AAPCS.
  */
-static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
-					 u64 arg2)
+static noinline int __invoke_psci_fn_hvc(u64 _function_id, u64 _arg0,
+					 u64 _arg1, u64 _arg2)
 {
+	register u64 function_id asm("x0") = _function_id;
+	register u64 arg0 asm("x1") = _arg0;
+	register u64 arg1 asm("x2") = _arg1;
+	register u64 arg2 asm("x3") = _arg2;
+
 	asm volatile(
 			__asmeq("%0", "x0")
 			__asmeq("%1", "x1")
@@ -128,9 +133,14 @@ static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
 	return function_id;
 }
 
-static noinline int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
-					 u64 arg2)
+static noinline int __invoke_psci_fn_smc(u64 _function_id, u64 _arg0,
+					 u64 _arg1, u64 _arg2)
 {
+	register u64 function_id asm("x0") = _function_id;
+	register u64 arg0 asm("x1") = _arg0;
+	register u64 arg1 asm("x2") = _arg1;
+	register u64 arg2 asm("x3") = _arg2;
+
 	asm volatile(
 			__asmeq("%0", "x0")
 			__asmeq("%1", "x1")
-- 
2.1.4
