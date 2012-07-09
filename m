From: pavel@denx.de (Pavel Machek)
Date: Mon, 9 Jul 2012 14:06:11 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <4FF483D2.70000@gmail.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <4FF483D2.70000@gmail.com>
Message-ID: <20120709120611.GD12130@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

[Oops, I missed few review comments; hard to see in all the quoted material.]

> > +static inline void cpu_leave_lowpower(void)
> > +{
> > +	unsigned int v;
> > +
> > +	asm volatile("mrc	p15, 0, %0, c1, c0, 0\n"
> > +	"	orr	%0, %0, %1\n"
> > +	"	mcr	p15, 0, %0, c1, c0, 0\n"
> > +	"	mrc	p15, 0, %0, c1, c0, 1\n"
> > +	"	orr	%0, %0, #0x20\n"
> > +	"	mcr	p15, 0, %0, c1, c0, 1\n"
> > +	  : "=&r" (v)
> > +	  : "Ir" (CR_C)
> > +	  : "cc");
> > +}
> > +
> > +static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> > +{
> > +	/*
> > +	 * there is no power-control hardware on this platform, so all
> > +	 * we can do is put the core into WFI; this is safe as the calling
> > +	 * code will have already disabled interrupts
> 
> Is this true or just copied from ARM Ltd platforms?

No idea, probably copied. Dinh?

But I guess it makes sense to just use the "WFI" for initial merge.

> > +++ b/arch/arm/mach-socfpga/localtimer.c
> > @@ -0,0 +1,34 @@
> > +/*
> > + *  Copyright (C) 2012 Altera Corporation
> > + *  Copyright (C) 2002 ARM Ltd.
> > + *  All Rights Reserved
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#include <linux/init.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +
> > +#include <asm/smp_twd.h>
> > +
> > +/*
> > + * Setup the local clock events for a CPU.
> > + */
> > +int __cpuinit socfpga_local_timer_setup(struct clock_event_device *evt)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
> 
> This compatible string is wrong (it changed). See the documentation.

OK, I updated the string (like below), but... should this code be
needed at all? Core should call this itself and
socfpga_local_timer_setup does not seem to be called at all...?

									Pavel 

diff --git a/arch/arm/mach-socfpga/localtimer.c b/arch/arm/mach-socfpga/localtimer.c
index 4aa9221..a616488 100644
--- a/arch/arm/mach-socfpga/localtimer.c
+++ b/arch/arm/mach-socfpga/localtimer.c
@@ -22,7 +22,7 @@ int __cpuinit socfpga_local_timer_setup(struct clock_event_device *evt)
 {
 	struct device_node *np;
 
-	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-twd-timer");
 	if (!twd_base) {
 		twd_base = of_iomap(np, 0);
 		WARN_ON(!twd_base);


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
