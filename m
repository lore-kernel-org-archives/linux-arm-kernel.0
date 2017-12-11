From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Mon, 11 Dec 2017 21:50:18 +0900
Subject: [PATCH 06/13] sh: do not use print_symbol()
In-Reply-To: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
References: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
Message-ID: <20171211125025.2270-7-sergey.senozhatsky@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

print_symbol() uses extra stack space to sprintf() symbol
information and then to feed that buffer to printk()

  char buffer[KSYM_SYMBOL_LEN];

  sprint_symbol(buffer, address);
  printk(fmt, buffer);

Replace print_symbol() with a direct printk("%pS") call.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
---
 arch/sh/kernel/process_32.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 2c7bdf8cb934..5c88e7cb9c18 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -20,7 +20,6 @@
 #include <linux/sched/task_stack.h>
 #include <linux/slab.h>
 #include <linux/elfcore.h>
-#include <linux/kallsyms.h>
 #include <linux/fs.h>
 #include <linux/ftrace.h>
 #include <linux/hw_breakpoint.h>
@@ -37,8 +36,8 @@ void show_regs(struct pt_regs * regs)
 	printk("\n");
 	show_regs_print_info(KERN_DEFAULT);
 
-	print_symbol("PC is at %s\n", instruction_pointer(regs));
-	print_symbol("PR is at %s\n", regs->pr);
+	printk("PC is at %pS\n", instruction_pointer(regs));
+	printk("PR is at %pS\n", (void *)regs->pr);
 
 	printk("PC  : %08lx SP  : %08lx SR  : %08lx ",
 	       regs->pc, regs->regs[15], regs->sr);
-- 
2.15.1
