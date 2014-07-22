From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 22 Jul 2014 15:42:47 +0100
Subject: [RFC] arm: section split in boot/compressed/head.S
In-Reply-To: <CAKv+Gu8k=1M9Y7mjYVYYqe94YNFAkG-MRw_GipvN7ORxo4CAMA@mail.gmail.com>
References: <20140721175432.GB4179@bivouac.eciton.net>
 <CAKv+Gu8k=1M9Y7mjYVYYqe94YNFAkG-MRw_GipvN7ORxo4CAMA@mail.gmail.com>
Message-ID: <20140722144247.GC4179@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 08:29:54PM +0200, Ard Biesheuvel wrote:
> On 21 July 2014 19:54, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > Reported-by: Roy Franz <roy.franz@linaro.org>
> >
> > The current code in boot/compressed/head.S executes pretty much
> > sequentially from "start", all the way until the end of
> > "dtb_check_done". However, shortly after the "not_angel" symbol, there
> > is a section change, in the form of a ".text" directive.
> >
> > This means any literal pools in .start end up getting inserted into
> > the middle of the instruction stream.
> >
> > Would something like the below (pardon the semantic silliness) be an
> > acceptable fix?
> >
> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > index 3a8b32d..8ee05e9 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -149,6 +149,10 @@ start:
> >                 mov     r0, #0x17               @ angel_SWIreason_EnterSVC
> >   ARM(          swi     0x123456        )       @ angel_SWI_ARM
> >   THUMB(                svc     0xab            )       @ angel_SWI_THUMB
> > +               b       angel
> 
> 
> The idea appears to be that code in .start sections from other
> platform specific object files gets put there, so it gets executed
> extremely early.
> Jumping over it kind of defeats the purpose here.

Ah, I got the impression something magic was going on, but failed to
spot that bit...

> Instead, adding an explicit .ltorg and jumping over /that/ should do
> the trick, I think, but perhaps it's better just to open code the
> literal pool in this case.

The current state seems fragile, so:

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 3a8b32d..8fded53 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -149,6 +149,11 @@ start:
 		mov	r0, #0x17		@ angel_SWIreason_EnterSVC
  ARM(		swi	0x123456	)	@ angel_SWI_ARM
  THUMB(		svc	0xab		)	@ angel_SWI_THUMB
+		b	angel
+
+		.ltorg
+
+angel:
 not_angel:
 		safe_svcmode_maskall r0
 		msr	spsr_cxsf, r9		@ Save the CPU boot mode in

?

/
    Leif
