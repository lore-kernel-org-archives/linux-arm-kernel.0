From: pavel@denx.de (Pavel Machek)
Date: Sat, 26 Jan 2013 21:59:05 +0100
Subject: [PATCHv1 for soc 5/5] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <1359147770.32148.28.camel@linux-builds1>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-6-git-send-email-dinguyen@altera.com>
 <20130125175511.GE10055@amd.pavel.ucw.cz>
 <1359147770.32148.28.camel@linux-builds1>
Message-ID: <20130126205905.GA3006@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Because the CPU1 start address is different for socfpga-vt and
> > > socfpga-cyclone5, we add code to use the correct CPU1 start addr.
> > > 
> > > +++ b/arch/arm/configs/socfpga_defconfig
> > > @@ -21,6 +21,7 @@ CONFIG_ARM_THUMBEE=y
> > >  # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
> > >  # CONFIG_CACHE_L2X0 is not set
> > >  CONFIG_HIGH_RES_TIMERS=y
> > > +CONFIG_VMSPLIT_2G=y
> > >  CONFIG_SMP=y
> > >  CONFIG_NR_CPUS=2
> > >  CONFIG_AEABI=y
> > 
> > Is this related to CPU1 start address?
> 
> Yes, it's really only necessary when running the virtual simulator.

Aha, but defconfig does not mean that people will not try that
config (and it may be useful for multiarch kernels etc). If we don't
know what the cause is, what about this?

Remove unneccessary #ifdef.

socfpga will not boot in VMSPLIT_3G mode on emulator for some
reason. Warn when such configuration is detected, and fall back to UP
mode (so that user has chance to read the message).

Thanks,
								Pavel

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 44cd055..dabf325 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -23,9 +23,7 @@ ENTRY(secondary_trampoline)
 
 ENTRY(secondary_trampoline_end)
 
-#ifdef CONFIG_SMP
 ENTRY(v7_secondary_startup)
        bl      v7_invalidate_l1
        b       secondary_startup
 ENDPROC(v7_secondary_startup)
-#endif
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index d54647e..81e0da0 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -75,6 +75,13 @@ static void __init socfpga_smp_init_cpus(void)
 
 	ncores = scu_get_core_count(socfpga_scu_base_addr);
 
+#ifndef CONFIG_VMSPLIT_2G
+	if (of_machine_is_compatible("altr,socfpga-vt")) {
+		printk("Emulator needs VMSPLIT_2G to work in SMP mode.\n");
+		early_printk("Emulator needs VMSPLIT_2G to work in SMP mode.\n");
+		ncores = 1;
+	}
+#endif
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
