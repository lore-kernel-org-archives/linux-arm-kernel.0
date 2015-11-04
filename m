From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Nov 2015 09:53:13 +0100
Subject: [PATCH 2/2] drivers/gpio: Port gpio driver to layerscape platform
In-Reply-To: <1446619704-27669-2-git-send-email-Gang.Liu@freescale.com>
References: <1446619704-27669-1-git-send-email-Gang.Liu@freescale.com>
 <1446619704-27669-2-git-send-email-Gang.Liu@freescale.com>
Message-ID: <4040829.fHtCUjX87j@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 November 2015 14:48:24 Liu Gang wrote:
> Layerscape has the same ip block/controller as
> GPIO on powerpc platform(MPC8XXX).
> 
> So use portable i/o accessors, as in_be32/out_be32
> accessors are Power architecture specific whereas
> ioread32/iowrite32 and ioread32be/iowrite32be are
> available in other architectures.
> 
> Layerscape GPIO controller's registers may be big
> or little endian, so the code needs to get the
> endian property from DTB, then make additional
> functions to fit right register read/write
> operations.
> 
> Currently the code can support ls2080a GPIO with
> little endian registers. And it can also work well
> on other layerscape platform with big endian GPIO
> registers.
> 
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 8949b3f..c3ca283 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -290,12 +290,12 @@ config GPIO_MPC5200
>  	depends on PPC_MPC52xx
>  
>  config GPIO_MPC8XXX
> -	bool "MPC512x/MPC8xxx GPIO support"
> +	bool "MPC512x/MPC8xxx/QorIQ GPIO support"
>  	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
> -		   FSL_SOC_BOOKE || PPC_86xx
> +		   FSL_SOC_BOOKE || PPC_86xx || ARCH_LAYERSCAPE
>  	help
>  	  Say Y here if you're going to use hardware that connects to the
> -	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
> +	  MPC512x/831x/834x/837x/8572/8610/QorIQ GPIOs.

It would be nice to also add '|| COMPILE_TEST' here and ensure that
it also builds on x86 with that set, to get better coverage from
the automated build testing infrastructure.

> +static bool gpio_little_endian;
> +static inline u32 gpio_in32(void __iomem *addr)
> +{
> +	u32 val;
> +
> +	if (gpio_little_endian)
> +		val = ioread32(addr);
> +	else
> +		val = ioread32be(addr);
> +
> +	return val;
> +}
> +
> +static inline void gpio_out32(u32 val, void __iomem *addr)
> +{
> +	if (gpio_little_endian)
> +		iowrite32(val, addr);
> +	else
> +		iowrite32be(val, addr);
> +}

I guess this is fixed per architecture, so you could also do this as

static inline void gpio_out32(u32 val, void __iomem *addr)
{
	if (IS_ENABLED(CONFIG_ARM))
		iowrite32(val, addr);
	else if (IS_ENABLED(CONFIG_PPC)
		iowrite32be(val, addr);
	else
		BUG();
}

and then check that the DT flag for little-endian matches
the architecture specific default.

Your version is more generic of course, while the one I show here
is a little more efficient and avoids the global variable. Your choice.

	Arnd
