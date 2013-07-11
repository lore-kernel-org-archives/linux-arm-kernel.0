From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Jul 2013 15:30:36 +0100
Subject: [PATCH] arm64: compat: fix compilation when using 64kB pages
Message-ID: <1373553036-5418-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling for 64kB pages, we end-up having conflicting
implementations for aarch32_break_handler().

Wrap the 4kB page implementation with a CONFIG_COMPAT guard and change
the !CONFIG_COMPAT implementation to be static inline instead of simply static.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h | 2 +-
 arch/arm64/kernel/debug-monitors.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index ef8235c..7c962f3 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -86,7 +86,7 @@ static inline int reinstall_suspended_bps(struct pt_regs *regs)
 #ifdef CONFIG_COMPAT
 int aarch32_break_handler(struct pt_regs *regs);
 #else
-static int aarch32_break_handler(struct pt_regs *regs)
+static inline int aarch32_break_handler(struct pt_regs *regs)
 {
 	return -EFAULT;
 }
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 08018e3..ceedcd7 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -246,6 +246,7 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
 int aarch32_break_handler(struct pt_regs *regs)
 {
 	siginfo_t info;
@@ -285,6 +286,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	force_sig_info(SIGTRAP, &info, current);
 	return 0;
 }
+#endif
 
 static int __init debug_traps_init(void)
 {
-- 
1.8.1.5
