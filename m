From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 20 Apr 2016 07:10:22 +0000
Subject: [PATCH 3/3] RTC: Update seconds time programming logic
In-Reply-To: <20160419223109.GF29844@piout.net>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
 <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
 <20160419223109.GF29844@piout.net>
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9825E0B42B@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: Wednesday, April 20, 2016 4:01 AM
> To: Anurag Kumar Vulisha <anuragku@xilinx.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Soren Brinkmann
> <sorenb@xilinx.com>; Michal Simek <michals@xilinx.com>; rtc-
> linux at googlegroups.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Punnaiah Choudary Kalluri <punnaia@xilinx.com>;
> Anirudha Sarangi <anirudh@xilinx.com>; Srikanth Vemula
> <svemula@xilinx.com>; Anurag Kumar Vulisha <anuragku@xilinx.com>
> Subject: Re: [PATCH 3/3] RTC: Update seconds time programming logic
> 
> 
> Hi,
> 
> Please use rtc: zynqmp in your subject line.
> 
> On 12/04/2016 at 17:45:46 +0530, Anurag Kumar Vulisha wrote :
> > @@ -78,6 +85,17 @@ static int xlnx_rtc_set_time(struct device *dev,
> > struct rtc_time *tm)
> >
> >  	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
> >
> > +	/*
> > +	 * Clear the rtc interrupt status register after setting the
> > +	 * time. During a read_time function, the code should read the
> > +	 * RTC_INT_STATUS register and if bit 0 is still 0, it means
> > +	 * that one second has not elapsed yet since RTC was set and
> > +	 * the current time should be read from SET_TIME_READ register;
> > +	 * otherwise, CURRENT_TIME register is read to report the time
> > +	 */
> > +	writel(RTC_INT_SEC | RTC_INT_ALRM, xrtcdev->reg_base +
> RTC_INT_STS);
> 
> You probably shouldn't clear RTC_INT_ALRM here but it should be done in
> the init and when enabling/disabling alarm. Or maybe easier would be to
> ignore RTC_INT_ALRM in xlnx_rtc_interrupt when it is not set in
> RTC_INT_MASK.
>

Thanks for reviewing the patch. I will remove this clearing  RTC_INT_ALRM interrupt logic
and send the next version of the patch.
 
> Or, instead of using interrupts, can't you simply read RTC_INT_STS in
> xlnx_rtc_read_time()? Is it updated even when the interrupt is not enabled?
> 

The reason for me keeping this logic is, our RTC controller updates the read register after 1 sec
delay, so when read , it gives 1 sec delay(correct time - 1 sec). So to avoid that we are programming
load time + 1sec into the write register. So when read we would be getting the correct time without
any delay. If any request comes from user to read time before RTC updating the read register, we
need to give the previous loaded time instead of giving the time from the read register. 
For doing the above said, we are relaying on seconds interrupt in  RTC_INT_STS register. We
Clear the RTC_INT_STS register while programming the time into the write register . If we get a
request from user to read time within the 1 sec period i.e before the RTC_INT_SEC interrupt bit
is set in RTC_INT_STS, we need to give the previous loaded time.
This should be done if time is requested from user space within  1 sec period after writing time, after
the 1 sec  delay if user requested the time , we can  give the give time from read register . This is because
the correct time is being updated in the read register after 1 sec delay. For this logic to happen we are
depending on  xrtcdev->time_updated  variable to get updated after the very fist RTC_INT_SEC interrupt
occurance in the interrupt handler.
Since we are relaying on  xrtcdev->time_updated  to get updated from interrupt handler, I think reading
the RTC_INT_STS in xlnx_rtc_read_time() is not helpful.

Thanks,
Anurag Kumar V
  
> > +	xrtcdev->time_updated = 0;
> > +
> >  	return 0;
> >  }
> >
> > @@ -85,7 +103,17 @@ static int xlnx_rtc_read_time(struct device *dev,
> > struct rtc_time *tm)  {
> >  	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> >
> > -	rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> > +	if (xrtcdev->time_updated == 0) {
> > +		/*
> > +		 * Time written in SET_TIME_WRITE has not yet updated into
> > +		 * the seconds read register, so read the time from the
> > +		 * SET_TIME_WRITE instead of CURRENT_TIME register.
> > +		 */
> > +		rtc_time64_to_tm(readl(xrtcdev->reg_base +
> RTC_SET_TM_RD), tm);
> > +		tm->tm_sec -= 1;
> > +	} else {
> > +		rtc_time64_to_tm(readl(xrtcdev->reg_base +
> RTC_CUR_TM), tm);
> > +	}
> >
> >  	return rtc_valid_tm(tm);
> >  }
> > @@ -133,6 +161,9 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev
> > *xrtcdev)  {
> >  	u32 rtc_ctrl;
> >
> > +	/* Enable RTC SEC interrupts */
> > +	writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_EN);
> > +
> >  	/* Enable RTC switch to battery when VCC_PSAUX is not available */
> >  	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
> >  	rtc_ctrl |= RTC_BATT_EN;
> > @@ -169,8 +200,13 @@ static irqreturn_t xlnx_rtc_interrupt(int irq, void
> *id)
> >  	/* Clear interrupt */
> >  	writel(status, xrtcdev->reg_base + RTC_INT_STS);
> >
> > -	if (status & RTC_INT_SEC)
> > +	if (status & RTC_INT_SEC) {
> > +		if (xrtcdev->time_updated == 0) {
> > +			/* RTC updated the seconds read register */
> > +			xrtcdev->time_updated = 1;
> > +		}
> >  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
> > +	}
> >  	if (status & RTC_INT_ALRM)
> >  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
> >
> > --
> > 2.1.2
> >
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
