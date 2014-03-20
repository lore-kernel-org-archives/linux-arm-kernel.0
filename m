From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 11:59:35 +0100
Subject: [PATCH 61/62] ARM: sunxi: fix build for THUMB2_KERNEL
In-Reply-To: <CAL_JsqKaL4W_bjozC_hTmZ9439pqh8f8pHU25H5CNdf8hQZtOg@mail.gmail.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-62-git-send-email-arnd@arndb.de>
 <CAL_JsqKaL4W_bjozC_hTmZ9439pqh8f8pHU25H5CNdf8hQZtOg@mail.gmail.com>
Message-ID: <201403201159.35842.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014, Rob Herring wrote:

> > --- a/arch/arm/mach-sunxi/headsmp.S
> > +++ b/arch/arm/mach-sunxi/headsmp.S
> > @@ -4,6 +4,7 @@
> >          .section ".text.head", "ax"
> >
> >  ENTRY(sun6i_secondary_startup)
> > -       msr     cpsr_fsxc, #0xd3
> > +       mov     r0, #0xd3
> > +       msr     cpsr_fsxc, r0
> >         b       secondary_startup
> 
> Secondary cores should always enter the kernel in ARM mode like the
> primary core, right? So we need the same switching to Thumb2 as
> head.S, but even secondary_startup doesn't do any switching. So either
> platforms jump into the kernel with a bx and happen to work or
> secondary boot is broken for Thumb2 kernels.

Makes sense. So should we instead do this?

.arm
ENTRY(sun6i_secondary_startup)
	ARM_BE8(setend   be ) /* I suppose we need this too */
	msr     cpsr_fsxc, #0xd3
	ldr	r0, =secondary_startup
	bx	r0

(I'm a bit confused about when to use what branch instruction, so
forgive me if the above doesn't make sense)

> Also, secondary_startup takes care of making sure the core is in SVC
> mode, so this function shouldn't be needed in the first place.

I'd rather not change this part, unless Maxime can confirm that it's
not necessary. I would assume that it's there for a reason otherwise.

	Arnd
