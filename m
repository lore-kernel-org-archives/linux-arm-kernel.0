From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jan 2011 19:13:48 +0530
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
	speed-up boot
In-Reply-To: <4D38641E.2000301@gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
	<43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
	<4D38641E.2000301@gmail.com>
Message-ID: <c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robherring2 at gmail.com]
> Sent: Thursday, January 20, 2011 10:05 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; Russell King; linux-
> omap at vger.kernel.org; Linus Walleij
> Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
> to speed-up boot

[..]

> >>
> >> There's already one way to do this with pre-calculated lpj.
> >>
> > How about the hot-plug path? This is not for just boot.
>
> The path is the same for hotplug and secondary boot, so yes for
> both.
> Plus you get the added benefit of speeding up the primary core boot
> as well.
>
No 'preset_lpj' will not work for the hotplug path when
cpufreq is active. It just useful only for boot in
its current form.

> >
> >> Also, this isn't multi-platform friendly. You could accomplish
> the
> >> same
> >> thing using the clock api to get the core frequency of each core
> and
> >> only calculate lpj if the frequency is different.
> > May be but what's wrong with the obvious approach which is
> > completely non-intrusive.
> > Why is not multi-platform friendly ?
> > Archs can choose not to select this option.
>
> I meant you can't have single kernel binary with a platform with
> single
> core freq and a platform with independent core freq.
>
> Looking at this some more, the only reason to call calibrate_delay
> is to
> get a more accurate value. If you have different frequencies per
> core,
> you've got bigger problems as loops_per_jiffy value is not per core.
> So
> your kconfig option name is misleading. Something like
> ARCH_WANT_UDELAY_RECALC would be more accurate. To get a more
> accurate
> calculation, calibrate_delay only needs to be called by 1 secondary
> core. Perhaps it could be called from somewhere that is not in the
> boot/hotplug path or only done once.
>
Similar name was there in my earlier version.
	"ARCH_SKIP_SECONDARY_CALIBRATE"
I changed it based on Linus W suggestion. I understand your one
binary point and this patch.

How about below approach?

-----------------------------------------------------
[PATCH] ARM: smp: Skip secondary cpu calibration to speed-up boot

On some architectures, secondary cores shares clock with primiary
core and hence scale together. Hence secondary core lpj calibration
is not necessary and can be skipped to save considerable time.

This can speed up the secondary cpu boot and hotplug cpu online
paths.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/smp.h     |    8 ++++++++
 arch/arm/kernel/smp.c          |   34 ++++++++++++++++++++++++++--------
 arch/arm/mach-omap2/omap-smp.c |    3 +++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 96ed521..7ffdfec 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -69,6 +69,14 @@ asmlinkage void secondary_start_kernel(void);
 extern void platform_secondary_init(unsigned int cpu);

 /*
+ * Skip the secondary calibration on architectures sharing clock
+ * with primary cpu. Needs to be called for archs inside
+ * platform_secondary_init()
+ */
+extern void secondary_skip_calibrate(void);
+
+
+/*
  * Initialize cpu_possible map, and enable coherency
  */
 extern void platform_smp_prepare_cpus(unsigned int);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4539ebc..b20c408 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -55,6 +55,8 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 };

+static unsigned int skip_secondary_calibrate;
+
 int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct cpuinfo_arm *ci = &per_cpu(cpu_data, cpu);
@@ -270,6 +272,16 @@ static void __cpuinit smp_store_cpu_info(unsigned int
cpuid)
 }

 /*
+ * Skip the secondary calibration on architectures sharing clock
+ * with primary cpu. Needs to be called for archs from
+ * platform_secondary_init()
+ */
+void secondary_skip_calibrate(void)
+{
+	skip_secondary_calibrate = 1;
+}
+
+/*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
@@ -312,7 +324,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 */
 	percpu_timer_setup();

-	calibrate_delay();
+	if (!skip_secondary_calibrate)
+		calibrate_delay();

 	smp_store_cpu_info(cpu);

@@ -332,14 +345,19 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	int cpu;
 	unsigned long bogosum = 0;

-	for_each_online_cpu(cpu)
-		bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
+	if (!skip_secondary_calibrate) {
+		for_each_online_cpu(cpu)
+			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;

-	printk(KERN_INFO "SMP: Total of %d processors activated "
-	       "(%lu.%02lu BogoMIPS).\n",
-	       num_online_cpus(),
-	       bogosum / (500000/HZ),
-	       (bogosum / (5000/HZ)) % 100);
+		printk(KERN_INFO "SMP: Total of %d processors activated "
+		       "(%lu.%02lu BogoMIPS).\n",
+			num_online_cpus(),
+			bogosum / (500000/HZ),
+			(bogosum / (5000/HZ)) % 100);
+	} else {
+		printk(KERN_INFO "SMP: Total of %d processors
activated.\n",
+			num_online_cpus());
+	}
 }

 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/arm/mach-omap2/omap-smp.c
b/arch/arm/mach-omap2/omap-smp.c
index b66cfe8..7342cd5 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -39,6 +39,9 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 */
 	gic_secondary_init(0);

+	/* Allow to skip secondary CPU calibration */
+	secondary_skip_calibrate();
+
 	/*
 	 * Synchronise with the boot thread.
 	 */
-- 
1.6.0.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-smp-Skip-secondary-cpu-calibration-to-speed-up.patch
Type: application/octet-stream
Size: 3698 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110121/8c8d8492/attachment.obj>
