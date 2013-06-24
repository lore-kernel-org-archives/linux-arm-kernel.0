From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 24 Jun 2013 10:52:05 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCB2MiAxLzNdIHJ0YzogbXhjX3J0YzogRHJpdmVyIHJl?=
 =?UTF-8?B?d29yaw==?=
In-Reply-To: <20130623191848.GD26397@pengutronix.de>
References: <1371976349-18679-1-git-send-email-shc_work@mail.ru>
 <20130623191848.GD26397@pengutronix.de>
Message-ID: <1372056725.539503696@f349.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sun, Jun 23, 2013 at 12:32:27PM +0400, Alexander Shiyan wrote:
> > This patch rework mxc_rtc driver.
> > Major changes have been made:
> > - Added second clock support (optional) which permit module functionality.
> > - Implemented support for periodic interrupts.
> > - Code have been optimized and cleaned.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  drivers/rtc/rtc-mxc.c | 382 +++++++++++++++++++++-----------------------------
> >  1 file changed, 159 insertions(+), 223 deletions(-)
...
> >  static u32 get_alarm_or_time(struct device *dev, int time_alarm)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> > -	void __iomem *ioaddr = pdata->ioaddr;
> > -	u32 day = 0, hr = 0, min = 0, sec = 0, hr_min = 0;
> > -
> > -	switch (time_alarm) {
> > -	case MXC_RTC_TIME:
> > -		day = readw(ioaddr + RTC_DAYR);
> > -		hr_min = readw(ioaddr + RTC_HOURMIN);
> > -		sec = readw(ioaddr + RTC_SECOND);
> > -		break;
> > -	case MXC_RTC_ALARM:
> > -		day = readw(ioaddr + RTC_DAYALARM);
> > -		hr_min = readw(ioaddr + RTC_ALRM_HM) & 0xffff;
> > -		sec = readw(ioaddr + RTC_ALRM_SEC);
> > -		break;
> > +	u32 day, hr, min, sec, hr_min;
> > +
> > +	if (time_alarm == MXC_RTC_TIME) {
> > +		day = readw(pdata->ioaddr + RTC_DAYR);
> > +		hr_min = readw(pdata->ioaddr + RTC_HOURMIN);
> > +		sec = readw(pdata->ioaddr + RTC_SECOND);
> > +	} else {
> > +		day = readw(pdata->ioaddr + RTC_DAYALARM);
> > +		hr_min = readw(pdata->ioaddr + RTC_ALRM_HM);
> > +		sec = readw(pdata->ioaddr + RTC_ALRM_SEC);
> 
> Why? If there's a reason for this change let us know it in a commit
> message to a separate patch.

Switch statement was replaced for avoid setup initial values
for "day", "hr_min" and "sec" variables.

> >  static void mxc_rtc_irq_enable(struct device *dev, unsigned int bit,
> > -				unsigned int enabled)
> > +			       unsigned int enabled)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> > -	void __iomem *ioaddr = pdata->ioaddr;
> >  	u32 reg;
> >  
> >  	spin_lock_irq(&pdata->rtc->irq_lock);
> > -	reg = readw(ioaddr + RTC_RTCIENR);
> >  
> > -	if (enabled)
> > +	reg = readw(pdata->ioaddr + RTC_RTCIENR);
> > +	if (enabled) {
> >  		reg |= bit;
> > -	else
> > +		/* Clear interrupt status */
> > +		writew(reg, pdata->ioaddr + RTC_RTCISR);
> > +	} else
> >  		reg &= ~bit;
> > +	writew(reg, pdata->ioaddr + RTC_RTCIENR);
> >  
> > -	writew(reg, ioaddr + RTC_RTCIENR);
> 
> Another hunk that might make sense but we do not know what's wrong with
> the original code.

This clears the interrupt status bit when an interrupt is turned on.

...

---
