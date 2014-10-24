From: johan@kernel.org (Johan Hovold)
Date: Fri, 24 Oct 2014 21:06:32 +0200
Subject: [PATCH] ARM: remove redundant irq disable at halt and restart
Message-ID: <1414177592-14547-1-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove redundant local_irq_disable() at machine halt and restart.

Since commit 44424c34049f ("ARM: 7803/1: Fix deadlock scenario with
smp_send_stop()") interrupts are disabled before stopping secondary
CPUs.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/kernel/process.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index a35f6ebbd2c2..5663ab57cf07 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -195,7 +195,6 @@ void machine_halt(void)
 	local_irq_disable();
 	smp_send_stop();
 
-	local_irq_disable();
 	while (1);
 }
 
@@ -237,7 +236,6 @@ void machine_restart(char *cmd)
 
 	/* Whoops - the platform was unable to reboot. Tell the user! */
 	printk("Reboot failed -- System halted\n");
-	local_irq_disable();
 	while (1);
 }
 
-- 
2.0.4
