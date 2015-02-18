From: kyle@redhat.com (Kyle McMartin)
Date: Wed, 18 Feb 2015 12:26:38 -0500
Subject: [PATCH] arm64: annotate psci invoke functions as notrace
Message-ID: <20150218172638.GB1772@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using GCC 5 to build the kernel with ftrace enabled, we encounter the
following error as a result of the mcount prologue changing the expected
register use of the function parameters,

/tmp/cc8Kpn7A.s: Assembler messages:
/tmp/cc8Kpn7A.s:41: Error: .err encountered
/tmp/cc8Kpn7A.s:42: Error: .err encountered
/tmp/cc8Kpn7A.s:43: Error: .err encountered
/tmp/cc8Kpn7A.s:101: Error: .err encountered
/tmp/cc8Kpn7A.s:102: Error: .err encountered
/tmp/cc8Kpn7A.s:103: Error: .err encountered
scripts/Makefile.build:257: recipe for target 'arch/arm64/kernel/psci.o' failed

Fix this by annotating the function as notrace, to suppress the
generation of profiling prologues and epilogues on the function.

Signed-off-by: Kyle McMartin <kyle@redhat.com>

--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -113,7 +113,7 @@ static void psci_power_state_unpack(u32 power_state,
  * The following two functions are invoked via the invoke_psci_fn pointer
  * and will not be inlined, allowing us to piggyback on the AAPCS.
  */
-static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
+static noinline notrace int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
 					 u64 arg2)
 {
 	asm volatile(
@@ -128,7 +128,7 @@ static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
 	return function_id;
 }
 
-static noinline int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
+static noinline notrace int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
 					 u64 arg2)
 {
 	asm volatile(
