From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 13 Aug 2010 19:27:12 +0200
Subject: [rtc-linux] [PATCH] rtc: rtc-lpc32xx: Introduce RTC driver for
	the LPC32XX SoC (v3)
In-Reply-To: <20100813112933.GA23852@pengutronix.de>
References: <1281650244-9889-1-git-send-email-wellsk40@gmail.com>
	<1281650244-9889-2-git-send-email-wellsk40@gmail.com>
	<20100813112933.GA23852@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F80AC719CAEF@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thanks for continued testing and review of the driver.

> > +
> > +#define LPC32XX_RTC_MATCH0_EN		(1 << 0)
> > +#define LPC32XX_RTC_MATCH1_EN		(1 << 1)
> > +#define LPC32XX_RTC_ONSW_MATCH0_EN	(1 << 2)
> > +#define LPC32XX_RTC_ONSW_MATCH1_EN	(1 << 3)
> > +#define LPC32XX_RTC_SW_RESET		(1 << 4)
> > +#define LPC32XX_RTC_CNTR_DIS		(1 << 6)
> > +#define LPC32XX_RTC_ONSW_FORCE_HIGH	(1 << 7)
> 
> I would have liked LPC32XX_RTC_CTRL_* as a prefix better as mentioned last
> time. It will do here for the RTC as it doesn't have much registers, though.
> 
> > +
> > +#define LPC32XX_RTC_MATCH0_INT_STS	(1 << 0)
> > +#define LPC32XX_RTC_MATCH1_INT_STS	(1 << 1)
> > +#define LPC32XX_RTC_ONSW_INT_STS	(1 << 2)
> 
> ditto for including the register name.
> 

No problem here..I'll change these.

> > +static int lpc32xx_rtc_alarm_irq_enable(struct device *dev,
> > +	unsigned int enabled)
> > +{
> > +	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
> > +	u32 tmp;
> > +
> > +	spin_lock_irq(&rtc->lock);
> > +	tmp = rtc_readl(rtc, LPC32XX_RTC_CTRL);
> > +
> > +	if (enabled) {
> > +		rtc->alarm_enabled = 1;
> > +		tmp |= LPC32XX_RTC_MATCH0_EN;
> > +	} else {
> > +		rtc->alarm_enabled = 0;
> > +		tmp &= ~LPC32XX_RTC_MATCH0_EN;
> > +	}
> 
> Maybe 'rtc->alarm_enabled = enabled;' or similar could be used. Didn't check
> thouroughly.
> 

I picked this specific approach because the type in the local rtc structure
is unsigned char (matching the struct rtc_wkalrm type) while the passed
parameter 'enabled' is unsigned long. I considered these..
	rtc->alarm_enabled = (unsigned char) enabled;
and
	rtc->alarm_enabled = !!enabled;

The direct assignment seemed the best approach to avoid some type of cast or
extra logic.

> > +	/*
> > +	 * The RTC is on a seperate power domain and can keep it's state
> > +	 * across a chip power cycle. If the RTC has never been previously
> > +	 * setup, then set it up now for the first time.
> > +	 */
> > +	tmp = rtc_readl(rtc, LPC32XX_RTC_CTRL);
> > +	if (rtc_readl(rtc, LPC32XX_RTC_KEY) == LPC32XX_RTC_KEY_ONSW_LOADVAL)
> > +{
> 
> This cannot work; it really should be '!=' otherwise the time will be reset at
> every reboot!
> 

Hmm, this was a good find. If the key value isn't setup correctly, the
boot ROM will clear the RTC counter on power-on reset. The time isn't being
cleared on my board, so something is setting up the key elsewhere. Your
suggested fix is probably the right fix, but I'll review. Sorry - I won't
get updates for this available until next week.
