From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jan 2015 10:51:44 +0100
Subject: [PATCH v2 2/5] drivers/rtc/rtc-armada38x: Add a new RTC driver
 for recent mvebu SoCs
In-Reply-To: <871tmxrsj8.fsf@natisbad.org>
References: <1421257155-3379-1-git-send-email-gregory.clement@free-electrons.com>	<1421257155-3379-3-git-send-email-gregory.clement@free-electrons.com>
 <871tmxrsj8.fsf@natisbad.org>
Message-ID: <54B78DB0.5050808@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,
[...]

>> +/*
>> + * According to the datasheet, we need to wait for 5us only between
>> + * two consecutive writes
>> + */
>> +static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
>> +{
>> +	writel(val, rtc->regs + offset);
>> +	udelay(5);
>> +}
> 
> The thing I do not get is how you can guarantee that an undelayed
> writel() in a function will not be followed less than 5?s later by
> another writel() in another function. For instance:
> 
>   1) a call to set_alarm() followed by a call to alarm_irq_enable().
>   2) some writel() or even rtc_udelayed_write() w/ sth asynchronous
>     occuring like your interrupt handler just after that.
> 
> I guess it may be possible to make assumptions on the fact that the
> amount of code before a writel() or rtc_udelayed_write() may prevent
> such scenario but it's difficult to tell, all the more w/ a spinlock
> before the writel() in irq_enable().
> 
> Considering the description of the bug, why not doing the following:
> 
>  1) implement rtc_delayed_write() a bit differently:
> 
>     static inline void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
>     {
> 	udelay(5);
> 	writel(val, rtc->regs + offset);
>     }
> 
>  2) remove all writel() in the driver and use rtc_delayed_write()
>     everywhere.
> 
> All writes being under the protection of your spinlock, this will
> guarantee the 5?s delay in all cases.

You're right. I tried avoiding loosing microseconds here and there, but there
is too many case where it can fail. So let's us it everywhere.

[...]

>> +static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
>> +	int ret = 0;
>> +	unsigned long time, flags;
>> +
>> +	ret = rtc_tm_to_time(tm, &time);
>> +
>> +	if (ret)
>> +		goto out;
>> +	/*
>> +	 * Setting the RTC time not always succeeds. According to the
>> +	 * errata we need to first write on the status register and
>> +	 * then wait for 100ms before writing to the time register to be
>> +	 * sure that the data will be taken into account.
>> +	 */
>> +	spin_lock_irqsave(&rtc->lock, flags);
>> +
>> +	writel(0, rtc->regs + RTC_STATUS);
>> +
>> +	spin_unlock_irqrestore(&rtc->lock, flags);
>> +
>> +	msleep(100);
>> +
>> +	spin_lock_irqsave(&rtc->lock, flags);
>> +
>> +	writel(time, rtc->regs + RTC_TIME);
> 
> probably not critical (it's rtc clock and not system clock) but you still
> introduce a 100ms shift when setting time here.

I am aware of this shift but the granularity is the second, so we can't do
better, we have to deal with the limitation of the hardware. :(

> 
> As for the two writel() not being done w/o releasing the spinlock, it
> looks a bit weird but it seems it's ok for other functions manipulating
> RTC_STATUS reg. 
> 
> Nonetheless, in the reverse direction, if a writel() occurs somewhere
> (e.g. in the alarm irq handler) during your msleep(), you may do your
> final writel() w/o having enforced the expected 100ms delay.

Actually I don't know if it is problematic if a writel occur in an other register
during the 100ms. I still wait for an answer for it.


Thanks,

Gregory




-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
