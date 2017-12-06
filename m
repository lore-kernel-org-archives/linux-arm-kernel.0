From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 6 Dec 2017 09:58:25 +0100
Subject: [PATCH v2 5/5] rtc: add mxc driver for i.MX53 SRTC
In-Reply-To: <20171206083618.eea63zqmpgaaazwl@pengutronix.de>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
 <20171206083618.eea63zqmpgaaazwl@pengutronix.de>
Message-ID: <20171206085825.GM21780@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2017 at 09:36:18 +0100, Sascha Hauer wrote:
> > +/*
> > + * This function updates the RTC alarm registers and then clears all the
> > + * interrupt status bits.
> > + * The caller should hold the pdata->lock
> > + *
> > + * @param  alrm         the new alarm value to be updated in the RTC
> > + *
> > + * @return  0 if successful; non-zero otherwise.
> > + */
> > +static int mxc_rtc_write_alarm_locked(struct mxc_rtc_data *const pdata,
> > +				      struct rtc_time *alarm_tm)
> > +{
> > +	void __iomem *const ioaddr = pdata->ioaddr;
> > +	unsigned long time;
> > +
> > +	rtc_tm_to_time(alarm_tm, &time);
> > +
> > +	if (time > U32_MAX) {
> > +		pr_err("Hopefully I am out of service by then :-(\n");
> > +		return -EINVAL;
> > +	}
> 
> This will never happen as on your target hardware unsigned long is a
> 32bit type. Not sure what is best to do here. Maybe you should test
> the return value of rtc_tm_to_time. ATM it returns 0 unconditionally,
> but rtc_tm_to_time could detect when the input time doesn't fit into
> its return type and return an error in this case.
> Also I just realized that it's unsigned and only overflows in the year
> 2106. I'm most likely dead then so I don't care that much ;)
> 

One solution is to use the 64bit version instead so it doesn't overflow.
This makes the time > U32_MAX work.
Also, I'll send (hopefully soon) a series adding proper range checking
for the whole RTC subsystem. And yes, it not urgent as I don't think I
will care so much in 2106 too ;)

> > +/*
> > + * This function reads the current RTC time into tm in Gregorian date.
> > + *
> > + * @param  tm           contains the RTC time value upon return
> > + *
> > + * @return  0 if successful; non-zero otherwise.
> > + */
> > +static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
> > +	time_t now;
> > +	int ret = mxc_rtc_lock(pdata);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	now = readl(pdata->ioaddr + SRTC_LPSCMR);
> > +	rtc_time_to_tm(now, tm);
> > +	ret = rtc_valid_tm(tm);

This check is useless for two reasons: you know that rtc_time_to_tm will
generate a valid tm and the core always checks the tm anyway.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
