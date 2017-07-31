From: panand@redhat.com (Pratyush Anand)
Date: Mon, 31 Jul 2017 16:10:33 +0530
Subject: [PATCH v3 5/5] arm64: fault: re-enable irq if it was disabled for
 single stepping
In-Reply-To: <cover.1501496603.git.panand@redhat.com>
References: <cover.1501496603.git.panand@redhat.com>
Message-ID: <9975fac37c34fcc83a43fc797d0dbf7e463a038f.1501496603.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We disable irq before single stepping and re-enable it after it.
However, if stepped instruction will cause a fault then we will enter
into fault handler with interrupt disabled, which is not desired.
But, we should be safe if we re-enable interrupt in fault handler if
it was disabled for single stepping.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/mm/fault.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ce5290dacba3..2b88807eb964 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -589,6 +589,8 @@ static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
 };
 
+static DEFINE_PER_CPU(bool, irq_enable_needed);
+
 /*
  * Dispatch a data abort to the relevant handler.
  */
@@ -597,6 +599,12 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 {
 	const struct fault_info *inf = esr_to_fault_info(esr);
 	struct siginfo info;
+	bool *irq_en_needed = this_cpu_ptr(&irq_enable_needed);
+
+	if (*irq_en_needed) {
+		regs->pstate &= ~PSR_I_BIT;
+		*irq_en_needed = false;
+	}
 
 	if (!inf->fn(addr, esr, regs))
 		return;
@@ -672,8 +680,6 @@ void __init hook_debug_fault_code(int nr,
 	debug_fault_info[nr].name	= name;
 }
 
-static DEFINE_PER_CPU(bool, irq_enable_needed);
-
 asmlinkage int __exception do_debug_exception(unsigned long addr,
 					      unsigned int esr,
 					      struct pt_regs *regs)
-- 
2.9.4
