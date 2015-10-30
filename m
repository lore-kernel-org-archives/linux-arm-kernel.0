From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 30 Oct 2015 19:09:29 +0800
Subject: [PATCH] clocksource: dw_apb_timer_of: support timer-based delay
In-Reply-To: <56334A1E.7060709@linaro.org>
References: <1446193659-1698-1-git-send-email-jszhang@marvell.com>
 <56334A1E.7060709@linaro.org>
Message-ID: <20151030190929.4c46066c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel,

On Fri, 30 Oct 2015 11:44:46 +0100
Daniel Lezcano <daniel.lezcano@....> wrote:

> On 10/30/2015 09:27 AM, Jisheng Zhang wrote:
> > Implement an ARM delay timer to be used for udelay(). This allows us to
> > skip the delay loop calibration at boot on Marvell BG2, BG2Q, BG2CD
> > platforms. And after this patch, udelay() will be unaffected by CPU
> > frequency changes.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >   drivers/clocksource/Kconfig           | 10 ++++++++++
> >   drivers/clocksource/dw_apb_timer_of.c | 16 ++++++++++++++++
> >   2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index a7726db..7b081805 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -29,6 +29,16 @@ config DW_APB_TIMER_OF
> >   	select DW_APB_TIMER
> >   	select CLKSRC_OF
> >
> > +config DW_APB_TIMER_BASED_DELAY
> > +	bool "DW APB timer based delay"
> > +	depends on ARM && DW_APB_TIMER_OF
> > +	default n
> > +	help
> > +	  This option enables support for using the DW APB timer to
> > +	  implement timer-based delay. It is useful for skiping the
> > +	  delay loop calibration at boot on some platforms. And the
> > +	  udelay() will be unaffected by CPU frequency changes.
> > +  
> 
> Why do you want it to be optional ?
> 

Because in some platforms which has arm arch timer, this dw apb timer
delay isn't needed, the arch timer is better. So we want it be optional
so that the platforms which need this feature select it manually when config
the kernel.

Thanks,
Jisheng
