From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 16 May 2017 16:35:37 +0200
Subject: [PATCH 42/48] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <d2485b56-52fa-6532-76cb-222f0c139566@linaro.org>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-43-git-send-email-alexandre.belloni@free-electrons.com>
 <576D0645.2070805@linaro.org>
 <20170516115916.ip3ea34bofg3jpuo@piout.net>
 <d2485b56-52fa-6532-76cb-222f0c139566@linaro.org>
Message-ID: <20170516143537.vib2o2t3nizrk363@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/2017 at 16:25:04 +0200, Daniel Lezcano wrote:
> On 16/05/2017 13:59, Alexandre Belloni wrote:
> > Hi Daniel,
> > 
> > Almost one year later, I'm back on that topic.
> > 
> > On 24/06/2016 at 12:07:01 +0200, Daniel Lezcano wrote:
> >>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> >>> index 47352d25c15e..ff7f4022c749 100644
> >>> --- a/drivers/clocksource/Kconfig
> >>> +++ b/drivers/clocksource/Kconfig
> >>> @@ -258,6 +258,19 @@ config ATMEL_ST
> >>>   	select CLKSRC_OF
> >>>   	select MFD_SYSCON
> >>>
> >>> +config ATMEL_ARM_TCB_CLKSRC
> >>> +	bool "TC Block Clocksource"
> >>
> >> The Kconfig options are set now with the COMPILE_TEST option in order to
> >> increase the compilation test coverage.
> >>
> >> Please, add bool "TC Block Clocksource" if COMPILE_TEST, ...
> >>
> >>> +	select REGMAP_MMIO
> >>> +	depends on GENERIC_CLOCKEVENTS
> >>> +	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
> >>> +	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
> >>
> >> ... remove these dependencies and let the SoC's Kconfig to select the timer
> >> like the other timers are.
> >>
> > 
> > The main issue with what you suggest is that it removes the possibility
> > to not compile the driver. This may be interesting for people using the
> > PIT as the clocksource/clockevent and the TCBs for something else.
> 
> Is it really a problem? We tend as much as possible to make silent
> options in order to let the platform config to select the right clock.
> 

I depends on how much you care about being able to remove as much as
possible from the kernel.
Both the PIT and the TCB can be used by AT91SAM9 and SAMA5, similarly,
both the system timer and the TCB can be used by AT91RM9200. I would
prefer letting the user select which drivers have to be compiled in the
kernel instead of pulling both with the SoC configuration.



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
