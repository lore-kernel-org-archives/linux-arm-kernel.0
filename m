From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 10 Nov 2010 19:32:08 +0530
Subject: [PATCH v3 08/13] OMAP1: DMA: Introduce DMA driver as platform
	device
In-Reply-To: <87bp5ykufg.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-9-git-send-email-manjugk@ti.com>
	<87bp5ykufg.fsf@deeprootsystems.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 3:54 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Cousson, Benoit; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v3 08/13] OMAP1: DMA: Introduce DMA 
> driver as platform device
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > Register OMAP1 DMA driver as platform device and add support
> > for registering through platform device layer using resource
> > structures.
> >
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap1/dma.c              |  182 
> ++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap1/include/mach/dma.h |   29 +++++
> >  2 files changed, 211 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap1/dma.c
> >  create mode 100644 arch/arm/mach-omap1/include/mach/dma.h
> >
> > diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> > new file mode 100644
> > index 0000000..e756069
> > --- /dev/null
> > +++ b/arch/arm/mach-omap1/dma.c
> > @@ -0,0 +1,182 @@
> > +/*
> > + * dma.c - OMAP1/OMAP7xx-specific DMA code
> > + *
> > + * Copyright (C) 2003 - 2008 Nokia Corporation
> > + * Author: Juha Yrj?l? <juha.yrjola@nokia.com>
> > + * DMA channel linking for 1610 by Samuel Ortiz 
> <samuel.ortiz@nokia.com>
> > + * Graphics DMA and LCD DMA graphics tranformations
> > + * by Imre Deak <imre.deak@nokia.com>
> > + * OMAP2/3 support Copyright (C) 2004-2007 Texas Instruments, Inc.
> > + * Some functions based on earlier dma-omap.c Copyright 
> (C) 2001 RidgeRun, Inc.
> > + *
> > + * Copyright (C) 2010 Texas Instruments, Inc.
> > + * Converted DMA library into platform driver
> > + *                   - G, Manjunath Kondaiah <manjugk@ti.com>
> > + *
> > + * This program is free software; you can redistribute it 
> and/or modify
> > + * it under the terms of the GNU General Public License 
> version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +#include <linux/pm_runtime.h>
> 
> no pm_runtime API usage in this patch.    Please add only when needed.
> 
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/sched.h>
> 
> why is sched.h needed?
> 
> > +#include <linux/spinlock.h>
> 
> ditto
> 
> > +#include <linux/errno.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/device.h>
> 
> When creating a new file like this, it's important to only include
> headers that are actually used/needed.

Ok. I will check these headers. It was copy paste from old dma driver.

> 
> > +#include <plat/dma.h>
> > +#include <plat/tc.h>
> > +
[...]
> > diff --git a/arch/arm/mach-omap1/include/mach/dma.h 
> b/arch/arm/mach-omap1/include/mach/dma.h
> > new file mode 100644
> > index 0000000..7949e3f
> > --- /dev/null
> > +++ b/arch/arm/mach-omap1/include/mach/dma.h
> > @@ -0,0 +1,29 @@
> > +/*
> > + *  OMAP DMA controller register offsets.
> > + *
> > + *  Copyright (C) 2003 Nokia Corporation
> > + *  Author: Juha Yrj?l? <juha.yrjola@nokia.com>
> > + *
> > + *  Copyright (C) 2010 Texas Instruments
> > + *  Converted DMA library into platform driver
> > + *       by G, Manjunath Kondaiah <manjugk@ti.com>
> > + *
> > + * This program is free software; you can redistribute it 
> and/or modify
> > + * it under the terms of the GNU General Public License as 
> published by
> > + * the Free Software Foundation; either version 2 of the 
> License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General 
> Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
> MA 02111-1307 USA
> > + */
> > +
> > +#ifndef __ASM_ARCH_OMAP1_DMA_H
> > +#define __ASM_ARCH_OMAP1_DMA_H
> > +
> > +#endif /* __ASM_ARCH_OMAP1_DMA_H */
> 
> Please don't create an empty header.  Just create it in the 
> series when
> (if) it's needed.  Same goes for next patch.

ok.

-Manjunath

> 
> I see you populate mach/dma.h later in the series, but I don't
> understand why those values need to be in the header.   More 
> comments on
> those patches...
> 
> Kevin
> 
> 
> 
