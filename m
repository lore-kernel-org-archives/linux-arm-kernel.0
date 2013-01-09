From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Wed, 09 Jan 2013 18:24:41 +0530
Subject: [PATCH 3/3] ARM: exynos5: Add clock save and restore
In-Reply-To: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
References: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <1357736081-19390-4-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After Suspend-Resume operation, it is observed that CLK_TOP_SRC3 register
gets modified if the G-Scaler/MFC devices are power gated.

The clock for G-Scaler gets set to XXTI which results in the device
running very slow.This issue also seen for MFC.

To solve above issue, the existing clock framework of exynos5 is used
to save and restore clocks while power gating instead of accessing
CLK_SRC_TOP3 register directly.The clock names are read from DT file.

Please refer below URL to know the background of this issue.
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14347.html.

Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c |  125 +++++++++++++++++++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 9f1351d..2f49de9 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -21,9 +21,14 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sched.h>
+#include <linux/clk.h>
+#include <linux/list.h>
 
 #include <mach/regs-pmu.h>
 #include <plat/devs.h>
+#include <plat/clock.h>
+#include <plat/clock-clksrc.h>
+
 
 /*
  * Exynos specific wrapper around the generic power domain
@@ -33,7 +38,69 @@ struct exynos_pm_domain {
 	char const *name;
 	bool is_off;
 	struct generic_pm_domain pd;
+	struct list_head list_pdclks;
+	struct list_head saved_list_pdclks;
+	int pd_clks;
+};
+
+struct exynos_pd_clk {
+	struct list_head node;
+	struct clk *clk;
 };
+static int exynos_pdclk_save(struct exynos_pm_domain *epd)
+{
+	struct exynos_pd_clk *pdclk;
+	struct exynos_pd_clk *saved_pdclk;
+
+	list_for_each_entry(pdclk, &epd->list_pdclks, node) {
+		if (pdclk) {
+			saved_pdclk = kzalloc(sizeof(struct exynos_pd_clk),
+					GFP_KERNEL);
+			if (!saved_pdclk) {
+				pr_err("%s: failed to allocate memory\n",
+					__func__);
+				return -ENOMEM;
+			}
+			saved_pdclk->clk = clk_get_parent(pdclk->clk);
+			if (IS_ERR(saved_pdclk->clk)) {
+				pr_err(" Cannot get parent for %s\n",
+							pdclk->clk->name);
+				return PTR_ERR(saved_pdclk->clk);
+			}
+			list_add_tail(&saved_pdclk->node,
+						&epd->saved_list_pdclks);
+		}
+	}
+	return 0;
+}
+
+static void exynos_pdclk_restore(struct exynos_pm_domain *epd)
+{
+	struct exynos_pd_clk *pdclk;
+	struct exynos_pd_clk *saved_pdclk;
+	struct list_head *p_clk;
+	struct list_head *p_saved_clk;
+	int ret;
+
+	p_saved_clk = epd->saved_list_pdclks.next;
+	p_clk = epd->list_pdclks.next;
+
+	for ( ; p_saved_clk != &epd->saved_list_pdclks &&
+		p_clk != &epd->list_pdclks;
+		p_clk = p_clk->next, p_saved_clk = p_saved_clk->next) {
+
+		saved_pdclk = list_entry(p_saved_clk,
+						struct exynos_pd_clk, node);
+		pdclk = list_entry(p_clk, struct exynos_pd_clk, node);
+		if (saved_pdclk && pdclk) {
+			ret = clk_set_parent(pdclk->clk, saved_pdclk->clk);
+			if (ret)
+				pr_err("Failed to set %s as parent of %s\n",
+				 saved_pdclk->clk->name, pdclk->clk->name);
+		}
+	}
+	return;
+}
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
@@ -45,6 +112,13 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 	base = pd->base;
 
+	if (!power_on) {
+		if (pd->pd_clks > 0)
+			if (exynos_pdclk_save(pd))
+				pr_err("Failed to save pdclks for %s\n",
+								domain->name);
+	}
+
 	pwr = power_on ? S5P_INT_LOCAL_PWR_EN : 0;
 	__raw_writel(pwr, base);
 
@@ -61,6 +135,11 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		cpu_relax();
 		usleep_range(80, 100);
 	}
+
+	if (!power_on) {
+		if (pd->pd_clks > 0)
+			exynos_pdclk_restore(pd);
+	}
 	return 0;
 }
 
@@ -157,10 +236,48 @@ static struct notifier_block platform_nb = {
 	.notifier_call = exynos_pm_notifier_call,
 };
 
+static int exynos_read_pdclk_from_dt(struct device_node *dev_node,
+						struct exynos_pm_domain *pd)
+{
+	int i = 0;
+	const char *clk_name;
+	struct exynos_pd_clk *pd_clk;
+	int err = 0;
+
+	INIT_LIST_HEAD(&pd->list_pdclks);
+	INIT_LIST_HEAD(&pd->saved_list_pdclks);
+
+	for (i = 0; i < pd->pd_clks; i++) {
+		pd_clk = kzalloc(sizeof(struct exynos_pd_clk),
+							GFP_KERNEL);
+		if (!pd_clk) {
+			pr_err("%s: failed to allocate memory\n",
+					__func__);
+			return -ENOMEM;
+		}
+		err = of_property_read_string_index(dev_node,
+				"samsung,exynos-pd-clks",
+				i,
+				&clk_name);
+		if (err) {
+			pr_err("failed to read pd_clks\n");
+			return err;
+		}
+		pd_clk->clk = clk_get(NULL, clk_name);
+		if (IS_ERR(pd_clk->clk)) {
+			pr_err("clk_get failed for %s\n", clk_name);
+			return PTR_ERR(pd_clk->clk);
+		}
+		list_add(&pd_clk->node, &pd->list_pdclks);
+	}
+	return 0;
+}
+
 static __init int exynos_pm_dt_parse_domains(void)
 {
 	struct platform_device *pdev;
 	struct device_node *np;
+	int err = 0;
 
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
@@ -182,6 +299,14 @@ static __init int exynos_pm_dt_parse_domains(void)
 		pd->pd.power_on = exynos_pd_power_on;
 		pd->pd.of_node = np;
 
+		pd->pd_clks = of_property_count_strings(np,
+						"samsung,exynos-pd-clks");
+		if (pd->pd_clks > 0) {
+			err = exynos_read_pdclk_from_dt(np, pd);
+			if (err)
+				return err;
+		}
+
 		platform_set_drvdata(pdev, pd);
 
 		on = __raw_readl(pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN;
-- 
1.7.5.4
