From: rajeev-dlh.kumar@st.com (rajeev)
Date: Thu, 28 Apr 2011 11:11:04 +0530
Subject: [PATCH resend] rtc: Adding support for spear rtc
In-Reply-To: <20110425152117.424cdba1.akpm@linux-foundation.org>
References: <b5f52fa9b1acd0c524ecb357788b22a1b6d8fa9c.1303730912.git.viresh.kumar@st.com>
	<20110425152117.424cdba1.akpm@linux-foundation.org>
Message-ID: <4DB8FDF0.5070604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/26/2011 3:51 AM, Andrew Morton wrote:
> On Mon, 25 Apr 2011 17:00:26 +0530
> Viresh Kumar <viresh.kumar@st.com> wrote:
>> From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
>> +static void rtc_wait_not_busy(struct spear_rtc_config *config)
>> +{
>> +	int status, count = 0;
>> +	unsigned long flags;
>> +
>> +	/* Assuming BUSY may stay active for 80 msec) */
>> +	for (count = 0; count < 80; count++) {
>> +		spin_lock_irqsave(&config->lock, flags);
>> +		status = readl(config->ioaddr + STATUS_REG);
>> +		spin_unlock_irqrestore(&config->lock, flags);
>> +		if ((status & STATUS_BUSY) == 0)
>> +			break;
>> +		/* check status busy, after each msec */
>> +		msleep(1);
>> +	}
>> +}
> 
> Question.  What activity causes STATUS_BUSY to become set?
> 

STATUS_BUSY is (PD | PT), where
[3] PD: Pending write to Date register.
[2] PT: Pending write to Time register.

So, when we have updated date and time, these bits ensures that date and time
are actually written in h/w.

>>
>> ...
>>
>> +static int spear_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct rtc_device *rtc = platform_get_drvdata(pdev);
>> +	struct spear_rtc_config *config = dev_get_drvdata(&rtc->dev);
>> +	unsigned int time, date;
>> +
>> +	/* we don't report wday/yday/isdst ... */
>> +	rtc_wait_not_busy(config);
> 
> Because here, we've waited for STATUS_BUSY to clear, but we don't
> appear to have taken any steps to prevent it from getting set again
> while these steps:
>
>> +	time = readl(config->ioaddr + TIME_REG);
>> +	date = readl(config->ioaddr + DATE_REG);
>> +	tm->tm_sec = (time >> SECOND_SHIFT) & SECOND_MASK;
>> +	tm->tm_min = (time >> MINUTE_SHIFT) & MIN_MASK;
>> +	tm->tm_hour = (time >> HOUR_SHIFT) & HOUR_MASK;
>> +	tm->tm_mday = (date >> MDAY_SHIFT) & DAY_MASK;
>> +	tm->tm_mon = (date >> MONTH_SHIFT) & MONTH_MASK;
>> +	tm->tm_year = (date >> YEAR_SHIFT) & YEAR_MASK;
> 
> are in progress?
> 

Because, we haven't written anything to date and time regs and so BUSY will not
be set again during these steps.

Best Rgds
Rajeev
