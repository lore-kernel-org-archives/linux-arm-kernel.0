From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 01 Oct 2015 11:05:47 +1000
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <CAFpQJXVegqortRLK+g7_9p82KMYwq0hg8n3_9bJqjGHsJvngaA@mail.gmail.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAFpQJXWzM644KsFWP9ei-k6gWgNVpBVT+UbY7NYdyfmyL=zMkw@mail.gmail.com>
 <CAFpQJXWFx2dQ_vv0POqkOiLe3eh9Ee=Sf+2Xx_08Vp=E4g6gLQ@mail.gmail.com>
 <20150930105331.GA10066@leverpostej>
 <CAFpQJXVegqortRLK+g7_9p82KMYwq0hg8n3_9bJqjGHsJvngaA@mail.gmail.com>
Message-ID: <1443661547.2828.40.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-30 at 23:20 +0530, Ganapatrao Kulkarni wrote:
> Hi Ben,

Before I dig in more (short on time right now), PAPR (at least a chunk
of it) was released publicly:

https://members.openpowerfoundation.org/document/dl/469

(You don't need to be a member nor to sign up to get it)

Cheers,
Ben.

> On Wed, Sep 30, 2015 at 4:23 PM, Mark Rutland <mark.rutland@arm.com>
> wrote:
> > On Tue, Sep 29, 2015 at 09:38:04AM +0100, Ganapatrao Kulkarni
> > wrote:
> > > (sending again, by mistake it was set to html mode)
> > > 
> > > On Tue, Sep 29, 2015 at 2:05 PM, Ganapatrao Kulkarni
> > > <gpkulkarni@gmail.com> wrote:
> > > > Hi Mark,
> > > > 
> > > > I have tried to answer your comments, in the meantime we are
> > > > waiting for Ben
> > > > to share the details.
> > > > 
> > > > On Fri, Aug 28, 2015 at 6:02 PM, Mark Rutland <
> > > > mark.rutland at arm.com> wrote:
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > On Fri, Aug 14, 2015 at 05:39:32PM +0100, Ganapatrao Kulkarni
> > > > > wrote:
> > > > > > DT bindings for numa map for memory, cores and IOs using
> > > > > > arm,associativity device node property.
> > > > > 
> > > > > Given this is just a copy of ibm,associativity, I'm not sure
> > > > > I see much
> > > > > point in renaming the properties.
> > > > > 
> > > > > However, (somewhat counter to that) I'm also concerned that
> > > > > this isn't
> > > > > sufficient for systems we're beginning to see today (more on
> > > > > that
> > > > > below), so I don't think a simple copy of ibm,associativity
> > > > > is good
> > > > > enough.
> > > > 
> > > > it is just copy right now, however it can evolve when we come
> > > > across more
> > > > arm64 numa platforms
> > 
> > Whatever we do I suspect we'll have to evolve it as new platforms
> > appear. As I mentioned there are contemporary NUMA ARM64 platforms
> > (e.g.
> > those with CCN) that I don't think we can ignore now given we'll
> > have to
> > cater for them.
> > 
> > > > > > +==========================================================
> > > > > > ====================
> > > > > > +2 - arm,associativity
> > > > > > 
> > > > > > +==========================================================
> > > > > > ====================
> > > > > > +The mapping is done using arm,associativity device
> > > > > > property.
> > > > > > +this property needs to be present in every device node
> > > > > > which needs to
> > > > > > to be
> > > > > > +mapped to numa nodes.
> > > > > 
> > > > > Can't there be some inheritance? e.g. all devices on a bus
> > > > > with an
> > > > > arm,associativity property being assumed to share that value?
> > > > 
> > > > yes there is inheritance and respective bus drivers should take
> > > > care of it,
> > > > like pci driver does at present.
> > 
> > Ok.
> > 
> > That seems counter to my initial interpretation of the wording that
> > the
> > property must be present on device nodes that need to be mapped to
> > NUMA
> > nodes.
> > 
> > Is there any simple way of describing the set of nodes that need
> > this
> > property?
> > 
> > > > > > +topology and boundary in the system at which a significant
> > > > > > difference
> > > > > > in
> > > > > > +performance can be measured between cross-device accesses
> > > > > > within
> > > > > > +a single location and those spanning multiple locations.
> > > > > > +The first cell always contains the broadest subdivision
> > > > > > within the
> > > > > > system,
> > > > > > +while the last cell enumerates the individual devices,
> > > > > > such as an SMT
> > > > > > thread
> > > > > > +of a CPU, or a bus bridge within an SoC".
> > > > > 
> > > > > While this gives us some hierarchy, this doesn't seem to
> > > > > encode relative
> > > > > distances at all. That seems like an oversight.
> > > > 
> > > > 
> > > > distance is computed, will add the details to document.
> > > > local nodes will have distance as 10(LOCAL_DISTANCE) and every
> > > > level, the
> > > > distance multiplies by 2.
> > > > for example, for level 1 numa topology, distance from local
> > > > node to remote
> > > > node will be 20.
> > 
> > This seems arbitrary.
> > 
> > Why not always have this explicitly described?
> > 
> > > > > Additionally, I'm somewhat unclear on how what you'd be
> > > > > expected to
> > > > > provide for this property in cases like ring or mesh
> > > > > interconnects,
> > > > > where there isn't a strict hierarchy (see systems with ARM's
> > > > > own CCN, or
> > > > > Tilera's TILE-Mx), but there is some measure of closeness.
> > > > 
> > > > 
> > > > IIUC, as per ARMs CCN architecture, all core/clusters are at
> > > > equal distance
> > > > of DDR, i dont see any NUMA topology.
> > 
> > The CCN is a ring interconnect, so CPU clusters (henceforth CPUs)
> > can be
> > connected with differing distances to RAM instances (or devices).
> > 
> > Consider the simplified network below:
> > 
> >   +-------+      +--------+      +-------+
> >   | CPU 0 |------| DRAM A |------| CPU 1 |
> >   +-------+      +--------+      +-------+
> >       |                              |
> >       |                              |
> >   +--------+                     +--------+
> >   | DRAM B |                     | DRAM C |
> >   +--------+                     +--------+
> >       |                              |
> >       |                              |
> >   +-------+      +--------+      +-------+
> >   | CPU 2 |------| DRAM D |------| CPU 3 |
> >   +-------+      +--------+      +-------+
> > 
> > In this case CPUs and DRAMs are spaced evenly on the ring, but the
> > distance between an arbitrary CPU and DRAM is not uniform.
> > 
> > CPU 0 can access DRAM A or DRAM B with a single hop, but accesses
> > to
> > DRAM C or DRAM D take three hops.
> > 
> > An access from CPU 0 to DRAM C could contend with accesses from CPU
> > 1 to
> > DRAM D, as they share hops on the ring.
> > 
> > There is definitely a NUMA topology here, but there's not a strict
> > hierarchy. I don't see how you would represent this with the
> > proposed
> > binding.
> can you please explain, how associativity property will represent
> this
> numa topology?
> > 
> > Likewise for the mesh networks (e.g. that of TILE-Mx)
> > 
> > > > however, if there are 2 SoC connected thorough the CCN, then it
> > > > is very much
> > > > similar to cavium topology.
> > > > 
> > > > > Must all of these have the same length? If so, why not have a
> > > > > #(whatever)-cells property in the root to describe the
> > > > > expected length?
> > > > > If not, how are they to be interpreted relative to each
> > > > > other?
> > > > 
> > > > 
> > > > yes, all are of default size.
> > 
> > Where that size is...?
> > 
> > > > IMHO, there is no need to add cells property.
> > 
> > That might be the case, but it's unclear from the documentation. I
> > don't
> > see how one would parse / verify values currently.
> > 
> > > > > > +the arm,associativity nodes. The first integer is the most
> > > > > > significant
> > > > > > +NUMA boundary and the following are progressively less
> > > > > > significant
> > > > > > boundaries.
> > > > > > +There can be more than one level of NUMA.
> > > > > 
> > > > > I'm not clear on why this is necessary; the arm,associativity
> > > > > property
> > > > > is already ordered from most significant to least significant
> > > > > per its
> > > > > description.
> > > > 
> > > > 
> > > > first entry in arm,associativity-reference-points is used to
> > > > find which
> > > > entry in associativity defines node id.
> > > > also entries in arm,associativity-reference-points defines,
> > > > how many entries(depth) in associativity can be used to
> > > > calculate node
> > > > distance
> > > > in both level 1 and  multi level(hierarchical) numa topology.
> > 
> > I think this needs a more thorough description; I don't follow the
> > current one.
> > 
> > > > > Is this only expected at the root of the tree? Can it be re
> > > > > -defined in
> > > > > sub-nodes?
> > > > 
> > > > yes it is defined only at the root.
> > 
> > This needs to be stated explicitly.
> > 
> > I see that this being the case, *,associativity-reference-points
> > would
> > be a more powerful property than the #(whatever)-cells property I
> > mentioned earlier, but a more thorough description is required.
> > 
> > Thanks,
> > Mark.
> thanks
> Ganapat
