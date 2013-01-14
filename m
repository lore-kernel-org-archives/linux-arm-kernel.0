From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 14 Jan 2013 20:26:22 +1300
Subject: [PATCH 02/11] ARM: nomadik: initial devicetree support
In-Reply-To: <1357599359-7385-1-git-send-email-linus.walleij@linaro.org>
References: <1357599359-7385-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1358148382.2198.2.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-07 at 23:55 +0100, Linus Walleij wrote:
> Support basic device tree boot on the Nomadik. Implement the
> support in the cpu file with the intent of deleting the board
> files later. At this stage IRQ controllers, system timer,
> l2x0 cache, UARTs and thus console boot is fully functional.
> Patch out the code adding devices by initcalls for now so
> as not to disturb the boot.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
...
> +static void __init cpu8815_timer_init_of(void)
> +{
> +	struct device_node *mtu;
> +	void __iomem *base;
> +	int irq;
> +	u32 src_cr;
> +
> +	mtu = of_find_node_by_path("/mtu0");
> +	if (!mtu)
> +		return;
> +	base = of_iomap(mtu, 0);
> +	if (WARN_ON(!base))
> +		return;
> +	irq = irq_of_parse_and_map(mtu, 0);
> +
> +	pr_info("Remapped MTU @ %p, irq: %d\n", base, irq);
> +
> +	/* Configure timer sources in "system reset controller" ctrl reg */
> +	src_cr = readl(base);
> +	src_cr &= SRC_CR_INIT_MASK;
> +	src_cr |= SRC_CR_INIT_VAL;
> +	writel(src_cr, base);
> +
> +	nmdk_timer_init(base, irq);
> +}
> +
> +struct sys_timer cpu8815_of_timer = {
> +	.init	= cpu8815_timer_init_of,
> +};
> +

struct sys_timer is disappearing in 3.9

>+DT_MACHINE_START(NOMADIK_DT, "ST-Ericsson Nomadik 8815")
>+       .map_io         = cpu8815_map_io,
>+       .init_irq       = cpu8815_init_irq_of,
>+       .handle_irq     = vic_handle_irq,
>+       .timer          = &cpu8815_of_timer,
>+       .init_machine   = cpu8815_init_of,
>+       .restart        = cpu8815_restart,
>+       .dt_compat      = cpu8815_board_compat,
>+MACHINE_END

You will be able to use .init_timer = cpu8815_of_timer in place of the
struct sys_timer.

The patches for this change are in arm-soc: timer/cleanup.

Regards
Tony P
