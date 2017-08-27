From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 27 Aug 2017 11:13:01 +0200
Subject: [PATCH v2 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170827003328.28370-3-afaerber@suse.de>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
Message-ID: <20170827091301.wbuzxkh7opz4blrc@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Not much to add, apart from the spinlock issue already spotted by Andrew.

On 27/08/2017 at 02:33:27 +0200, Andreas F?rber wrote:
> +struct rtd119x_rtc {
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct rtc_device *rtcdev;
> +	unsigned base_year;

checkpatch complains this should be made unsigned int

> +	spinlock_t lock;
> +};
> +
> +static inline int rtd119x_rtc_year_days(int year)
> +{
> +	return rtc_year_days(1, 12, year);

I'm not sure it is worth wrapping rtc_year_days

> +static int rtd119x_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	unsigned long flags;
> +	s32 day;
> +	u32 sec;
> +	unsigned year;

unsigned int

> +	int tries = 0;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +
> + while (true) {
> +     tm->tm_sec = (readl_relaxed(data->base + RTD_RTCSEC) & RTD_RTCSEC_RTCSEC_MASK) >> 1;
> +     tm->tm_min  = readl_relaxed(data->base + RTD_RTCMIN) & RTD_RTCMIN_RTCMIN_MASK;
> +     tm->tm_hour = readl_relaxed(data->base + RTD_RTCHR) & RTD_RTCHR_RTCHR_MASK;
> +     day  =  readl_relaxed(data->base + RTD_RTCDATE1) & RTD_RTCDATE1_RTCDATE1_MASK;
> +     day |= (readl_relaxed(data->base + RTD_RTCDATE2) & RTD_RTCDATE2_RTCDATE2_MASK) << 8;
> +     sec  = (readl_relaxed(data->base + RTD_RTCSEC) & RTD_RTCSEC_RTCSEC_MASK) >> 1;
> +     tries++;
> +
> +     if (sec == tm->tm_sec)
> +         break;
> +
> +     if (tries >= 3) {
> +         spin_unlock_irqrestore(&data->lock, flags);
> +         return -EINVAL;
> +     }
> + }
> + if (tries > 1)
> +     dev_dbg(dev, "%s: needed %i tries\n", __func__, tries);
> +
> + spin_unlock_irqrestore(&data->lock, flags);
> +
> + year = data->base_year;
> + while (day >= rtd119x_rtc_year_days(year)) {
> +     day -= rtd119x_rtc_year_days(year);
> +     year++;
> + }
> + tm->tm_year = year - 1900;
> + tm->tm_yday = day;
> +
> + tm->tm_mon = 0;
> + while (day >= rtc_month_days(tm->tm_mon, year)) {
> +     day -= rtc_month_days(tm->tm_mon, year);
> +     tm->tm_mon++;
> + }
> + tm->tm_mday = day + 1;
> +
> + return rtc_valid_tm(tm);

As you spotted, you can return 0 here.

> +}
> +
> +static int rtd119x_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	unsigned long flags;
> +	unsigned day;

ditto


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
