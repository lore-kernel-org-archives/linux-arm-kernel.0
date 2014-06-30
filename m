From: xerofoify@gmail.com (Nicholas Krause)
Date: Sun, 29 Jun 2014 22:52:40 -0400
Subject: [PATCH] Fixes gemmi_idle in file idle.c
Message-ID: <1404096760-5239-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

disables the IRQ line in gemmi_idle before calling cpu_do_idle.
In addition, according to the Fixme message in this file fixes
races that may occur due to not disabling the IRQ before calling
cpu_do_idle.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-gemini/idle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-gemini/idle.c b/arch/arm/mach-gemini/idle.c
index ddf8ec9..2880f5a 100644
--- a/arch/arm/mach-gemini/idle.c
+++ b/arch/arm/mach-gemini/idle.c
@@ -17,8 +17,7 @@ static void gemini_idle(void)
 	 * disabled.
 	 */
 
-	/* FIXME: Enabling interrupts here is racy! */
-	local_irq_enable();
+	local_irq_disable();
 	cpu_do_idle();
 }
 
-- 
1.9.1
