From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 22:06:15 +0800
Subject: [RFC PATCH 1/1] ARM: imx: enable SPARSE_IRQ for imx
In-Reply-To: <1340111993-6676-1-git-send-email-b29396@freescale.com>
References: <20120619130145.GD10387@shlinux2.ap.freescale.net>
 <1340111993-6676-1-git-send-email-b29396@freescale.com>
Message-ID: <20120619140613.GH21951@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 09:19:53PM +0800, Dong Aisheng wrote:
> After adding irqdomain support for both tzic and avic irq chip,
> the original defined hw irq number in <soc>.h file like mx53.h
> can not be directly used by the driver anymore.
> This issue can be found when enable SPARSE_IRQ because when
> SPARSE_IRQ is enabled the linux virtual irq and hw irq is not the same
> anymore even using legacy irqdomain after mapping.
> User should always call irq_find_mapping() to get the correct linux virtual
> irq number to use in driver level.
> 
> Tested on i.MX53 LOCO.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

NAK.

I have been keeping saying that the irq number used in resource should
always be Linux irq.  Unfortunately, you are not listening.

> ---
>  arch/arm/Kconfig                                |    1 +
>  arch/arm/mach-imx/clk-imx21.c                   |    3 +-
>  arch/arm/mach-imx/clk-imx27.c                   |    3 +-
>  arch/arm/mach-imx/clk-imx31.c                   |    3 +-
>  arch/arm/mach-imx/clk-imx35.c                   |    6 +-
>  arch/arm/mach-imx/clk-imx51-imx53.c             |    7 +-
>  arch/arm/mach-imx/mm-imx1.c                     |    8 +-
>  arch/arm/mach-imx/mm-imx21.c                    |   14 +++--
>  arch/arm/mach-imx/mm-imx25.c                    |   15 +++--
>  arch/arm/mach-imx/mm-imx27.c                    |   14 +++--
>  arch/arm/mach-imx/mm-imx3.c                     |   24 +++++---
>  arch/arm/mach-imx/mm-imx5.c                     |   74 +++++++++++++++++------
>  arch/arm/plat-mxc/avic.c                        |   13 +++-
>  arch/arm/plat-mxc/include/mach/common.h         |    3 +
>  arch/arm/plat-mxc/include/mach/devices-common.h |   28 ++++++++-
>  arch/arm/plat-mxc/include/mach/irqs.h           |   44 -------------
>  arch/arm/plat-mxc/irq-common.h                  |    3 +
>  arch/arm/plat-mxc/tzic.c                        |   13 +++-
>  drivers/media/video/mx1_camera.c                |    1 +
>  sound/soc/fsl/imx-pcm-fiq.c                     |    1 +
>  20 files changed, 168 insertions(+), 110 deletions(-)

...

>  static inline struct platform_device *imx_add_platform_device_dmamask(
>  		const char *name, int id,
> -		const struct resource *res, unsigned int num_resources,
> +		struct resource *res, unsigned int num_resources,
>  		const void *data, size_t size_data, u64 dmamask)
>  {
>  	struct platform_device_info pdevinfo = {
> @@ -28,12 +30,34 @@ static inline struct platform_device *imx_add_platform_device_dmamask(
>  		.size_data = size_data,
>  		.dma_mask = dmamask,
>  	};
> +
> +	int i;
> +
> +	/* convert to linux virtual irq for driver to use */
> +	for (i = 0; i < num_resources; i++) {
> +		if (res[i].flags & IORESOURCE_IRQ) {
> +#ifdef CONFIG_MXC_AVIC
> +			if (cpu_is_mx1() || cpu_is_mx21()
> +				|| cpu_is_mx25() || cpu_is_mx27()
> +				|| cpu_is_mx31() || cpu_is_mx35())
> +				res[i].start = avic_irq_find_mapping(res[i].start);
> +#endif
> +
> +#ifdef CONFIG_MXC_TZIC
> +			if (cpu_is_mx50() || cpu_is_mx51() || cpu_is_mx53())
> +				res[i].start = tzic_irq_find_mapping(res[i].start);
> +#endif
> +			WARN_ON(!res[i].start);
> +			res[i].end = res[i].start;
> +		}
> +	}
> +
What a "beautiful" hacking!  I'm so familiar with such kind of code,
because I have been working for long time to kill them.

As I said, not every single imx device is added by calling
imx_add_platform_device.  And if you really want to do this conversion,
the right place should be platform_device_add_resources(), so that no
one could possibly be missed, and we do not have imx be so unique on
this conversion.  If you can do that, I would be happy to ACK it.
But I guess you will have a "little" problem with doing that. 

>  	return platform_device_register_full(&pdevinfo);
>  }

-- 
Regards,
Shawn
