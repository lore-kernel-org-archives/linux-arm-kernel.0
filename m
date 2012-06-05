From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Tue, 5 Jun 2012 09:59:35 +0530
Subject: [PATCH v3 1/9] ARM: tegra: add clk_prepare/clk_unprepare
In-Reply-To: <1338870583-8704-1-git-send-email-pgaikwad@nvidia.com>
References: <1338870583-8704-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1338870583-8704-2-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_prepare/clk_unprepare as required by the generic clk framework.

Tested on Ventana and Cardhu.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
Please ignore previous versions. Updated commit message and
maintainers properly in this version. No other change.

This patch should go through Tegra tree since other patches to port Tegra
to generic clock framework are dependent on it.

 arch/arm/mach-tegra/cpu-tegra.c |    6 +++---
 arch/arm/mach-tegra/dma.c       |    2 +-
 arch/arm/mach-tegra/pcie.c      |    6 +++---
 arch/arm/mach-tegra/powergate.c |    4 ++--
 arch/arm/mach-tegra/timer.c     |    4 ++--
 arch/arm/mach-tegra/usb_phy.c   |   16 ++++++++--------
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index 7a065f0..ceb52db 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -189,8 +189,8 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 		return PTR_ERR(emc_clk);
 	}
 
-	clk_enable(emc_clk);
-	clk_enable(cpu_clk);
+	clk_prepare_enable(emc_clk);
+	clk_prepare_enable(cpu_clk);
 
 	cpufreq_frequency_table_cpuinfo(policy, freq_table);
 	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
@@ -212,7 +212,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
 	cpufreq_frequency_table_cpuinfo(policy, freq_table);
-	clk_disable(emc_clk);
+	clk_disable_unprepare(emc_clk);
 	clk_put(emc_clk);
 	clk_put(cpu_clk);
 	return 0;
diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
index abea4f6..2698d7d 100644
--- a/arch/arm/mach-tegra/dma.c
+++ b/arch/arm/mach-tegra/dma.c
@@ -720,7 +720,7 @@ int __init tegra_dma_init(void)
 		ret = PTR_ERR(c);
 		goto fail;
 	}
-	ret = clk_enable(c);
+	ret = clk_prepare_enable(c);
 	if (ret != 0) {
 		pr_err("Unable to enable clock for APB DMA\n");
 		goto fail;
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 0e09137..d3ad515 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -723,9 +723,9 @@ static int tegra_pcie_power_regate(void)
 
 	tegra_pcie_xclk_clamp(false);
 
-	clk_enable(tegra_pcie.afi_clk);
-	clk_enable(tegra_pcie.pex_clk);
-	return clk_enable(tegra_pcie.pll_e);
+	clk_prepare_enable(tegra_pcie.afi_clk);
+	clk_prepare_enable(tegra_pcie.pex_clk);
+	return clk_prepare_enable(tegra_pcie.pll_e);
 }
 
 static int tegra_pcie_clocks_get(void)
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index f5b12fb..15d5065 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -146,7 +146,7 @@ int tegra_powergate_sequence_power_up(int id, struct clk *clk)
 	if (ret)
 		goto err_power;
 
-	ret = clk_enable(clk);
+	ret = clk_prepare_enable(clk);
 	if (ret)
 		goto err_clk;
 
@@ -162,7 +162,7 @@ int tegra_powergate_sequence_power_up(int id, struct clk *clk)
 	return 0;
 
 err_clamp:
-	clk_disable(clk);
+	clk_disable_unprepare(clk);
 err_clk:
 	tegra_powergate_power_off(id);
 err_power:
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 315672c..57b5bdc 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -189,7 +189,7 @@ static void __init tegra_init_timer(void)
 			" Assuming 12Mhz input clock.\n");
 		rate = 12000000;
 	} else {
-		clk_enable(clk);
+		clk_prepare_enable(clk);
 		rate = clk_get_rate(clk);
 	}
 
@@ -201,7 +201,7 @@ static void __init tegra_init_timer(void)
 	if (IS_ERR(clk))
 		pr_warn("Unable to get rtc-tegra clock\n");
 	else
-		clk_enable(clk);
+		clk_prepare_enable(clk);
 
 	switch (rate) {
 	case 12000000:
diff --git a/arch/arm/mach-tegra/usb_phy.c b/arch/arm/mach-tegra/usb_phy.c
index 54e353c..022b33a 100644
--- a/arch/arm/mach-tegra/usb_phy.c
+++ b/arch/arm/mach-tegra/usb_phy.c
@@ -247,7 +247,7 @@ static void utmip_pad_power_on(struct tegra_usb_phy *phy)
 	unsigned long val, flags;
 	void __iomem *base = phy->pad_regs;
 
-	clk_enable(phy->pad_clk);
+	clk_prepare_enable(phy->pad_clk);
 
 	spin_lock_irqsave(&utmip_pad_lock, flags);
 
@@ -259,7 +259,7 @@ static void utmip_pad_power_on(struct tegra_usb_phy *phy)
 
 	spin_unlock_irqrestore(&utmip_pad_lock, flags);
 
-	clk_disable(phy->pad_clk);
+	clk_disable_unprepare(phy->pad_clk);
 }
 
 static int utmip_pad_power_off(struct tegra_usb_phy *phy)
@@ -272,7 +272,7 @@ static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 		return -EINVAL;
 	}
 
-	clk_enable(phy->pad_clk);
+	clk_prepare_enable(phy->pad_clk);
 
 	spin_lock_irqsave(&utmip_pad_lock, flags);
 
@@ -284,7 +284,7 @@ static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 
 	spin_unlock_irqrestore(&utmip_pad_lock, flags);
 
-	clk_disable(phy->pad_clk);
+	clk_disable_unprepare(phy->pad_clk);
 
 	return 0;
 }
@@ -580,7 +580,7 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 	msleep(5);
 	gpio_direction_output(config->reset_gpio, 1);
 
-	clk_enable(phy->clk);
+	clk_prepare_enable(phy->clk);
 	msleep(1);
 
 	val = readl(base + USB_SUSP_CTRL);
@@ -689,7 +689,7 @@ struct tegra_usb_phy *tegra_usb_phy_open(struct device *dev, int instance,
 		err = PTR_ERR(phy->pll_u);
 		goto err0;
 	}
-	clk_enable(phy->pll_u);
+	clk_prepare_enable(phy->pll_u);
 
 	parent_rate = clk_get_rate(clk_get_parent(phy->pll_u));
 	for (i = 0; i < ARRAY_SIZE(tegra_freq_table); i++) {
@@ -735,7 +735,7 @@ struct tegra_usb_phy *tegra_usb_phy_open(struct device *dev, int instance,
 	return phy;
 
 err1:
-	clk_disable(phy->pll_u);
+	clk_disable_unprepare(phy->pll_u);
 	clk_put(phy->pll_u);
 err0:
 	kfree(phy);
@@ -810,7 +810,7 @@ void tegra_usb_phy_close(struct tegra_usb_phy *phy)
 		clk_put(phy->clk);
 	else
 		utmip_pad_close(phy);
-	clk_disable(phy->pll_u);
+	clk_disable_unprepare(phy->pll_u);
 	clk_put(phy->pll_u);
 	kfree(phy);
 }
-- 
1.7.4.1
