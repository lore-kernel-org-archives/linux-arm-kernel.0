From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 23 Jan 2014 19:36:13 +0100
Subject: [PATCH 4/5] ARM: S3C24XX: convert boards to use common restart
 function
In-Reply-To: <52E15B74.3040409@samsung.com>
References: <3105326.uFdOVLyXH8@phil> <2227259.2cNbl9uzOp@phil>
 <52E15B74.3040409@samsung.com>
Message-ID: <7172372.015CdWJg1F@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 23. Januar 2014, 19:12:04 schrieb Tomasz Figa:
> Hi Heiko,
> 
> On 06.01.2014 19:40, Heiko St?bner wrote:
> > This converts all boards to use the new common restart function instead
> > of SoC specific ones.
> > 
> > The mach-s3c2416-dt board now tries to setup either a swrst- or watchdog-
> > reset so that it will be able to handle more s3c24xx-SoCs later on.
> 
> [snip]
> 
> > diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> > b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c index 0a86953..88716fa4 100644
> > --- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> > +++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> > @@ -24,6 +24,7 @@
> > 
> >   #include <plat/cpu.h>
> >   #include <plat/pm.h>
> > 
> > +#include <plat/watchdog-reset.h>
> > 
> >   #include "common.h"
> > 
> > @@ -34,6 +35,14 @@ static void __init s3c2416_dt_map_io(void)
> > 
> >   static void __init s3c2416_dt_machine_init(void)
> >   {
> > 
> > +	s3c24xx_swrst_reset_of_init();
> > +
> > +#ifdef CONFIG_SAMSUNG_WDT_RESET
> > +	/* if no special swrst-device exists try to find a watchdog */
> > +	if (!s3c24xx_swrst_reset_available())
> > +		samsung_wdt_reset_of_init();
> > +#endif
> 
> Hmm... I think it would be safe to assume availability of soft reset,
> especially if you could move the restart code to the clock driver.

ok, so something like the following:

the boards would simply use samsung_watchdog_reset, which should according to 
the manuals be available on all architectures. And the ccf-driver on 
appropriate architectures would simple replace the arm_pm_restart callback 
with its own SoC specific one?

For the s3c2412 this also means that the clock-logic would get simplified.


Like this, or do I overlook something?


Thanks
Heiko
