From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 30 Jun 2013 12:26:53 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCB2MyAxLzVdIHJ0YzogbXhjX3J0YzogRHJpdmVyIHJl?=
 =?UTF-8?B?d29yaw==?=
In-Reply-To: <20130630075234.GE10414@pengutronix.de>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
 <20130630075234.GE10414@pengutronix.de>
Message-ID: <1372580813.432068011@f179.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Jun 29, 2013 at 12:40:40PM +0400, Alexander Shiyan wrote:
> > This patch rework mxc_rtc driver.
> > Major changes have been made:
> > - Added second clock support (optional) which permit module functionality.
> > - Implemented support for periodic interrupts.
> > - Some code have been optimized.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
...
> > -static inline int is_imx1_rtc(struct rtc_plat_data *data)
> > -{
> > -	return data->devtype == IMX1_RTC;
> > -}
> 
> What is wrong with this function?

All good here. This call is used only once in set_mmss, so no reason
to have separate function.
I agree that we can make it in a separate patch, but the optimization of the
code is specified in the changelog.

> >   * This function is used to obtain the RTC time or the alarm value in
> >   * second.
> > @@ -110,20 +75,16 @@ static u32 get_alarm_or_time(struct device *dev, int time_alarm)
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
> >  	}
> 
> It is debatable whether this change makes sense or not. It is cleanup
> though and should not be mixed with functionality change also in this
> patch.

As I wrote earlier, this is just a way to remove the initial variables setup.
"u32 day = 0, hr = 0, min = 0, sec = 0, hr_min = 0;" ==> "u32 day, hr, min, sec, hr_min;"

...
> > -	/* clear all the interrupt status bits */
> > -	writew(readw(ioaddr + RTC_RTCISR), ioaddr + RTC_RTCISR);
> > +	/* clear interrupt status bit */
> > +	writew(RTC_ALM_BIT, pdata->ioaddr + RTC_RTCISR);
> > +
> 
> This change is not explained. Are there problems with the old code?
> This hunk raises a question which should be answered in a commit message
> for a separate patch.

Not correct to clear all interrupt status bits. We can lost update and/or periodic
status.

...
> >  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> > -	void __iomem *ioaddr = pdata->ioaddr;
> >  
> > -	spin_lock_irq(&pdata->rtc->irq_lock);
> > +	if (pdata->irq >= 0) {
> > +		unsigned long rate = clk_get_rate(pdata->clk_rtc);
> >  
> > -	/* Disable all rtc interrupts */
> > -	writew(0, ioaddr + RTC_RTCIENR);
> > +		pdata->rtc->max_user_freq = rate / 64;
> > +		rtc_irq_set_freq(pdata->rtc, NULL, rate / 64);
> > +		mxc_rtc_irq_enable(&pdev->dev, RTC_1HZ_BIT | RTC_SAM7_BIT, 1);
> > +	}
> 
> The irq seems to be made optional here. Do we need this? Do we want
> this? Again, this is something hidden in a big patch.

IRQ is checked in mxc_rtc_irq_enable function.
I agree that freq should be set if IRQ is used.

...
> > +	pdata->rtc_ops.open		= mxc_rtc_open;
> > +	pdata->rtc_ops.release		= mxc_rtc_release;
> > +	pdata->rtc_ops.read_time	= mxc_rtc_read_time;
> > +	pdata->rtc_ops.set_mmss		= mxc_rtc_set_mmss;
> > +	pdata->rtc_ops.read_alarm	= mxc_rtc_read_alarm;
> > +	pdata->rtc_ops.set_alarm	= mxc_rtc_set_alarm;
> > +	pdata->rtc_ops.alarm_irq_enable	= mxc_rtc_alarm_irq_enable;
> 
> So struct rtc_class_ops is embedded into struct rtc_plat_data now. Why
> is this necessary?

Just save BSS. Can be moved into cleanup part.

...

To summarize, I do not know what to do with this patch. Most likely I shall
not continue to work on this driver. Just keep in mind that using driver in its
current state is impossible (clk).
Thanks.

---
