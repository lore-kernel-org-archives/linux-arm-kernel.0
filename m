From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 17:28:57 +0100
Subject: [PATCH 2/9] lpc2k: Exception vector handling
In-Reply-To: <20110317161825.GA31219@pengutronix.de>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-3-git-send-email-ithamar.adema@team-embedded.nl>
	<20110317161825.GA31219@pengutronix.de>
Message-ID: <1300379337.2138.88.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-17 at 17:18 +0100, Uwe Kleine-K?nig wrote:
> On Thu, Mar 17, 2011 at 04:54:17PM +0100, Ithamar R. Adema wrote:
> > diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> > index e8d8856..618a971 100644
> > --- a/arch/arm/kernel/entry-armv.S
> > +++ b/arch/arm/kernel/entry-armv.S
> > @@ -1208,6 +1208,7 @@ __stubs_end:
> >  
> >  	.globl	__vectors_start
> >  __vectors_start:
> > +#ifndef CONFIG_ARCH_LPC2K
> >   ARM(	swi	SYS_ERROR0	)
> >   THUMB(	svc	#0		)
> >   THUMB(	nop			)
> > @@ -1218,6 +1219,23 @@ __vectors_start:
> >  	W(b)	vector_addrexcptn + stubs_offset
> >  	W(b)	vector_irq + stubs_offset
> >  	W(b)	vector_fiq + stubs_offset
> > +#else /* CONFIG_ARCH_LPC2K */
> The description from the commit log should be repeated here.

OK, will include the description as comment there in the next version.

> And I wonder if this shouldn't depend on CONFIG_ARCH_LPC2K but
> CONFIG_MMU.

Well, looking at th uClinux kernel tree, it seems this was only done for
the NXP LPC2K range, so that's why I kept it under CONFIG_ARCH_LPC2K.

> > +	swi	SYS_ERROR0
> I think arm7tdmi doesn't have thumb2, does it? If it has you need to do
> ARM(swi SYS_ERROR0)
> THUMB(svc ..)
> ...
> 
> as above

Correct, the ARM7TDMI-S only supports Thumb, not Thumb2.

Thanks for reviewing!

Ithamar.
