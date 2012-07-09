From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 17:09:48 +0800
Subject: [PATCH] ARM: disable interrupt before spinning endlessly
Message-ID: <1341824988-18615-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU will endlessly spin at the end of machine_halt and
machine_restart calls.  However, this will lead to a soft lockup
warning after about 20 seconds, if CONFIG_LOCKUP_DETECTOR is enabled,
as system timer is still alive.

Disable interrupt before going to spin endlessly, so that the lockup
warning will never be seen.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/kernel/process.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 19c95ea..693b744 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -247,6 +247,7 @@ void machine_shutdown(void)
 void machine_halt(void)
 {
 	machine_shutdown();
+	local_irq_disable();
 	while (1);
 }
 
@@ -268,6 +269,7 @@ void machine_restart(char *cmd)
 
 	/* Whoops - the platform was unable to reboot. Tell the user! */
 	printk("Reboot failed -- System halted\n");
+	local_irq_disable();
 	while (1);
 }
 
-- 
1.7.5.4
