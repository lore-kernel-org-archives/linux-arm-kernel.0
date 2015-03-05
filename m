From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 6 Mar 2015 00:35:32 +0100
Subject: [PATCH v2 1/7] ARM: at91: switch to multiplatform
In-Reply-To: <CAL_Jsq+r3KrAcR+n6uwo-k_OVNfzDrK+MNZ7ech_RsQirutaaQ@mail.gmail.com>
References: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425583068-5826-2-git-send-email-alexandre.belloni@free-electrons.com>
 <CAL_Jsq+r3KrAcR+n6uwo-k_OVNfzDrK+MNZ7ech_RsQirutaaQ@mail.gmail.com>
Message-ID: <20150305233532.GD3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2015 at 16:50:57 -0600, Rob Herring wrote :
> > -config SOC_SAMA5
> > +config ARCH_AT91
> >         bool
> > -       select ATMEL_AIC5_IRQ
> > +       select ARCH_REQUIRE_GPIOLIB
> >         select COMMON_CLK_AT91
> > -       select CPU_V7
> > +       select CLKDEV_LOOKUP
> 
> This is already selected by COMMON_CLK I think.
> 
> >         select GENERIC_CLOCKEVENTS
> 
> This is already selected.
> 

I'm just moving options around I didn't add or remove any. That applies
to most of your comments.

> > -       select MEMORY
> > -       select ATMEL_SDRAMC
> > -       select PHYLIB if NETDEVICES
> > -
> > -menu "Atmel AT91 System-on-Chip"
> > -
> > -choice
> > -
> > -       prompt "Core type"
> > -
> > -config SOC_SAM_V4_V5
> > -       bool "ARM9 AT91SAM9/AT91RM9200"
> > -       help
> > -         Select this if you are using one of Atmel's AT91SAM9 or
> > -         AT91RM9200 SoC.
> > -
> > -config SOC_SAM_V7
> > -       bool "Cortex A5"
> > +       select IRQ_DOMAIN
> > +       select NEED_MACH_IO_H if PCCARD
> 
> This won't work on multi-platform.
> 

There is a patch removing it that is part of another series. IT will be
applied before this patch.

> 
> > +       select MEMORY
> > +       select ATMEL_SDRAMC
> > +       select PHYLIB if NETDEVICES
> 
> This belongs with your network driver.

Probably not, it is there because of the phy fixups. Anyway, it is being
removed by another series as we don't like to carry phy fixups.

> >  config AT91_TIMER_HZ
> > -       int "Kernel HZ (jiffies per second)"
> > -       range 32 1024
> > -       depends on ARCH_AT91
> > -       default "128" if SOC_AT91RM9200
> > -       default "100"
> > -       help
> > +       int "Kernel HZ (jiffies per second)"
> 
> How is this multi-platform compatible. This belongs with the
> clockevent driver probably.
> 

It is not different from what is done for ARCH_EXYNOS4 which is also
mutliplatform (and the more annoyingly ARMv7). I propose to restrict
that to SOC_AT91RM9200 so that it only affects ARMv4 (and I guess not
many people care about those now). I'm not sure it is a good idea to
move it to clokevents because of how it is handled in arch/arm/Kconfig.

I'll add a patch on top of that to further cleanup the unnecessary
options you pointed and moving COMMON_CLK_AT91 to driver/clk.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
