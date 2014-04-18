From: jays.lee@samsung.com (Jungseok Lee)
Date: Fri, 18 Apr 2014 16:59:03 +0900
Subject: [PATCH v3 1/7] arm64: Use pr_* instead of printk
Message-ID: <000201cf5adc$10e4aa80$32adff80$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixed the following checkpatch complaint as using pr_*
instead of printk.

WARNING: printk() should include KERN_ facility level

Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
---
 arch/arm64/kernel/traps.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7ffaddd..0484e81 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -65,7 +65,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	printk("%s%s(0x%016lx to 0x%016lx)\n", lvl, str, bottom, top);
+	pr_emerg("%s%s(0x%016lx to 0x%016lx)\n", lvl, str, bottom, top);
 
 	for (first = bottom & ~31; first < top; first += 32) {
 		unsigned long p;
@@ -83,7 +83,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 					sprintf(str + i * 9, " ????????");
 			}
 		}
-		printk("%s%04lx:%s\n", lvl, first & 0xffff, str);
+		pr_emerg("%s%04lx:%s\n", lvl, first & 0xffff, str);
 	}
 
 	set_fs(fs);
@@ -124,7 +124,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 			break;
 		}
 	}
-	printk("%sCode: %s\n", lvl, str);
+	pr_emerg("%sCode: %s\n", lvl, str);
 
 	set_fs(fs);
 }
@@ -156,7 +156,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.pc = thread_saved_pc(tsk);
 	}
 
-	printk("Call trace:\n");
+	pr_emerg("Call trace:\n");
 	while (1) {
 		unsigned long where = frame.pc;
 		int ret;
@@ -328,17 +328,17 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 
 void __pte_error(const char *file, int line, unsigned long val)
 {
-	printk("%s:%d: bad pte %016lx.\n", file, line, val);
+	pr_crit("%s:%d: bad pte %016lx.\n", file, line, val);
 }
 
 void __pmd_error(const char *file, int line, unsigned long val)
 {
-	printk("%s:%d: bad pmd %016lx.\n", file, line, val);
+	pr_crit("%s:%d: bad pmd %016lx.\n", file, line, val);
 }
 
 void __pgd_error(const char *file, int line, unsigned long val)
 {
-	printk("%s:%d: bad pgd %016lx.\n", file, line, val);
+	pr_crit("%s:%d: bad pgd %016lx.\n", file, line, val);
 }
 
 void __init trap_init(void)
-- 
1.7.10.4
