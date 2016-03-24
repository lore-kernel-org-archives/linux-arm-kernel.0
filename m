From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Mar 2016 10:50:32 +0800
Subject: [PATCH] ARM: reboot: remove duplicated local_irq_disable()
Message-ID: <1458787832-7877-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once entering machine_halt() and machine_restart, local_irq_disable()
is called, and local irq is keptdisabled, so the local_irq_disable()
at the end of these two functions are not necessary, remove it.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/reboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 71a2ff9..3fa867a 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -104,8 +104,6 @@ void machine_halt(void)
 {
 	local_irq_disable();
 	smp_send_stop();
-
-	local_irq_disable();
 	while (1);
 }
 
@@ -150,6 +148,5 @@ void machine_restart(char *cmd)
 
 	/* Whoops - the platform was unable to reboot. Tell the user! */
 	printk("Reboot failed -- System halted\n");
-	local_irq_disable();
 	while (1);
 }
-- 
2.8.0.rc3
