From: hwoo.yang@gmail.com (Hyungwoo Yang)
Date: Fri, 4 May 2012 13:28:15 -0700
Subject: [PATCH] Prevent process migration during vfp_init()
Message-ID: <CAOsG7tqktqxxU9gtyqojP7KP87cy1jpgT8H==wOe0cQj8=LV+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I think I've found a bug and I think it can happen to anyone if there
us heavy load on cores during init stage.

I really need your opinion.

In vfp_init() in "arch/arm/vfp/vfpmodule.c", if there is process
migration between vfp_enable() and smp_call_function() then kernel
crashes.

=== kernel log when system crashes ===
[ 4.319730] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 1
[ 4.329163] Unable to handle kernel paging request at virtual address 7c512ed8
[ 4.336511] pgd = c0004000
[ 4.339323] [7c512ed8] *pgd=00000000
[ 4.343127] Internal error: Oops: 5 [#1] PREEMPT SMP
[ 4.348166] last sysfs file:
[ 4.351282] Modules linked in:
[ 4.354503] CPU: 0 Tainted: G W (2.6.39.4 #1)
[ 4.360078] PC is at task_rq_lock+0x2c/0x74
[ 4.364412] LR is at try_to_wake_up+0x40/0x440
[ 4.368929] pc : [<c0073178>] lr : [<c007fd98>] psr: 20000193

=== Why it happens ===
I've found the error happens only when there's process migration just
after vfp_init().
Due to the migration, a VFP which is not enabled is accessed and
kernel crashes => smp_call_function() doesn't work as it is expected.

===== original code =====

      if (cpu_arch >= CPU_ARCH_ARMv6)
              vfp_enable(NULL); <== if migration happens just after
vfp_enable(NULL), kernel crashes.
                :
                :
      vfpsid = fmrx(FPSID); <== if migration happens, read tries to
access disbled VFP unit.
                :
                :
     if (VFP_arch)
              printk("not present\n");
      else if (vfpsid & FPSID_NODOUBLE) {
              printk("no double precision support\n");
      } else {
              hotcpu_notifier(vfp_hotplug, 0);

              smp_call_function(vfp_enable, NULL, 1); <== if migration
happens, smp_call_function will not work as it is expected.
=======================

Do you have any opinion?


There're a few ways of preventing migration (like set affinity or
disable premption) but the following is one of the way.
======== Here is my fix ============

>From f96fc79d508235706462336239eb30d66e2e6c0b Mon Sep 17 00:00:00 2001
From: Hyungwoo Yang <hyungwooy@nvidia.com>
Date: Fri, 4 May 2012 11:22:59 -0700
Subject: [PATCH] System crashes if there is process migration during
vfp_init() call.

During vfp_init(), if a process which called vfp_enable() is migrated just
after the call, then the process executing the rest of code will access
a VFP unit which is not ENABLED and also smp_call_function() will not work
as it is expected.

This patch prevents accessing VFP unit disabled by preventing migration
and also replaces smp_call_function() with on_each_cpu() to make sure that
no VFP remains disabled.

Signed-off-by: Hyungwoo Yang <hyungwooy@nvidia.com>

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index bc683b8..6f33e4d 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -655,7 +655,9 @@ static int __init vfp_init(void)
 {
 	unsigned int vfpsid;
 	unsigned int cpu_arch = cpu_architecture();
-
+#ifdef CONFIG_SMP
+	preempt_disable();
+#endif
 	if (cpu_arch >= CPU_ARCH_ARMv6)
 		vfp_enable(NULL);

@@ -667,7 +669,9 @@ static int __init vfp_init(void)
 	vfp_vector = vfp_testing_entry;
 	barrier();
 	vfpsid = fmrx(FPSID);
-	barrier();
+#ifdef CONFIG_SMP
+	preempt_enable();
+#endif
 	vfp_vector = vfp_null_entry;

 	printk(KERN_INFO "VFP support v0.3: ");
@@ -678,7 +682,7 @@ static int __init vfp_init(void)
 	} else {
 		hotcpu_notifier(vfp_hotplug, 0);

-		smp_call_function(vfp_enable, NULL, 1);
+		on_each_cpu(vfp_enable, NULL, 1);

 		VFP_arch = (vfpsid & FPSID_ARCH_MASK) >> FPSID_ARCH_BIT;  /*
Extract the architecture version */
 		printk("implementor %02x architecture %d part %02x variant %x rev %x\n",
-- 
1.7.0.4
