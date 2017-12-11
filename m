From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Mon, 11 Dec 2017 21:50:25 +0900
Subject: [PATCH 13/13] arc: do not use __print_symbol()
In-Reply-To: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
References: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
Message-ID: <20171211125025.2270-14-sergey.senozhatsky@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__print_symbol() uses extra stack space to sprintf() symbol
information and then to feed that buffer to printk()

  char buffer[KSYM_SYMBOL_LEN];

  sprint_symbol(buffer, address);
  printk(fmt, buffer);

Replace __print_symbol() with a direct printk("%pS") call.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/stacktrace.c b/arch/arc/kernel/stacktrace.c
index 74315f302971..bf40e06f3fb8 100644
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -163,7 +163,7 @@ arc_unwind_core(struct task_struct *tsk, struct pt_regs *regs,
  */
 static int __print_sym(unsigned int address, void *unused)
 {
-	__print_symbol("  %s\n", address);
+	printk("  %pS\n", (void *)address);
 	return 0;
 }
 
-- 
2.15.1
