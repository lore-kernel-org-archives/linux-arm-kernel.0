From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Fri, 21 Aug 2015 03:07:46 +0000
Subject: [PATCH 2/2] soc/fsl: add ftm alarm driver for ls1021a platform
In-Reply-To: <CACRpkdYB23PbECUb2FP=_ck8PJe42wdifEcMSdKWrKnJLNp=pg@mail.gmail.com>
References: <1439358807-9024-1-git-send-email-dongsheng.wang@freescale.com>
 <1439358807-9024-2-git-send-email-dongsheng.wang@freescale.com>
 <CACRpkdbninKuGzhEc5mN+85j-=w_wYQgra-Ark_Du6gWKN2=tg@mail.gmail.com>
 <SN1PR0301MB161682A7FC5200580BED09119D7C0@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <CACRpkdYB23PbECUb2FP=_ck8PJe42wdifEcMSdKWrKnJLNp=pg@mail.gmail.com>
Message-ID: <SN1PR0301MB1616A184ADD450D95B29E8A19D650@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Walleij and Russell,

I will drop this patch. Thanks for your review.

[PATCH v2 1/2] soc/fsl: add freescale dir for SOC specific drivers

But the 1/2 of the patches also need, because there has another patch(Freescale FPGA driver) need 1/2 patch.
Need I push the 1/2 patch with another patches(Freescale FPGA driver) or push 1/2 standalone without another
patch? 

Regards,
-Dongsheng

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Friday, August 14, 2015 6:07 PM
> To: Wang Dongsheng-B40534; John Stultz
> Cc: Alessandro Zummo; Alexandre Belloni; Shawn Guo; Nair, Sandeep; Hans de Goede;
> Wang Huan-B18965; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; rtc-linux at googlegroups.com
> Subject: Re: [PATCH 2/2] soc/fsl: add ftm alarm driver for ls1021a platform
> 
> On Fri, Aug 14, 2015 at 5:12 AM, Wang Dongsheng
> <Dongsheng.Wang@freescale.com> wrote:
> >> On Wed, Aug 12, 2015 at 7:53 AM, Dongsheng Wang
> >> <dongsheng.wang@freescale.com> wrote:
> >>
> >> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >> >
> >> > Only Ftm0 can be used when system going to deep sleep. So this driver
> >> > to support ftm0 as a wakeup source.
> >> >
> >> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> >> > ---
> >> > *V2*
> >> > Change Copyright 2014 to 2015.
> >> (...)
> >> > +config FTM_ALARM
> >> > +       bool "FTM alarm driver"
> >> > +       depends on SOC_LS1021A
> >> > +       default n
> >> > +       help
> >> > +         Say y here to enable FTM alarm support.  The FTM alarm provides
> >> > +         alarm functions for wakeup system from deep sleep.  There is only
> >> > +         one FTM can be used in ALARM(FTM 0).
> >> (...)
> >> > +static u32 time_to_cycle(unsigned long time)
> >> > +static u32 cycle_to_time(u32 cycle)
> >> > +static int ftm_set_alarm(u64 cycle)
> >> > +static irqreturn_t ftm_alarm_interrupt(int irq, void *dev_id)
> >> > +static ssize_t ftm_alarm_show(struct device *dev,
> >> > +                             struct device_attribute *attr,
> >> > +                             char *buf)
> >> > +static ssize_t ftm_alarm_store(struct device *dev,
> >> > +                              struct device_attribute *attr,
> >> > +                              const char *buf, size_t count)
> >> (...)
> >> > +static struct device_attribute ftm_alarm_attributes = __ATTR(ftm_alarm,
> 0644,
> >> > +                       ftm_alarm_show, ftm_alarm_store);
> >>
> >> If you're gonna invent ABIs, document then in Documentation/ABI/testing/*.
> >>
> >> But I don't get it. Why is this driver not in drivers/rtc?
> >>
> >> It does a subset of what an RTC does. The ioctl()'s of an RTC
> >> can do what you want to do. And much much more.
> >>
> >> If it can't do all an RTC can do, surely the RTC subsystem
> >> can be augmented to host it anyway. It's way to close to
> >> an RTC to have it's own random sysfs driver like this.
> >>
> >> Unless I'm totally off, rewrite this to an RTC driver and post
> >> it to the RTC maintainers.
> >
> > FlexTimer is not a RTC device and not have any rtc deivce function. They
> belong to
> > different devices, why we need to register this to RTC framework? I am
> confused about this.
> >
> > Now in freescale layerscape platform this driver is only for FlexTimer0, and
> not
> > fit for each flextimer. Because only FlexTimer0 still turn-on when system in
> the Deep Sleep.
> >
> > If the "alarm" make you feel confused or mislead you think this is a RTC
> devices. I think
> > I need to change the "alarm" to "timer".
> 
> I think it is an RTC, it is just that the hardware engineer
> designed it with a wakeup usecase in mind and did not call
> it an RTC. Wakeup is one of the things RTCs do.
> 
> If you inspect a few drivers in drivers/rtc such as drivers/rtc/rtc-pl030.c
> you will find that they are just as crude as this "alarm" thing.
> 
> It has a counter that counts cycles, it has a comparator
> and an alarm function. It is an on-chip RTC, just like PL030
> no matter what the datasheet or hardware engineer thinks it
> should be called, the Linux kernel calls this an RTC, and it
> has a subsystem for handling it, so we should use it and
> not invent random new stuff.
> 
> If the hardware is really so strange that the counter can only
> be started if you also put an alarm at the same time (I doubt
> it, but OK if you say so) it is a subset of an RTC that can
> only be used for alarms but not timekeeping, but it should
> *still* live in drivers/rtc.
> 
> Think for a moment on the huge effort that John Stultz put into
> integrating Android alarm timers with POSIX and the RTC
> subsystem and fixing it all from the smallest handset to
> the largest S360 supercomputer. The approach of a custom
> device just throws all of that out the window and reinvents the
> mechanism in userspace, forcing all standardized userspace to
> have special code to handle this special alarm with its
> special sysfs ABI.
> 
> Check
> commit ff3ead96d17f47ee70c294a5cc2cce9b61e82f0f
> "timers: Introduce in-kernel alarm-timer interface"
> for example.
> 
> Even if you persist on keeping it in its own magic driver
> like this, it should implement the alarm timer interface
> from <linux/alarmtimer.h> and I bet after that you don't
> need the sysfs files anymore, as the system will sleep
> and wake up from the regular syscalls instead of using
> magic poking in sysfs from userspace. AFAICT this hardware
> is designed for exactly this usecase.
> 
> tools/testing/selftests/timers/alarmtimer-suspend.c
> is there for you to test your driver with alarmtimer
> support.
> 
> Needless to say: if you implement it as an RTC you get the
> alarmtimer interaction for free. That is why we have the
> subsystem after all: to be helpful.
> 
> Yours,
> Linus Walleij
