From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Sep 2011 10:30:01 +0800
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level debug
	uart
In-Reply-To: <20110907123635.GT28816@pengutronix.de>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
	<20110906202555.GQ28816@pengutronix.de>
	<20110907110001.GI8148@S2100-06.ap.freescale.net>
	<20110907123635.GT28816@pengutronix.de>
Message-ID: <20110912023000.GC1258@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 02:36:35PM +0200, Uwe Kleine-K?nig wrote:
> On Wed, Sep 07, 2011 at 07:00:02PM +0800, Shawn Guo wrote:
> > On Tue, Sep 06, 2011 at 10:25:55PM +0200, Uwe Kleine-K?nig wrote:
> > > On Tue, Sep 06, 2011 at 05:58:36PM +0800, Shawn Guo wrote:

[...]

> > > > diff --git a/arch/arm/plat-mxc/include/mach/mx6q.h b/arch/arm/plat-mxc/include/mach/mx6q.h
> > > > new file mode 100644
> > > > index 0000000..7432310
> > > > --- /dev/null
> > > > +++ b/arch/arm/plat-mxc/include/mach/mx6q.h
> > > > @@ -0,0 +1,29 @@
> > > > +/*
> > > > + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> > > > + * Copyright 2011 Linaro Ltd.
> > > > + *
> > > > + * The code contained herein is licensed under the GNU General Public
> > > > + * License. You may obtain a copy of the GNU General Public License
> > > > + * Version 2 or later at the following locations:
> > > > + *
> > > > + * http://www.opensource.org/licenses/gpl-license.html
> > > > + * http://www.gnu.org/copyleft/gpl.html
> > > > + */
> > > > +
> > > > +#ifndef __MACH_MX6Q_H__
> > > > +#define __MACH_MX6Q_H__
> > > > +
> > > > +/* static mappings */
> > > > +#define IMX6Q_VA(x)		(0xf4000000 + (x))
> > > > +
> > > > +#define MX6Q_SCU_BASE_ADDR	0x00a00000
> > > > +#define MX6Q_CCM_BASE_ADDR	0x020c4000
> > > > +#define MX6Q_ANATOP_BASE_ADDR	0x020c8000
> > > > +#define MX6Q_UART4_BASE_ADDR	0x021f0000
> > > > +
> > > > +#define MX6Q_SCU_BASE_VADDR	IMX6Q_VA(MX6Q_SCU_BASE_ADDR)
> > > > +#define MX6Q_CCM_BASE_VADDR	IMX6Q_VA(MX6Q_CCM_BASE_ADDR)
> > > > +#define MX6Q_ANATOP_BASE_VADDR	IMX6Q_VA(MX6Q_ANATOP_BASE_ADDR)
> > > > +#define MX6Q_UART4_BASE_VADDR	IMX6Q_VA(MX6Q_UART4_BASE_ADDR)
> > > Depending on the sizes of these memory regions you can use the existing
> > > IMX_IO_P2V here. The conditions are:
> > > 
> > > 	SCU_SIZE <= 0x200000
> Actually this should be 0x100000 as this is the size that is mapped in a
> continous chunk.
> 
> > > 	CCM_SIZE <= 0x4000
> > > 	ANATOP_SIZE <= 0x28000
> > > 	UART4 <= 0x100000
> > > 
> > This is exactly what I dislike about IMX_IO_P2V().  We have to verify
> > all these conditions manually.  Looking at the static mapping below
> I did it semi-manual, I just put your constants for imx6q into my script
> (all with size=0x4000 for now) and it told me:
> 
> ...
>  * mx6q:
>  *	SCU	0x00a00000+0x004000	->	0xf4000000+0x004000
>  *	CCM	0x020c4000+0x004000	->	0xf42c4000+0x004000
>  *	ANATOP	0x020c8000+0x004000	->	0xf42c8000+0x004000
>  *	UART4	0x021f0000+0x004000	->	0xf42f0000+0x004000
> ...
> 
> > (copied from arch/arm/plat-mxc/include/mach/hardware.h), do you think
> > it's really scalable and easy to maintain for the long run?
> At least it provides a way to verify the correctness of the mapping.
> Before I introduced the mapping function there was a conflict IIRC.
> 
> > /*
> >  * This is rather complicated for humans and ugly to verify, but for a machine
> >  * it's OK.  Still more as it is usually only applied to constants.  The upsides
> >  * on using this approach are:
> >  *
> >  *  - same mapping on all i.MX machines
> >  *  - works for assembler, too
> >  *  - no need to nurture #defines for virtual addresses
> >  *
> >  * The downside it, it's hard to verify (but I have a script for that).
> If you want I can provide you that script.
> 
Yes, please. I would use IMX_IO_P2V() in the next post.

[...]

> > #define IMX_IO_P2V(x)	(						\
> > 			0xf4000000 +					\
> > 			(((x) & 0x50000000) >> 6) +			\
> > 			(((x) & 0x0b000000) >> 4) +			\
> > 			(((x) & 0x000fffff)))
> > 
> > > hmm, looking at patch 4 SCU_BASE is determined by a coprocessor
> > > instruction?!
> > 
> > Ah, yes.  The SCU physical base address can be retrieved from
> > coprocessor.
> Is there an advantage in autodetecting the base address?
>  
Any disadvantage for doing so?

-- 
Regards,
Shawn
