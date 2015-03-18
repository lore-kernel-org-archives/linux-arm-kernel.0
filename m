From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 18 Mar 2015 08:42:32 +0100
Subject: [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <1426649260.3662.5.camel@mtksdaap41>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
 <20150316153048.GC10068@pengutronix.de>
 <1426595474.24415.18.camel@mtksdaap41>
 <20150317134345.GG10068@pengutronix.de>
 <1426649260.3662.5.camel@mtksdaap41>
Message-ID: <20150318074232.GO10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eddie,

On Wed, Mar 18, 2015 at 11:27:40AM +0800, Eddie Huang wrote:
> On Tue, 2015-03-17 at 14:43 +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Mar 17, 2015 at 08:31:14PM +0800, Eddie Huang wrote:
> > > On Mon, 2015-03-16 at 16:30 +0100, Uwe Kleine-K?nig wrote:
> > > > On Wed, Jan 28, 2015 at 05:27:56PM +0800, Eddie Huang wrote:
> > > > > [...]
> > > > > +static irqreturn_t rtc_irq_handler_thread(int irq, void *data)
> > > > > +{
> > > > > +	struct mt6397_rtc *rtc = data;
> > > > > +	u16 irqsta, irqen;
> > > > > +
> > > > > +	mutex_lock(&rtc->lock);
> > > > > +	irqsta = rtc_read(rtc, RTC_IRQ_STA);
> > > > Do you really need to lock for a single read access?
> > > 
> > > I think this lock is necessary, because other thread may access rtc
> > > register at the same time, for example, call mtk_rtc_set_alarm to modify
> > > alarm time.
> > That would be a valid reason if mtk_rtc_set_alarm touched that register
> > twice in a single critical section and the handler must not read the
> > value of the first write. Otherwise it should be fine, shouldn't it?
> > 
> 
> My original though is if disable alarm in mtk_rtc_set_alarm function,
> RTC_IRQ_STA may be affected, this is why I add mutex. After checking
> with designer, RTC_IRQ_STA will not be affected. I will remove the
> mutex.
Even if IRQ_STA is changed there is no problem. With the lock the
following can happen:

Either the irq thread comes first:

	thread1			thread2

	lock
	rtc_read
	unlock   ------------>  lock
				dosomething with IRQ_STA
				unlock

or the other thread comes first:

	thread1			thread2

				lock
				dosomething with IRQ_STA
	lock   <-------------	unlock
	rtc_read
	unlock

So thread1 either reads the old or the new value of IRQ_STA.

Without locking you have the same! Either the write in thread2 comes
first or not. And depending on that you either read the new or the old
value respectively.

Of course this assumes that a write is atomic in the sense that if you
update a value from 0x01 to 0x10 there is no point in time a reader can
see 0x00 or 0x11. But this is usually given. Also reading the register
in question must not have side effects that affect the other threads.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
