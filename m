From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 20 Apr 2016 10:31:06 +0000
Subject: [PATCH 3/3] RTC: Update seconds time programming logic
In-Reply-To: <20160420075741.GK29844@piout.net>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
 <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
 <20160419223109.GF29844@piout.net>
 <3802E9A6666DF54886E2B9CBF743BA9825E0B42B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160420075741.GK29844@piout.net>
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9825E0B4BE@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: Wednesday, April 20, 2016 1:28 PM
> To: Anurag Kumar Vulisha <anuragku@xilinx.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Soren Brinkmann
> <sorenb@xilinx.com>; Michal Simek <michals@xilinx.com>; rtc-
> linux at googlegroups.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Punnaiah Choudary Kalluri <punnaia@xilinx.com>;
> Anirudha Sarangi <anirudh@xilinx.com>; Srikanth Vemula
> <svemula@xilinx.com>; Srinivas Goud <sgoud@xilinx.com>
> Subject: Re: [PATCH 3/3] RTC: Update seconds time programming logic
>
> On 20/04/2016 at 07:10:22 +0000, Anurag Kumar Vulisha wrote :
> > The reason for me keeping this logic is, our RTC controller updates
> > the read register after 1 sec delay, so when read , it gives 1 sec
> > delay(correct time - 1 sec). So to avoid that we are programming load
> > time + 1sec into the write register. So when read we would be getting
> > the correct time without any delay. If any request comes from user to read
> time before RTC updating the read register, we need to give the previous
> loaded time instead of giving the time from the read register.
> > For doing the above said, we are relaying on seconds interrupt in
> > RTC_INT_STS register. We Clear the RTC_INT_STS register while
> > programming the time into the write register . If we get a request
> > from user to read time within the 1 sec period i.e before the RTC_INT_SEC
> interrupt bit is set in RTC_INT_STS, we need to give the previous loaded
> time.
> > This should be done if time is requested from user space within  1 sec
> > period after writing time, after the 1 sec  delay if user requested
> > the time , we can  give the give time from read register . This is
> > because the correct time is being updated in the read register after 1
> > sec delay. For this logic to happen we are depending on  xrtcdev-
> >time_updated  variable to get updated after the very fist RTC_INT_SEC
> interrupt occurance in the interrupt handler.
> > Since we are relaying on  xrtcdev->time_updated  to get updated from
> > interrupt handler, I think reading the RTC_INT_STS in xlnx_rtc_read_time()
> is not helpful.
> >
>
> Yeas, I understood that. But my question was whether the interrupt handling
> was necessary at all.
> Instead of waiting for an interrupt to set time_updated, can't you simply read
> RTC_INT_STS and check for the RTC_INT_SEC bit in
> xlnx_rtc_read_time() ?
>
> Something like:
>
> status = readl(xrtcdev->reg_base + RTC_INT_STS) if (status & RTC_INT_SEC)
>       rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> else
>       rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_SET_TM_RD) - 1,
> tm);
>
> It all depends on whether the RTC_INT_SEC bit in RTC_INT_STS is being
> updated even when it is not enabled as an interrupt.
>

The above said logic will work if we doesn't clear the RTC_INT_STS register after the
RTC_INT_SEC bit is set, this happens only if interrupts are not enabled. If interrupts
are enabled we will be clearing the RTC_INT_STS every time in the interrupt handler.
And moreover we need to return time from RTC_SET_TM_RD only if time is requested
within 1 sec span after programming the time only , so this is required only for one time.
Since we are clearing the RTC_INT_STS in our interrupt handler, we might end up in giving
the wrong time to the user when requested.So I think this logic might not work.
Please correct me if am wrong.

Thanks,
Anurag Kumar V

> > Thanks,
> > Anurag Kumar V
> >
> > > > +       xrtcdev->time_updated = 0;
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -85,7 +103,17 @@ static int xlnx_rtc_read_time(struct device
> > > > *dev, struct rtc_time *tm)  {
> > > >         struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> > > >
> > > > -       rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> > > > +       if (xrtcdev->time_updated == 0) {
> > > > +               /*
> > > > +                * Time written in SET_TIME_WRITE has not yet updated into
> > > > +                * the seconds read register, so read the time from the
> > > > +                * SET_TIME_WRITE instead of CURRENT_TIME register.
> > > > +                */
> > > > +               rtc_time64_to_tm(readl(xrtcdev->reg_base +
> > > RTC_SET_TM_RD), tm);
> > > > +               tm->tm_sec -= 1;
> > > > +       } else {
> > > > +               rtc_time64_to_tm(readl(xrtcdev->reg_base +
> > > RTC_CUR_TM), tm);
> > > > +       }
> > > >
> > > >         return rtc_valid_tm(tm);
> > > >  }
> > > > @@ -133,6 +161,9 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev
> > > > *xrtcdev)  {
> > > >         u32 rtc_ctrl;
> > > >
> > > > +       /* Enable RTC SEC interrupts */
> > > > +       writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_EN);
> > > > +
> > > >         /* Enable RTC switch to battery when VCC_PSAUX is not available */
> > > >         rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
> > > >         rtc_ctrl |= RTC_BATT_EN;
> > > > @@ -169,8 +200,13 @@ static irqreturn_t xlnx_rtc_interrupt(int
> > > > irq, void
> > > *id)
> > > >         /* Clear interrupt */
> > > >         writel(status, xrtcdev->reg_base + RTC_INT_STS);
> > > >
> > > > -       if (status & RTC_INT_SEC)
> > > > +       if (status & RTC_INT_SEC) {
> > > > +               if (xrtcdev->time_updated == 0) {
> > > > +                       /* RTC updated the seconds read register */
> > > > +                       xrtcdev->time_updated = 1;
> > > > +               }
> > > >                 rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
> > > > +       }
> > > >         if (status & RTC_INT_ALRM)
> > > >                 rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
> > > >
> > > > --
> > > > 2.1.2
> > > >
> > >
> > > --
> > > Alexandre Belloni, Free Electrons
> > > Embedded Linux, Kernel and Android engineering
> > > http://free-electrons.com
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
