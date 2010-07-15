From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 12:27:14 +0100
Subject: [PATCH 2/6] U6715 clocks gating management U6 clock generic
	driver & U6715 cgu clock specific
In-Reply-To: <1278688913-26417-3-git-send-email-philippe.langlais@stericsson.com>
References: <1278688913-26417-1-git-send-email-philippe.langlais@stericsson.com>
	<1278688913-26417-3-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100715112714.GC29322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 09, 2010 at 05:21:49PM +0200, Philippe Langlais wrote:
> diff --git a/arch/arm/mach-u67xx/Makefile b/arch/arm/mach-u67xx/Makefile
> index 38cf624..8c1dad8 100644
> --- a/arch/arm/mach-u67xx/Makefile
> +++ b/arch/arm/mach-u67xx/Makefile
> @@ -5,7 +5,10 @@
>  ## Object file lists.
>  
>  # Common support
> -obj-y			:= devices.o
> +obj-y			:= devices.o cgu.o
> +
> +# Specific machine support
> +obj-$(CONFIG_ARCH_U67XX) += clock_data_u67xx.o

Aren't we already using this makefile because CONFIG_ARCH_U67XX is set?

> +int u6_clk_set_parent_uart(struct clk *clk, struct clk *parent)
> +{
> +
> +	if (!strcmp(parent->name, "pclk2_ck")) {
> +		clk->parent = parent;
> +		return 0;
> +	} else if (!strcmp(parent->name, "clk26m_ck")) {
> +		clk->parent = parent;
> +		return 0;
> +	} else if (!strcmp(parent->name, "clk13m_ck")) {
> +		clk->parent = parent;
> +		return 0;
> +	} else {
> +		return -1;

Ouch.  This will cause clk_set_parent() to return -1, which is -EPERM.
I don't think you mean "operation not permitted".  Maybe -ENOENT, -ENXIO,
or -EINVAL would be more appropriate?

> +/*
> + * Standard clock functions defined in include/linux/clk.h
> + */
> +int clk_enable(struct clk *clk)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (clk == ERR_PTR(-ENOENT))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&clockfw_lock, flags);
> +	if (arch_clock->clk_enable)
> +		ret = arch_clock->clk_enable(clk);
> +	spin_unlock_irqrestore(&clockfw_lock, flags);

Hmm.  This looks like it's been modelled on OMAP.

Wouldn't it be better to move some of the U67xx stuff into here,
such as the use-count tracking - rather than having each sub-arch
reimplement it?
