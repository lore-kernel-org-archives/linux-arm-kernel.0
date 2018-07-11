From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 11 Jul 2018 13:00:35 +0200
Subject: [PATCH 1/3] arm: Convert arm boot_lock to raw
In-Reply-To: <20180711110037.12928-1-bigeasy@linutronix.de>
References: <20180711110037.12928-1-bigeasy@linutronix.de>
Message-ID: <20180711110037.12928-2-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Rowand <frank.rowand@am.sony.com>

The arm boot_lock is used by the secondary processor startup code.  The locking
task is the idle thread, which has idle->sched_class == &idle_sched_class.
idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
lock, the attempt to wake it when the lock becomes available will fail:

try_to_wake_up()
   ...
      activate_task()
         enqueue_task()
            p->sched_class->enqueue_task(rq, p, flags)

Fix by converting boot_lock to a raw spin lock.

Cc: "Andreas F?rber" <afaerber@suse.de>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-msm at vger.kernel.org
Cc: linux-soc at vger.kernel.org
Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Link: http://lkml.kernel.org/r/4E77B952.3010606 at am.sony.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tony Lindgren <tony@atomide.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org> [Exynos5422 Linaro PM-QA]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-actions/platsmp.c   |  6 +++---
 arch/arm/mach-exynos/platsmp.c    | 12 ++++++------
 arch/arm/mach-hisi/platmcpm.c     | 22 +++++++++++-----------
 arch/arm/mach-omap2/omap-smp.c    | 10 +++++-----
 arch/arm/mach-prima2/platsmp.c    | 10 +++++-----
 arch/arm/mach-qcom/platsmp.c      | 10 +++++-----
 arch/arm/mach-spear/platsmp.c     | 10 +++++-----
 arch/arm/mach-sti/platsmp.c       | 10 +++++-----
 arch/arm/mach-sunxi/mc_smp.c      | 20 ++++++++++----------
 arch/arm/plat-versatile/platsmp.c | 10 +++++-----
 10 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 3efaa10efc43..770079245d27 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -39,7 +39,7 @@ static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
 static int ncores;
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void owl_secondary_startup(void);
 
@@ -93,7 +93,7 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	udelay(10);
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	smp_send_reschedule(cpu);
 
@@ -106,7 +106,7 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
 	writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
 
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return 0;
 }
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 6a1e682371b3..17dca0ff336e 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -239,7 +239,7 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void exynos_secondary_init(unsigned int cpu)
 {
@@ -252,8 +252,8 @@ static void exynos_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr)
@@ -317,7 +317,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -344,7 +344,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		if (timeout == 0) {
 			printk(KERN_ERR "cpu1 power enable failed");
-			spin_unlock(&boot_lock);
+			raw_spin_unlock(&boot_lock);
 			return -ETIMEDOUT;
 		}
 	}
@@ -390,7 +390,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * calibrations, then wait for it to finish
 	 */
 fail:
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? ret : 0;
 }
diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index f66815c3dd07..00524abd963f 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -61,7 +61,7 @@
 
 static void __iomem *sysctrl, *fabric;
 static int hip04_cpu_table[HIP04_MAX_CLUSTERS][HIP04_MAX_CPUS_PER_CLUSTER];
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 static u32 fabric_phys_addr;
 /*
  * [0]: bootwrapper physical address
@@ -113,7 +113,7 @@ static int hip04_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
 	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
 		return -EINVAL;
 
-	spin_lock_irq(&boot_lock);
+	raw_spin_lock_irq(&boot_lock);
 
 	if (hip04_cpu_table[cluster][cpu])
 		goto out;
@@ -147,7 +147,7 @@ static int hip04_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
 
 out:
 	hip04_cpu_table[cluster][cpu]++;
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 
 	return 0;
 }
@@ -162,11 +162,11 @@ static void hip04_cpu_die(unsigned int l_cpu)
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 	hip04_cpu_table[cluster][cpu]--;
 	if (hip04_cpu_table[cluster][cpu] == 1) {
 		/* A power_up request went ahead of us. */
-		spin_unlock(&boot_lock);
+		raw_spin_unlock(&boot_lock);
 		return;
 	} else if (hip04_cpu_table[cluster][cpu] > 1) {
 		pr_err("Cluster %d CPU%d boots multiple times\n", cluster, cpu);
@@ -174,7 +174,7 @@ static void hip04_cpu_die(unsigned int l_cpu)
 	}
 
 	last_man = hip04_cluster_is_down(cluster);
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 	if (last_man) {
 		/* Since it's Cortex A15, disable L2 prefetching. */
 		asm volatile(
@@ -203,7 +203,7 @@ static int hip04_cpu_kill(unsigned int l_cpu)
 	       cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
 
 	count = TIMEOUT_MSEC / POLL_MSEC;
-	spin_lock_irq(&boot_lock);
+	raw_spin_lock_irq(&boot_lock);
 	for (tries = 0; tries < count; tries++) {
 		if (hip04_cpu_table[cluster][cpu])
 			goto err;
@@ -211,10 +211,10 @@ static int hip04_cpu_kill(unsigned int l_cpu)
 		data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
 		if (data & CORE_WFI_STATUS(cpu))
 			break;
-		spin_unlock_irq(&boot_lock);
+		raw_spin_unlock_irq(&boot_lock);
 		/* Wait for clean L2 when the whole cluster is down. */
 		msleep(POLL_MSEC);
-		spin_lock_irq(&boot_lock);
+		raw_spin_lock_irq(&boot_lock);
 	}
 	if (tries >= count)
 		goto err;
@@ -231,10 +231,10 @@ static int hip04_cpu_kill(unsigned int l_cpu)
 		goto err;
 	if (hip04_cluster_is_down(cluster))
 		hip04_set_snoop_filter(cluster, 0);
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 	return 1;
 err:
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 	return 0;
 }
 #endif
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 69df3620eca5..7cc060865c92 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -69,7 +69,7 @@ static const struct omap_smp_config omap5_cfg __initconst = {
 	.startup_addr = omap5_secondary_startup,
 };
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void __iomem *omap4_get_scu_base(void)
 {
@@ -136,8 +136,8 @@ static void omap4_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -150,7 +150,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * Update the AuxCoreBoot0 with boot state for secondary core.
@@ -229,7 +229,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return 0;
 }
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 75ef5d4be554..c17c86e5d860 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -22,7 +22,7 @@
 
 static void __iomem *clk_base;
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void sirfsoc_secondary_init(unsigned int cpu)
 {
@@ -36,8 +36,8 @@ static void sirfsoc_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static const struct of_device_id clk_ids[]  = {
@@ -75,7 +75,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	/* make sure write buffer is drained */
 	mb();
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -107,7 +107,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 5494c9e0c909..e8ce157d3548 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -46,7 +46,7 @@
 
 extern void secondary_startup_arm(void);
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void qcom_cpu_die(unsigned int cpu)
@@ -60,8 +60,8 @@ static void qcom_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int scss_release_secondary(unsigned int cpu)
@@ -284,7 +284,7 @@ static int qcom_boot_secondary(unsigned int cpu, int (*func)(unsigned int))
 	 * set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
@@ -297,7 +297,7 @@ static int qcom_boot_secondary(unsigned int cpu, int (*func)(unsigned int))
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return ret;
 }
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index 39038a03836a..6da5c93872bf 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -32,7 +32,7 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
 
@@ -47,8 +47,8 @@ static void spear13xx_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -59,7 +59,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -84,7 +84,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 231f19e17436..a3419b7003e6 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -35,7 +35,7 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void sti_secondary_init(unsigned int cpu)
 {
@@ -48,8 +48,8 @@ static void sti_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -60,7 +60,7 @@ static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -91,7 +91,7 @@ static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index b4037b603897..8a6c872f52b5 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -367,7 +367,7 @@ static void sunxi_cluster_cache_disable_without_axi(void)
 static int sunxi_mc_smp_cpu_table[SUNXI_NR_CLUSTERS][SUNXI_CPUS_PER_CLUSTER];
 int sunxi_mc_smp_first_comer;
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static bool sunxi_mc_smp_cluster_is_down(unsigned int cluster)
 {
@@ -399,7 +399,7 @@ static int sunxi_mc_smp_boot_secondary(unsigned int l_cpu, struct task_struct *i
 	if (cluster >= SUNXI_NR_CLUSTERS || cpu >= SUNXI_CPUS_PER_CLUSTER)
 		return -EINVAL;
 
-	spin_lock_irq(&boot_lock);
+	raw_spin_lock_irq(&boot_lock);
 
 	if (sunxi_mc_smp_cpu_table[cluster][cpu])
 		goto out;
@@ -417,7 +417,7 @@ static int sunxi_mc_smp_boot_secondary(unsigned int l_cpu, struct task_struct *i
 
 out:
 	sunxi_mc_smp_cpu_table[cluster][cpu]++;
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 
 	return 0;
 }
@@ -448,13 +448,13 @@ static void sunxi_mc_smp_cpu_die(unsigned int l_cpu)
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	pr_debug("%s: cluster %u cpu %u\n", __func__, cluster, cpu);
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 	sunxi_mc_smp_cpu_table[cluster][cpu]--;
 	if (sunxi_mc_smp_cpu_table[cluster][cpu] == 1) {
 		/* A power_up request went ahead of us. */
 		pr_debug("%s: aborting due to a power up request\n",
 			 __func__);
-		spin_unlock(&boot_lock);
+		raw_spin_unlock(&boot_lock);
 		return;
 	} else if (sunxi_mc_smp_cpu_table[cluster][cpu] > 1) {
 		pr_err("Cluster %d CPU%d boots multiple times\n",
@@ -463,7 +463,7 @@ static void sunxi_mc_smp_cpu_die(unsigned int l_cpu)
 	}
 
 	last_man = sunxi_mc_smp_cluster_is_down(cluster);
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	gic_cpu_if_down(0);
 	if (last_man)
@@ -542,11 +542,11 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
 
 	/* wait for CPU core to die and enter WFI */
 	count = TIMEOUT_USEC / POLL_USEC;
-	spin_lock_irq(&boot_lock);
+	raw_spin_lock_irq(&boot_lock);
 	for (tries = 0; tries < count; tries++) {
-		spin_unlock_irq(&boot_lock);
+		raw_spin_unlock_irq(&boot_lock);
 		usleep_range(POLL_USEC / 2, POLL_USEC);
-		spin_lock_irq(&boot_lock);
+		raw_spin_lock_irq(&boot_lock);
 
 		/*
 		 * If the user turns off a bunch of cores@the same
@@ -593,7 +593,7 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
 	sunxi_cluster_powerdown(cluster);
 
 out:
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 	pr_debug("%s: cluster %u cpu %u powerdown: %d\n",
 		 __func__, cluster, cpu, ret);
 	return !ret;
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index c2366510187a..6b60f582b738 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -32,7 +32,7 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void versatile_secondary_init(unsigned int cpu)
 {
@@ -45,8 +45,8 @@ void versatile_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -57,7 +57,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * This is really belt and braces; we hold unintended secondary
@@ -87,7 +87,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
-- 
2.18.0
