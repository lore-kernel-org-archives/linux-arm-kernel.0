From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 31 May 2012 16:28:57 +0300
Subject: [PATCHv3 4/9] ARM: OMAP3: add manual control for mpu / core pwrdm
 usecounting
In-Reply-To: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
Message-ID: <1338470942-20185-5-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mpu / core powerdomain usecounts are now statically increased
by 1 during MPU activity. This allows the domains to reflect
actual usage, and will allow the usecount to reach 0 just before
all CPUs are ready to idle. Proper powerdomain usecounts are
propageted to voltagedomain level also, and will allow vc
callbacks to be triggered at right point of time.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c      |    3 ++
 arch/arm/mach-omap2/pm44xx.c      |    3 ++
 arch/arm/mach-omap2/powerdomain.c |   54 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |    3 ++
 4 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a34023d..b746fe0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -757,6 +757,9 @@ int __init omap3_pm_init(void)
 	omap_pm_suspend = omap3_pm_suspend;
 #endif
 
+	/* Notify pwrdm usecounters about active CPU */
+	pwrdm_cpu_wakeup();
+
 	arm_pm_idle = omap3_pm_idle;
 	omap3_idle_init();
 
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index ea24174..45eef2d 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -206,6 +206,9 @@ int __init omap4_pm_init(void)
 	omap_pm_suspend = omap4_pm_suspend;
 #endif
 
+	/* Notify pwrdm usecounters about active CPU */
+	pwrdm_cpu_wakeup();
+
 	/* Overwrite the default cpu_do_idle() */
 	arm_pm_idle = omap_default_idle;
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 317bea1..2a2237c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -47,6 +47,7 @@ enum {
 static LIST_HEAD(pwrdm_list);
 
 static struct pwrdm_ops *arch_pwrdm;
+static struct powerdomain *mpu_pwrdm, *core_pwrdm;
 
 /* Private functions */
 
@@ -1008,11 +1009,15 @@ void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
 int pwrdm_pre_transition(void)
 {
 	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
+	/* Decrease mpu / core usecounts to indicate we are entering idle */
+	pwrdm_cpu_idle();
 	return 0;
 }
 
 int pwrdm_post_transition(void)
 {
+	/* Increase mpu / core usecounts to indicate we are leaving idle */
+	pwrdm_cpu_wakeup();
 	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
 	return 0;
 }
@@ -1092,3 +1097,52 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
 
 	return 0;
 }
+
+static void pwrdm_get_idle_cycle_pwrdms(void)
+{
+	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
+	if (!mpu_pwrdm)
+		pr_err("%s: failed to get mpu_pwrdm\n", __func__);
+
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+	if (!core_pwrdm)
+		pr_err("%s: failed to get core_pwrdm\n", __func__);
+}
+
+/**
+ * pwrdm_cpu_wakeup - notify pwrdm usecounters about active CPU
+ *
+ * This function must be called just after a CPU has become active.
+ * Some powerdomains have static dependencies with MPU idle cycle,
+ * namely mpu_pwrdm and core_pwrdm. These powerdomains will get
+ * their usecounts increased / decreased each sleep cycle so that
+ * they reach 0 just before all CPUs have reached idle, and wake-up
+ * right after it. This allows the dependent voltage domains to
+ * follow idle cycle properly and trigger their callbacks for
+ * sleep / wakeup, which in turn will control e.g. auto retention
+ * feature.
+ */
+void pwrdm_cpu_wakeup(void)
+{
+	if (!mpu_pwrdm || !core_pwrdm)
+		pwrdm_get_idle_cycle_pwrdms();
+
+	pwrdm_clkdm_enable(mpu_pwrdm);
+	pwrdm_clkdm_enable(core_pwrdm);
+}
+
+/**
+ * pwrdm_cpu_idle - notify pwrdm usecounters about idling CPU
+ *
+ * This function must be called just before CPU is about to idle.
+ * Similar to pwrdm_cpu_wakeup, this is used to make sure the idle
+ * cycle dependent powerdomains follow the sleep cycle properly.
+ */
+void pwrdm_cpu_idle(void)
+{
+	if (!mpu_pwrdm || !core_pwrdm)
+		pwrdm_get_idle_cycle_pwrdms();
+
+	pwrdm_clkdm_disable(mpu_pwrdm);
+	pwrdm_clkdm_disable(core_pwrdm);
+}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 705b983..ecf7d3d 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -220,6 +220,9 @@ int pwrdm_post_transition(void);
 void pwrdm_clkdm_enable(struct powerdomain *pwrdm);
 void pwrdm_clkdm_disable(struct powerdomain *pwrdm);
 
+void pwrdm_cpu_wakeup(void);
+void pwrdm_cpu_idle(void);
+
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
-- 
1.7.4.1
