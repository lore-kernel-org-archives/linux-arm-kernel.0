From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 04 Jul 2013 15:25:38 -0700
Subject: [RFC] clk: add flags to distinguish xtal clocks
In-Reply-To: <1372971912-10877-1-git-send-email-coelho@ti.com>
References: <1372971912-10877-1-git-send-email-coelho@ti.com>
Message-ID: <20130704222538.10823.2559@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Luciano Coelho (2013-07-04 14:05:12)
> Add a flag that indicate whether the clock is a crystal or not.  Since
> no clocks set this flag right now, include an additional flag that
> indicates whether the type is set or not.  If the CLK_IS_TYPE_DEFINED
> flag is not set, the value of the CLK_IS_TYPE_XTAL flag is undefined.
> This ensures backwards compatibility.
> 
> Additionally, parse a new device tree binding in clk-fixed-rate to set
> this flag.
> 
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> ---
> 
> I'm not  familiar with the common clock framework and I'm not
> entirely sure the flags can be used in such a way, but to me it looks
> reasonable, since some clock consumers may need to know what type of
> clock is being provided.
> 
> Specifically, the wl12xx firmware needs to know if the clock is XTAL
> or not to handle the stabilization and boosts properly.

Hi Luciano,

I'd like clarification on one point. Is the same clock input signal used
on the wifi chip? What I mean is, are there multiple clock inputs and
XTAL is one, and not-XTAL is another?

Or is it the same clock input and basically the problem is that you need
to know what kind of waveform to expect (e.g. square versus sine)?

Regards,
Mike

> 
> My main idea is that I need to pass this information in the device
> tree definition of the clocks, so that the driver can pass this
> information on to the firmware.
> 
> Please let me know if this looks ok or not.  If not, please let me
> know if you have any other ideas on how to solve my problem (of
> knowing whether the clock attached to the WiLink chip is XTAL or not).
> 
> 
> 
> 
>  drivers/clk/clk-fixed-rate.c |    6 +++++-
>  include/linux/clk-provider.h |    2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index dc58fbd..4003a82 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -90,13 +90,17 @@ void of_fixed_clk_setup(struct device_node *node)
>         struct clk *clk;
>         const char *clk_name = node->name;
>         u32 rate;
> +       unsigned long flags = CLK_IS_ROOT;
>  
>         if (of_property_read_u32(node, "clock-frequency", &rate))
>                 return;
>  
> +       if (of_property_read_bool(node, "clock-xtal"))
> +               flags |= CLK_IS_TYPE_DEFINED | CLK_IS_TYPE_XTAL;
> +
>         of_property_read_string(node, "clock-output-names", &clk_name);
>  
> -       clk = clk_register_fixed_rate(NULL, clk_name, NULL, CLK_IS_ROOT, rate);
> +       clk = clk_register_fixed_rate(NULL, clk_name, NULL, flags, rate);
>         if (!IS_ERR(clk))
>                 of_clk_add_provider(node, of_clk_src_simple_get, clk);
>  }
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 1186098..034320b 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -27,6 +27,8 @@
>  #define CLK_IS_ROOT            BIT(4) /* root clk, has no parent */
>  #define CLK_IS_BASIC           BIT(5) /* Basic clk, can't do a to_clk_foo() */
>  #define CLK_GET_RATE_NOCACHE   BIT(6) /* do not use the cached clk rate */
> +#define CLK_IS_TYPE_DEFINED    BIT(7) /* the clock type is defined */
> +#define CLK_IS_TYPE_XTAL       BIT(8) /* this is a crystal clock */
>  
>  struct clk_hw;
>  
> -- 
> 1.7.10.4
