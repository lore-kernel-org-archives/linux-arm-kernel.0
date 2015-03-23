From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Mar 2015 12:49:48 +0000
Subject: ERRATA work-arounds in the kernel
In-Reply-To: <550C93B9.7010203@free.fr>
References: <550C4B12.1030608@free.fr>
 <20150320172041.GI3421@e104818-lin.cambridge.arm.com>
 <550C93B9.7010203@free.fr>
Message-ID: <20150323124947.GB12757@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 10:40:09PM +0100, Mason wrote:
> On 20/03/2015 18:20, Catalin Marinas wrote:
> > On Fri, Mar 20, 2015 at 05:30:10PM +0100, Mason wrote:
> >> I also looked at ARM's "Errata Summary Table" for the Cortex A9. There are
> >> roughly 90 errata documented there. (This document is 2 years old.)
> >>
> >> I assume that some (most?) of these do not apply to Linux, but it seems
> >> likely that some do?
> >>
> >> I'm wondering why there are not more work-arounds available in Kconfig?
> > 
> > There are a few reasons:
> > 
> > - erratum cannot be triggered in Linux
> > - erratum cannot be worked around in Linux (e.g. it requires some
> >   undocumented control bits to be set by firmware or even hw workaround
> >   like the system errata)
> > - cat A erratum with no feasible workaround (and partners usually take
> >   an ECO fix)
> 
> What's an ECO fix?

A netlist fix for hardware:

http://en.wikipedia.org/wiki/Engineering_change_order

> > - erratum does not affect any CPU revision in production (not all rxpy
> >   revisions are in the field; I would include here early CPU revisions
> >   that were licensed as development chips but not widely used)
> > - we simply missed them. So if you think there is any that needs to be
> >   upstreamed, let us know or submit a patch
> > 
> >> I'm wondering if it is possible to trigger some of these with a "normal"
> >> work-load on a "normal" kernel? Has anyone (perhaps ARM employees) looked
> >> at that? (I suppose they have.)
> > 
> > Define "normal". It's really hard to quantify as the workloads can vary
> > widely between different use cases (e.g. mobile vs server).
> 
> Well, the quotes around "normal" were a tongue-in-cheek cop-out
> recognizing that defining "norm" here is tricky business ;-)
> 
> That being said, there are errata (speaking generally, not just
> about ARM) that only trigger in the lab (or in simulation) and
> there are errata that fire more readily (more hand-waving, sorry).
> 
> And #782772 looked like the latter to me (but I would defer to
> your experience).

Unless we are sure that the conditions cannot be met in Linux, there is
no way to guarantee that the erratum won't hit. Many of them are really
unlikely and may have never been reproduced at top level (bare metal
software) but since it cannot be guaranteed, we implement the
workarounds in the kernel. It is up to the device vendor to decide
whether to enable it in production or not (based on some intensive
testing). Also, if we can't reproduce it here, it doesn't mean that a
different device won't trigger it, especially when the erratum is highly
dependent on timings (the reverse is also true, we trigger it here but
some hw vendors can't).

> >> For example, errata #782772
> >> "Speculative execution of a Load-Exclusive or Store-Exclusive instruction
> >> after a write to Strongly Ordered memory might deadlock the processor."
> >> (The recommended work-around is a strategically-placed DMB.)
> >>
> >> Since ldrex is used in low-level code, it seems possible to hit that one?
> >> Or perhaps Linux does not support "Strongly Ordered" memory regions?
> > 
> > It support SO memory and it's used in some cases.
> 
> Therefore, errata 782772 could trigger on a "typical" system,
> right?

If that "typical" system is using SO memory. There are some cases where
Linux ends up with SO memory (MT_UNCACHED or pgprot_noncached).

-- 
Catalin
