From: khilman@ti.com (Kevin Hilman)
Date: Mon, 05 Mar 2012 16:09:28 -0800
Subject: [PATCH] mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
In-Reply-To: <20120305234240.GQ12083@atomide.com> (Tony Lindgren's message of
 "Mon, 5 Mar 2012 15:42:41 -0800")
References: <20120305234240.GQ12083@atomide.com>
Message-ID: <87obsaio93.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
>
> Otherwise we can get following warning when re-loading the
> omap_hsmmc driver module when gpio_twl4030 module is not
> loaded:
>
> omap_hsmmc omap_hsmmc.0: Unbalanced pm_runtime_enable!
> omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
> omap_hsmmc: probe of omap_hsmmc.0 failed with error -22
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>
> Kevin, maybe take a look and see if this is correct and
> fits into your PM branches?

Looks right to me:

Acked-by: Kevin Hilman <khilman@ti.com>

But this is a fix to the driver itself, so Chris should queue this in
mmc-next.

Chris, can you take this one?

Kevin


>
> Tony
>
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2146,6 +2146,7 @@ err_irq_cd_init:
>  err_irq:
>  	pm_runtime_mark_last_busy(host->dev);
>  	pm_runtime_put_autosuspend(host->dev);
> +	pm_runtime_disable(host->dev);
>  	clk_put(host->fclk);
>  	if (host->got_dbclk) {
>  		clk_disable(host->dbclk);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
