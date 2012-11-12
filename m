From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 15:09:44 +0000
Subject: [PATCH 12/14] ARM: SPEAr3xx: shirq: simplify and move the shared
 irq multiplexor to DT
In-Reply-To: <71bbb1faf3cd048953dcf24ef9ce6d9dd37fe8e1.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <71bbb1faf3cd048953dcf24ef9ce6d9dd37fe8e1.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <201211121509.45176.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 November 2012, Viresh Kumar wrote:
> From: Shiraz Hashim <shiraz.hashim@st.com>
> 
> SPEAr3xx architecture includes shared/multiplexed irqs for certain set
> of devices. The multiplexor provides a single interrupt to parent
> interrupt controller (VIC) on behalf of a group of devices.
> 
> There can be multiple groups available on SPEAr3xx variants but not
> exceeding 4. The number of devices in a group can differ, further they
> may share same set of status/mask registers spanning across different
> bit masks. Also in some cases the group may not have enable or other
> registers. This makes software little complex.
> 
> Present implementation was non-DT and had few complex data structures to
> decipher banks, number of irqs supported, mask and registers involved.
> 
> This patch simplifies the overall design and convert it in to DT.  It
> also removes all registration from individual SoC files and bring them
> in to common shirq.c.
> 
> Also updated the corresponding documentation for DT binding of shirq.

Looks basically ok, but I have a few comments.

> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/arm/spear/shirq.txt        |  48 ++++
>  arch/arm/mach-spear3xx/include/mach/irqs.h         |  10 +-
>  arch/arm/mach-spear3xx/spear300.c                  | 103 -------
>  arch/arm/mach-spear3xx/spear310.c                  | 202 --------------
>  arch/arm/mach-spear3xx/spear320.c                  | 204 --------------
>  arch/arm/mach-spear3xx/spear3xx.c                  |   4 +
>  arch/arm/plat-spear/include/plat/shirq.h           |  35 +--
>  arch/arm/plat-spear/shirq.c                        | 305 +++++++++++++++++----

I guess it would be nice to move this to drivers/irqchip/st-shirq.c now
that we have introduced that directory.

>  static const char * const spear320_dt_board_compat[] = {
> diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
> index 98144ba..781aec9 100644
> --- a/arch/arm/mach-spear3xx/spear3xx.c
> +++ b/arch/arm/mach-spear3xx/spear3xx.c
> @@ -121,6 +122,9 @@ struct sys_timer spear3xx_timer = {
>  
>  static const struct of_device_id vic_of_match[] __initconst = {
>  	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
> +	{ .compatible = "st,spear300-shirq", .data = spear3xx_shirq_of_init, },
> +	{ .compatible = "st,spear310-shirq", .data = spear3xx_shirq_of_init, },
> +	{ .compatible = "st,spear320-shirq", .data = spear3xx_shirq_of_init, },
>  	{ /* Sentinel */ }
>  };

You list three "compatible" values here with the same init function, and then

> +int __init spear3xx_shirq_of_init(struct device_node *np,
> +		struct device_node *parent)
> +{
> +	struct spear_shirq **shirq_blocks;
> +	void __iomem *base;
> +	int block_nr, ret;
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		pr_err("%s: failed to map shirq registers\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	if (of_device_is_compatible(np, "st,spear300-shirq")) {
> +		shirq_blocks = spear300_shirq_blocks;
> +		block_nr = ARRAY_SIZE(spear300_shirq_blocks);
> +	} else if (of_device_is_compatible(np, "st,spear310-shirq")) {
> +		shirq_blocks = spear310_shirq_blocks;
> +		block_nr = ARRAY_SIZE(spear310_shirq_blocks);
> +	} else if (of_device_is_compatible(np, "st,spear320-shirq")) {
> +		shirq_blocks = spear320_shirq_blocks;
> +		block_nr = ARRAY_SIZE(spear320_shirq_blocks);
> +	} else {
> +		pr_err("%s: unknown platform\n", __func__);
> +		ret = -EINVAL;
> +		goto unmap;
> +	}
> +
> +	ret = shirq_init(shirq_blocks, block_nr, base, np);
> +	if (ret) {
> +		pr_err("%s: shirq initialization failed\n", __func__);
> +		goto unmap;
> +	}
> +
> +	return ret;
> +
> +unmap:
> +	iounmap(base);
> +	return ret;
> +}

In that multiplex between thre three again. I think it would be cleaner to have
three separate functions and move the call to of_iomap into shirq_init.

	Arnd
