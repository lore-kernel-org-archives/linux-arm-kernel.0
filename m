From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:54 -0800
Subject: [PATCH 12/35] davinci: clock framework: remove spinlock usage
In-Reply-To: <1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Currently, the spinlock in DaVinci clock framework is being
used to:

1) Protect clock structure variables usecount and rate against
concurrent modification.

2) Protect against simultaneous PSC enables/disables ie.
serialize davinci_psc_config().

3) Serialize clk_set_rate():
	i.	Prevent simultaneous setting of clock rates
	ii.	Ensure clock list remains sane during rate
		propagation (also in clk_set_parent).

Remove the spinlock usage in clock framework by:

1) Making clock rate and usecount as atomic variables.

2) Making davinci_psc_config() protect itself instead of
relying on serialization by caller.

3) (i) Allowing the clk->set_rate to serialize itself. There
should be no need to serialize all clock rate settings.
Currently the only user of rate setting is cpufreq driver on
DA850. cpufreq naturally serializes the calls to set CPU rate.
Also, there appears no need to lock IRQs during CPU rate
transtitions. If required, IRQs can be locked in the actual
set_rate function.

3) (ii) Use the mutex already in place for serialzing clock list
manipulation for serializing clock rate propagation as well.

Apart from the general benefit of reducing locking granurlarity,
the main motivation behind this change is to enable usage of
clock framework for off-chip clock synthesizers. One such
synthesizer, CDCE949, is present on DM6467 EVM. Access to the
synthesizer happens through I2C bus - accessing which can lead to
CPU sleep. Having IRQs locked in clk_set_rate prevents the
clk->set_rate function from sleeping.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c |    4 +-
 arch/arm/mach-davinci/clock.c            |   74 ++++++++++++-----------------
 arch/arm/mach-davinci/clock.h            |    4 +-
 arch/arm/mach-davinci/da830.c            |    2 +-
 arch/arm/mach-davinci/da850.c            |    4 +-
 arch/arm/mach-davinci/dm355.c            |    4 +-
 arch/arm/mach-davinci/dm365.c            |    4 +-
 arch/arm/mach-davinci/dm644x.c           |    8 ++--
 arch/arm/mach-davinci/dm646x.c           |    8 ++--
 arch/arm/mach-davinci/psc.c              |    6 ++
 10 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 542bfdb..6ff3411 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -722,9 +722,9 @@ static __init void davinci_dm646x_evm_irq_init(void)
 void __init dm646x_board_setup_refclk(struct clk *clk)
 {
 	if (machine_is_davinci_dm6467tevm())
-		clk->rate = DM6467T_EVM_REF_FREQ;
+		atomic_set(&clk->rate, DM6467T_EVM_REF_FREQ);
 	else
-		clk->rate = DM646X_EVM_REF_FREQ;
+		atomic_set(&clk->rate, DM646X_EVM_REF_FREQ);
 }
 
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 0fa68c5..46c95e0 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -28,7 +28,6 @@
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
-static DEFINE_SPINLOCK(clockfw_lock);
 
 static unsigned psc_domain(struct clk *clk)
 {
@@ -41,15 +40,16 @@ static void __clk_enable(struct clk *clk)
 {
 	if (clk->parent)
 		__clk_enable(clk->parent);
-	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
+	if (atomic_read(&clk->usecount) == 0 && (clk->flags & CLK_PSC))
 		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc, 1);
+	atomic_inc(&clk->usecount);
 }
 
 static void __clk_disable(struct clk *clk)
 {
-	if (WARN_ON(clk->usecount == 0))
+	if (WARN_ON(atomic_read(&clk->usecount) == 0))
 		return;
-	if (--clk->usecount == 0 && !(clk->flags & CLK_PLL))
+	if (atomic_dec_and_test(&clk->usecount) && !(clk->flags & CLK_PLL))
 		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc, 0);
 	if (clk->parent)
 		__clk_disable(clk->parent);
@@ -57,14 +57,10 @@ static void __clk_disable(struct clk *clk)
 
 int clk_enable(struct clk *clk)
 {
-	unsigned long flags;
-
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
 
-	spin_lock_irqsave(&clockfw_lock, flags);
 	__clk_enable(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return 0;
 }
@@ -72,14 +68,10 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
-	unsigned long flags;
-
 	if (clk == NULL || IS_ERR(clk))
 		return;
 
-	spin_lock_irqsave(&clockfw_lock, flags);
 	__clk_disable(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
 
@@ -88,7 +80,7 @@ unsigned long clk_get_rate(struct clk *clk)
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
 
-	return clk->rate;
+	return atomic_read(&clk->rate);
 }
 EXPORT_SYMBOL(clk_get_rate);
 
@@ -100,7 +92,7 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 	if (clk->round_rate)
 		return clk->round_rate(clk, rate);
 
-	return clk->rate;
+	return atomic_read(&clk->rate);
 }
 EXPORT_SYMBOL(clk_round_rate);
 
@@ -111,28 +103,27 @@ static void propagate_rate(struct clk *root)
 
 	list_for_each_entry(clk, &root->children, childnode) {
 		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
+			atomic_set(&clk->rate, clk->recalc(clk));
 		propagate_rate(clk);
 	}
 }
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	unsigned long flags;
 	int ret = -EINVAL;
 
 	if (clk == NULL || IS_ERR(clk))
 		return ret;
 
-	spin_lock_irqsave(&clockfw_lock, flags);
 	if (clk->set_rate)
 		ret = clk->set_rate(clk, rate);
 	if (ret == 0) {
 		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
+			atomic_set(&clk->rate, clk->recalc(clk));
+		mutex_lock(&clocks_mutex);
 		propagate_rate(clk);
+		mutex_unlock(&clocks_mutex);
 	}
-	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
 }
@@ -140,26 +131,22 @@ EXPORT_SYMBOL(clk_set_rate);
 
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
-	unsigned long flags;
-
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
 
 	/* Cannot change parent on enabled clock */
-	if (WARN_ON(clk->usecount))
+	if (WARN_ON(atomic_read(&clk->usecount)))
 		return -EINVAL;
 
 	mutex_lock(&clocks_mutex);
 	clk->parent = parent;
 	list_del_init(&clk->childnode);
 	list_add(&clk->childnode, &clk->parent->children);
-	mutex_unlock(&clocks_mutex);
 
-	spin_lock_irqsave(&clockfw_lock, flags);
 	if (clk->recalc)
-		clk->rate = clk->recalc(clk);
+		atomic_set(&clk->rate, clk->recalc(clk));
 	propagate_rate(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
+	mutex_unlock(&clocks_mutex);
 
 	return 0;
 }
@@ -170,7 +157,7 @@ int clk_register(struct clk *clk)
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
 
-	if (WARN(clk->parent && !clk->parent->rate,
+	if (WARN(clk->parent && !atomic_read(&clk->parent->rate),
 			"CLK: %s parent %s has no rate!\n",
 			clk->name, clk->parent->name))
 		return -EINVAL;
@@ -184,16 +171,16 @@ int clk_register(struct clk *clk)
 	mutex_unlock(&clocks_mutex);
 
 	/* If rate is already set, use it */
-	if (clk->rate)
+	if (atomic_read(&clk->rate))
 		return 0;
 
 	/* Else, see if there is a way to calculate it */
 	if (clk->recalc)
-		clk->rate = clk->recalc(clk);
+		atomic_set(&clk->rate, clk->recalc(clk));
 
 	/* Otherwise, default to parent rate */
 	else if (clk->parent)
-		clk->rate = clk->parent->rate;
+		atomic_set(&clk->rate, atomic_read(&clk->parent->rate));
 
 	return 0;
 }
@@ -219,9 +206,9 @@ static int __init clk_disable_unused(void)
 {
 	struct clk *ck;
 
-	spin_lock_irq(&clockfw_lock);
+	mutex_lock(&clocks_mutex);
 	list_for_each_entry(ck, &clocks, node) {
-		if (ck->usecount > 0)
+		if (atomic_read(&ck->usecount) > 0)
 			continue;
 		if (!(ck->flags & CLK_PSC))
 			continue;
@@ -233,7 +220,7 @@ static int __init clk_disable_unused(void)
 		pr_info("Clocks: disable unused %s\n", ck->name);
 		davinci_psc_config(psc_domain(ck), ck->gpsc, ck->lpsc, 0);
 	}
-	spin_unlock_irq(&clockfw_lock);
+	mutex_unlock(&clocks_mutex);
 
 	return 0;
 }
@@ -244,7 +231,7 @@ static unsigned long clk_sysclk_recalc(struct clk *clk)
 {
 	u32 v, plldiv;
 	struct pll_data *pll;
-	unsigned long rate = clk->rate;
+	unsigned long rate = atomic_read(&clk->rate);
 
 	/* If this is the PLL base clock, no more calculations needed */
 	if (clk->pll_data)
@@ -253,7 +240,7 @@ static unsigned long clk_sysclk_recalc(struct clk *clk)
 	if (WARN_ON(!clk->parent))
 		return rate;
 
-	rate = clk->parent->rate;
+	rate = atomic_read(&clk->parent->rate);
 
 	/* Otherwise, the parent must be a PLL */
 	if (WARN_ON(!clk->parent->pll_data))
@@ -281,9 +268,9 @@ static unsigned long clk_sysclk_recalc(struct clk *clk)
 static unsigned long clk_leafclk_recalc(struct clk *clk)
 {
 	if (WARN_ON(!clk->parent))
-		return clk->rate;
+		return atomic_read(&clk->rate);
 
-	return clk->parent->rate;
+	return atomic_read(&clk->parent->rate);
 }
 
 static unsigned long clk_pllclk_recalc(struct clk *clk)
@@ -291,11 +278,11 @@ static unsigned long clk_pllclk_recalc(struct clk *clk)
 	u32 ctrl, mult = 1, prediv = 1, postdiv = 1;
 	u8 bypass;
 	struct pll_data *pll = clk->pll_data;
-	unsigned long rate = clk->rate;
+	unsigned long rate = atomic_read(&clk->rate);
 
 	pll->base = IO_ADDRESS(pll->phys_base);
 	ctrl = __raw_readl(pll->base + PLLCTL);
-	rate = pll->input_rate = clk->parent->rate;
+	rate = pll->input_rate = atomic_read(&clk->parent->rate);
 
 	if (ctrl & PLLCTL_PLLEN) {
 		bypass = 0;
@@ -333,8 +320,8 @@ static unsigned long clk_pllclk_recalc(struct clk *clk)
 		rate /= postdiv;
 	}
 
-	pr_debug("PLL%d: input = %lu MHz [ ",
-		 pll->num, clk->parent->rate / 1000000);
+	pr_debug("PLL%d: input = %u MHz [ ",
+		 pll->num, atomic_read(&clk->parent->rate) / 1000000);
 	if (bypass)
 		pr_debug("bypass ");
 	if (prediv > 1)
@@ -443,7 +430,7 @@ int __init davinci_clk_init(struct davinci_clk *clocks)
 		}
 
 		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
+			atomic_set(&clk->rate, clk->recalc(clk));
 
 		if (clk->lpsc)
 			clk->flags |= CLK_PSC;
@@ -505,7 +492,8 @@ dump_clock(struct seq_file *s, unsigned nest, struct clk *parent)
 			min(i, (unsigned)(sizeof(buf) - 1 - nest)));
 
 	seq_printf(s, "%s users=%2d %-3s %9ld Hz\n",
-		   buf, parent->usecount, state, clk_get_rate(parent));
+			buf, atomic_read(&parent->usecount), state,
+			clk_get_rate(parent));
 	/* REVISIT show device associations too */
 
 	/* cost is now small, but not linear... */
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 31fb6ea..fa3e373 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -84,8 +84,8 @@ struct clk {
 	struct list_head	node;
 	struct module		*owner;
 	const char		*name;
-	unsigned long		rate;
-	u8			usecount;
+	atomic_t		rate;
+	atomic_t		usecount;
 	u8			lpsc;
 	u8			gpsc;
 	u32			flags;
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 5479605..7a7895d 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -43,7 +43,7 @@ static struct pll_data pll0_data = {
 
 static struct clk ref_clk = {
 	.name		= "ref_clk",
-	.rate		= DA830_REF_FREQ,
+	.rate		= ATOMIC_INIT(DA830_REF_FREQ),
 };
 
 static struct clk pll0_clk = {
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 1ac8f63..5c6dd97 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -55,7 +55,7 @@ static struct pll_data pll0_data = {
 
 static struct clk ref_clk = {
 	.name		= "ref_clk",
-	.rate		= DA850_REF_FREQ,
+	.rate		= ATOMIC_INIT(DA850_REF_FREQ),
 };
 
 static struct clk pll0_clk = {
@@ -1025,7 +1025,7 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long armrate)
 
 static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
-	return clk->rate;
+	return atomic_read(&clk->rate);
 }
 #endif
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index dedf4d4..2244e8c 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -55,7 +55,7 @@ static struct pll_data pll2_data = {
 static struct clk ref_clk = {
 	.name = "ref_clk",
 	/* FIXME -- crystal rate is board-specific */
-	.rate = DM355_REF_FREQ,
+	.rate = ATOMIC_INIT(DM355_REF_FREQ),
 };
 
 static struct clk pll1_clk = {
@@ -314,7 +314,7 @@ static struct clk timer2_clk = {
 	.name = "timer2",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_TIMER2,
-	.usecount = 1,              /* REVISIT: why cant' this be disabled? */
+	.usecount = ATOMIC_INIT(1), /* REVISIT: why cant' this be disabled? */
 };
 
 static struct clk timer3_clk = {
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2ec619e..cc3bae4 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -52,7 +52,7 @@ static struct pll_data pll2_data = {
 
 static struct clk ref_clk = {
 	.name		= "ref_clk",
-	.rate		= DM365_REF_FREQ,
+	.rate		= ATOMIC_INIT(DM365_REF_FREQ),
 };
 
 static struct clk pll1_clk = {
@@ -358,7 +358,7 @@ static struct clk timer2_clk = {
 	.name		= "timer2",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_TIMER2,
-	.usecount	= 1,
+	.usecount	= ATOMIC_INIT(1),
 };
 
 static struct clk timer3_clk = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 2cd0081..e65e29e 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -47,7 +47,7 @@ static struct pll_data pll2_data = {
 
 static struct clk ref_clk = {
 	.name = "ref_clk",
-	.rate = DM644X_REF_FREQ,
+	.rate = ATOMIC_INIT(DM644X_REF_FREQ),
 };
 
 static struct clk pll1_clk = {
@@ -131,7 +131,7 @@ static struct clk dsp_clk = {
 	.parent = &pll1_sysclk1,
 	.lpsc = DAVINCI_LPSC_GEM,
 	.flags = PSC_DSP,
-	.usecount = 1,			/* REVISIT how to disable? */
+	.usecount = ATOMIC_INIT(1),	/* REVISIT how to disable? */
 };
 
 static struct clk arm_clk = {
@@ -146,7 +146,7 @@ static struct clk vicp_clk = {
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_IMCOP,
 	.flags = PSC_DSP,
-	.usecount = 1,			/* REVISIT how to disable? */
+	.usecount = ATOMIC_INIT(1),	/* REVISIT how to disable? */
 };
 
 static struct clk vpss_master_clk = {
@@ -274,7 +274,7 @@ static struct clk timer2_clk = {
 	.name = "timer2",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_TIMER2,
-	.usecount = 1,              /* REVISIT: why cant' this be disabled? */
+	.usecount = ATOMIC_INIT(1), /* REVISIT: why cant' this be disabled? */
 };
 
 struct davinci_clk dm644x_clks[] = {
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 515d3ed..6f80616 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -60,7 +60,7 @@ static struct clk ref_clk = {
 
 static struct clk aux_clkin = {
 	.name = "aux_clkin",
-	.rate = DM646X_AUX_FREQ,
+	.rate = ATOMIC_INIT(DM646X_AUX_FREQ),
 };
 
 static struct clk pll1_clk = {
@@ -158,7 +158,7 @@ static struct clk dsp_clk = {
 	.parent = &pll1_sysclk1,
 	.lpsc = DM646X_LPSC_C64X_CPU,
 	.flags = PSC_DSP,
-	.usecount = 1,			/* REVISIT how to disable? */
+	.usecount = ATOMIC_INIT(1),		/* REVISIT how to disable? */
 };
 
 static struct clk arm_clk = {
@@ -262,14 +262,14 @@ static struct clk pwm0_clk = {
 	.name = "pwm0",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_PWM0,
-	.usecount = 1,            /* REVIST: disabling hangs system */
+	.usecount = ATOMIC_INIT(1),	/* REVIST: disabling hangs system */
 };
 
 static struct clk pwm1_clk = {
 	.name = "pwm1",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_PWM1,
-	.usecount = 1,            /* REVIST: disabling hangs system */
+	.usecount = ATOMIC_INIT(1),	/* REVIST: disabling hangs system */
 };
 
 static struct clk timer0_clk = {
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index adf6b5c..06130df 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
 
 #include <mach/cputype.h>
 #include <mach/psc.h>
@@ -53,6 +54,9 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 	void __iomem *psc_base;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	u32 next_state = enable ? 0x3 : 0x2; /* 0x3 enables, 0x2 disables */
+	/* Protect against simultaneous enable/disable of PSCs */
+	DEFINE_SPINLOCK(lock);
+	unsigned long flags;
 
 	if (!soc_info->psc_bases || (ctlr >= soc_info->psc_bases_num)) {
 		pr_warning("PSC: Bad psc data: 0x%x[%d]\n",
@@ -62,6 +66,7 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 
 	psc_base = soc_info->psc_bases[ctlr];
 
+	spin_lock_irqsave(&lock, flags);
 	mdctl = __raw_readl(psc_base + MDCTL + 4 * id);
 	mdctl &= ~MDSTAT_STATE_MASK;
 	mdctl |= next_state;
@@ -100,4 +105,5 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 	do {
 		mdstat = __raw_readl(psc_base + MDSTAT + 4 * id);
 	} while (!((mdstat & MDSTAT_STATE_MASK) == next_state));
+	spin_unlock_irqrestore(&lock, flags);
 }
-- 
1.6.6.rc2.1.g42108
