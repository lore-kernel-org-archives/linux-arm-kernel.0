From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 01 Jul 2013 17:06:38 -0700
Subject: [PATCH 1/4] rtc: omap: restore back (hard-code) wakeup support
In-Reply-To: <1372412109-986-2-git-send-email-gururaja.hebbar@ti.com> (Hebbar
 Gururaja's message of "Fri, 28 Jun 2013 15:05:06 +0530")
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <87ehbhomep.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> rtc-omap driver modules is used both by OMAP1/2, Davinci SoC platforms.
>
> However, rtc wake support on OMAP1 is broken. Hence the
> device_init_wakeup() was removed from rtc-omap driver and moved to
> platform board files that supported it (DA850/OMAP-L138). [1]
>
> However, recently [2] it was suggested that driver should always do a
> device_init_wakeup(dev, true). Platforms that don't want/need
> wakeup support can disable it from userspace via:
>
>     echo disabled > /sys/devices/.../power/wakeup
>
> Also, with the new DT boot-up, board file doesn't exist and hence there
> is no way to have device wakeup support rtc.
>
> The fix for above issues, is to hard code device_init_wakeup() inside
> driver and let platforms that don't need this, handle it through the
> sysfs power entry.
>
> [1]
> https://patchwork.kernel.org/patch/136731/
>
> [2]
> http://www.mail-archive.com/davinci-linux-open-source at linux.
> davincidsp.com/msg26077.html
>
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
> :100644 100644 b0ba3fc... 761919d... M	drivers/rtc/rtc-omap.c
>  drivers/rtc/rtc-omap.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index b0ba3fc..761919d 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -423,6 +423,8 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  	 *    is write-only, and always reads as zero...)
>  	 */
>  
> +	device_init_wakeup(&pdev->dev, true);
> +
>  	if (new_ctrl & (u8) OMAP_RTC_CTRL_SPLIT)
>  		pr_info("%s: split power mode\n", pdev->name);
