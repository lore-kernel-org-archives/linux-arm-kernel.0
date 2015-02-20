From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 20 Feb 2015 10:21:34 -0800
Subject: [PATCHv2 10/15] clk: mvebu: extend common code to allow an
 optional refclk
In-Reply-To: <1424451874-25375-11-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-11-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150220182134.421.95366@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Thomas Petazzoni (2015-02-20 09:04:29)
> The Armada 39x, contrary to its predecessor, has a configurable
> reference clock frequency, of either 25 Mhz, or 40 Mhz. For the
> previous SoCs, it was fixed to 25 Mhz and described directly as such
> in the Device Tree.
> 
> For Armada 39x, we need to read certain registers to know whether the
> frequency is 25 or 40 Mhz. Therefore, this commit extends the common
> mvebu clock code to allow the SoC-specific code to say it wants to
> register a reference clock, by giving a non-NULL ->get_refclk_freq()
> function pointer in its coreclk_soc_desc structure.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Looks fine to me. I'll apply after -rc1 drops.

Regards,
Mike

> ---
>  drivers/clk/mvebu/common.c | 17 +++++++++++++++++
>  drivers/clk/mvebu/common.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
> index 0d4d121..15b370f 100644
> --- a/drivers/clk/mvebu/common.c
> +++ b/drivers/clk/mvebu/common.c
> @@ -121,6 +121,11 @@ void __init mvebu_coreclk_setup(struct device_node *np,
>  
>         /* Allocate struct for TCLK, cpu clk, and core ratio clocks */
>         clk_data.clk_num = 2 + desc->num_ratios;
> +
> +       /* One more clock for the optional refclk */
> +       if (desc->get_refclk_freq)
> +               clk_data.clk_num += 1;
> +
>         clk_data.clks = kzalloc(clk_data.clk_num * sizeof(struct clk *),
>                                 GFP_KERNEL);
>         if (WARN_ON(!clk_data.clks)) {
> @@ -162,6 +167,18 @@ void __init mvebu_coreclk_setup(struct device_node *np,
>                 WARN_ON(IS_ERR(clk_data.clks[2+n]));
>         };
>  
> +       /* Register optional refclk */
> +       if (desc->get_refclk_freq) {
> +               const char *name = "refclk";
> +               of_property_read_string_index(np, "clock-output-names",
> +                                             2 + desc->num_ratios, &name);
> +               rate = desc->get_refclk_freq(base);
> +               clk_data.clks[2 + desc->num_ratios] =
> +                       clk_register_fixed_rate(NULL, name, NULL,
> +                                               CLK_IS_ROOT, rate);
> +               WARN_ON(IS_ERR(clk_data.clks[2 + desc->num_ratios]));
> +       }
> +
>         /* SAR register isn't needed anymore */
>         iounmap(base);
>  
> diff --git a/drivers/clk/mvebu/common.h b/drivers/clk/mvebu/common.h
> index 783b563..f0de6c8 100644
> --- a/drivers/clk/mvebu/common.h
> +++ b/drivers/clk/mvebu/common.h
> @@ -30,6 +30,7 @@ struct coreclk_soc_desc {
>         u32 (*get_tclk_freq)(void __iomem *sar);
>         u32 (*get_cpu_freq)(void __iomem *sar);
>         void (*get_clk_ratio)(void __iomem *sar, int id, int *mult, int *div);
> +       u32 (*get_refclk_freq)(void __iomem *sar);
>         bool (*is_sscg_enabled)(void __iomem *sar);
>         u32 (*fix_sscg_deviation)(u32 system_clk);
>         const struct coreclk_ratio *ratios;
> -- 
> 2.1.0
> 
