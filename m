From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 20 Aug 2017 23:10:16 +0200
Subject: [RFC 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170820083219.siez3rl2hbjgjgk5@piout.net>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-3-afaerber@suse.de>
 <20170820083219.siez3rl2hbjgjgk5@piout.net>
Message-ID: <3307d3ed-c8e0-a7b5-f0ee-d401f4b12a90@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Am 20.08.2017 um 10:32 schrieb Alexandre Belloni:
> On 20/08/2017 at 03:36:30 +0200, Andreas F?rber wrote:
>> +static int rtd119x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
>> +	time64_t t;
>> +	u32 day;
>> +
>> +	day = readl_relaxed(data->base + RTD_RTCDATE_LOW);
>> +	day |= readl_relaxed(data->base + RTD_RTCDATE_HIGH) << 8;
> 
> Is RTD_RTCDATE_HIGH latched when RTD_RTCDATE_LOW is read?

I do not have an answer to that.

> If this is not
> the case, you probably want to handle a possible update between both
> readl_relaxed.

Are you proposing to disable the RTC while reading the registers, or
something related to my choice of _relaxed? (it follows an explanation
by Marc Zyngier on the irq mux series) Inconsistencies might not be
limited to the date.

>> +	t = mktime64(data->base_year, 1, 1, 0, 0, 0);
>> +	t += day * 24 * 60 * 60;
>> +	rtc_time64_to_tm(t, tm);

BTW is there any more efficient way to get from year+days to
day/month/year without going via seconds?

>> +	tm->tm_sec  = readl_relaxed(data->base + RTD_RTCSEC) >> 1;
>> +	tm->tm_min  = readl_relaxed(data->base + RTD_RTCMIN);
>> +	tm->tm_hour = readl_relaxed(data->base + RTD_RTCHR);
>> +
>> +	return rtc_valid_tm(tm);
>> +}
>> +
>> +static int rtd119x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
>> +	time64_t time_base, new_time, time_delta;
>> +	unsigned long day;
>> +
>> +	if (tm->tm_year < data->base_year)
>> +		return -EINVAL;
>> +
>> +	time_base = mktime64(data->base_year, 1, 1, 0, 0, 0);
>> +	new_time = rtc_tm_to_time64(tm);
>> +	time_delta = new_time - time_base;
>> +	day = time_delta / (24 * 60 * 60);
>> +	if (day > 0x7fff)
>> +		return -EINVAL;
>> +
>> +	rtd119x_rtc_set_enabled(dev, false);
>> +
>> +	writel_relaxed(tm->tm_sec,  data->base + RTD_RTCSEC);
>> +	writel_relaxed(tm->tm_min,  data->base + RTD_RTCMIN);
>> +	writel_relaxed(tm->tm_hour, data->base + RTD_RTCHR);
>> +	writel_relaxed(day & 0xff, data->base + RTD_RTCDATE_LOW);
>> +	writel_relaxed((day >> 8) & 0x7f, data->base + RTD_RTCDATE_HIGH);
>> +
>> +	rtd119x_rtc_set_enabled(dev, true);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rtd119x_rtc_open(struct device *dev)
>> +{
>> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(data->clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = readl_relaxed(data->base + RTD_RTCACR);
>> +	dev_info(dev, "rtcacr = 0x%08x\n", val);
>> +	if (!(val & BIT(7))) {
>> +	}
> 
> I don't see the point of reading that register, and not doing anything
> with it.

Thanks for spotting this. The story is that the old downstream has code
for this case, but in my testing I didn't run into that path and forgot.
Explanations are largely missing in the vendor code. That code should
probably be added here in v2 and the dev_info() dropped, rather than
dropping the current no-op expression.

>> +
>> +	rtd119x_rtc_set_enabled(dev, true);
>> +
> 
> This is certainly not what you want. The RTC device is usually not
> opened so enabling the RTC when open and disabling it when closed will
> not work on most systems. This is probably true for the clock too. i.e
> what you do here should be done in probe.

I did test the probe path to work, but I can change it again. The
downstream code had it in probe, but looking at rtc_class_ops I saw
those hooks and thought they'd serve a purpose - what are they for then?
(Any chance you can improve the documentation comments to avoid such
misunderstandings? :))

>> +	return 0;
>> +}
[snip]

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
