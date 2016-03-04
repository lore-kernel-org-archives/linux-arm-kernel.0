From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 4 Mar 2016 05:37:26 -0800
Subject: [PATCH v6 3/6] watchdog: pnx4008: add support for soft reset
In-Reply-To: <1457040025-1108-4-git-send-email-slemieux.tyco@gmail.com>
References: <1457040025-1108-1-git-send-email-slemieux.tyco@gmail.com>
 <1457040025-1108-4-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <56D98F96.6040708@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 01:20 PM, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
>
> Add support for explicit soft reset using the reboot mode.
>
> The default reboot mode behavior is unchanged;
> you can overwrite the default reboot type in the board specific file
> "DT_MACHINE_START" definition using the "reboot_mode" parameter.
>
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes from v5 to v6:
> - remove typecast.
>
> Changes from v4 to v5:
> - no logical change; updated to work with new revision of patch #2.
>
> Changes from v3 to v4:
> - none.
>
> Changes from v2 to v3:
> - no logical change; updated to work with new revision of patch #2.
>
> Changes from v1 to v2:
> - Rename patch title;
>    was "arm: lpc32xx: restart: add support for soft reset"
> - Add change to "pnx-4008" driver instead of "mach-lpc32xx".
> - Use define available in "pnx-4008" when writting to watchdog register.
>
>   drivers/watchdog/pnx4008_wdt.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index f3be522..51be66e 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -129,9 +129,16 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
>   static int pnx4008_restart_handler(struct watchdog_device *wdd,
>   				   unsigned long mode, void *cmd)
>   {
> -	/* Instant assert of RESETOUT_N with pulse length 1mS */
> -	writel(13000, WDTIM_PULSE(wdt_base));
> -	writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
> +	if (mode == REBOOT_SOFT) {
> +		/* Force match output active */
> +		writel(EXT_MATCH0, WDTIM_EMR(wdt_base));
> +		/* Internal reset on match output (RESOUT_N not asserted) */
> +		writel(M_RES1, WDTIM_MCTRL(wdt_base));
> +	} else {
> +		/* Instant assert of RESETOUT_N with pulse length 1mS */
> +		writel(13000, WDTIM_PULSE(wdt_base));
> +		writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
> +	}
>
>   	/* Wait for watchdog to reset system */
>   	mdelay(1000);
>
