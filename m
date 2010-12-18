From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 11:04:45 +0000
Subject: [PATCH] ARM: VFP: re-initialize VFP coprocessor access enables on CPU
	hotplug
Message-ID: <E1PTuaj-0000Fp-JS@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can not guarantee that VFP will be enabled when CPU hotplug brings
a CPU back online from a reset state.  Add a hotplug CPU notifier to
ensure that the VFP coprocessor access is enabled whenever a CPU comes
back online.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/vfp/vfpmodule.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 8063a32..b865a53 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -10,9 +10,12 @@
  */
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/cpu.h>
 #include <linux/kernel.h>
+#include <linux/notifier.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
+#include <linux/smp.h>
 #include <linux/init.h>
 
 #include <asm/cputype.h>
@@ -484,7 +487,19 @@ void vfp_flush_hwstate(struct thread_info *thread)
 	put_cpu();
 }
 
-#include <linux/smp.h>
+#ifdef CONFIG_HOTPLUG_CPU
+static int vfp_hotplug_notifier(struct notifier_block *b, unsigned long action,
+				void *data)
+{
+	if (action == CPU_STARTING)
+		vfp_enable(NULL);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block vfp_hotplug_nb = {
+	.notifier_call = vfp_hotplug_notifier,
+};
+#endif
 
 /*
  * VFP support code initialisation.
@@ -514,6 +529,10 @@ static int __init vfp_init(void)
 	else if (vfpsid & FPSID_NODOUBLE) {
 		printk("no double precision support\n");
 	} else {
+#ifdef CONFIG_HOTPLUG_CPU
+		register_cpu_notifier(&vfp_hotplug_nb);
+#endif
+
 		smp_call_function(vfp_enable, NULL, 1);
 
 		VFP_arch = (vfpsid & FPSID_ARCH_MASK) >> FPSID_ARCH_BIT;  /* Extract the architecture version */
-- 
1.6.2.5
