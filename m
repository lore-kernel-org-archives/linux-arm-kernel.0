From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 3 May 2015 20:56:01 +0200
Subject: [PATCHv7 8/8] watchdog: omap_wdt: Convert to use new core
 extensions
In-Reply-To: <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <20150503185601.GD25193@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Apr 22, 2015 at 02:11:42PM +0300, Timo Kokkonen wrote:
> Use the new watchdog core extensions to let watchdog core take over
> boot time watchdog behavior. The difference is that early-timeout-sec
> device tree property becomes available for this driver and a running
> watchdog is not stopped unless the core decides to stop it.
> 
> Omap watchdog is running by default in the boot up but bootloader
> might have stopped it. Therefore we fill the WDOG_HW_RUNNING_AT_BOOT
> bit depending on the actual watchdog state so that the watchdog core
> can act properly.
> 
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> ---
>  drivers/watchdog/omap_wdt.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index bbaf39a..7164f2e 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -78,6 +78,13 @@ static void omap_wdt_reload(struct omap_wdt_dev *wdev)
>  	/* reloaded WCRR from WLDR */
>  }
>  
> +static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
> +{
> +	void __iomem *base = wdev->base;
> +
> +	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
> +}
This isn't reliable. The sequence needed to enable the watchdog is
	writel(0xbbbb, base + OMAP_WATCHDOG_SPR);
	writel(0x4444, base + OMAP_WATCHDOG_SPR);

The sequence to stop is:
	writel(0xaaaa, base + OMAP_WATCHDOG_SPR);
	writel(0x5555, base + OMAP_WATCHDOG_SPR);

But:

barebox at TI AM335x BeagleBone black:/ md 0x44e35048+4
44e35048: 00005555                                           UU..
barebox at TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444
barebox at TI AM335x BeagleBone black:/ md 0x44e35048+4
44e35048: 00004444                                           DD..

So the register contains 0x4444 but the timer doesn't run. So at best
testing for 0x4444 is a good heuristic.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
