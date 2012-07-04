From: per.forlin@stericsson.com (Per Forlin)
Date: Wed, 4 Jul 2012 09:51:02 +0200
Subject: [PATCH] ARM: reboot: disable nonboot CPUs
Message-ID: <1341388262-3801-1-git-send-email-per.forlin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the nonboot CPUs to safely migrate tasks and interrupts
to the boot CPU. This will prevent the nonboot CPUs to
interfer or block the boot CPU from being able to reboot
the system successfully.

This reboot issue was detected on u8500 when using ab8500 to initaite a
system restart. The issue happens because smp_send_stop() stops the CPUs
wihouth migrating all resources.
If not issuing smp_send_stop() u8500 reboots successfully.

It's optional to support CONFIG_PM_SLEEP_SMP therefore smp_send_stop()
can't simply be replaced by disable_nonboot_cpus()

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
---
 arch/arm/kernel/process.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 864580a..aab4f81 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -239,6 +239,7 @@ __setup("reboot=", reboot_setup);
 
 void machine_shutdown(void)
 {
+	disable_nonboot_cpus();
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
-- 
1.7.10
