From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Jul 2013 18:03:04 +0200
Subject: scripts/kallsyms: Avoid ARM veneer symbols
In-Reply-To: <20130625150941.GF2327@linaro.org>
References: <2983817.Xe2505Drlj@wuerfel> <20130625150941.GF2327@linaro.org>
Message-ID: <201307031803.04501.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 June 2013, Dave Martin wrote:
> On Mon, Jun 24, 2013 at 04:01:43PM +0200, Arnd Bergmann wrote:
> > When building ARM kernels that exceed a certain size, the linker
> > will add "veneers" that allow long branches. Unfortunately,
> > using a longer kallsyms section may lead to the extra veneers
> > being needed, which leads to inconsistent kallsyms data with the
> > message
> > 
> > Inconsistent kallsyms data
> > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > 
> > In some case, not just one but up to three extra passes were
> > needed before getting to a state that needed no extra veneers.
> 
> Do you understand why this was happening?  It sounds like there
> must have been branches crossing from one side of the kallsyms
> data to the other, triggering veneer insertion any time the
> kallsyms data grows.
> 
> Branches between .{init,exit}.text and .text (crossing .rodata) seem the
> likeliest culprits, but that's guesswork on my part.

kallsyms is part of rodata, which is between .text and .init.text.
I understand this is intentional, and we already use two passes
of kallsyms to make sure the size is right. However the assumption
is that only the data of the kallsyms table changes between runs,
not the size of it.

> If that's whats going on, multiple kallsyms passes is actually a correct
> approach here: I think they should terminate after a number of steps
> roughly proportional to log(number of branches across .rodata). We
> could come up with a heuristic which allows us to choose the right
> limit with a high degree of reliability, since branch density in
> compiled C code is likely to be roughly.

It also seems to be a part of the design to do exactly two passes
and treat anything beyond that as bugs, doing it the way you
suggest would significantly increase the build time since the
kallsyms+linker stage cannot be done in parallel or sped up
using ccache.

> But including the veneer symbols in kallsyms is arguably not all
> that useful.
> 
> The main potential effect is that profiling might occasionally
> sample the PC as being in a completely bogus function which it
> never passed through at all, because of the way kallsyms tracks
> only symbol locations and not sizes (if I remember right) --
> so a veneer will actually get accounted against some arbitrary
> adjacent function.
> 
> I don't know how much this matters.

Interesting point. No idea how often that happens. All the veneers
for one section are in one place though, so we could in theory
add a kallsyms entry for that section as long as can identify
it.

> > The easiest solution is to skip veneers in kallsyms in the
> > same way we already skip a couple of other symbols.
> 
> The other symbols are not stripped for the purpose of making
> kallsyms terminate quickly.  The mapping symbols are rather
> different: masses of symbols with duplicate names which are
> not very interesting for most people.

Right.

> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 487ac6f..53ec0bb 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c
> > @@ -69,14 +69,32 @@ static void usage(void)
> >  	exit(1);
> >  }
> >  
> > -/*
> > - * This ignores the intensely annoying "mapping symbols" found
> > - * in ARM ELF files: $a, $t and $d.
> > - */
> >  static inline int is_arm_mapping_symbol(const char *str)
> 
> The function's name is now wrong.  Should it be renamed or split up?

Sure I can rename it. Any suggestions?

	Arnd
