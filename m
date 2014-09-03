From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Sep 2014 10:37:53 -0700
Subject: [PATCH resend 1/4] clk: hix5hd2: add complex clk
In-Reply-To: <1409031970-4821-2-git-send-email-zhangfei.gao@linaro.org>
References: <1409031970-4821-1-git-send-email-zhangfei.gao@linaro.org>
 <1409031970-4821-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140903173753.11368.10916@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Zhangfei Gao (2014-08-25 22:46:07)
> +static int clk_ether_enable(struct clk_hw *hw)
> +{
> +       struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(clk->ctrl_reg);
> +       val |= clk->ctrl_clk_mask | clk->ctrl_rst_mask;
> +       writel_relaxed(val, clk->ctrl_reg);
> +       val &= ~(clk->ctrl_rst_mask);
> +       writel_relaxed(val, clk->ctrl_reg);
> +
> +       val = readl_relaxed(clk->phy_reg);
> +       val |= clk->phy_clk_mask;
> +       val &= ~(clk->phy_rst_mask);
> +       writel_relaxed(val, clk->phy_reg);
> +       mdelay(10);
> +
> +       val &= ~(clk->phy_clk_mask);
> +       val |= clk->phy_rst_mask;
> +       writel_relaxed(val, clk->phy_reg);
> +       mdelay(10);
> +
> +       val |= clk->phy_clk_mask;
> +       val &= ~(clk->phy_rst_mask);
> +       writel_relaxed(val, clk->phy_reg);
> +       mdelay(30);

With all of these mdelays, I wonder if you should use .prepare and
.unprepare instead? Does the Ethernet driver call clk_{en|dis}able from
interrupt context?

> +       return 0;
> +}
> +
> +static void clk_ether_disable(struct clk_hw *hw)
> +{
> +       struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(clk->ctrl_reg);
> +       val &= ~(clk->ctrl_clk_mask);
> +       writel_relaxed(val, clk->ctrl_reg);
> +}
> +
> +static struct clk_ops clk_ether_ops = {
> +       .enable = clk_ether_enable,
> +       .disable = clk_ether_disable,
> +};
> +
> +static int clk_complex_enable(struct clk_hw *hw)
> +{
> +       struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(clk->ctrl_reg);
> +       val |= clk->ctrl_clk_mask;
> +       val &= ~(clk->ctrl_rst_mask);
> +       writel_relaxed(val, clk->ctrl_reg);
> +
> +       val = readl_relaxed(clk->phy_reg);
> +       val |= clk->phy_clk_mask;
> +       val &= ~(clk->phy_rst_mask);
> +       writel_relaxed(val, clk->phy_reg);
> +
> +       return 0;
> +}
> +
> +static void clk_complex_disable(struct clk_hw *hw)
> +{
> +       struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(clk->ctrl_reg);
> +       val |= clk->ctrl_rst_mask;
> +       val &= ~(clk->ctrl_clk_mask);
> +       writel_relaxed(val, clk->ctrl_reg);
> +
> +       val = readl_relaxed(clk->phy_reg);
> +       val |= clk->phy_rst_mask;
> +       val &= ~(clk->phy_clk_mask);
> +       writel_relaxed(val, clk->phy_reg);
> +}
> +
> +static struct clk_ops clk_complex_ops = {
> +       .enable = clk_complex_enable,
> +       .disable = clk_complex_disable,
> +};

These enable/disable callbacks look good, with no delays.

Regards,
Mike
