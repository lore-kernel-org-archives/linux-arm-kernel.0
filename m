From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 2 Jul 2016 17:30:11 -0300
Subject: [PATCH RFC 6/7] clk: imx: pllv3: convert to prepare_hw and
 set_rate_hw
In-Reply-To: <1467208335-29876-7-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
 <1467208335-29876-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5DnFevNf6tdJ62woC33Mv3cGgTYLkOq6OOz+3RxZJpnMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Wed, Jun 29, 2016 at 10:52 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

Thanks for working on this series.

Tested the whole series on a mx7d-sdb and it does fix the several clk
warnings that we currently have.

> +static int clk_pllv3_set_rate_done(struct clk_hw *hw)
> +{
> +       struct clk_pllv3 *pll = to_clk_pllv3(hw);
> +       u32 val = readl_relaxed(pll->base) & pll->powerdown;

I had to change this to:

--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -108,7 +108,7 @@ static long clk_pllv3_round_rate(struct clk_hw *hw, unsigned
 static int clk_pllv3_set_rate_done(struct clk_hw *hw)
 {
        struct clk_pllv3 *pll = to_clk_pllv3(hw);
-       u32 val = readl_relaxed(pll->base) & pll->powerdown;
+       u32 val = readl_relaxed(pll->base) & pll->power_bit;

,so that it can build against linux-next.
