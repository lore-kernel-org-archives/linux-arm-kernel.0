From: horms@verge.net.au (Simon Horman)
Date: Mon, 15 Apr 2013 13:01:09 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM
In-Reply-To: <CABYn4sx6czjsCqF0UQf3qD1h4sj9Si1AmtMSogEjjdbTuy7zzQ@mail.gmail.com>
References: <1365689264-14410-1-git-send-email-hechtb+renesas@gmail.com>
 <20130412005635.GG24461@verge.net.au>
 <CABYn4sx6czjsCqF0UQf3qD1h4sj9Si1AmtMSogEjjdbTuy7zzQ@mail.gmail.com>
Message-ID: <20130415040109.GF3070@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 02:54:46PM +0200, Bastian Hecht wrote:
> Hi Simon,
> 
> 2013/4/12 Simon Horman <horms@verge.net.au>:
> > On Thu, Apr 11, 2013 at 04:07:43PM +0200, Bastian Hecht wrote:
> >> We add 2 Suspend to RAM modes:
> >> - A3SM PLL0 on/off:     Power domain A3SM that contains the ARM core
> >>                         and the 2nd level cache with either PLL0 on
> >>                         or off
> >>
> >> As the suspend to memory mechanism we use A3SM PLL off. A3SM PLL on
> >> is included here too, so CPUIdle can use both power down modes (not
> >> included in this patch).
> >>
> >> The setup of the SYSC regarding the external IRQs is taken from
> >> pm-sh7372.c from Magnus Damm.
> >>
> >> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> >> ---
> >> This patch relies on
> >> ARM: hw_breakpoint: Do not use __cpuinitdata for dbg_cpu_pm_nb
> >>
> >> v2: successor to [PATCH] ARM: shmobile: r8a7740: Add Suspend-To-RAM modes and CPUIdle
> >>
> >> - Removed the 2nd L1 flush in the asm shutdown code. See comment in code for explanation.
> >> - Reworked the ifdefs: We can only use CPUIdle if SUSPEND is set as well.
> >> - Removed cpu_do_idle() in r8a7740_enter_suspend: We don't want to sleep twice...
> >>
> >> If you want to test this use this workaround in the st1232 driver in
> >> drivers/input/touchscreen/st1232.c:
> >>
> >>         error = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
> >> -                                    IRQF_ONESHOT, client->name, ts);
> >> +                                    IRQF_NO_SUSPEND | IRQF_ONESHOT, client->name, ts);
> >>
> >> You need it as the current irqpin driver doesn't handle wakeup devices properly yet.
> >>
> >> Tested with the 4 possiblities        L2 on - Suspend on/off - CPUIdle on/off
> >> and with the additional test  L2 off - Suspend on - CPUIdle on
> >
> > Hi Bastian,
> >
> > are the pre-requisites listed above likely to be in v3.11-rc1 or rc2?
> 
> I probably was a bit incorrect by saying "relies on". Right now the
> complete suspend system is broken on ARM UP systems. So I think we can
> use this patch without coordination regarding the other patch. It's
> just when you want to test this here, then you need the above
> mentioned patch to fix the system first before you can do anything.

Thanks that seems reasonable.

However, I will hold of queuing-up this series as there seems
to be some discussion relating to patch 1/2. Please let me know
when that is resolved via discussion or a fresh series.
