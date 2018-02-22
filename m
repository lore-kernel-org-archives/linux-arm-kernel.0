From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:56 +0000
Subject: [PATCH 8/9] arm64: Move show_unhandled_signals_ratelimited into
 traps.c
In-Reply-To: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519308057-4953-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

show_unhandled_signals_ratelimited is only called in traps.c, so move it
out of its macro in the dreaded system_misc.h and into a static function
in traps.c

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/system_misc.h | 11 -----------
 arch/arm64/kernel/traps.c            |  7 +++++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 07aa8e3c5630..28893a0b141d 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -45,17 +45,6 @@ extern void __show_regs(struct pt_regs *);
 
 extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
-#define show_unhandled_signals_ratelimited()				\
-({									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,	\
-				      DEFAULT_RATELIMIT_BURST);		\
-	bool __show_ratelimited = false;				\
-	if (show_unhandled_signals && __ratelimit(&_rs))		\
-		__show_ratelimited = true;				\
-	__show_ratelimited;						\
-})
-
 int handle_guest_sea(phys_addr_t addr, unsigned int esr);
 
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 637ae3702950..4231488a5a9f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -223,6 +223,13 @@ void die(const char *str, struct pt_regs *regs, int err)
 		do_exit(SIGSEGV);
 }
 
+static bool show_unhandled_signals_ratelimited(void)
+{
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	return show_unhandled_signals && __ratelimit(&rs);
+}
+
 void arm64_force_sig_info(struct siginfo *info, const char *str,
 			  struct task_struct *tsk)
 {
-- 
2.1.4
