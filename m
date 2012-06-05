From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Jun 2012 09:28:41 +0200
Subject: [PATCH] RFC: ARM: Ensure backtraces console printing in sleep mode
Message-ID: <1338881321-10728-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aurelien Gerault <aurelien.gerault-nonst@stericsson.com>

Ensuring that oops & panic messages/backtraces will be printed
in console, even if in sleep mode (i.e. when the console is
locked).

So, unlock the console before printing.

Signed-off-by: Aurelien Gerault <aurelien.gerault-nonst@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/traps.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 4928d89..42a5057 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/console.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -273,6 +274,9 @@ void die(const char *str, struct pt_regs *regs, int err)
 	int ret;
 	enum bug_trap_type bug_type = BUG_TRAP_TYPE_NONE;
 
+	/* ensure that backtrace will be printed in console */
+	console_unlock();
+
 	oops_enter();
 
 	raw_spin_lock_irq(&die_lock);
-- 
1.7.9.2
