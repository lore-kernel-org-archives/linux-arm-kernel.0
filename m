From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 25 Apr 2011 15:21:17 -0700
Subject: [PATCH resend] rtc: Adding support for spear rtc
In-Reply-To: <b5f52fa9b1acd0c524ecb357788b22a1b6d8fa9c.1303730912.git.viresh.kumar@st.com>
References: <b5f52fa9b1acd0c524ecb357788b22a1b6d8fa9c.1303730912.git.viresh.kumar@st.com>
Message-ID: <20110425152117.424cdba1.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr 2011 17:00:26 +0530
Viresh Kumar <viresh.kumar@st.com> wrote:

> From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/rtc/Kconfig     |    8 +
>  drivers/rtc/Makefile    |    1 +
>  drivers/rtc/rtc-spear.c |  534 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 543 insertions(+), 0 deletions(-)

The driver looks nice and clean.

>
> ...
>
> +static void rtc_wait_not_busy(struct spear_rtc_config *config)
> +{
> +	int status, count = 0;
> +	unsigned long flags;
> +
> +	/* Assuming BUSY may stay active for 80 msec) */
> +	for (count = 0; count < 80; count++) {
> +		spin_lock_irqsave(&config->lock, flags);
> +		status = readl(config->ioaddr + STATUS_REG);
> +		spin_unlock_irqrestore(&config->lock, flags);
> +		if ((status & STATUS_BUSY) == 0)
> +			break;
> +		/* check status busy, after each msec */
> +		msleep(1);
> +	}
> +}

Question.  What activity causes STATUS_BUSY to become set?

>
> ...
>
> +static int spear_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct rtc_device *rtc = platform_get_drvdata(pdev);
> +	struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
> +	unsigned int time, date;
> +
> +	/* we don't report wday/yday/isdst ... */
> +	rtc_wait_not_busy(config);

Because here, we've waited for STATUS_BUSY to clear, but we don't
appear to have taken any steps to prevent it from getting set again
while these steps:

> +	time = readl(config->ioaddr + TIME_REG);
> +	date = readl(config->ioaddr + DATE_REG);
> +	tm->tm_sec = (time >> SECOND_SHIFT) & SECOND_MASK;
> +	tm->tm_min = (time >> MINUTE_SHIFT) & MIN_MASK;
> +	tm->tm_hour = (time >> HOUR_SHIFT) & HOUR_MASK;
> +	tm->tm_mday = (date >> MDAY_SHIFT) & DAY_MASK;
> +	tm->tm_mon = (date >> MONTH_SHIFT) & MONTH_MASK;
> +	tm->tm_year = (date >> YEAR_SHIFT) & YEAR_MASK;

are in progress?

> +	bcd2tm(tm);
> +	return 0;
> +}
>
> ...
>
