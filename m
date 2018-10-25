From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 Oct 2018 12:01:08 -0700
Subject: [PATCH v2] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS disabled
Message-ID: <20181025190110.7564-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some software such as perf makes unconditional use of the special
[vectors] page which is only provided when CONFIG_KUSER_HELPERS is
enabled in the kernel.

Facilitate the debugging of such situations by printing a debug message
to the kernel log showing the task name and the faulting address.

Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f4ea4c62c613..58f69fa07df9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -173,6 +173,12 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		show_regs(regs);
 	}
 #endif
+#ifndef CONFIG_KUSER_HELPERS
+	if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
+		printk_ratelimited(KERN_DEBUG
+				   "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
+				   tsk->comm, addr);
+#endif
 
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
-- 
2.17.1
