From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jul 2011 18:56:57 +0200
Subject: [PATCH v2 1/3] gpio/mxc: get gpio range/base from gpio core
In-Reply-To: <1309879166-25788-2-git-send-email-shawn.guo@linaro.org>
References: <1309879166-25788-1-git-send-email-shawn.guo@linaro.org>
	<1309879166-25788-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110705165657.GK6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 11:19:24PM +0800, Shawn Guo wrote:
> Instead of assigning the gpio range based on pdev->id, the patch
> makes changes to get the range from gpio core that is dynamically
> allocated.
> 
> As a result, the uses of pdev->id can be removed from the driver.
> This will make dt migration of the driver easier.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/gpio.h |   13 +++++++++----
>  arch/arm/plat-mxc/include/mach/irqs.h |   21 +++------------------
>  drivers/gpio/gpio-mxc.c               |   18 ++++++++++--------
>  3 files changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
> index 31c820c..abdf5d7 100644
> --- a/arch/arm/plat-mxc/include/mach/gpio.h
> +++ b/arch/arm/plat-mxc/include/mach/gpio.h
> @@ -23,10 +23,15 @@
>  #include <mach/hardware.h>
>  #include <asm-generic/gpio.h>
>  
> -
> -/* There's a off-by-one betweem the gpio bank number and the gpiochip */
> -/* range e.g. GPIO_1_5 is gpio 5 under linux */
> -#define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
> +/*
> + * There's a off-by-one betweem the gpio bank number and the gpiochip
> + * range e.g. GPIO_1_5 is gpio 5 under linux.
> + *
> + * When gpio core allocates gpio range for a bank, it starts from the
> + * end of the total range.  That is to say, bank 0 will get a higher
> + * gpio range than bank 1.
> + */
> +#define IMX_GPIO_NR(bank, nr)	(ARCH_NR_GPIOS - (bank) * 32 + (nr))

That is not a good idea. First of all not all boards use this macro.
This could be fixed, but it is a no go to allocate the gpios dynamically
and add a macro which makes assumptions on the range which gets
allocated.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
