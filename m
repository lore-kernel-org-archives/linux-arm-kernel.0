From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jul 2016 15:07:38 +0100
Subject: [PATCH 2/4] arm64: debug: remove redundant spsr manipulation
In-Reply-To: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
Message-ID: <1468937260-23988-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to explicitly clear the SS bit immediately before
setting it unconditionally.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 7a907e401c98..91fff48d0f57 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -170,22 +170,13 @@ postcore_initcall(debug_monitors_init);
  */
 static void set_regs_spsr_ss(struct pt_regs *regs)
 {
-	unsigned long spsr;
-
-	spsr = regs->pstate;
-	spsr &= ~DBG_SPSR_SS;
-	spsr |= DBG_SPSR_SS;
-	regs->pstate = spsr;
+	regs->pstate |= DBG_SPSR_SS;
 }
 NOKPROBE_SYMBOL(set_regs_spsr_ss);
 
 static void clear_regs_spsr_ss(struct pt_regs *regs)
 {
-	unsigned long spsr;
-
-	spsr = regs->pstate;
-	spsr &= ~DBG_SPSR_SS;
-	regs->pstate = spsr;
+	regs->pstate &= ~DBG_SPSR_SS;
 }
 NOKPROBE_SYMBOL(clear_regs_spsr_ss);
 
-- 
2.1.4
