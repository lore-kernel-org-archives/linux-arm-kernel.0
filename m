From: robherring2@gmail.com (Rob Herring)
Date: Fri, 28 Mar 2014 10:42:54 -0500
Subject: [PATCH 74/75] ARM: l2c: always enable low power modes
In-Reply-To: <E1WTYaK-0007I0-Sm@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaK-0007I0-Sm@rmk-PC.arm.linux.org.uk>
Message-ID: <CAL_Jsq+vja-BeNfiVnOicFAa+E6jigDfnb5KWWpxZCZ3eGkJiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 10:20 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Always enable the L2C low power modes on L2C-310 R3P0 and newer parts.

I assume you want to squash this with patch 68/75? Or you are still
debating whether we want to do this or not? Given that it is r3px
only, that should greatly reduce any chance of breakage to newer
platforms.

Rob

>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/devicetree/bindings/arm/l2cc.txt |  2 --
>  arch/arm/mm/cache-l2x0.c                       | 22 ++++++++++++----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index e0dd400ecea6..b513cb8196fe 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -40,8 +40,6 @@ implementations of the L2 cache controller with compatible programming models.
>  - arm,filter-ranges : <start length> Starting address and length of window to
>    filter. Addresses in the filter window are directed to the M1 port. Other
>    addresses will go to the M0 port.
> -- arm,dynamic-clk-gating : Enables dynamic clock gating (PL310)
> -- arm,standby-mode : Enables standby mode (PL310)
>  - interrupts : 1 combined interrupt.
>  - cache-id-part: cache id part number to be used if it is not present
>    on hardware
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 700a66260f94..b1f103d402be 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -752,6 +752,18 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
>                         1 + (prefetch & L310_PREFETCH_CTRL_OFFSET_MASK));
>         }
>
> +       /* r3p0 or later has power control register */
> +       if (rev >= L310_CACHE_ID_RTL_R3P0) {
> +               u32 power_ctrl;
> +
> +               l2c_write_sec(L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN,
> +                             base, L310_POWER_CTRL);
> +               power_ctrl = readl_relaxed(base + L310_POWER_CTRL);
> +               pr_info("L2C-310: dynamic clock gating %sabled, standby mode %sabled\n",
> +                       power_ctrl & L310_DYNAMIC_CLK_GATING_EN ? "en" : "dis",
> +                       power_ctrl & L310_STNDBY_MODE_EN ? "en" : "dis");
> +       }
> +
>         l2c_enable(base, aux, num_lock);
>
>         if (aux & L310_AUX_CTRL_FULL_LINE_ZERO) {
> @@ -1033,7 +1045,6 @@ static void __init l2c310_of_parse(const struct device_node *np,
>         u32 data[3] = { 0, 0, 0 };
>         u32 tag[3] = { 0, 0, 0 };
>         u32 filter[2] = { 0, 0 };
> -       u32 val;
>
>         of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
>         if (tag[0] && tag[1] && tag[2])
> @@ -1060,15 +1071,6 @@ static void __init l2c310_of_parse(const struct device_node *np,
>                 writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
>                                l2x0_base + L310_ADDR_FILTER_START);
>         }
> -
> -       val = 0;
> -       if (of_property_read_bool(np, "arm,dynamic-clk-gating"))
> -               val |= L310_DYNAMIC_CLK_GATING_EN;
> -       if (of_property_read_bool(np, "arm,standby-mode"))
> -               val |= L310_STNDBY_MODE_EN;
> -
> -       if (val)
> -               l2c_write_sec(val, l2x0_base, L310_POWER_CTRL);
>  }
>
>  static const struct l2c_init_data of_l2c310_data __initconst = {
> --
> 1.8.3.1
>
