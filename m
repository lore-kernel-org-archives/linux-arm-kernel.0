From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 31 Aug 2018 10:34:22 -0700
Subject: [PATCH v3 5/5] clk: RK808: add RK809 and RK817 support.
In-Reply-To: <1535081762-20844-1-git-send-email-tony.xie@rock-chips.com>
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081762-20844-1-git-send-email-tony.xie@rock-chips.com>
Message-ID: <153573686206.93865.11806745452503167124@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tony Xie (2018-08-23 20:36:02)
> diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
> index 6461f28..c5d3492 100644
> --- a/drivers/clk/clk-rk808.c
> +++ b/drivers/clk/clk-rk808.c
> @@ -96,6 +96,66 @@ static int rk808_clkout2_is_prepared(struct clk_hw *hw)
> +
> +static int rk817_clkout2_is_prepared(struct clk_hw *hw)
> +{
> +       struct rk808_clkout *rk808_clkout = container_of(hw,
> +                                                        struct rk808_clkout,
> +                                                        clkout2_hw);
> +       struct rk808 *rk808 = rk808_clkout->rk808;
> +       unsigned int val;
> +
> +       int ret = regmap_read(rk808->regmap, RK817_SYS_CFG(1), &val);
> +
> +       if (ret < 0)
> +               return ret;

The clk core handles the return value here as true or false. Probably
should return 0 here.

> +
> +       return (val & RK817_CLK32KOUT2_EN) ? 1 : 0;
> +}
> +
> +static const struct clk_ops rk817_clkout2_ops = {
> +       .prepare = rk817_clkout2_prepare,
> +       .unprepare = rk817_clkout2_unprepare,
> +       .is_prepared = rk817_clkout2_is_prepared,
> +       .recalc_rate = rk808_clkout_recalc_rate,
> +};
> +
> +static const struct clk_ops *rkpmic_get_ops(long variant)

Use the enum here for 'variant'? Then the case statement here will
complain loudly for unhandled cases.

> +{
> +       switch (variant) {
> +       case RK809_ID:
> +       case RK817_ID:
> +               return &rk817_clkout2_ops;
> +       case RK805_ID:
> +       case RK808_ID:
> +       case RK818_ID:
> +               return &rk808_clkout2_ops;
> +       }
> +
> +       return &rk808_clkout2_ops;
> +}
> +
>  static int rk808_clkout_probe(struct platform_device *pdev)
>  {
>         struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
> @@ -127,7 +187,7 @@ static int rk808_clkout_probe(struct platform_device *pdev)
>                 return ret;
>  
>         init.name = "rk808-clkout2";
> -       init.ops = &rk808_clkout2_ops;
> +       init.ops = rkpmic_get_ops(rk808->variant);
>         rk808_clkout->clkout2_hw.init = &init;
>  
>         /* optional override of the clockname */
> -- 
> 1.9.1
> 
> 
