From: balbi@ti.com (Felipe Balbi)
Date: Thu, 11 Aug 2011 17:15:31 +0300
Subject: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
	implementations
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Message-ID: <20110811141528.GL28500@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 09:08:01AM +0100, Russell King - ARM Linux wrote:
> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/gpio.h                 |   10 ++++++++++
>  arch/arm/mach-at91/include/mach/gpio.h      |    5 +----
>  arch/arm/mach-ep93xx/include/mach/gpio.h    |    7 +------
>  arch/arm/mach-exynos4/include/mach/gpio.h   |    5 +----
>  arch/arm/mach-gemini/include/mach/gpio.h    |    5 +----
>  arch/arm/mach-ks8695/include/mach/gpio.h    |   11 ++---------
>  arch/arm/mach-lpc32xx/include/mach/gpio.h   |   17 +----------------
>  arch/arm/mach-msm/include/mach/gpio.h       |    5 +----
>  arch/arm/mach-mxs/include/mach/gpio.h       |    6 +-----
>  arch/arm/mach-realview/include/mach/gpio.h  |    6 +-----
>  arch/arm/mach-s3c2410/include/mach/gpio.h   |    5 +----
>  arch/arm/mach-s3c64xx/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5p64x0/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5pc100/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5pv210/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-shmobile/include/mach/gpio.h  |   15 +--------------
>  arch/arm/mach-tegra/include/mach/gpio.h     |    6 +-----
>  arch/arm/mach-versatile/include/mach/gpio.h |    6 +-----
>  arch/arm/mach-vt8500/include/mach/gpio.h    |    6 +-----
>  arch/arm/mach-w90x900/include/mach/gpio.h   |    5 +----
>  arch/arm/plat-mxc/include/mach/gpio.h       |    5 +----
>  arch/arm/plat-nomadik/include/plat/gpio.h   |   11 +----------
>  arch/arm/plat-omap/include/plat/gpio.h      |   15 +--------------
>  arch/arm/plat-orion/include/plat/gpio.h     |    6 ++----
>  arch/arm/plat-spear/include/plat/gpio.h     |    6 +-----
>  25 files changed, 36 insertions(+), 151 deletions(-)
> 
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 166a7a3..15e8970 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -4,4 +4,14 @@
>  /* not all ARM platforms necessarily support this API ... */
>  #include <mach/gpio.h>
>  
> +#ifdef __ARM_GPIOLIB_TRIVIAL
> +/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
> +#include <asm-generic/gpio.h>
> +
> +/* The trivial gpiolib dispatchers */
> +#define gpio_get_value  __gpio_get_value
> +#define gpio_set_value  __gpio_set_value
> +#define gpio_cansleep   __gpio_cansleep
> +#endif

could that be a selectable symbol ? Something like:

CONFIG_HAS_ARM_TRIVIAL_GPIO

then on Kconfig you just:

select HAS_ARM_TIVIAL_GPIO or something ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110811/69b04482/attachment.sig>
