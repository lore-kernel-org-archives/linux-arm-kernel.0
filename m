From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 6 Nov 2012 05:45:34 +0000
Subject: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver
In-Reply-To: <1352108549-9341-3-git-send-email-anilkumar@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-3-git-send-email-anilkumar@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC04226@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 15:12:27, AnilKumar, Chimata wrote:
[...]
>  
> +#define SHUTDOWN_TIME_SEC		2
> +#define SECS_IN_MIN			60
> +#define WAIT_AFTER			(SECS_IN_MIN - SHUTDOWN_TIME_SEC)
> +#define WAIT_TIME_MS			(SHUTDOWN_TIME_SEC * 1000)
> +
>  static void __iomem	*rtc_base;
>  
[...]
> +
> +	/* Wait few seconds instead of rollover */
> +	do {
> +		omap_rtc_read_time(NULL, &tm);
> +		if (WAIT_AFTER <= tm.tm_sec)
> +			mdelay(WAIT_TIME_MS);
> +	} while (WAIT_AFTER <= tm.tm_sec);

This hardcoded wait for rollover doesn't look good. I see some
helper functions in rtc-lib.c which probably could be used for
converting the current time to elapsed seconds, add the delay and
then convert it back to the time to be programmed in RTC without
worrying about rollover. Why not use that?

> +
> +	/* Add shutdown time to the current value */
> +	tm.tm_sec += SHUTDOWN_TIME_SEC;
> +
> +	if (tm2bcd(&tm) < 0)
> +		return;
> +
> +	pr_info("System will go to power_off state in approx. %d secs\n",
> +			SHUTDOWN_TIME_SEC);
> +
> +	/* Set the ALARM2 time */
> +	rtc_write(tm.tm_sec, OMAP_RTC_ALARM2_SECONDS_REG);
> +	rtc_write(tm.tm_min, OMAP_RTC_ALARM2_MINUTES_REG);
> +	rtc_write(tm.tm_hour, OMAP_RTC_ALARM2_HOURS_REG);
> +	rtc_write(tm.tm_mday, OMAP_RTC_ALARM2_DAYS_REG);
> +	rtc_write(tm.tm_mon, OMAP_RTC_ALARM2_MONTHS_REG);
> +	rtc_write(tm.tm_year, OMAP_RTC_ALARM2_YEARS_REG);
> +
> +	/* Enable alarm2 interrupt */
> +	val = readl(rtc_base + OMAP_RTC_INTERRUPTS_REG);
> +	writel(val | OMAP_RTC_INTERRUPTS_IT_ALARM2,
> +				rtc_base + OMAP_RTC_INTERRUPTS_REG);
> +

These registers are not present in older versions of the IP so how
does that get handled?

You also need to describe the connection between the ALARM2 and the
power off logic in detail.

Regards,
Vaibhav
