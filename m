From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 26 May 2013 22:46:12 +0200
Subject: [RFC PATCHv4 1/6] arm: TI-Nspire platform code
In-Reply-To: <1369480087-24786-2-git-send-email-dt.tangr@gmail.com>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <1369480087-24786-2-git-send-email-dt.tangr@gmail.com>
Message-ID: <201305262246.12803.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 May 2013, Daniel Tang wrote:

> +static struct map_desc nspire_io_desc[] __initdata = {
> +	{
> +		.virtual	=  NSPIRE_EARLY_UART_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(NSPIRE_EARLY_UART_PHYS_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE
> +	},

You  can remove this now and call debug_ll_io_init() instead, so you can
remove the duplicate definitions of the base addresses.

> +	{
> +		.virtual	=  NSPIRE_PWR_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(NSPIRE_PWR_PHYS_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE
> +	}
> +};

And I think this one can be replaced with a call to of_iomap:

> +static void __init nspire_early_init(void)
> +{
> +	void __iomem *pwr = IOMEM(NSPIRE_PWR_VIRT_BASE);
> +
> +	/* Re-enable bus access to all peripherals */
> +	writel(0, pwr + NSPIRE_PWR_BUS_DISABLE1);
> +	writel(0, pwr + NSPIRE_PWR_BUS_DISABLE2);
> +
> +	pr_info("Re-enabled bus access to all peripherals\n");
> +}

Since it seems to be used only in this one function.

> +DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
> +	.map_io		= nspire_map_io,
> +	.init_irq	= irqchip_init,
> +	.init_time	= nspire_init_time,
> +	.init_machine	= nspire_init,
> +	.init_early	= nspire_early_init,
> +	.dt_compat	= nspire_dt_match,
> +	.restart	= nspire_restart,
> +MACHINE_END

The reference to irqchip_init is now the default, so you can drop that too.
nspire_init_time is still needed right now, but I'd like to initialize the
clocks automatically soon, so that will go away in the future.

Please reorder the other callbacks in call order, same as the structure
definition.

	Arnd
