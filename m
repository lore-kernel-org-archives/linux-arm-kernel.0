From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 28 Oct 2009 11:23:04 +0100
Subject: [RFC PATCH 2/2] MXC: add pcmcia support
In-Reply-To: <20091027172702.7671.50161.stgit@srv002.fuzzey.net>
References: <20091027172652.7671.85583.stgit@srv002.fuzzey.net>
	<20091027172702.7671.50161.stgit@srv002.fuzzey.net>
Message-ID: <20091028102304.GE15296@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Can you please split the arch specific changes from the driver? These
are two different subsystems with two different maintainers.


On Tue, Oct 27, 2009 at 06:27:02PM +0100, Martin Fuzzey wrote:
> 
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>
> 
> ---
> 
>  arch/arm/mach-mx2/clock_imx21.c |    1 
>  arch/arm/mach-mx2/clock_imx27.c |    1 
>  arch/arm/mach-mx2/devices.c     |   21 +
>  arch/arm/mach-mx2/devices.h     |    1 
>  arch/arm/mach-mx3/clock.c       |    1 
>  drivers/pcmcia/Kconfig          |    6 
>  drivers/pcmcia/Makefile         |    3 
>  drivers/pcmcia/mxc_generic.c    |  711 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 745 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/pcmcia/mxc_generic.c
> 
> diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-mx2/clock_imx21.c
> index 801e9d2..e131312 100644
> --- a/arch/arm/mach-mx2/clock_imx21.c
> +++ b/arch/arm/mach-mx2/clock_imx21.c
> @@ -960,6 +960,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
>  	_REGISTER_CLOCK(NULL, "owire", owire_clk)
>  	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
> +	_REGISTER_CLOCK("mxc-pcmcia", NULL, hclk_clk)
>  };
>  
>  /*
> diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
> index a3a76cf..ed2fb96 100644
> --- a/arch/arm/mach-mx2/clock_imx27.c
> +++ b/arch/arm/mach-mx2/clock_imx27.c
> @@ -674,6 +674,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk)
>  	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
>  	_REGISTER_CLOCK(NULL, "scc", scc_clk)
> +	_REGISTER_CLOCK("mxc-pcmcia", NULL, ahb_clk)
>  };
>  
>  /* Adjust the clock path for TO2 and later */
> diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
> index 50199af..906ccb2 100644
> --- a/arch/arm/mach-mx2/devices.c
> +++ b/arch/arm/mach-mx2/devices.c
> @@ -564,3 +564,24 @@ int __init mxc_register_gpios(void)
>  {
>  	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
>  }
> +
> +static struct resource mxc_resource_pcmcia[] = {
> +	[0] = {
> +		.start  = PCMCIA_CTL_BASE_ADDR,
> +		.end    = PCMCIA_CTL_BASE_ADDR + 0x67,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start  = MXC_INT_PCMCIA,
> +		.end    = MXC_INT_PCMCIA,
> +		.flags  = IORESOURCE_IRQ,
> +	},

Please let the compiler count the array indices.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
