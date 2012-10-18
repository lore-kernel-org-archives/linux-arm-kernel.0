From: pavel@denx.de (Pavel Machek)
Date: Thu, 18 Oct 2012 12:09:47 +0200
Subject: [PATCHv1] arm:socfpga: Enable SMP for socfpga
In-Reply-To: <507F3F9C.7040704@gmail.com>
References: <1350501498-23601-1-git-send-email-dinguyen@altera.com>
 <507F01FD.6070403@gmail.com> <20121017230216.GA25651@elf.ucw.cz>
 <507F3F9C.7040704@gmail.com>
Message-ID: <20121018100946.GA26258@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> +	timeout = jiffies + (1 * HZ);
> >>> +	while (time_before(jiffies, timeout)) {
> >>> +		smp_rmb();
> >>> +		if (pen_release == -1)
> >>> +			break;
> >>> +
> >>> +		udelay(10);
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * now the secondary core is starting up let it run its
> >>> +	 * calibrations, then wait for it to finish
> >>> +	 */
> >>> +	spin_unlock(&boot_lock);
> >>> +	return pen_release != -1 ? -ENOSYS : 0;
> >>
> >> You don't need any of this if you can reset secondary cores on
> >> hotplug.
> > 
> > What exactly is unneccessary? I'd like to wait for secondary to come
> > up so we can raise an error if it does not...?
> > 
> 
> Look at the highbank code.
> 
> If hotplug will cause a reset of the core, then none of this pen code is
> needed. If hotplug just does a wfi and returns from the wfi when
> onlining the core like Versatile Express, then you need this pen code.
> There's been several prior discussions about this on the list.
> 
> If you will never support hotplug (and therefore suspend), then you
> don't need this pen code either.

Ok, so I guess we should go with the simple code for now? Something
like...

BTW... I wonder if I should put socfpga_smp_init_cpus(void) into the
library somewhere? (Where?) Same code is used on highbank, imx,
socfpga, spear13xx, tegra and ct-ca9x4...

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 081b4d1..ee19ce9 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/plat-socfpga5xs1/headsmp.S
+ *  Trampoline to bring CPU from reset.
  *
  *  Copyright (c) 2012 Pavel Machek <pavel@denx.de>
  *  Copyright (c) u-boot contributors
@@ -15,9 +15,9 @@
 
 	__INIT
 
-#define HPS_SYSMGR_ADDRESS 0xffd08000
-#define CONFIG_SYSTEM_MANAGER               HPS_SYSMGR_ADDRESS
-#define CONFIG_CPU1_START_ADDR 	        (CONFIG_SYSTEM_MANAGER + 0x10)
+#define HPS_SYSMGR_ADDRESS	0xffd08000
+#define CONFIG_SYSTEM_MANAGER	HPS_SYSMGR_ADDRESS
+#define CONFIG_CPU1_START_ADDR	(CONFIG_SYSTEM_MANAGER + 0x10)
 
 ENTRY(secondary_trampoline)
 	movw	r0, #:lower16:CONFIG_CPU1_START_ADDR
@@ -25,9 +25,4 @@ ENTRY(secondary_trampoline)
 
 	ldr	r1, [r0]
 	bx	r1
-	
 ENTRY(secondary_trampoline_end)
-
-	.align
-	.long	pen_release
-
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 60c2b4a..fb3c58c 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -1,4 +1,7 @@
-/* Copyright 2010-2011 Calxeda, Inc.
+/*
+ * SMP support.
+ * 
+ * Copyright 2010-2011 Calxeda, Inc.
  * Copyright 2012 Pavel Machek <pavel@denx.de>
  * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
  *
@@ -31,8 +34,6 @@
 static void __iomem *sys_manager_base_addr;
 static void __iomem *rst_manager_base_addr;
 
-static DEFINE_SPINLOCK(boot_lock);
-
 static void __cpuinit socfpga_secondary_init(unsigned int cpu)
 {
 	/*
@@ -41,41 +42,20 @@ static void __cpuinit socfpga_secondary_init(unsigned int cpu)
 	 * for us: do so
 	 */
 	gic_secondary_init(0);
-
-	/*
-	 * let the primary processor know we're out of the
-	 * pen, then head off into the C entry point
-	 */
-	pen_release = -1;
-	smp_wmb();
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
-
-	early_printk("Secondary ready.\n");
+	early_printk("Started secondary.\n");
 }
 
 static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
 	extern char secondary_trampoline, secondary_trampoline_end;
 
 	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
 
 	early_printk("Boot secondary...\n");
-	/*
-	 * Set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
 
 	memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
 	__raw_writel(virt_to_phys(secondary_startup), (sys_manager_base_addr+0x10));
-	pen_release = 0;
 	flush_cache_all();
 	smp_wmb();
 	outer_clean_range(0, trampoline_size);
@@ -83,21 +63,7 @@ static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct
 	   in u-boot */
 	__raw_writel(0, rst_manager_base_addr + 0x10);
 
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		smp_rmb();
-		if (pen_release == -1)
-			break;
-
-		udelay(10);
-	}
-
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-	return pen_release != -1 ? -ENOSYS : 0;
+	return 0;
 }
 
 /*


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
