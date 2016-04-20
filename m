From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 Apr 2016 09:57:41 +0200
Subject: [PATCH 3/3] RTC: Update seconds time programming logic
In-Reply-To: <3802E9A6666DF54886E2B9CBF743BA9825E0B42B@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
 <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
 <20160419223109.GF29844@piout.net>
 <3802E9A6666DF54886E2B9CBF743BA9825E0B42B@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20160420075741.GK29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/2016 at 07:10:22 +0000, Anurag Kumar Vulisha wrote :
> The reason for me keeping this logic is, our RTC controller updates the read register after 1 sec
> delay, so when read , it gives 1 sec delay(correct time - 1 sec). So to avoid that we are programming
> load time + 1sec into the write register. So when read we would be getting the correct time without
> any delay. If any request comes from user to read time before RTC updating the read register, we
> need to give the previous loaded time instead of giving the time from the read register. 
> For doing the above said, we are relaying on seconds interrupt in  RTC_INT_STS register. We
> Clear the RTC_INT_STS register while programming the time into the write register . If we get a
> request from user to read time within the 1 sec period i.e before the RTC_INT_SEC interrupt bit
> is set in RTC_INT_STS, we need to give the previous loaded time.
> This should be done if time is requested from user space within  1 sec period after writing time, after
> the 1 sec  delay if user requested the time , we can  give the give time from read register . This is because
> the correct time is being updated in the read register after 1 sec delay. For this logic to happen we are
> depending on  xrtcdev->time_updated  variable to get updated after the very fist RTC_INT_SEC interrupt
> occurance in the interrupt handler.
> Since we are relaying on  xrtcdev->time_updated  to get updated from interrupt handler, I think reading
> the RTC_INT_STS in xlnx_rtc_read_time() is not helpful.
> 

Yeas, I understood that. But my question was whether the interrupt
handling was necessary at all.
Instead of waiting for an interrupt to set time_updated, can't you
simply read RTC_INT_STS and check for the RTC_INT_SEC bit in
xlnx_rtc_read_time() ?

Something like:

status = readl(xrtcdev->reg_base + RTC_INT_STS)
if (status & RTC_INT_SEC)
	rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
else
	rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_SET_TM_RD) - 1, tm);

It all depends on whether the RTC_INT_SEC bit in RTC_INT_STS is being
updated even when it is not enabled as an interrupt.

> Thanks,
> Anurag Kumar V
>   
> > > +	xrtcdev->time_updated = 0;
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -85,7 +103,17 @@ static int xlnx_rtc_read_time(struct device *dev,
> > > struct rtc_time *tm)  {
> > >  	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> > >
> > > -	rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> > > +	if (xrtcdev->time_updated == 0) {
> > > +		/*
> > > +		 * Time written in SET_TIME_WRITE has not yet updated into
> > > +		 * the seconds read register, so read the time from the
> > > +		 * SET_TIME_WRITE instead of CURRENT_TIME register.
> > > +		 */
> > > +		rtc_time64_to_tm(readl(xrtcdev->reg_base +
> > RTC_SET_TM_RD), tm);
> > > +		tm->tm_sec -= 1;
> > > +	} else {
> > > +		rtc_time64_to_tm(readl(xrtcdev->reg_base +
> > RTC_CUR_TM), tm);
> > > +	}
> > >
> > >  	return rtc_valid_tm(tm);
> > >  }
> > > @@ -133,6 +161,9 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev
> > > *xrtcdev)  {
> > >  	u32 rtc_ctrl;
> > >
> > > +	/* Enable RTC SEC interrupts */
> > > +	writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_EN);
> > > +
> > >  	/* Enable RTC switch to battery when VCC_PSAUX is not available */
> > >  	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
> > >  	rtc_ctrl |= RTC_BATT_EN;
> > > @@ -169,8 +200,13 @@ static irqreturn_t xlnx_rtc_interrupt(int irq, void
> > *id)
> > >  	/* Clear interrupt */
> > >  	writel(status, xrtcdev->reg_base + RTC_INT_STS);
> > >
> > > -	if (status & RTC_INT_SEC)
> > > +	if (status & RTC_INT_SEC) {
> > > +		if (xrtcdev->time_updated == 0) {
> > > +			/* RTC updated the seconds read register */
> > > +			xrtcdev->time_updated = 1;
> > > +		}
> > >  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
> > > +	}
> > >  	if (status & RTC_INT_ALRM)
> > >  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
> > >
> > > --
> > > 2.1.2
> > >
> > 
> > --
> > Alexandre Belloni, Free Electrons
> > Embedded Linux, Kernel and Android engineering
> > http://free-electrons.com

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
