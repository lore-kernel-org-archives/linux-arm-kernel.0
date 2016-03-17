From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 17 Mar 2016 15:53:54 +0300
Subject: [PATCH v2 09/11] usb: ohci-da8xx: Remove code that references mach
In-Reply-To: <1458181615-27782-10-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-10-git-send-email-david@lechnology.com>
Message-ID: <56EAA8E2.7070904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 5:26 AM, David Lechner wrote:

> Including mach/* is frowned upon in device drivers, so get rid of it.
>
> This replaces usb20_clk and code that pokes CFGCHIP2 with a proper phy
> driver.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>
> v2 changes: Uses the new phy driver instead of using a second clock.
>
>
>   drivers/usb/host/ohci-da8xx.c | 90 +++++++++++++++++++++----------------------
>   1 file changed, 44 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index e5c33bc..c648674 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -15,58 +15,40 @@
>   #include <linux/jiffies.h>
>   #include <linux/platform_device.h>
>   #include <linux/clk.h>
> -
> -#include <mach/da8xx.h>
> +#include <linux/phy/phy.h>
>   #include <linux/platform_data/usb-davinci.h>
>
>   #ifndef CONFIG_ARCH_DAVINCI_DA8XX
>   #error "This file is DA8xx bus glue.  Define CONFIG_ARCH_DAVINCI_DA8XX."
>   #endif
>
> -#define CFGCHIP2	DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG)
> -
>   static struct clk *usb11_clk;
> -static struct clk *usb20_clk;
> +static struct phy *usb11_phy;
>
>   /* Over-current indicator change bitmask */
>   static volatile u16 ocic_mask;
>
> -static void ohci_da8xx_clock(int on)
> +static int ohci_da8xx_enable(void)
>   {
[...]
> +	ret = clk_prepare_enable(usb11_clk);
> +	if (ret)
> +		return ret;
>
> -		/* Disable USB 1.1 PHY */
> -		cfgchip2 &= ~CFGCHIP2_USB1SUSPENDM;
> +	ret = phy_power_on(usb11_phy);

    Aren't you supposed to call phy_init() first?

> +	if (ret) {
> +		clk_disable_unprepare(usb11_clk);
> +		return ret;
>   	}
> -	__raw_writel(cfgchip2, CFGCHIP2);
> +
> +	return 0;
> +}
> +
> +static void ohci_da8xx_disable(void)
> +{
> +	phy_power_off(usb11_phy);

   ... and phy_exit() after that?

> +	clk_disable_unprepare(usb11_clk);
>   }
>
>   /*
[...]

MBR, Sergei
