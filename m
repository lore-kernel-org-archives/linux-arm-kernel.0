From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 18 Mar 2015 11:27:40 +0800
Subject: [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <20150317134345.GG10068@pengutronix.de>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
 <20150316153048.GC10068@pengutronix.de>
 <1426595474.24415.18.camel@mtksdaap41>
 <20150317134345.GG10068@pengutronix.de>
Message-ID: <1426649260.3662.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, 2015-03-17 at 14:43 +0100, Uwe Kleine-K?nig wrote:
> Hello Eddie,
> 
> On Tue, Mar 17, 2015 at 08:31:14PM +0800, Eddie Huang wrote:
> > On Mon, 2015-03-16 at 16:30 +0100, Uwe Kleine-K?nig wrote:
> > > On Wed, Jan 28, 2015 at 05:27:56PM +0800, Eddie Huang wrote:
> > > > [...]
> > > > +static u16 rtc_read(struct mt6397_rtc *rtc, u32 offset)
> > > rtc_read is a bad name for a driver. There are already 6 functions with
> > > this name in the kernel. Better use a unique prefix.
> > 
> > I will use prefix mtk_
> I would prefer a prefix that is unique to the driver. "mtk_" doesn't
> work to distinguish between the rtc and a (say) spi driver. What you
> want here is that if someone reports a bug on any mailinglist with a
> backtrace you are able to immediately see which driver is affected.
> 

My meaning is mtk_rtc_read, mtk_rtc_write.

> > > > [...]
> > > > +static irqreturn_t rtc_irq_handler_thread(int irq, void *data)
> > > > +{
> > > > +	struct mt6397_rtc *rtc = data;
> > > > +	u16 irqsta, irqen;
> > > > +
> > > > +	mutex_lock(&rtc->lock);
> > > > +	irqsta = rtc_read(rtc, RTC_IRQ_STA);
> > > Do you really need to lock for a single read access?
> > 
> > I think this lock is necessary, because other thread may access rtc
> > register at the same time, for example, call mtk_rtc_set_alarm to modify
> > alarm time.
> That would be a valid reason if mtk_rtc_set_alarm touched that register
> twice in a single critical section and the handler must not read the
> value of the first write. Otherwise it should be fine, shouldn't it?
> 

My original though is if disable alarm in mtk_rtc_set_alarm function,
RTC_IRQ_STA may be affected, this is why I add mutex. After checking
with designer, RTC_IRQ_STA will not be affected. I will remove the
mutex.

> > > > +static int mtk_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > > > +{
> > > > +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> > > > +
> > > > +	tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> > > > +	tm->tm_mon++;
> > > > +	mutex_lock(&rtc->lock);
> > > > +	rtc_write(rtc, RTC_TC_YEA, tm->tm_year);
> > > > +	rtc_write(rtc, RTC_TC_MTH, tm->tm_mon);
> > > > +	rtc_write(rtc, RTC_TC_DOM, tm->tm_mday);
> > > > +	rtc_write(rtc, RTC_TC_HOU, tm->tm_hour);
> > > > +	rtc_write(rtc, RTC_TC_MIN, tm->tm_min);
> > > > +	rtc_write(rtc, RTC_TC_SEC, tm->tm_sec);
> > > Is this racy? I.e. what happens if RTC_TC_SEC overflows just before you
> > > write to it but after you wrote RTC_TC_MIN?
> > 
> > register value will write to hardware after rtc_write_trigger, so the
> > racy condition not exist.
> Ah, it seems the hardware guys did their job. Nice.
> 
> Best regards
> Uwe
> 
