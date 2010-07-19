From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 19 Jul 2010 17:30:33 +0900
Subject: [PATCH 1/4] ARM: SAMSUNG SoC: Powerdomain/Block-gating Support
In-Reply-To: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
References: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279528236-6076-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even when all the clocks of a domain are turned off, turning off the
power for the domain saves (leakage) current. Thus, we need to control
powerdomain accordingly to save even more power when we do clock gating.

Block-gating is a similar feature with powerdomain, but, it controls
"block", which is smaller than power-domain, and the saved current is
not so significant.

This patch enables powerdomain/block-gating support for Samsung SoC.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/Kconfig              |   19 +++++++
 arch/arm/plat-samsung/clock.c              |   76 ++++++++++++++++++++++++++-
 arch/arm/plat-samsung/include/plat/clock.h |   32 ++++++++++++
 3 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index bd007e3..1fddb04 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -298,4 +298,23 @@ config SAMSUNG_WAKEMASK
 	  and above. This code allows a set of interrupt to wakeup-mask
 	  mappings. See <plat/wakeup-mask.h>
 
+config SAMSUNG_POWERDOMAIN
+	bool "Powerdomain Control Support"
+	depends on CPU_S5PV210
+	select S5PV210_POWERDOMAIN
+	help
+	  Compile support for powerdomain controls. This code allows
+	  enabling and diabling powerdomain according to its clocks,
+	  which often saves significant amount of power.
+
+config SAMSUNG_BLOCKGATING
+	bool "Block Gating Control Support"
+	depends on SAMSUNG_POWERDOMAIN && CPU_S5PV210
+	select S5PV210_BLOCKGATING
+	help
+	  Compile support for block gating controls. This code allows
+	  enabling and diabling blocks according to its clocks.
+	  However, at least in S5PV210, this is not as effective as
+	  powerdomain control.
+
 endif
diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 8bf79f3..f8a30f7 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -113,6 +113,10 @@ void clk_put(struct clk *clk)
 
 int clk_enable(struct clk *clk)
 {
+#if defined(CONFIG_SAMSUNG_BLOCKGATING) || defined(CONFIG_SAMSUNG_POWERDOMAIN)
+	struct clk *p;
+#endif
+
 	if (IS_ERR(clk) || clk == NULL)
 		return -EINVAL;
 
@@ -120,8 +124,38 @@ int clk_enable(struct clk *clk)
 
 	spin_lock(&clocks_lock);
 
-	if ((clk->usage++) == 0)
-		(clk->enable)(clk, 1);
+	if ((clk->usage++) == 0) {
+#ifdef CONFIG_SAMSUNG_BLOCKGATING
+		if (clk->bd && clk->bd->ref_count == 0) {
+			if (clk->bd->pd_set)
+				clk->bd->pd_set(clk->bd, 1);
+			clk->bd->ref_count++;
+		}
+#endif
+#ifdef CONFIG_SAMSUNG_POWERDOMAIN
+		if (clk->pd) {
+			if (clk->pd->ref_count == 0 &&
+					clk->pd->num_clks_boot_on <= 0) {
+				list_for_each_entry(p, &clk->pd->clocks,
+						powerdomain_list) {
+					if (p->enable)
+						p->enable(p, 1);
+				}
+
+				clk->pd->pd_set(clk->pd, 1);
+
+				list_for_each_entry(p, &clk->pd->clocks,
+						powerdomain_list) {
+					if (p->enable)
+						p->enable(p, 0);
+				}
+			}
+			clk->pd->ref_count++;
+		}
+#endif
+		if (clk->enable)
+			(clk->enable)(clk, 1);
+	}
 
 	spin_unlock(&clocks_lock);
 	return 0;
@@ -134,8 +168,29 @@ void clk_disable(struct clk *clk)
 
 	spin_lock(&clocks_lock);
 
-	if ((--clk->usage) == 0)
+	if ((--clk->usage) == 0) {
 		(clk->enable)(clk, 0);
+#ifdef CONFIG_SAMSUNG_POWERDOMAIN
+		if (clk->pd) {
+			if (clk->pd->ref_count == 1 &&
+					clk->pd->num_clks_boot_on <= 0 &&
+					clk->pd->pd_set)
+				clk->pd->pd_set(clk->pd, 0);
+			if (clk->pd->ref_count > 0)
+				clk->pd->ref_count--;
+		}
+#endif
+#ifdef CONFIG_SAMSUNG_BLOCKGATING
+		if (clk->bd) {
+			if (clk->bd->ref_count == 1 &&
+					clk->bd->num_clks_boot_on <= 0 &&
+					clk->bd->pd_set)
+				clk->bd->pd_set(clk->bd, 0);
+			if (clk->bd->ref_count > 0)
+				clk->bd->ref_count--;
+		}
+#endif
+	}
 
 	spin_unlock(&clocks_lock);
 	clk_disable(clk->parent);
@@ -327,6 +382,21 @@ int s3c24xx_register_clock(struct clk *clk)
 	list_add(&clk->list, &clocks);
 	spin_unlock(&clocks_lock);
 
+#ifdef CONFIG_SAMSUNG_POWERDOMAIN
+	if (clk->pd) {
+		spin_lock(&clocks_lock);
+		list_add(&clk->powerdomain_list, &clk->pd->clocks);
+		spin_unlock(&clocks_lock);
+	}
+#endif
+#ifdef CONFIG_SAMSUNG_BLOCKGATING
+	if (clk->bd) {
+		spin_lock(&clocks_lock);
+		list_add(&clk->blockgating_list, &clk->bd->clocks);
+		spin_unlock(&clocks_lock);
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 0fbcd0e..bf851e1 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -11,6 +11,30 @@
 
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_SAMSUNG_POWERDOMAIN
+struct register_save {
+	unsigned int		addr;
+	unsigned int		data;
+};
+
+struct powerdomain {
+	/* The number of clks that are never-disabled and "BOOT_ON" */
+	int			num_clks_boot_on;
+	struct list_head	clocks;
+
+	unsigned long	*pd_reg;
+	unsigned long	*pd_stable_reg;
+	unsigned long		pd_ctrlbit;
+	unsigned long		pd_stable_ctrlbit;
+	int			ref_count;
+
+	int			(*pd_set)(struct powerdomain *, int enable);
+	bool			normal_ff_saved;
+	struct register_save	*normal_ff;
+	unsigned int		num_normal_ff;
+};
+#endif
+
 struct clk;
 
 /**
@@ -47,6 +71,14 @@ struct clk {
 
 	struct clk_ops		*ops;
 	int		    (*enable)(struct clk *, int enable);
+#ifdef CONFIG_SAMSUNG_POWERDOMAIN
+	struct powerdomain	*pd;
+	struct list_head	powerdomain_list;
+#endif
+#ifdef CONFIG_SAMSUNG_BLOCKGATING
+	struct powerdomain	*bd;
+	struct list_head	blockgating_list;
+#endif
 };
 
 /* other clocks which may be registered by board support */
-- 
1.6.3.3
