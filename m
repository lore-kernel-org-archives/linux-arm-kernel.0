From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 Jun 2018 14:29:34 +0100
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
Message-ID: <20180629132934.GA16282@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 01:23:54PM +0200, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 11:29:27AM +0100, Sudeep Holla wrote:
> > On Thu, Jun 28, 2018 at 07:32:43PM +0200, Andrew Jones wrote:
> > > On Thu, Jun 28, 2018 at 05:30:51PM +0100, Sudeep Holla wrote:
> > > > I am not sure if we can ever guarantee that DT and ACPI will get the
> > > > same ids whatever counter we use as it depends on the order presented in
> > > > the firmware(DT or ACPI). So I am not for generating ids for core and
> > > > threads in that way.
> > >
> > > I don't believe we have to guarantee that the exact (package,core,thread)
> > > triplet describing a PE with DT matches ACPI. We just need to guarantee
> > > that each triplet we select properly puts a PE in the same group as its
> > > peers. So, as long as we keep the grouping described by DT or ACPI, then
> > > the (package,core,thread) IDs assigned are pretty arbitrary.
> > >
> > 
> > If that's the requirement, we already do that. The IDs are just too
> > arbitrary :)
> 
> Right. The patch doesn't fix anything, it just makes the IDs less weird
> looking to humans, and brings some consistency to IDs across systems
> and hardware descriptions.
>

I agree, but don't think counter like this will be harmless. It can create
some other inconsistency in some other way.

> > 
> > > I could change the commit message to state we can generate IDs *like*
> > > DT does (i.e. with counters), even if they may not result in identical
> > > triplet to PE mappings.
> > >
> > 
> > Why we need to make it *like DT* ?
> 
> Because the DT parser considers human readers, which, IMHO, is nicer.
> 
> The consistency remapping to counters brings shouldn't be overlooked. If
> both ACPI and DT present the CPUs in the same order (i.e.  cpu0 is mpidr0,
> cpu1 is mpidr1, ...) using their respective descriptions, then this patch
> will ensure topology IDs are the same. 

Yes, it's all fine in theory. But firmware is the one presenting it and
ACPI PPTT has UID for a reason and I want that to be the single source
for these IDs.

> Also, when going from machine to
> machine, it's nice to expect package/core/thread-id to be within
> the same range and to vary by a set difference (1), rather than have
> IDs that increment by 20 on one system and by 160 on another,
> depending on how the ACPI table nodes are laid out.
>

If it matters a lot, vendors must use UID for consistency. Since OS doesn't
use those IDs for any particular reason, OS must not care.

> > 
> > > >
> > > > So I would like to keep it simple and just have this counters for
> > > > package ids as demonstrated in Shunyong's patch.
> > > >
> > >
> > > If we don't also handle cores when there are threads, then the cores
> > > will also end up having weird IDs.
> > >
> > 
> > Yes, but if PPTT says it has valid ID, I would prefer that over DT like
> > generated.
> 
> Valid *ACPI* ID, which just means it's a guaranteed unique ACPI UID,
> which isn't likely going to be anything useful to a user.
> 

How is that different from OS generated one from user's perspective ?
Vendors might assign sockets UID and he may help them to replace one.
Having some generated counter based id is not helpful.

So if someone needs to have valid IDs there, better to pass it via PPTT.
OS will otherwise put any value(current offset is good choice)

--
Regards,
Sudeep
