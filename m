From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Sep 2014 13:57:16 +0200
Subject: [PATCH] ARM: hw_breakpoint: Trap undef instruction exceptions on
 wake-up
Message-ID: <1410955036-1956-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If power area D4, which contains the Coresight-ETM hardware block, is
powered down on R-Mobile A1 (r8a7740), the kernel crashes when
suspending from s2ram with:

    Internal error: Oops - undefined instruction: 0 [#1] ARM

This happens because dbg_cpu_pm_notify() calls reset_ctrl_regs(), which
can't access the debug registers as the debug module is powered down.

Protect the call to reset_ctrl_regs() by an undefined instruction hook,
like was done in commit 0d352e3d006c9589 ("ARM: hw_breakpoint: trap
undef instruction exceptions in reset_ctrl_regs") for another caller.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Question: Do we need the same protection in dbg_reset_notify()?
          I can't trigger that case, as r8a7740 has only one CPU core.
---
 arch/arm/kernel/hw_breakpoint.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 4d963fb66e3f0bce..f55f25d4e4de7674 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1038,8 +1038,21 @@ static struct notifier_block dbg_reset_nb = {
 static int dbg_cpu_pm_notify(struct notifier_block *self, unsigned long action,
 			     void *v)
 {
-	if (action == CPU_PM_EXIT)
+	if (action == CPU_PM_EXIT) {
+		/*
+		 * We need to tread carefully here because DBGSWENABLE may be
+		 * driven low on this core and there isn't an architected way to
+		 * determine that.
+		 */
+		register_undef_hook(&debug_reg_hook);
+
+		/*
+		 * Reset the breakpoint resources. We assume that a halting
+		 * debugger will leave the world in a nice state for us.
+		 */
 		reset_ctrl_regs(NULL);
+		unregister_undef_hook(&debug_reg_hook);
+	}
 
 	return NOTIFY_OK;
 }
-- 
1.9.1
