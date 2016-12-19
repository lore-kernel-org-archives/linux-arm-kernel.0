From: atull@kernel.org (Alan Tull)
Date: Sun, 18 Dec 2016 19:58:37 -0600 (CST)
Subject: [PATCH v4 2/2] ARM: ep93xx: Register ts73xx-fpga manager driver
 for TS-7300
In-Reply-To: <20161218202158.10582-3-f.fainelli@gmail.com>
References: <20161218202158.10582-1-f.fainelli@gmail.com>
 <20161218202158.10582-3-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.10.1612181957510.2528@atull-730U3E-740U3E>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 Dec 2016, Florian Fainelli wrote:

> Register the TS-7300 FPGA manager device drivers which allows us to load
> bitstreams into the on-board Altera Cyclone II FPGA.
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Alan Tull <atull@opensource.altera.com>

> ---
>  arch/arm/mach-ep93xx/ts72xx.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index 3b39ea353d30..acf72ea670ef 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -230,6 +230,28 @@ static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
>  	.phy_id		= 1,
>  };
>  
> +#if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
> +
> +/* Relative to EP93XX_CS1_PHYS_BASE */
> +#define TS73XX_FPGA_LOADER_BASE		0x03c00000
> +
> +static struct resource ts73xx_fpga_resources[] = {
> +	{
> +		.start	= EP93XX_CS1_PHYS_BASE + TS73XX_FPGA_LOADER_BASE,
> +		.end	= EP93XX_CS1_PHYS_BASE + TS73XX_FPGA_LOADER_BASE + 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device ts73xx_fpga_device = {
> +	.name	= "ts73xx-fpga-mgr",
> +	.id	= -1,
> +	.resource = ts73xx_fpga_resources,
> +	.num_resources = ARRAY_SIZE(ts73xx_fpga_resources),
> +};
> +
> +#endif
> +
>  static void __init ts72xx_init_machine(void)
>  {
>  	ep93xx_init_devices();
> @@ -238,6 +260,10 @@ static void __init ts72xx_init_machine(void)
>  	platform_device_register(&ts72xx_wdt_device);
>  
>  	ep93xx_register_eth(&ts72xx_eth_data, 1);
> +#if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
> +	if (board_is_ts7300())
> +		platform_device_register(&ts73xx_fpga_device);
> +#endif
>  }
>  
>  MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
