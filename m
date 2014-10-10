From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Oct 2014 13:08:03 -0500
Subject: [PATCH 10/12] rtc: omap: enable wake-up from power off
In-Reply-To: <1412881594-25678-11-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-11-git-send-email-johan@kernel.org>
Message-ID: <20141010180755.GW31348@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 09:06:32PM +0200, Johan Hovold wrote:
> The ALARM interrupt must not be disabled during shutdown in order to be
> able to power up the system using an RTC alarm.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

nicely done!

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index b0319864dd42..8836c58901b5 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -670,7 +670,15 @@ static SIMPLE_DEV_PM_OPS(omap_rtc_pm_ops, omap_rtc_suspend, omap_rtc_resume);
>  
>  static void omap_rtc_shutdown(struct platform_device *pdev)
>  {
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	u8 mask;
> +
> +	/*
> +	 * Keep the ALARM interrupt enabled to allow the system to power up on
> +	 * alarm events.
> +	 */
> +	mask = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> +	mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
> +	rtc_write(mask, OMAP_RTC_INTERRUPTS_REG);
>  }
>  
>  MODULE_ALIAS("platform:omap_rtc");
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/cefe0c51/attachment-0001.sig>
