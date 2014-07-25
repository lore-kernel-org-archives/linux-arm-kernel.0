From: varkabhadram@gmail.com (Varka Bhadram)
Date: Fri, 25 Jul 2014 16:06:01 +0530
Subject: [PATCH v3 1/6] rtc: sun6i: Add sun6i RTC driver
In-Reply-To: <1406279608-489-2-git-send-email-wens@csie.org>
References: <1406279608-489-1-git-send-email-wens@csie.org>
 <1406279608-489-2-git-send-email-wens@csie.org>
Message-ID: <53D23311.5000402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 02:43 PM, Chen-Yu Tsai wrote:
> This patch introduces the driver for the RTC in the Allwinner A31 and
> A23 SoCs.
>
> Unlike the RTC found in A10/A20 SoCs, which was part of the timer, the
> RTC in A31/A23 are a separate hardware block, which also contain a few
> controls for the RTC block hardware (a regulator and RTC block GPIO pin
> latches), while also having separate interrupts for the alarms.
>
> The hardware is different enough to make a different driver for it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>   .../devicetree/bindings/rtc/sun6i-rtc.txt          |  17 +
>   drivers/rtc/Kconfig                                |   7 +
>   drivers/rtc/Makefile                               |   1 +
>   drivers/rtc/rtc-sun6i.c                            | 447 +++++++++++++++++++++
>   4 files changed, 472 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
>   create mode 100644 drivers/rtc/rtc-sun6i.c
>
(....)

> +static int sun6i_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
> +{
> +	struct sun6i_rtc_dev *chip = dev_get_drvdata(dev);
> +	u32 date = 0;
> +	u32 time = 0;
> +	int year;
> +
> +	year = rtc_tm->tm_year + 1900;
> +	if (year < SUN6I_YEAR_MIN || year > SUN6I_YEAR_MAX) {
> +		dev_err(dev, "rtc only supports year in range %d - %d\n",
> +				SUN6I_YEAR_MIN, SUN6I_YEAR_MAX);

dev_err(dev, "rtc only supports year in range %d - %d\n",
	SUN6I_YEAR_MIN, SUN6I_YEAR_MAX);

> +		return -EINVAL;
> +	}
> +
> +	rtc_tm->tm_year -= SUN6I_YEAR_OFF;
> +	rtc_tm->tm_mon += 1;
> +
> +	date = SUN6I_DATE_SET_DAY_VALUE(rtc_tm->tm_mday) |
> +		SUN6I_DATE_SET_MON_VALUE(rtc_tm->tm_mon)  |
> +		SUN6I_DATE_SET_YEAR_VALUE(rtc_tm->tm_year);
> +
> +	if (is_leap_year(year))
> +		date |= SUN6I_LEAP_SET_VALUE(1);
> +
> +	time = SUN6I_TIME_SET_SEC_VALUE(rtc_tm->tm_sec)  |
> +		SUN6I_TIME_SET_MIN_VALUE(rtc_tm->tm_min)  |
> +		SUN6I_TIME_SET_HOUR_VALUE(rtc_tm->tm_hour);
> +
> +	/* Check whether registers are writable */
> +	if (sun6i_rtc_wait(chip, SUN6I_LOSC_CTRL,
> +				SUN6I_LOSC_CTRL_ACC_MASK, 50)) {

if (sun6i_rtc_wait(chip, SUN6I_LOSC_CTRL,
		   SUN6I_LOSC_CTRL_ACC_MASK, 50)

> +		dev_err(dev, "rtc is still busy.\n");
> +		return -EBUSY;
> +	}
> +
> +	writel(time, chip->base + SUN6I_RTC_HMS);
> +
> +	/*
> +	 * After writing the RTC HH-MM-SS register, the
> +	 * SUN6I_LOSC_CTRL_RTC_HMS_ACC bit is set and it will not
> +	 * be cleared until the real writing operation is finished
> +	 */
> +
> +	if (sun6i_rtc_wait(chip, SUN6I_LOSC_CTRL,
> +				SUN6I_LOSC_CTRL_RTC_HMS_ACC, 50)) {

same..

> +		dev_err(dev, "Failed to set rtc time.\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	writel(date, chip->base + SUN6I_RTC_YMD);
> +
> +	/*
> +	 * After writing the RTC YY-MM-DD register, the
> +	 * SUN6I_LOSC_CTRL_RTC_YMD_ACC bit is set and it will not
> +	 * be cleared until the real writing operation is finished
> +	 */
> +
> +	if (sun6i_rtc_wait(chip, SUN6I_LOSC_CTRL,
> +				SUN6I_LOSC_CTRL_RTC_YMD_ACC, 50)) {

same...


-- 
Regards,
Varka Bhadram.
