From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 00:36:10 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <20101218000828.GG9937@n2100.arm.linux.org.uk>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101216232849.GY9937@n2100.arm.linux.org.uk>
	<AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
	<20101217231449.GF9937@n2100.arm.linux.org.uk>
	<AANLkTi=-foyb9c5F4tFpGK6KzQnP9htJW8GwYoUHVK0r@mail.gmail.com>
	<20101218000828.GG9937@n2100.arm.linux.org.uk>
Message-ID: <20101218003610.GH9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 18, 2010 at 12:08:28AM +0000, Russell King - ARM Linux wrote:
> The first bug I've spotted in that area would be VFP - which is not
> hotplug aware.  VFP needs to register into the hotplug notifier system
> so that vfp_enable() can be called.  I'll have a patch for that before
> this weekend is out.

This patch ensures that VFP is correctly re-initialized when the CPU
restarts.

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
