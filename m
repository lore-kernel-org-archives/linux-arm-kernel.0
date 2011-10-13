From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 10:38:36 +0100
Subject: [PATCH 3/9] ARM: SPMP8000: Add clk support
In-Reply-To: <1318178172-7965-4-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-4-git-send-email-zoss@devai.org>
Message-ID: <20111013093836.GK21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 09, 2011 at 06:36:06PM +0200, Zoltan Devai wrote:
> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
>  arch/arm/mach-spmp8000/clkdev.c             |  586 +++++++++++++++++++++++++++
>  arch/arm/mach-spmp8000/clock.c              |  155 +++++++
>  arch/arm/mach-spmp8000/include/mach/clock.h |   37 ++
>  3 files changed, 778 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-spmp8000/clkdev.c
>  create mode 100644 arch/arm/mach-spmp8000/clock.c
>  create mode 100644 arch/arm/mach-spmp8000/include/mach/clock.h
> 
> diff --git a/arch/arm/mach-spmp8000/clkdev.c b/arch/arm/mach-spmp8000/clkdev.c
> new file mode 100644
> index 0000000..c492d20
> --- /dev/null
> +++ b/arch/arm/mach-spmp8000/clkdev.c
> @@ -0,0 +1,586 @@
> +/*
> + * SPMP8000 machines clock support
> + *
> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/spinlock.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <mach/clock.h>
> +#include <mach/scu.h>

I find the use of 'scu' for something which isn't the SMP Coherence Unit
rather confusing - and I suspect you will too if/when spmp8000 has SMP
support.

> +static int divider_set_clock(struct clk *clk, int on)
> +{
> +	u32 divider;
> +
> +	if (!(clk->flags & CLK_DIVIDER_WITH_ENABLE))
> +		return -EINVAL;
> +
> +	divider = readl(REG_SCU_BASE(clk->scu) + clk->dividerreg);
> +	if (on)
> +		divider |= DIVIDER_ENABLE_BIT;
> +	else
> +		divider = 0;
> +	writel(divider, REG_SCU_BASE(clk->scu) + clk->dividerreg);

When you enable, you preserve the other bits in the register.  When you
disable, you zero the whole register.  That looks rather odd - either
you want to preserve the other bits or you don't.

> +
> +	return 0;
> +}
> +
> +static void divider_enable_clock(struct clk *clk)
> +{
> +	divider_set_clock(clk, 1);
> +}
> +
> +static void divider_disable_clock(struct clk *clk)
> +{
> +	divider_set_clock(clk, 0);
> +}

afaics, this is the only place divider_set_clock() is called from - which
returns an int which is never checked.  Is there any point to it
returning an int?

> +
> +static unsigned long divider_get_rate(struct clk *clk)
> +{
> +	u32 divider;
> +	unsigned long parent_rate = clk_get_rate(clk->parent);
> +
> +	if (!parent_rate) {
> +		clk->rate = 0;
> +		return clk->rate;
> +	}
> +
> +	divider = readl(REG_SCU_BASE(clk->scu) + clk->dividerreg);
> +	if ((clk->flags & CLK_DIVIDER_WITH_ENABLE) &&
> +		!(divider & DIVIDER_ENABLE_BIT)) {
> +		clk->rate = 0UL;
> +		return clk->rate;

You really should return the rate which you're going to get when the
clock is enabled here, not zero because it happens to be disabled at
the current point in time.

> +	}
> +
> +	clk->rate = parent_rate / ((divider & clk->divmask) + 1);
> +
> +	return clk->rate;
> +}
> +
> +static int divider_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	unsigned long parent_rate = clk_get_rate(clk->parent);
> +	u32 divider, divider_old;
> +
> +	if (unlikely(!parent_rate || rate > parent_rate)) {
> +		clk->rate = 0;
> +		pr_debug("parent rate not sufficient\n");
> +		return -EINVAL;
> +	}

You should set to the maximum (parent rate) in that case.

> +
> +	divider = (parent_rate / rate) - 1;
> +
> +	if (divider > clk->divmask) {
> +		pr_debug("input clock too high\n");
> +		return -EINVAL;
> +	};

Set to the minimum rate here.  The trailing ';' is not required.

> +
> +	divider_old = readl(REG_SCU_BASE(clk->scu) + clk->dividerreg);
> +	writel(0, REG_SCU_BASE(clk->scu) + clk->dividerreg);
> +	writel(divider, REG_SCU_BASE(clk->scu) + clk->dividerreg);
> +
> +	/* Re-enable clock if it was enabled before */
> +	if (divider_old & DIVIDER_ENABLE_BIT)
> +		writel(divider | DIVIDER_ENABLE_BIT,
> +			REG_SCU_BASE(clk->scu) + clk->dividerreg);
> +
> +	clk->rate = parent_rate / (divider + 1);
> +
> +	return 0;
> +}
...
> +static void __clk_disable(struct clk *clk)
> +{
> +	BUG_ON(clk->refcount == 0);
> +
> +	if (!(--clk->refcount) && clk->disable) {
> +		clk->disable(clk);
> +		if (clk->parent)
> +			__clk_disable(clk->parent);
> +	}
> +}

What if the clock has a parent but no disable function?

> +
> +static int __clk_enable(struct clk *clk)
> +{
> +	int ret = 0;
> +
> +	if (clk->refcount++ == 0 && clk->enable) {
> +		if (clk->parent)
> +			ret = __clk_enable(clk->parent);
> +		if (ret)
> +			return ret;
> +		else
> +			clk->enable(clk);

What if the clock has a parent but no enable function?
