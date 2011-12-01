From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Dec 2011 15:18:07 +0100
Subject: [PATCH] arm/imx6: add restart support for imx6q
In-Reply-To: <1322668872-13011-1-git-send-email-shawn.guo@linaro.org>
References: <1322668872-13011-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111201141807.GN27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 12:01:12AM +0800, Shawn Guo wrote:
> The restart support was missed from the initial imx6q submission.
> The mxc_restart() does not work for imx6q.  Instead, this patch adds
> the restart for imx6q.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Hi Russell,
> 
> This patch is to support restart support for imx6q based on your
> 'reset' branch.  Is it possible for you to take this patch through
> your 'reset' branch?
> 
>  arch/arm/mach-imx/clock-imx6q.c         |    2 -
>  arch/arm/mach-imx/mach-imx6q.c          |   33 ++++++++++++++++++++++++++++++-
>  arch/arm/mach-imx/src.c                 |   23 +++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/common.h |    1 +
>  4 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
> index 613a1b9..2234031 100644
> --- a/arch/arm/mach-imx/clock-imx6q.c
> +++ b/arch/arm/mach-imx/clock-imx6q.c
> @@ -1931,14 +1931,12 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
>  		val |= 0x1 << BP_CLPCR_LPM;
>  		val &= ~BM_CLPCR_VSTBY;
>  		val &= ~BM_CLPCR_SBYOS;
> -		val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
>  		break;
>  	case STOP_POWER_OFF:
>  		val |= 0x2 << BP_CLPCR_LPM;
>  		val |= 0x3 << BP_CLPCR_STBY_COUNT;
>  		val |= BM_CLPCR_VSTBY;
>  		val |= BM_CLPCR_SBYOS;
> -		val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index dc8b6e2..54ce8ec 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -10,10 +10,13 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/init.h>
> +#include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <asm/hardware/cache-l2x0.h>
> @@ -23,6 +26,34 @@
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  
> +void imx6q_restart(char mode, const char *cmd)
> +{
> +	struct device_node *np;
> +	void __iomem *wdog_base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> +	wdog_base = of_iomap(np, 0);
> +	WARN_ON(!wdog_base);

You don't need a WARN_ON here as you derefence the NULL pointer below...
Wouldn't it be better to do soft_restart() if the iomap fails?


> +
> +	imx_src_prepare_restart();
> +
> +	/* enable wdog */
> +	writew_relaxed(1 << 2, wdog_base);
> +	/* write twice to ensure the request will not get ignored */
> +	writew_relaxed(1 << 2, wdog_base);
> +
> +	/* wait for reset to assert ... */
> +	mdelay(500);
> +
> +	pr_err("Watchdog reset failed to assert reset\n");
> +
> +	/* delay to allow the serial port to show the message */
> +	mdelay(50);
> +
> +	/* we'll take a jump through zero as a poor second */
> +	soft_restart(0);
> +}
> +

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
