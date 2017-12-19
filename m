From: morten.rasmussen@foss.arm.com (Morten Rasmussen)
Date: Tue, 19 Dec 2017 09:38:03 +0000
Subject: [PATCH v5 7/9] arm64: Topology, rename cluster_id
In-Reply-To: <20171218154703.GA8157@red-moon>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-8-jeremy.linton@arm.com>
 <20171213180217.GB4060@red-moon>
 <7bb4e955-f3e5-d22f-4e78-eac97e66a9a6@arm.com>
 <20171218124229.GG507@e105550-lin.cambridge.arm.com>
 <20171218154703.GA8157@red-moon>
Message-ID: <20171219093803.GH507@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 03:47:03PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 18, 2017 at 12:42:29PM +0000, Morten Rasmussen wrote:
> > On Fri, Dec 15, 2017 at 10:36:35AM -0600, Jeremy Linton wrote:
> > > Hi,
> > > 
> > > On 12/13/2017 12:02 PM, Lorenzo Pieralisi wrote:
> > > >[+Morten, Dietmar]
> > > >
> > > >$SUBJECT should be:
> > > >
> > > >arm64: topology: rename cluster_id
> > > 
> > > Sure..
> > > 
> > > >
> > > >On Fri, Dec 01, 2017 at 04:23:28PM -0600, Jeremy Linton wrote:
> > > >>Lets match the name of the arm64 topology field
> > > >>to the kernel macro that uses it.
> > > >>
> > > >>Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > >>---
> > > >>  arch/arm64/include/asm/topology.h |  4 ++--
> > > >>  arch/arm64/kernel/topology.c      | 27 ++++++++++++++-------------
> > > >>  2 files changed, 16 insertions(+), 15 deletions(-)
> > > >>
> > > >>diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> > > >>index c4f2d50491eb..118136268f66 100644
> > > >>--- a/arch/arm64/include/asm/topology.h
> > > >>+++ b/arch/arm64/include/asm/topology.h
> > > >>@@ -7,14 +7,14 @@
> > > >>  struct cpu_topology {
> > > >>  	int thread_id;
> > > >>  	int core_id;
> > > >>-	int cluster_id;
> > > >>+	int physical_id;
> > > >
> > > >package_id ?
> > > 
> > > Given the macro is topology_physical_package_id, either makes sense to me.
> > > <shrug> I will change it in the next set.
> > 
> > I would vote for package_id too. arch/arm has 'socket_id' though.
> > 
> > > >
> > > >It has been debated before, I know. Should we keep the cluster_id too
> > > >(even if it would be 1:1 mapped to package_id - for now) ?
> > > 
> > > Well given that this patch replaces the patch that did that at your
> > > request..
> > > 
> > > I was hoping someone else would comment here, but my take at this point is
> > > that it doesn't really matter in a functional sense at the moment.
> > > Like the chiplet discussion it can be the subject of a future patch along
> > > with the patches which tweak the scheduler to understand the split.
> > > 
> > > BTW, given that i'm OoO next week, and the following that are the holidays,
> > > I don't intend to repost this for a couple weeks. I don't think there are
> > > any issues with this set.
> > > 
> > > >
> > > >There is also arch/arm to take into account, again, this patch is
> > > >just renaming (as it should have named since the beginning) a
> > > >topology level but we should consider everything from a legacy
> > > >perspective.
> > 
> > arch/arm has gone for thread/core/socket for the three topology levels
> > it supports.
> > 
> > I'm not sure what short term value keeping cluster_id has? Isn't it just
> > about where we make the package = cluster assignment? Currently it is in
> > the definition of topology_physical_package_id. If we keep cluster_id
> > and add package_id, it gets moved into the MPIDR/DT parsing code. 
> > 
> > Keeping cluster_id and introducing a topology_cluster_id function could
> > help cleaning up some of the users of topology_physical_package_id that
> > currently assumes package_id == cluster_id though.
> 
> I think we should settle for a name (eg package_id), remove cluster_id
> and convert arch/arm socket_id to the same naming used on arm64 (for
> consistency - it is just a variable rename).

Agreed. 

> This leaves us with the naming "cluster" only in DT topology bindings,
> which should be fine, given that "cluster" in that context is just a
> "processor-container" - yes we could have chosen a better naming in
> the first place but that's what it is.

I think having "clusters" in DT is fine as it represent the actual
hardware topology and uses the actual "Arm" term to describe it. The
default topology in Linux just doesn't have an equivalent topology
level, but that can be fixed. DT is however missing a notion of package.

> We should nuke the existing users of topology_physical_package_id()
> to identify clusters, I would not add another function for that purpose,
> let's nip it in the bud.

Even better if that can be pulled of.

Morten
