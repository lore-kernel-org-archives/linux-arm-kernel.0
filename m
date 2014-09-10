From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 10 Sep 2014 09:52:11 -0700
Subject: [PATCH resend 1/4] clk: hix5hd2: add complex clk
In-Reply-To: <CABHwWpQRj1YepkszoiiH0_vAp_-mS8qSwrEiLNkRoKvUUt7uxg@mail.gmail.com>
References: <1409031970-4821-1-git-send-email-zhangfei.gao@linaro.org>
 <1409031970-4821-2-git-send-email-zhangfei.gao@linaro.org>
 <20140903173753.11368.10916@quantum>
 <CABHwWpQRj1YepkszoiiH0_vAp_-mS8qSwrEiLNkRoKvUUt7uxg@mail.gmail.com>
Message-ID: <20140910165211.19023.39726@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting ??? (2014-09-04 23:37:25)
> 
> 
> 2014-09-04 1:37 GMT+08:00 Mike Turquette <mturquette@linaro.org>:
> 
>     Quoting Zhangfei Gao (2014-08-25 22:46:07)
>     > +static int clk_ether_enable(struct clk_hw *hw)
>     > +{
>     > +? ? ? ?struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
>     > +? ? ? ?u32 val;
>     > +
>     > +? ? ? ?val = readl_relaxed(clk->ctrl_reg);
>     > +? ? ? ?val |= clk->ctrl_clk_mask | clk->ctrl_rst_mask;
>     > +? ? ? ?writel_relaxed(val, clk->ctrl_reg);
>     > +? ? ? ?val &= ~(clk->ctrl_rst_mask);
>     > +? ? ? ?writel_relaxed(val, clk->ctrl_reg);
>     > +
>     > +? ? ? ?val = readl_relaxed(clk->phy_reg);
>     > +? ? ? ?val |= clk->phy_clk_mask;
>     > +? ? ? ?val &= ~(clk->phy_rst_mask);
>     > +? ? ? ?writel_relaxed(val, clk->phy_reg);
>     > +? ? ? ?mdelay(10);
>     > +
>     > +? ? ? ?val &= ~(clk->phy_clk_mask);
>     > +? ? ? ?val |= clk->phy_rst_mask;
>     > +? ? ? ?writel_relaxed(val, clk->phy_reg);
>     > +? ? ? ?mdelay(10);
>     > +
>     > +? ? ? ?val |= clk->phy_clk_mask;
>     > +? ? ? ?val &= ~(clk->phy_rst_mask);
>     > +? ? ? ?writel_relaxed(val, clk->phy_reg);
>     > +? ? ? ?mdelay(30);
> 
>     With all of these mdelays, I wonder if you should use .prepare and
>     .unprepare instead? Does the Ethernet driver call clk_{en|dis}able from
>     interrupt context?
> 
> ?
> Thank you for the advise.
> 
> In hix5hd2 soc, these mdelays are necessary for resetting the Ethernet ?phy
> device. The hardware need some time to be stable.It's difficult to use .prepare
> and .unprepare instead, because they are embeded in several places among the
> whole sequence. Even though some code segment could be put into ?the .prepare
> callback, mdelays should still be reserved. So we hope to keep this manner if
> it's ok.

OK. I wonder if you should be using the reset controller framework to control the
reset of your phy? Some clock drivers are also reset drivers since bits
for controlling that stuff are often combined in the same register
space. As an example, take a look at:

drivers/clk/qcom/gcc-apq8084.c

> 
> The Ethernet driver won't call clk_enable and clk_disable from interrupt
> context.

Good to know. clk_enable and clk_disable are designed to be called
safely from interrupt context. clk_prepare and clk_unprepare often
enable/disable a clock, but are designed for use in a regular process
context (e.g. we might sleep or schedule). So depending on how long it
takes you to enable/disable your Ethernet clock you might want to
migrate to those callbacks instead.

Regards,
Mike

> 
>     ?
> 
>     > +? ? ? ?return 0;
>     > +}
>     > +
>     > +static void clk_ether_disable(struct clk_hw *hw)
>     > +{
>     > +? ? ? ?struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
>     > +? ? ? ?u32 val;
>     > +
>     > +? ? ? ?val = readl_relaxed(clk->ctrl_reg);
>     > +? ? ? ?val &= ~(clk->ctrl_clk_mask);
>     > +? ? ? ?writel_relaxed(val, clk->ctrl_reg);
>     > +}
>     > +
>     > +static struct clk_ops clk_ether_ops = {
>     > +? ? ? ?.enable = clk_ether_enable,
>     > +? ? ? ?.disable = clk_ether_disable,
>     > +};
>     > +
>     > +static int clk_complex_enable(struct clk_hw *hw)
>     > +{
>     > +? ? ? ?struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
>     > +? ? ? ?u32 val;
>     > +
>     > +? ? ? ?val = readl_relaxed(clk->ctrl_reg);
>     > +? ? ? ?val |= clk->ctrl_clk_mask;
>     > +? ? ? ?val &= ~(clk->ctrl_rst_mask);
>     > +? ? ? ?writel_relaxed(val, clk->ctrl_reg);
>     > +
>     > +? ? ? ?val = readl_relaxed(clk->phy_reg);
>     > +? ? ? ?val |= clk->phy_clk_mask;
>     > +? ? ? ?val &= ~(clk->phy_rst_mask);
>     > +? ? ? ?writel_relaxed(val, clk->phy_reg);
>     > +
>     > +? ? ? ?return 0;
>     > +}
>     > +
>     > +static void clk_complex_disable(struct clk_hw *hw)
>     > +{
>     > +? ? ? ?struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
>     > +? ? ? ?u32 val;
>     > +
>     > +? ? ? ?val = readl_relaxed(clk->ctrl_reg);
>     > +? ? ? ?val |= clk->ctrl_rst_mask;
>     > +? ? ? ?val &= ~(clk->ctrl_clk_mask);
>     > +? ? ? ?writel_relaxed(val, clk->ctrl_reg);
>     > +
>     > +? ? ? ?val = readl_relaxed(clk->phy_reg);
>     > +? ? ? ?val |= clk->phy_rst_mask;
>     > +? ? ? ?val &= ~(clk->phy_clk_mask);
>     > +? ? ? ?writel_relaxed(val, clk->phy_reg);
>     > +}
>     > +
>     > +static struct clk_ops clk_complex_ops = {
>     > +? ? ? ?.enable = clk_complex_enable,
>     > +? ? ? ?.disable = clk_complex_disable,
>     > +};
> 
>     These enable/disable callbacks look good, with no delays.
> 
>     Regards,
>     Mike
> 
> 
