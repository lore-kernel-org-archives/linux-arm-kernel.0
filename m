From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Mon, 11 Dec 2017 21:50:24 +0900
Subject: [PATCH 12/13] lib: do not use print_symbol()
In-Reply-To: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
References: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
Message-ID: <20171211125025.2270-13-sergey.senozhatsky@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

print_symbol() uses extra stack space to sprintf() symbol
information and then to feed that buffer to printk()

  char buffer[KSYM_SYMBOL_LEN];

  sprint_symbol(buffer, address);
  printk(fmt, buffer);

Replace print_symbol() with a direct printk("%pS") call.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 lib/smp_processor_id.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 835cc6df2776..85925aaa4fff 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -5,7 +5,6 @@
  * DEBUG_PREEMPT variant of smp_processor_id().
  */
 #include <linux/export.h>
-#include <linux/kallsyms.h>
 #include <linux/sched.h>
 
 notrace static unsigned int check_preemption_disabled(const char *what1,
@@ -43,7 +42,7 @@ notrace static unsigned int check_preemption_disabled(const char *what1,
 	printk(KERN_ERR "BUG: using %s%s() in preemptible [%08x] code: %s/%d\n",
 		what1, what2, preempt_count() - 1, current->comm, current->pid);
 
-	print_symbol("caller is %s\n", (long)__builtin_return_address(0));
+	printk("caller is %pS\n", __builtin_return_address(0));
 	dump_stack();
 
 out_enable:
-- 
2.15.1
