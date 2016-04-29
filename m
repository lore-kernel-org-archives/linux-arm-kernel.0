From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 29 Apr 2016 09:42:18 -0400
Subject: [PATCH] sched/core: don't include asm/mmu_context from drivers
In-Reply-To: <1461919995-21001-1-git-send-email-arnd@arndb.de>
References: <1461919995-21001-1-git-send-email-arnd@arndb.de>
Message-ID: <20160429094218.61b26849@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2016 10:52:32 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> This reverts the earlier fix attempt and works around the problem
> by including both linux/mmu_context.h and asm/mmu_context.h from
> kernel/sched/core.c. This is not a good solution but seems less
> hacky than the alternatives.

What about simply not compiling finish_arch_post_lock_switch() when
building modules?

(untested, not compiled or anything)

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index fa5b42d44985..3f22d1b6bac8 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -66,6 +66,7 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+#ifndef MODULE
 #define finish_arch_post_lock_switch \
 	finish_arch_post_lock_switch
 static inline void finish_arch_post_lock_switch(void)
@@ -87,6 +88,7 @@ static inline void finish_arch_post_lock_switch(void)
 		preempt_enable_no_resched();
 	}
 }
+#endif /* !MODULE */
 
 #endif	/* CONFIG_MMU */
 
