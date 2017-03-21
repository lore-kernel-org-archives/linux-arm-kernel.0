From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 21 Mar 2017 16:49:56 -0700
Subject: [PATCH 3/5] clk: meson-gxbb: Add GXL/GXM GP0 Variant
In-Reply-To: <1489411604-18700-4-git-send-email-narmstrong@baylibre.com>
References: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
 <1489411604-18700-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <149014019624.54062.687648107621865354@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Quoting Neil Armstrong (2017-03-13 06:26:42)
> @@ -821,6 +893,7 @@ struct pll_params_table gxbb_gp0_params_table[] = {
>         &gxbb_hdmi_pll,
>         &gxbb_sys_pll,
>         &gxbb_gp0_pll,
> +       &gxl_gp0_pll,

Is there a reason for adding the pointer to this array here? It seems to
me that the gxbb_gp0_pll and gxl_gp0_pll are mutually exclusive, so
perhaps two different tables should be used?

>  };
>  
>  static struct meson_clk_mpll *const gxbb_clk_mplls[] = {
> @@ -923,6 +996,10 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
>         struct clk *parent_clk;
>         struct device *dev = &pdev->dev;
>  
> +       /* Override GP0 clock for GXL/GXM */
> +       if (of_device_is_compatible(dev->of_node, "amlogic,gxl-clkc"))
> +               gxbb_hw_onecell_data.hws[CLKID_GP0_PLL] = &gxl_gp0_pll.hw;

Similarly, this above is a little ugly compared to dedicated tables for
each variant.

Regards,
Mike

> +
>         /*  Generic clocks and PLLs */
>         clk_base = of_iomap(dev->of_node, 0);
>         if (!clk_base) {
> @@ -996,6 +1073,7 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id gxbb_clkc_match_table[] = {
>         { .compatible = "amlogic,gxbb-clkc" },
> +       { .compatible = "amlogic,gxl-clkc" },
>         { }
>  };
>  
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index 8ee2022..7f99bf6 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -71,6 +71,8 @@
>  #define HHI_GP0_PLL_CNTL2              0x44 /* 0x11 offset in data sheet */
>  #define HHI_GP0_PLL_CNTL3              0x48 /* 0x12 offset in data sheet */
>  #define HHI_GP0_PLL_CNTL4              0x4c /* 0x13 offset in data sheet */
> +#define        HHI_GP0_PLL_CNTL5               0x50 /* 0x14 offset in data sheet */
> +#define        HHI_GP0_PLL_CNTL1               0x58 /* 0x16 offset in data sheet */
>  
>  #define HHI_XTAL_DIVN_CNTL             0xbc /* 0x2f offset in data sheet */
>  #define HHI_TIMER90K                   0xec /* 0x3b offset in data sheet */
> -- 
> 1.9.1
> 
