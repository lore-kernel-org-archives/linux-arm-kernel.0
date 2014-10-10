From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Oct 2014 13:00:54 -0500
Subject: [PATCH 07/12] rtc: omap: silence bogus power-up reset message at
 probe
In-Reply-To: <1412881594-25678-8-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-8-git-send-email-johan@kernel.org>
Message-ID: <20141010180054.GS31348@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 09:06:29PM +0200, Johan Hovold wrote:
> Some legacy RTC IP revisions has a power-up reset flag in the status
> register that later revisions lack.
> 
> As this flag is always read back as set on later revisions (or is
> overloaded with a different flag), make sure to only clear the flag and
> print the info message on legacy platforms.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 1c58920b0c88..0ef016553a97 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -118,6 +118,12 @@
>   */
>  #define OMAP_RTC_HAS_32KCLK_EN		BIT(2)
>  
> +/*
> + * Some legacy RTC IP revisions has a power-up reset flag which later
> + * revisions lack.
> + */
> +#define OMAP_RTC_HAS_POWER_UP_RESET	BIT(3)
> +
>  static void __iomem	*rtc_base;
>  
>  #define rtc_read(addr)		readb(rtc_base + (addr))
> @@ -347,6 +353,7 @@ static int omap_rtc_timer;
>  static struct platform_device_id omap_rtc_devtype[] = {
>  	{
>  		.name	= DRIVER_NAME,
> +		.driver_data = OMAP_RTC_HAS_POWER_UP_RESET,
>  	},
>  	[OMAP_RTC_DATA_AM3352_IDX] = {
>  		.name	= "am3352-rtc",
> @@ -376,7 +383,7 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  {
>  	struct resource		*res;
>  	struct rtc_device	*rtc;
> -	u8			reg, new_ctrl;
> +	u8			reg, mask, new_ctrl;
>  	const struct platform_device_id *id_entry;
>  	const struct of_device_id *of_id;
>  
> @@ -429,12 +436,16 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  
>  	/* clear old status */
>  	reg = rtc_read(OMAP_RTC_STATUS_REG);
> -	if (reg & (u8) OMAP_RTC_STATUS_POWER_UP) {
> -		dev_info(&pdev->dev, "RTC power up reset detected\n");
> -		rtc_write(OMAP_RTC_STATUS_POWER_UP, OMAP_RTC_STATUS_REG);
> +
> +	mask = OMAP_RTC_STATUS_ALARM;
> +	if (id_entry->driver_data & OMAP_RTC_HAS_POWER_UP_RESET) {
> +		mask |= OMAP_RTC_STATUS_POWER_UP;
> +		if (reg & OMAP_RTC_STATUS_POWER_UP)
> +			dev_info(&pdev->dev, "RTC power up reset detected\n");
>  	}
> -	if (reg & (u8) OMAP_RTC_STATUS_ALARM)
> -		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
> +
> +	if (reg & mask)
> +		rtc_write(reg & mask, OMAP_RTC_STATUS_REG);
>  
>  	/* handle periodic and alarm irqs */
>  	if (devm_request_irq(&pdev->dev, omap_rtc_timer, rtc_irq, 0,
> -- 
> 2.0.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/60129a7b/attachment.sig>
