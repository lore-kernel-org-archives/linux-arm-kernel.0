From: npiggin@gmail.com (Nicholas Piggin)
Date: Wed, 26 Jul 2017 22:03:34 +1000
Subject: [BUG] v4.12 breaks pxa25x
In-Reply-To: <20170726114139.GN31807@n2100.armlinux.org.uk>
References: <87inirsgzk.fsf@belgarion.home>
 <20170717081518.GI31807@n2100.armlinux.org.uk>
 <87eftfrs0e.fsf@belgarion.home> <87o9s7qw64.fsf@belgarion.home>
 <20170726114139.GN31807@n2100.armlinux.org.uk>
Message-ID: <20170726220334.2961ae22@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jul 2017 12:41:39 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Wed, Jul 26, 2017 at 01:23:15PM +0200, Robert Jarzmik wrote:
> > Robert Jarzmik <robert.jarzmik@free.fr> writes:  
> > > Sure, it like this :
> > > c06f22c8 D user_pmd_table
> > > c06f22cc d __warned.19178
> > > c06f22cd d clean_addr
> > >
> > > And I have no idea how to link that __warned.19178 with the WARN_xxx() statement ...
> > >
> > > This bisection I made points me to :
> > > # first bad commit: [799c43415442414b1032580c47684cb709dfed6d] kbuild: thin archives make default for all archs
> > >
> > > Reverting this commit makes my kernel boot again.  
> > 
> > Hi Russell,
> > 
> > I think I know where this is comming from.
> >   - in file: ~/mio_linux/kernel/include/asm-generic/vmlinux.lds.h:206
> >   - the definition of DATA_DATA looks like :
> >     (*.data .data.[0-9a-zA-Z_]*)
> >     ...
> >     *(.data.unlikely)
> >     ...
> > 
> > This doesn't look good to me, as .data.unlikely fullfills the first wildcard,
> > and the linker is allowed to mix .data and .data.unlikely symbols to its
> > pleasure, while .data.unlikely symbols (at least in my case) are not 4 bytes
> > multiples.  
> 
> Obviously, the mixing of .data.unlikely with the normal .data sections
> is undesirable - that looks like it's come from commit b67067f1176d
> ("kbuild: allow archs to select link dead code/data elimination") dated
> 2016, which according to git describe --contains was merged in v4.9-rc1.
> So it's unlikely to be directly caused by this, although this commit is
> implicated.
> 
> I wonder if Nick realised this side effect (that .data.unlikely is no
> longer grouped together) - maybe we need to rename .data.unlikely?
> (Adding Nick and Michal).

I did to some degree -- hence TEXT was not done that way -- but obviously
did not look closely enough.

The right short term fix I think is to make those wildcards depend only on
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.

One way to avoid clashes with compiler generated section names is to use
".." as separators in our section names.

Anyway I'll code up a fix for the linker script that we can get into 4.12,
thanks for pointing it out.

Thanks,
Nick
