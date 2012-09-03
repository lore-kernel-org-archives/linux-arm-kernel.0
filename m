From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  3 Sep 2012 22:24:58 +0800
Subject: [PATCH] kernel/sys.c: call disable_nonboot_cpus in kernel_restart
Message-ID: <1346682298-13958-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like kernel_power_off calls disable_nonboot_cpus, we may want to have
kernel_restart call disable_nonboot_cpus as well.  Doing so can help
the machines that require boot cpu be the last alive cpu during reboot
to survive with kernel restart.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 kernel/sys.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 241507f..6fab59a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -368,6 +368,7 @@ EXPORT_SYMBOL(unregister_reboot_notifier);
 void kernel_restart(char *cmd)
 {
 	kernel_restart_prepare(cmd);
+	disable_nonboot_cpus();
 	if (!cmd)
 		printk(KERN_EMERG "Restarting system.\n");
 	else
-- 
1.7.5.4
