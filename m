From: mturquette@linaro.org (Thomas Petazzoni)
Date: Wed, 23 Jul 2014 16:53:58 -0700
Subject: [PATCHv3 3/7] clk: mvebu: extend clk-cpu for dynamic frequency scaling
In-Reply-To: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140723235358.6419.26311@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+static int clk_cpu_on_set_rate(struct clk_hw *hwclk, unsigned long rate,
+                              unsigned long parent_rate)
+{
+       u32 reg;
+       unsigned long fabric_div, target_div, cur_rate;
+       struct cpu_clk *cpuclk = to_cpu_clk(hwclk);
+
+       /*
+        * PMU DFS registers are not mapped, Device Tree does not
+        * describes them. We cannot change the frequency dynamically.
+        */
+       if (!cpuclk->pmu_dfs)
+               return -ENODEV;
+
+       cur_rate = __clk_get_rate(hwclk->clk);
+
+       reg = readl(cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL2_OFFSET);
+       fabric_div = (reg >> SYS_CTRL_CLK_DIVIDER_CTRL2_NBCLK_RATIO_SHIFT) &
+               SYS_CTRL_CLK_DIVIDER_MASK;
+
+       /* Frequency is going up */
+       if (rate == 2 * cur_rate)
+               target_div = fabric_div / 2;
+       /* Frequency is going down */
+       else
+               target_div = fabric_div;
+
+       if (target_div == 0)
+               target_div = 1;
+
+       reg = readl(cpuclk->pmu_dfs);
+       reg &= ~(PMU_DFS_RATIO_MASK << PMU_DFS_RATIO_SHIFT);
+       reg |= (target_div << PMU_DFS_RATIO_SHIFT);
+       writel(reg, cpuclk->pmu_dfs);
+
+       reg = readl(cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET);
+       reg |= (SYS_CTRL_CLK_DIVIDER_CTRL_RESET_ALL <<
+               SYS_CTRL_CLK_DIVIDER_CTRL_RESET_SHIFT);
+       writel(reg, cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET);
+
+       return mvebu_pmsu_dfs_request(cpuclk->cpu);
+}
+
+static int clk_cpu_set_rate(struct clk_hw *hwclk, unsigned long rate,
+                           unsigned long parent_rate)
+{
+       if (__clk_is_enabled(hwclk->clk))
+               return clk_cpu_on_set_rate(hwclk, rate, parent_rate);
+       else
+               return clk_cpu_off_set_rate(hwclk, rate, parent_rate);

This is racy. You don't hold the clk_enable lock so it could be enable
between the conditional check and executing clk_cpu_on_set_rate.

How do you ensure that secondary CPU clocks are not enabled/disabled
when changing rates?

Regards,
Mike
