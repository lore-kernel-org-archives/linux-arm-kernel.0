From: robherring2@gmail.com (Rob Herring)
Date: Thu, 24 Jan 2013 11:47:25 -0600
Subject: [PATCH 1/7] clk: add common of_clk_init() function
In-Reply-To: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <510173AD.8080402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 01:00 AM, Prashant Gaikwad wrote:
> Modify of_clk_init function so that it will determine which
> driver to initialize based on device tree instead of each driver
> registering to it.
> 
> Based on a similar patch for drivers/irqchip by Thomas Petazzoni and
> drivers/clocksource by Stephen Warren.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> ---

For this and highbank:

Tested-by: Rob Herring <rob.herring@calxeda.com>

>  drivers/clk/clk-fixed-rate.c      |    1 +
>  drivers/clk/clk.c                 |    9 +++++++++
>  include/asm-generic/vmlinux.lds.h |   10 ++++++++++
>  include/linux/clk-provider.h      |    6 ++++++
>  4 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index af78ed6..f2104df 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -101,4 +101,5 @@ void __init of_fixed_clk_setup(struct device_node *node)
>  		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>  }
>  EXPORT_SYMBOL_GPL(of_fixed_clk_setup);
> +CLK_OF_DECLARE(fixed_clk, "fixed-clock", of_fixed_clk_setup);
>  #endif
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 037b48a..fb38dd8 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/device.h>
> +#include <linux/init.h>
>  
>  static DEFINE_SPINLOCK(enable_lock);
>  static DEFINE_MUTEX(prepare_lock);
> @@ -1805,6 +1806,11 @@ struct of_clk_provider {
>  	void *data;
>  };
>  
> +extern struct of_device_id __clk_of_table[];
> +
> +static const struct of_device_id __clk_of_table_sentinel
> +	__used __section(__clk_of_table_end);
> +
>  static LIST_HEAD(of_clk_providers);
>  static DEFINE_MUTEX(of_clk_lock);
>  
> @@ -1933,6 +1939,9 @@ void __init of_clk_init(const struct of_device_id *matches)
>  {
>  	struct device_node *np;
>  
> +	if (!matches)
> +		matches = __clk_of_table;
> +
>  	for_each_matching_node(np, matches) {
>  		const struct of_device_id *match = of_match_node(matches, np);
>  		of_clk_init_cb_t clk_init_cb = match->data;
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1e744c5..8282f7c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -158,6 +158,15 @@
>  #define CLKSRC_OF_TABLES()
>  #endif
>  
> +#ifdef CONFIG_COMMON_CLK
> +#define CLK_OF_TABLES() . = ALIGN(8);				\
> +			VMLINUX_SYMBOL(__clk_of_table) = .;	\
> +			*(__clk_of_table)			\
> +			*(__clk_of_table_end)
> +#else
> +#define CLK_OF_TABLES()
> +#endif
> +
>  #define KERNEL_DTB()							\
>  	STRUCT_ALIGN();							\
>  	VMLINUX_SYMBOL(__dtb_start) = .;				\
> @@ -502,6 +511,7 @@
>  	CPU_DISCARD(init.rodata)					\
>  	MEM_DISCARD(init.rodata)					\
>  	CLKSRC_OF_TABLES()						\
> +	CLK_OF_TABLES()							\
>  	KERNEL_DTB()
>  
>  #define INIT_TEXT							\
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 4989b8a..7f197d7 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -379,7 +379,13 @@ struct clk_onecell_data {
>  };
>  struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
>  const char *of_clk_get_parent_name(struct device_node *np, int index);
> +
>  void of_clk_init(const struct of_device_id *matches);
>  
> +#define CLK_OF_DECLARE(name, compat, fn)			\
> +	static const struct of_device_id __clk_of_table_##name	\
> +		__used __section(__clk_of_table)		\
> +		= { .compatible = compat, .data = fn };
> +
>  #endif /* CONFIG_COMMON_CLK */
>  #endif /* CLK_PROVIDER_H */
> 
