From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 17:05:09 +0100
Subject: [PATCH 61/62] ARM: sunxi: fix build for THUMB2_KERNEL
In-Reply-To: <CAL_JsqL_XkF6VRAJdgRmZvX6uud3S8OqvzoTqc9hy2PNDUv5kw@mail.gmail.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <201403201159.35842.arnd@arndb.de>
 <CAL_JsqL_XkF6VRAJdgRmZvX6uud3S8OqvzoTqc9hy2PNDUv5kw@mail.gmail.com>
Message-ID: <4626847.CFbp3XOTnf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014 10:54:49 Rob Herring wrote:
> On Thu, Mar 20, 2014 at 5:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 19 March 2014, Rob Herring wrote:
> >
> >> > --- a/arch/arm/mach-sunxi/headsmp.S
> >> > +++ b/arch/arm/mach-sunxi/headsmp.S
> >> > @@ -4,6 +4,7 @@
> >> >          .section ".text.head", "ax"
> >> >
> >> >  ENTRY(sun6i_secondary_startup)
> >> > -       msr     cpsr_fsxc, #0xd3
> >> > +       mov     r0, #0xd3
> >> > +       msr     cpsr_fsxc, r0
> >> >         b       secondary_startup
> >>
> >> Secondary cores should always enter the kernel in ARM mode like the
> >> primary core, right? So we need the same switching to Thumb2 as
> >> head.S, but even secondary_startup doesn't do any switching. So either
> >> platforms jump into the kernel with a bx and happen to work or
> >> secondary boot is broken for Thumb2 kernels.
> >
> > Makes sense. So should we instead do this?
> 
> That would work, but I'm more worried that Thumb2 may be broken on
> other platforms.

I'm rather sure it is. I have found lots of build-time bugs with
thumb2, so by extrapolation there are more run-time bugs. I have
considered just enabling it in multi_v7_defconfig though, mainly
to see what would break ;-).

> > .arm
> > ENTRY(sun6i_secondary_startup)
> >         ARM_BE8(setend   be ) /* I suppose we need this too */
> >         msr     cpsr_fsxc, #0xd3
> >         ldr     r0, =secondary_startup
> >         bx      r0
> >
> > (I'm a bit confused about when to use what branch instruction, so
> > forgive me if the above doesn't make sense)
> >
> >> Also, secondary_startup takes care of making sure the core is in SVC
> >> mode, so this function shouldn't be needed in the first place.
> >
> > I'd rather not change this part, unless Maxime can confirm that it's
> > not necessary. I would assume that it's there for a reason otherwise.
> 
> That often proves to not be the case. :) Initial SOC code is whatever
> we've failed to delete from vendor BSP code.
> 
> Looking at the review comments adding SMP boot, there was discussion
> about entering in HYP mode and that being dependent on u-boot support,
> but nothing whether this was needed or not. So it appears to me we
> probably enter the kernel in the reset default of secure supervisor
> mode and this code is a nop. This code would not work if it was HYP
> mode. So when u-boot does correctly setup HYP mode, this code will be
> broken (although other parts of smp_ops will be too).
> 
> The first things secondary_startup do are:
> 
> -set BE mode
> -if in HYP mode, install hyp vectors and drop to SVC
> -set the CPSR to a know value (safe_svcmode_maskall r9)
> 
> So this code is completely redundant and unnecessary. If there were
> some reason for it, then it should be in secondary_startup.

Ah, thanks for the clarification. Shall we just delete the file then
and jump straight to secondary_startup?

	Arnd
