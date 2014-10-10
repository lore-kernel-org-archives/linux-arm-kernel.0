From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Oct 2014 12:55:26 -0500
Subject: [PATCH 01/12] rtc: omap: fix clock-source configuration
In-Reply-To: <1412881594-25678-2-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-2-git-send-email-johan@kernel.org>
Message-ID: <20141010175515.GM31348@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 09:06:23PM +0200, Johan Hovold wrote:
> Make sure not to reset the clock-source configuration when enabling the
> 32kHz clock mux.
> 
> Until the clock source can be configured through device tree we must not
> overwrite settings made by the bootloader (e.g. clock-source selection).
> 
> Fixes: cd914bba03d8 ("drivers/rtc/rtc-omap.c: add support for enabling
> 32khz clock")
> Cc: stable <stable@vger.kernel.org>
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 21142e6574a9..f842c216f2dd 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -431,8 +431,10 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
>  
>  	/* enable RTC functional clock */
> -	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN)
> -		rtc_writel(OMAP_RTC_OSC_32KCLK_EN, OMAP_RTC_OSC_REG);
> +	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN) {
> +		reg = rtc_read(OMAP_RTC_OSC_REG);
> +		rtc_writel(reg | OMAP_RTC_OSC_32KCLK_EN, OMAP_RTC_OSC_REG);
> +	}
>  
>  	/* clear old status */
>  	reg = rtc_read(OMAP_RTC_STATUS_REG);
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/7bd0b537/attachment.sig>
