From: will.deacon@arm.com (Will Deacon)
Date: Sun, 5 Aug 2012 12:42:00 +0100
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <20120805095528.GO2626@pengutronix.de>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
Message-ID: <20120805114200.GC21771@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 10:55:28AM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Aug 03, 2012 at 12:45:32PM +0100, Will Deacon wrote:
> > How about something like:
> > 
> > 
> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > index 835898e..9f07be2 100644
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -86,6 +86,7 @@
> >         __HEAD
> >  ENTRY(stext)
> >  
> > + THUMB(        .inst   0xe200e004      )       @ ARM: and lr, r0, #4 T2: b 1f
> >   THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
> >   THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
> >   THUMB(        .thumb                  )       @ switch to Thumb now.
> Great idea, but it doesn't work as suggested. My compiler already barfs
> on the .arm above:
> 
> 	arch/arm/kernel/head-nommu.S:36: Error: selected processor does not support ARM opcodes
> 	arch/arm/kernel/head-nommu.S:42: Error: attempt to use an ARM instruction on a Thumb-only processor -- `adr r9,1f+1'
> 	arch/arm/kernel/head-nommu.S:43: Error: attempt to use an ARM instruction on a Thumb-only processor -- `bx r9'

Aaand our good friend gas bites us again. Out of interest, what happens 
if you pass -march=all instead of whatever you currently pass (armv7m or
something I guess?). We hit a bug the other day assembling the decompressor
and I'd be interested to know what the tools do with your code.

> but something like that should be doable.

Maybe we should just .inst the two arm instructions as well and lose the
.arm directive. Given that the size of those instructions is now encoded
in the first instruction (for the Thumb-2 branch), it would also make it
clear that you can't just add extra arm instructions there without
changing the branch.

Will
