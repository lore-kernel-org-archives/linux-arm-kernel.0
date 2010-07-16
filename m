From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Jul 2010 21:44:36 +0100
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <AANLkTimKpmZaGRYfYs8HGDz-_VG8ePXN6bZvl2-YcNdR@mail.gmail.com>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<20100716183028.GB26854@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1007161439240.10598@xanadu.home>
	<AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
	<1279310976.18579.8.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimKpmZaGRYfYs8HGDz-_VG8ePXN6bZvl2-YcNdR@mail.gmail.com>
Message-ID: <1279313076.20418.3.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-16 at 21:17 +0100, Grant Likely wrote:
> On Fri, Jul 16, 2010 at 2:09 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, 2010-07-16 at 19:46 +0100, Linus Torvalds wrote:
> >> On Fri, Jul 16, 2010 at 11:40 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> >
> >> > DOH.
> >>
> >> Well, it's possible that the correct approach is a mixture.
> >>
> >> Automatically do the trivial cases (recursive selects, dependencies
> >> that are simple or of the form "x && y" etc), and warn about the cases
> >> that aren't trivial (where "not trivial" may not necessarily be about
> >> fundamentally ambiguous ones, but just "complex enough that I won't
> >> even try").
> >
> > There is still a risk with this approach when the Kconfig isn't entirely
> > correct. For example, on ARM we have (I pushed a patch already):
> >
> > config CPU_32v6K
> >        depends on CPU_V6
> >
> > config CPU_V7
> >        select CPU_32v6K
> >
> > In this simple approach, we end up selecting CPU_V6 when we only need
> > CPU_V7. There other places like this in the kernel.
> >
> > Of course, kbuild could still warn but if people rely on this feature to
> > select options automatically I suspect they would ignore the warnings.
> 
> In my first patch, I made Kconfig problems errors instead of warnings.
>  That would prevent people from ignoring them.

My point was that if we allow kbuild to select dependencies
automatically (as per Nico's initial suggestion, followed up by Linus),
in the above situation CPU_V7 would trigger the selection of CPU_V6 and
I don't want this. If we rely on such automatic selection of the
"depends on" options, we can't make the warnings be errors.

-- 
Catalin
