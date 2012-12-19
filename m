From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Dec 2012 16:44:41 -0700
Subject: [PATCH] kexec: disable non-boot CPUs
Message-ID: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Both the regular reboot and shutdown paths do this. It seems reasonable
for kexec to work the same way.

On the Tegra ARM SoC at least, this change allows kexec to work with SMP
enabled. ARM's machine_shutdown() simply puts all CPUs into a loop. If
the code of that loop is over-written, the CPUs may crash, and cause the
kexec'd kernel not to be able to initialize them. In practice, this
causes the kexec'd kernel to hang and/or crash. The intended way to
solve this is for ARM machines to provide a cpu_kill SMP operation to
e.g. power down the CPUs, or place them in reset. However, at least on
Tegra, the implementation of that function would simply be duplicating
the hotplug code that already exists, so it seems simpler to just call
disable_nonboot_cpus() for the kexec path, just like reboot/shutdown.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 kernel/kexec.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 5e4bd78..6fe74d3 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1570,6 +1570,7 @@ int kernel_kexec(void)
 #endif
 	{
 		kernel_restart_prepare(NULL);
+		disable_nonboot_cpus();
 		printk(KERN_EMERG "Starting new kernel\n");
 		machine_shutdown();
 	}
-- 
1.7.10.4
