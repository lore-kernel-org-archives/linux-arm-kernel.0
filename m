From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 14 Feb 2011 10:38:34 +0530
Subject: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
	cause data corruption
In-Reply-To: <AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com><1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com><AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com><13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
	<AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com>
Message-ID: <33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw at motorola.com]
> Sent: Sunday, February 13, 2011 4:48 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; Kevin Hilman; tony at atomide.com;
> linux-arm-kernel at lists.infradead.org; Catalin Marinas
> Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> operation can cause data corruption
>
> On Sat, Feb 12, 2011 at 11:59 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> From: Andrei Warkentin [mailto:andreiw at motorola.com]
> >> Sent: Saturday, February 12, 2011 11:20 PM
> >> To: Santosh Shilimkar
> >> Cc: linux-omap at vger.kernel.org; khilman at ti.com; tony at atomide.com;
> >> linux-arm-kernel at lists.infradead.org; Catalin Marinas
> >> Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> >> operation can cause data corruption
> >>
> > [....]
> >
> >>
> >> Can these PL310 errata fixes be made more generic? PL310 is
> present
> >> in
> >> non-OMAP platforms too, which lack the TI hypervisor. And these
> >> platforms might have the same PL310 rev, and suffer the same
> >> glitches.
> >> While ideally there is some kind of hypervisor_ops to modify the
> >> protected register, at the very least there should be the generic
> >> debug_write handling the ?"I ?can write all PL310 regs" case. If
> >> you're interested I have a patch someplace that tried to do this,
> >> hopefully I can still find it.
> >
> > They are kind of generic. If you look at it, the only change
> > Which is arch specific is the implementation of "debug_writel"
> function.
> > Today this code is not in generic PL310 code, but
> > OMAP specific.
> >
> > May be we can make this as exported function pointer, which
> > arch's can populate.
> >
> > Will that work for you ?
> >
> > Regards,
> > Santosh
> >
>
> Ie something like the following.... what do you think???
>
> #define L2X0_DCR (0xF40)
>
> static void debug_writel(unsigned long val)
> {
> #ifdef CONFIG_ARCH_OMAP4
>        omap_smc1(0x100, val);
> #else
>        writel_relaxed(val, l2x0_base + L2X0_DCR);
> #endif
> }
> ...
I understood that from first comment. But I am not in favor
of polluting common ARM files with SOC specific #ifdeffery.
We have gone over this when first errata support
was added for PL310

I have a better way to handle this scenario.
Expect an updated patch for this.

Regards,
Santosh
