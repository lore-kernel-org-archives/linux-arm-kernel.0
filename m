From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Fri, 15 May 2015 15:47:46 +0000
Subject: [PATCH 02/18] ARM: imx: Add the definitions for imx_timer and its
 versions
In-Reply-To: <20150515011855.GA10411@tiger>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
 <1430405073-13106-3-git-send-email-shenwei.wang@freescale.com>
 <20150515011855.GA10411@tiger>
Message-ID: <BL2PR03MB37097A8970E35759E872B1983C70@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2015?5?14? 20:19
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 02/18] ARM: imx: Add the definitions for imx_timer and its
> versions
> 
> On Thu, Apr 30, 2015 at 09:44:17AM -0500, Shenwei Wang wrote:
> > A struct was added to describe the imx hardware timers.
> > Added four macros to define the imx timer version.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> > ---
> >  arch/arm/mach-imx/time.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c index
> > eef6b66..5df3c53 100644
> > --- a/arch/arm/mach-imx/time.c
> > +++ b/arch/arm/mach-imx/time.c
> > @@ -81,6 +81,21 @@
> >  #define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
> >  #define timer_is_v2()	(!timer_is_v1())
> >
> > +#define IMX_TIMER_V0         (0)
> > +#define IMX_TIMER_V1         (1)
> > +#define IMX_TIMER_V2         (2)
> > +#define IMX_TIMER_V3         (3)
> 
> I prefer to use an enum type instead of macros. Also I do not like the versions
> which are numbered by software arbitrarily.  Instead, I'd like to use SoC name
> that firstly integrates the version to code the type/version.
> 
Seems we have different implementation philosophy. I don't want to involve any
SoC information inside a driver for either an IP block or an external component.
The only exception here is the DT bindings, as the SoC name is commonly accepted
To be used in the compatible string.

Regards,
Shenwei


> Shawn
> 
> > +
> > +struct imx_timer {
> > +	void __iomem *timer_base;
> > +	int version;
> > +	struct clock_event_device evt;
> > +	struct irqaction act;
> > +	void (*gpt_irq_enable)(struct imx_timer *);
> > +	void (*gpt_irq_disable)(struct imx_timer *);
> > +	void (*gpt_irq_acknowledge)(struct imx_timer *); };
> > +
> >  static struct clock_event_device clockevent_mxc;  static enum
> > clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
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
