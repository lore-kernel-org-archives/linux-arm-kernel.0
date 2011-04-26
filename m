From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 06:27:14 +0200
Subject: [PATCH 02/14] at91: introduce commom AT91_BASE_SYS
In-Reply-To: <4DB5EC1A.7080400@bluewatersys.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-2-git-send-email-plagnioj@jcrosoft.com>
	<4DB5EC1A.7080400@bluewatersys.com>
Message-ID: <20110426042714.GE12904@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> > index 7bdf566..46ae08f 100644
> > --- a/arch/arm/mach-at91/at91rm9200.c
> > +++ b/arch/arm/mach-at91/at91rm9200.c
> > @@ -20,16 +20,12 @@
> >  #include <mach/at91_st.h>
> >  #include <mach/cpu.h>
> >  
> > +#include "soc.h"
> >  #include "generic.h"
> >  #include "clock.h"
> >  
> >  static struct map_desc at91rm9200_io_desc[] __initdata = {
> >  	{
> > -		.virtual	= AT91_VA_BASE_SYS,
> > -		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
> > -		.length		= SZ_4K,
> > -		.type		= MT_DEVICE,
> > -	}, {
> 
> If the RM9200 system controller is not at the same base address as the
> other variants then how does the common AT91_BASE_SYS work correctly? I
> can't see an offseting code. What am I missing?
you have reserved memory and the then we map it in memory
cf hardware.h
> 
> <snip>
> 
> > diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
> > index 3d64a75..b7ff44a 100644
> > --- a/arch/arm/mach-at91/include/mach/hardware.h
> > +++ b/arch/arm/mach-at91/include/mach/hardware.h
> > @@ -16,6 +16,20 @@
> >  
> >  #include <asm/sizes.h>
> >  
> > +#if !defined(CONFIG_ARCH_AT91X40)
> > +/*
> > + * on all at91 except rm9200 and x40 have the System Controller start in reallity
> > + * at 0xffffc000 of 16KiB
> > + *
> > + * on rm9200 it's start at 0xfffe4000 of 111KiB with non reserved data starting
> > + * at 0xfffff000
> > + *
> > + * so we will use a common AT91_BASE_SYS at 0xffffc000 of 16KiB
> > + * and map the same memory space
> 
> Please reword this as suggested for the changelog.
> 
> <snip>
> 
> > diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
> > new file mode 100644
> > index 0000000..6c30d74
> > --- /dev/null
> > +++ b/arch/arm/mach-at91/soc.h
> > @@ -0,0 +1,22 @@
> > +/*
> > + * Copyright (C) 2007 Atmel Corporation.
> > + * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > + *
> > + * Under GPLv2
> > + *
> > + */
> > +
> > +struct at91_soc {
> > +	char *name;
> 
> Should be const. Do we really need the name of the AT91 variant? We
> could just export the initialize function and get rid of this new struct
> which would further reduce the line count?
yeah some board can have different soc so print is usefull

I do not want to export 1000 of functions as done today
the struct is here for this

Best Regards,
J.
