From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 20 Apr 2016 13:37:30 +0000
Subject: [PATCH 3/3] RTC: Update seconds time programming logic
In-Reply-To: <20160420120221.GR29844@piout.net>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
 <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
 <20160419223109.GF29844@piout.net>
 <3802E9A6666DF54886E2B9CBF743BA9825E0B42B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160420075741.GK29844@piout.net>
 <3802E9A6666DF54886E2B9CBF743BA9825E0B4BE@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160420120221.GR29844@piout.net>
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9825E0B50C@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Thanks for reviewing the patch, I will sent v2 with the changes updated.

Thanks,
Anurag Kumar V

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: Wednesday, April 20, 2016 5:32 PM
> To: Anurag Kumar Vulisha <anuragku@xilinx.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Soren Brinkmann
> <sorenb@xilinx.com>; Michal Simek <michals@xilinx.com>; rtc-
> linux at googlegroups.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Punnaiah Choudary Kalluri <punnaia@xilinx.com>;
> Anirudha Sarangi <anirudh@xilinx.com>; Srikanth Vemula
> <svemula@xilinx.com>; Srinivas Goud <sgoud@xilinx.com>
> Subject: Re: [PATCH 3/3] RTC: Update seconds time programming logic
> 
> On 20/04/2016 at 10:31:06 +0000, Anurag Kumar Vulisha wrote :
> > > Yeas, I understood that. But my question was whether the interrupt
> > > handling was necessary at all.
> > > Instead of waiting for an interrupt to set time_updated, can't you
> > > simply read RTC_INT_STS and check for the RTC_INT_SEC bit in
> > > xlnx_rtc_read_time() ?
> > >
> > > Something like:
> > >
> > > status = readl(xrtcdev->reg_base + RTC_INT_STS) if (status &
> RTC_INT_SEC)
> > >       rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> > > else
> > >       rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_SET_TM_RD) - 1,
> > > tm);
> > >
> > > It all depends on whether the RTC_INT_SEC bit in RTC_INT_STS is
> > > being updated even when it is not enabled as an interrupt.
> > >
> >
> > The above said logic will work if we doesn't clear the RTC_INT_STS
> > register after the RTC_INT_SEC bit is set, this happens only if
> > interrupts are not enabled. If interrupts are enabled we will be clearing the
> RTC_INT_STS every time in the interrupt handler.
> > And moreover we need to return time from RTC_SET_TM_RD only if time is
> > requested within 1 sec span after programming the time only , so this is
> required only for one time.
> > Since we are clearing the RTC_INT_STS in our interrupt handler, we
> > might end up in giving the wrong time to the user when requested.So I
> think this logic might not work.
> > Please correct me if am wrong.
> >
> 
> Simply stop clearing RTC_INT_SEC from RTC_INT_STS in the interrupt
> handler.
> 
> You can also remove
> 	if (status & RTC_INT_SEC)
> 		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
> 
> as it will not be used. Update interrupts are handled by the core using timers
> anyway. And as you can see, there was no code enabling RTC_INT_SEC in
> RTC_INT_EN before your patch.
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com
