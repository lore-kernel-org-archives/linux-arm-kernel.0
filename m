From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 2 Nov 2015 11:03:34 +0800
Subject: [PATCH] clocksource: dw_apb_timer_of: support timer-based delay
In-Reply-To: <3950525.pKSJGoymu4@wuerfel>
References: <1446193659-1698-1-git-send-email-jszhang@marvell.com>
 <56334A1E.7060709@linaro.org>	<20151030190929.4c46066c@xhacker>
 <3950525.pKSJGoymu4@wuerfel>
Message-ID: <20151102110334.049b5439@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd and Daniel,

On Fri, 30 Oct 2015 13:42:01 +0100
Arnd Bergmann wrote:

> On Friday 30 October 2015 19:09:29 Jisheng Zhang wrote:
> > > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > > > index a7726db..7b081805 100644
> > > > --- a/drivers/clocksource/Kconfig
> > > > +++ b/drivers/clocksource/Kconfig
> > > > @@ -29,6 +29,16 @@ config DW_APB_TIMER_OF
> > > >     select DW_APB_TIMER
> > > >     select CLKSRC_OF
> > > >
> > > > +config DW_APB_TIMER_BASED_DELAY
> > > > +   bool "DW APB timer based delay"
> > > > +   depends on ARM && DW_APB_TIMER_OF
> > > > +   default n
> > > > +   help
> > > > +     This option enables support for using the DW APB timer to
> > > > +     implement timer-based delay. It is useful for skiping the
> > > > +     delay loop calibration at boot on some platforms. And the
> > > > +     udelay() will be unaffected by CPU frequency changes.
> > > > +    
> > > 
> > > Why do you want it to be optional ?
> > >   
> > 
> > Because in some platforms which has arm arch timer, this dw apb timer
> > delay isn't needed, the arch timer is better. So we want it be optional
> > so that the platforms which need this feature select it manually when config
> > the kernel.
> >   
> 
> This is not ideal from an overall maintenance perspective. We want to
> be able to have a kernel with all drivers enabled that gives us the
> best behavior on all platforms.
> 
> The current behavior appears to be that we override all previous
> registrations as long as the new one is higher resolution. Is that
> the case here? I.e. does the arch timer have a lower resultion than
> the dw-apb timer but have some other advantages?

Take one Marvell Berlin platform for example, the arch timer freq is 25MHZ,
whose resolution is lower than the dw apb timer at 100MHZ. But dw apb timer
is on the APB bus while arch timer sits in CPU, so I guess the cost of
accessing the apb timer is higher than arch timer. 

I have a solution for this case: in platforms with arch timer, I can mark
the dw apb timer as "disabled" in the dts even though the timer sits there.
Then I could make DW_APB_TIMER_BASED_DELAY non-optional but selected by the
the ARCH_XYZ. Is this acceptable?

Thanks in advance,
Jisheng
