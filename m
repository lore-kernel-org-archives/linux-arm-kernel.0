From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Fri, 14 Aug 2015 03:12:13 +0000
Subject: [PATCH 2/2] soc/fsl: add ftm alarm driver for ls1021a platform
In-Reply-To: <CACRpkdbninKuGzhEc5mN+85j-=w_wYQgra-Ark_Du6gWKN2=tg@mail.gmail.com>
References: <1439358807-9024-1-git-send-email-dongsheng.wang@freescale.com>
 <1439358807-9024-2-git-send-email-dongsheng.wang@freescale.com>
 <CACRpkdbninKuGzhEc5mN+85j-=w_wYQgra-Ark_Du6gWKN2=tg@mail.gmail.com>
Message-ID: <SN1PR0301MB161682A7FC5200580BED09119D7C0@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Thursday, August 13, 2015 9:54 PM
> To: Wang Dongsheng-B40534; John Stultz; Alessandro Zummo; Alexandre Belloni
> Cc: Shawn Guo; Nair, Sandeep; Hans de Goede; Wang Huan-B18965; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; rtc-
> linux at googlegroups.com
> Subject: Re: [PATCH 2/2] soc/fsl: add ftm alarm driver for ls1021a platform
> 
> On Wed, Aug 12, 2015 at 7:53 AM, Dongsheng Wang
> <dongsheng.wang@freescale.com> wrote:
> 
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > Only Ftm0 can be used when system going to deep sleep. So this driver
> > to support ftm0 as a wakeup source.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > *V2*
> > Change Copyright 2014 to 2015.
> (...)
> > +config FTM_ALARM
> > +       bool "FTM alarm driver"
> > +       depends on SOC_LS1021A
> > +       default n
> > +       help
> > +         Say y here to enable FTM alarm support.  The FTM alarm provides
> > +         alarm functions for wakeup system from deep sleep.  There is only
> > +         one FTM can be used in ALARM(FTM 0).
> (...)
> > +static u32 time_to_cycle(unsigned long time)
> > +static u32 cycle_to_time(u32 cycle)
> > +static int ftm_set_alarm(u64 cycle)
> > +static irqreturn_t ftm_alarm_interrupt(int irq, void *dev_id)
> > +static ssize_t ftm_alarm_show(struct device *dev,
> > +                             struct device_attribute *attr,
> > +                             char *buf)
> > +static ssize_t ftm_alarm_store(struct device *dev,
> > +                              struct device_attribute *attr,
> > +                              const char *buf, size_t count)
> (...)
> > +static struct device_attribute ftm_alarm_attributes = __ATTR(ftm_alarm, 0644,
> > +                       ftm_alarm_show, ftm_alarm_store);
> 
> If you're gonna invent ABIs, document then in Documentation/ABI/testing/*.
> 
> But I don't get it. Why is this driver not in drivers/rtc?
> 
> It does a subset of what an RTC does. The ioctl()'s of an RTC
> can do what you want to do. And much much more.
> 
> If it can't do all an RTC can do, surely the RTC subsystem
> can be augmented to host it anyway. It's way to close to
> an RTC to have it's own random sysfs driver like this.
> 
> Unless I'm totally off, rewrite this to an RTC driver and post
> it to the RTC maintainers.
> 

FlexTimer is not a RTC device and not have any rtc deivce function. They belong to
different devices, why we need to register this to RTC framework? I am confused about this.

Now in freescale layerscape platform this driver is only for FlexTimer0, and not
fit for each flextimer. Because only FlexTimer0 still turn-on when system in the Deep Sleep.

If the "alarm" make you feel confused or mislead you think this is a RTC devices. I think
I need to change the "alarm" to "timer".

Regards,
-Dongsheng
