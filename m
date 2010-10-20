From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 11:20:14 +0200
Subject: [PATCH 5/5] ARM: remove per-platform timex.h include files
In-Reply-To: <20101020090850.GJ28166@pengutronix.de>
References: <20101020045200.GB12979@mail.wantstofly.org>
	<20101020090850.GJ28166@pengutronix.de>
Message-ID: <20101020092014.GB12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 11:08:50AM +0200, Uwe Kleine-K?nig wrote:

> Hi Lennert,

Hi Uwe,


> > As they are now redundant.
> > 
> > Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> > ---
> >  arch/arm/mach-aaec2000/include/mach/timex.h   |   18 -----
> > [...]
> > diff --git a/arch/arm/mach-at91/include/mach/timex.h b/arch/arm/mach-at91/include/mach/timex.h
> > deleted file mode 100644
> > index 05a6e8a..0000000
> > --- a/arch/arm/mach-at91/include/mach/timex.h
> > +++ /dev/null
> > @@ -1,92 +0,0 @@
> > -/*
> > - * arch/arm/mach-at91/include/mach/timex.h
> > - *
> > - *  Copyright (C) 2003 SAN People
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - * GNU General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU General Public License
> > - * along with this program; if not, write to the Free Software
> > - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> > - */
> > -
> > -#ifndef __ASM_ARCH_TIMEX_H
> > -#define __ASM_ARCH_TIMEX_H
> > -
> > -#include <mach/hardware.h>
> > -
> > -#if defined(CONFIG_ARCH_AT91RM9200)
> > -
> > -#define CLOCK_TICK_RATE		(AT91_SLOW_CLOCK)
> > -
> > -#elif defined(CONFIG_ARCH_AT91SAM9260)
> > -
> > -#if defined(CONFIG_MACH_USB_A9260) || defined(CONFIG_MACH_QIL_A9260)
> > -#define AT91SAM9_MASTER_CLOCK	90000000
> > -#else
> > -#define AT91SAM9_MASTER_CLOCK	99300000
> > -#endif
>
> I wonder if you checked that the defines you remove here are otherwise
> unused?!  a quick grep showed for example that
> arch/arm/mach-at91/at91x40.c includes mach/timex.h.

Well, patch #1 in the series does this:


diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index ad3ec85..e3dce6e 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -16,9 +16,10 @@
 #include <asm/mach/arch.h>
 #include <mach/at91x40.h>
 #include <mach/at91_st.h>
-#include <mach/timex.h>
 #include "generic.h"
 
+#define AT91X40_MASTER_CLOCK   40000000
+
 /*
  * Export the clock functions for the AT91X40. Some external code common
  * to all AT91 family parts relys on this, like the gpio and serial support.


There's also AT91SAM9_MASTER_CLOCK, but that is not used anywhere in
the tree.  And the use of LATCH in mach-at91/at91rm9200_time.c is also
taken care of in patch #1.

I'll try an at91 kernel build to confirm that this works as intended.


thanks,
Lennert
