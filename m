From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 10:23:06 +0900
Subject: [PATCH v2 01/03] ARM: shmobile: Introduce
 shmobile_clk_workaround()
In-Reply-To: <20140312233617.17009.94940.sendpatchset@w520>
References: <20140312233608.17009.65690.sendpatchset@w520>
 <20140312233617.17009.94940.sendpatchset@w520>
Message-ID: <20140313012303.GI25813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 08:36:17AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Introduce a new clock workaround function used by DT reference
> code on the mach-shmobile subarchitecture. The new function
> shmobile_clk_workaround() is used to configure clkdev to
> allow DT and platform devices to coexist. It is possible for
> the DT reference board code to also request enabling of the clock
> in case the driver does not implement clock control.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up with Wolfram's Reviewed-by
and Tested-by which he supplied for v1.

I have also removed the trailing empty line that this
patch adds to clock.c.

> ---
> 
>  Changes since V1:
>  - Reworked patch dependency, updated include file path
> 
>  arch/arm/mach-shmobile/Makefile             |    2 -
>  arch/arm/mach-shmobile/clock.c              |   29 +++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/clock.h |   16 ++++++++++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> --- 0001/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile	2014-03-13 08:29:12.000000000 +0900
> @@ -21,8 +21,8 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.
>  obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
>  
>  # Clock objects
> -ifndef CONFIG_COMMON_CLK
>  obj-y				+= clock.o
> +ifndef CONFIG_COMMON_CLK
>  obj-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
>  obj-$(CONFIG_ARCH_SH73A0)	+= clock-sh73a0.o
>  obj-$(CONFIG_ARCH_R8A73A4)	+= clock-r8a73a4.o
> --- 0001/arch/arm/mach-shmobile/clock.c
> +++ work/arch/arm/mach-shmobile/clock.c	2014-03-13 08:29:35.000000000 +0900
> @@ -21,6 +21,32 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +
> +#ifdef CONFIG_COMMON_CLK
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <mach/clock.h>
> +
> +void __init shmobile_clk_workaround(const struct clk_name *clks,
> +				    int nr_clks, bool enable)
> +{
> +	const struct clk_name *clkn;
> +	struct clk *clk;
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_clks; ++i) {
> +		clkn = clks + i;
> +		clk = clk_get(NULL, clkn->clk);
> +		if (!IS_ERR(clk)) {
> +			clk_register_clkdev(clk, clkn->con_id, clkn->dev_id);
> +			if (enable)
> +				clk_prepare_enable(clk);
> +			clk_put(clk);
> +		}
> +	}
> +}
> +
> +#else /* CONFIG_COMMON_CLK */
>  #include <linux/sh_clk.h>
>  #include <linux/export.h>
>  #include <mach/clock.h>
> @@ -58,3 +84,6 @@ void __clk_put(struct clk *clk)
>  {
>  }
>  EXPORT_SYMBOL(__clk_put);
> +
> +#endif /* CONFIG_COMMON_CLK */
> +
> --- 0001/arch/arm/mach-shmobile/include/mach/clock.h
> +++ work/arch/arm/mach-shmobile/include/mach/clock.h	2014-03-13 08:29:12.000000000 +0900
> @@ -1,6 +1,21 @@
>  #ifndef CLOCK_H
>  #define CLOCK_H
>  
> +#ifdef CONFIG_COMMON_CLK
> +/* temporary clock configuration helper for platform devices */
> +
> +struct clk_name {
> +	const char *clk;
> +	const char *con_id;
> +	const char *dev_id;
> +};
> +
> +void shmobile_clk_workaround(const struct clk_name *clks, int nr_clks,
> +			     bool enable);
> +
> +#else /* CONFIG_COMMON_CLK */
> +/* legacy clock implementation */
> +
>  unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk);
>  extern struct sh_clk_ops shmobile_fixed_ratio_clk_ops;
>  
> @@ -36,4 +51,5 @@ do {			\
>  	(p)->div = d;	\
>  } while (0)
>  
> +#endif /* CONFIG_COMMON_CLK */
>  #endif
> 
