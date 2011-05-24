From: francesco.virlinzi@st.com (Francesco VIRLINZI)
Date: Tue, 24 May 2011 09:01:27 +0200
Subject: [PATCH 3/4] clk: Add fixed-rate clock
In-Reply-To: <1305876469.327290.592839707336.3.gpush@pororo>
References: <1305876469.327290.592839707336.3.gpush@pororo>
Message-ID: <4DDB57C7.5010007@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy

Is this patch really required?

If I have just a static clk with only a name and a rate;
I can obtain the rate with the
clk_get_rate(..)

and I don't need extra code/data to manage the fixed_clk (in my
  view it's already fixed due to a null struct clk_hw_ops).

Could you clarify what the would address?
Thanks
Regards
  Francesco


On 5/20/2011 9:27 AM, Jeremy Kerr wrote:
> Signed-off-by: Jeremy Kerr<jeremy.kerr@canonical.com>
>
> ---
>   drivers/clk/Kconfig     |    4 ++++
>   drivers/clk/Makefile    |    1 +
>   drivers/clk/clk-fixed.c |   17 +++++++++++++++++
>   include/linux/clk.h     |   14 ++++++++++++++
>   4 files changed, 36 insertions(+)
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index e611e34..0a27963 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -5,3 +5,7 @@ config CLKDEV_LOOKUP
>
>   config GENERIC_CLK
>   	bool
> +
> +config GENERIC_CLK_FIXED
> +	bool
> +	depends on GENERIC_CLK
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 570d5b9..9a3325a 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -1,3 +1,4 @@
>
>   obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
>   obj-$(CONFIG_GENERIC_CLK)	+= clk.o
> +obj-$(CONFIG_GENERIC_CLK_FIXED)	+= clk-fixed.o
> diff --git a/drivers/clk/clk-fixed.c b/drivers/clk/clk-fixed.c
> new file mode 100644
> index 0000000..47a27f9
> --- /dev/null
> +++ b/drivers/clk/clk-fixed.c
> @@ -0,0 +1,17 @@
> +
> +#include<linux/clk.h>
> +#include<linux/module.h>
> +
> +#define to_clk_fixed(c) container_of(c, struct clk_hw_fixed, hw)
> +
> +static unsigned long clk_fixed_recalc_rate(struct clk_hw *hw)
> +{
> +	return to_clk_fixed(hw)->rate;
> +}
> +
> +struct clk_hw_ops clk_fixed_ops = {
> +	.recalc_rate = clk_fixed_recalc_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_fixed_ops);
> +
> +
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index e0969d2..fd62e86 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -110,6 +110,20 @@ int clk_prepare(struct clk *clk);
>    */
>   void clk_unprepare(struct clk *clk);
>
> +/* Base clock implementations. Platform clock implementations can use these
> + * directly, or 'subclass' as approprate */
> +
> +#ifdef CONFIG_GENERIC_CLK_FIXED
> +
> +struct clk_hw_fixed {
> +	struct clk_hw	hw;
> +	unsigned long	rate;
> +};
> +
> +extern struct clk_hw_ops clk_fixed_ops;
> +
> +#endif /* CONFIG_GENERIC_CLK_FIXED */
> +
>   #else /* !CONFIG_GENERIC_CLK */
>
>   /*
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
