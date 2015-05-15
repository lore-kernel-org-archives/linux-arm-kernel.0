From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Fri, 15 May 2015 15:39:46 +0000
Subject: [PATCH 00/18] ARM: imx: make the imx timer driver implementation
 independent of SoCs.
In-Reply-To: <20150515075406.GE10411@tiger>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
 <20150515075406.GE10411@tiger>
Message-ID: <BL2PR03MB3705C98C051BD25A990A90383C70@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2015?5?15? 2:54
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 00/18] ARM: imx: make the imx timer driver implementation
> independent of SoCs.
> 
> On Thu, Apr 30, 2015 at 09:44:15AM -0500, Shenwei Wang wrote:
> > There are 4 versions of the timer hardware on Freescale MXC hardware.
> > --Version 0: MX1/MXL
> > --Version 1: MX21, MX27.
> > --Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q(Rev1.0) --Version 3:
> > MX6DL, MX6SX, MX6Q(Rev1.1+)
> >
> > This patch has removed the SoC related codes, and implemented the
> > driver directly upon the hardware timer IP version. The new timer
> > driver has redesigned the internal APIs, and limited the use of global variables
> as well.
> >
> > As the new driver has become independent of the SoCs, it has been
> > moved from the directory arch/arm/mach-imx into the directory
> > drivers/clocksources.
> 
> Overall, I do not like how things get done here, the software version numbering,
> the patch splitting, invasive changes than necessary.  So I just worked out my
> version and will post for review shortly.
> 
Agreed that the patch was splitting because I wanted to let the reviewers know the
Procedures of the changes. The idea for the series of patches is to re-implement 
The gpt timer driver just based on the IP. I don't want to involve any SoC
Information inside the driver. A driver should have no knowledge of a SoC, but be simply
Implemented upon the IP block. 


> Shawn
> 
> > Shenwei Wang (18):
> >   ARM: imx: Add a parameter to mxc_timer_init
> >   ARM: imx: Add the definitions for imx_timer and its versions
> >   ARM: imx: Add an array of timer IP block versions
> >   ARM: imx: Added one more parameter for mxc_clockevent_init
> >   ARM: imx: Added one more parameter for mxc_clocksource_init
> >   ARM: imx: New timer driver APIs based on IP block
> >   ARM: imx: Initialize the imx_timer structure
> >   ARM: imx: Reimplemented the _mxc_timer_init based on IP version
> >   ARM: imx: Removed the SoC relating codes in mxc_timer_interrupt
> >   ARM: imx: Removed the SoC relating codes in mxc_set_mode
> >   ARM: imx: Enabled the unused parameter
> >   ARM: imx: Remove one global variable in mxc_clocksource_init
> >   ARM: imx: Removed the unused functions and variables
> >   ARM: imx: Removed the global variable "timer_base"
> >   ARM: imx: Remove the SoC relating codes in mxc_clockevent_init
> >   ARM: imx: Move the  variable clockevent_mode into mxc_set_mode
> >   ARM: imx: Codes clean up
> >   ARM: imx: Move time.c into drivers/clocksources
> >
> >  arch/arm/mach-imx/Makefile      |   2 +-
> >  arch/arm/mach-imx/time.c        | 388 ---------------------------
> >  drivers/clk/imx/clk-imx1.c      |   3 +-
> >  drivers/clk/imx/clk-imx21.c     |   3 +-
> >  drivers/clk/imx/clk-imx27.c     |   3 +-
> >  drivers/clk/imx/clk-imx31.c     |   3 +-
> >  drivers/clk/imx/clk-imx35.c     |   5 +-
> >  drivers/clk/imx/clk.h           |   2 +-
> >  drivers/clocksource/Makefile    |   1 +
> >  drivers/clocksource/timer-gpt.c | 572
> > ++++++++++++++++++++++++++++++++++++++++
> >  10 files changed, 586 insertions(+), 396 deletions(-)  delete mode
> > 100644 arch/arm/mach-imx/time.c  create mode 100644
> > drivers/clocksource/timer-gpt.c
> >
> > --
> > 1.9.1
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
