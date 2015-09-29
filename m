From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 29 Sep 2015 19:42:18 +1000
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <CAFpQJXWFx2dQ_vv0POqkOiLe3eh9Ee=Sf+2Xx_08Vp=E4g6gLQ@mail.gmail.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAFpQJXWzM644KsFWP9ei-k6gWgNVpBVT+UbY7NYdyfmyL=zMkw@mail.gmail.com>
 <CAFpQJXWFx2dQ_vv0POqkOiLe3eh9Ee=Sf+2Xx_08Vp=E4g6gLQ@mail.gmail.com>
Message-ID: <1443519738.2865.8.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-29 at 14:08 +0530, Ganapatrao Kulkarni wrote:
> (sending again, by mistake it was set to html mode)

I sorry, I was trying to get OpenPower to move faster & release PAPR
publicly but it looks like it's going to take a bit longer, so I'll try
to write a summary in the next couple of days.

Ben.

> On Tue, Sep 29, 2015 at 2:05 PM, Ganapatrao Kulkarni
> <gpkulkarni@gmail.com> wrote:
> > Hi Mark,
> > 
> > I have tried to answer your comments, in the meantime we are
> > waiting for Ben
> > to share the details.
> > 
> > On Fri, Aug 28, 2015 at 6:02 PM, Mark Rutland <mark.rutland@arm.com
> > > wrote:
> > > 
> > > Hi,
> > > 
> > > On Fri, Aug 14, 2015 at 05:39:32PM +0100, Ganapatrao Kulkarni
> > > wrote:
> > > > DT bindings for numa map for memory, cores and IOs using
> > > > arm,associativity device node property.
> > > 
> > > Given this is just a copy of ibm,associativity, I'm not sure I
> > > see much
> > > point in renaming the properties.
> > > 
> > > However, (somewhat counter to that) I'm also concerned that this
> > > isn't
> > > sufficient for systems we're beginning to see today (more on that
> > > below), so I don't think a simple copy of ibm,associativity is
> > > good
> > > enough.
> > 
> > it is just copy right now, however it can evolve when we come
> > across more
> > arm64 numa platforms
> > > 
> > > 
> > > > 
> > > > Signed-off-by: Ganapatrao Kulkarni <
> > > > gkulkarni at caviumnetworks.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/numa.txt | 212
> > > > +++++++++++++++++++++++++
> > > >  1 file changed, 212 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/arm/numa.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/arm/numa.txt
> > > > b/Documentation/devicetree/bindings/arm/numa.txt
> > > > new file mode 100644
> > > > index 0000000..dc3ef86
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/arm/numa.txt
> > > > @@ -0,0 +1,212 @@
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +NUMA binding description.
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +1 - Introduction
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +
> > > > +Systems employing a Non Uniform Memory Access (NUMA)
> > > > architecture
> > > > contain
> > > > +collections of hardware resources including processors,
> > > > memory, and I/O
> > > > buses,
> > > > +that comprise what is commonly known as a NUMA node.
> > > > +Processor accesses to memory within the local NUMA node is
> > > > generally
> > > > faster
> > > > +than processor accesses to memory outside of the local NUMA
> > > > node.
> > > > +DT defines interfaces that allow the platform to convey NUMA
> > > > node
> > > > +topology information to OS.
> > > > +
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +2 - arm,associativity
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +The mapping is done using arm,associativity device property.
> > > > +this property needs to be present in every device node which
> > > > needs to
> > > > to be
> > > > +mapped to numa nodes.
> > > 
> > > Can't there be some inheritance? e.g. all devices on a bus with
> > > an
> > > arm,associativity property being assumed to share that value?
> > 
> > yes there is inheritance and respective bus drivers should take
> > care of it,
> > like pci driver does at present.
> > > 
> > > 
> > > > +
> > > > +arm,associativity property is set of 32-bit integers which
> > > > defines
> > > > level of
> > > 
> > > s/set/list/ -- the order is important.
> > 
> > ok
> > > 
> > > 
> > > > +topology and boundary in the system at which a significant
> > > > difference
> > > > in
> > > > +performance can be measured between cross-device accesses
> > > > within
> > > > +a single location and those spanning multiple locations.
> > > > +The first cell always contains the broadest subdivision within
> > > > the
> > > > system,
> > > > +while the last cell enumerates the individual devices, such as
> > > > an SMT
> > > > thread
> > > > +of a CPU, or a bus bridge within an SoC".
> > > 
> > > While this gives us some hierarchy, this doesn't seem to encode
> > > relative
> > > distances at all. That seems like an oversight.
> > 
> > 
> > distance is computed, will add the details to document.
> > local nodes will have distance as 10(LOCAL_DISTANCE) and every
> > level, the
> > distance multiplies by 2.
> > for example, for level 1 numa topology, distance from local node to
> > remote
> > node will be 20.
> > 
> > > 
> > > 
> > > Additionally, I'm somewhat unclear on how what you'd be expected
> > > to
> > > provide for this property in cases like ring or mesh
> > > interconnects,
> > > where there isn't a strict hierarchy (see systems with ARM's own
> > > CCN, or
> > > Tilera's TILE-Mx), but there is some measure of closeness.
> > 
> > 
> > IIUC, as per ARMs CCN architecture, all core/clusters are at equal
> > distance
> > of DDR, i dont see any NUMA topology.
> > however, if there are 2 SoC connected thorough the CCN, then it is
> > very much
> > similar to cavium topology.
> > 
> > > Must all of these have the same length? If so, why not have a
> > > #(whatever)-cells property in the root to describe the expected
> > > length?
> > > If not, how are they to be interpreted relative to each other?
> > 
> > 
> > yes, all are of default size.
> > IMHO, there is no need to add cells property.
> > > 
> > > 
> > > > +
> > > > +ex:
> > > 
> > > s/ex/Example:/, please. There's no need to contract that.
> > > 
> > > > +       /* board 0, socket 0, cluster 0, core 0  thread 0 */
> > > > +       arm,associativity = <0 0 0 0 0>;
> > > > +
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +3 - arm,associativity-reference-points
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +This property is a set of 32-bit integers, each representing
> > > > an index
> > > > into
> > > 
> > > Likeise, s/set/list/
> > 
> > ok
> > > 
> > > 
> > > > +the arm,associativity nodes. The first integer is the most
> > > > significant
> > > > +NUMA boundary and the following are progressively less
> > > > significant
> > > > boundaries.
> > > > +There can be more than one level of NUMA.
> > > 
> > > I'm not clear on why this is necessary; the arm,associativity
> > > property
> > > is already ordered from most significant to least significant per
> > > its
> > > description.
> > 
> > 
> > first entry in arm,associativity-reference-points is used to find
> > which
> > entry in associativity defines node id.
> > also entries in arm,associativity-reference-points defines,
> > how many entries(depth) in associativity can be used to calculate
> > node
> > distance
> > in both level 1 and  multi level(hierarchical) numa topology.
> > 
> > > 
> > > 
> > > What does this property achieve?
> > > 
> > > The description also doesn't describe where this property is
> > > expected to
> > > live. The example isn't sufficient to disambiguate that,
> > > especially as
> > > it seems like a trivial case.
> > 
> > sure, will add one more example to describe the
> > arm,associativity-reference-points
> > > 
> > > 
> > > Is this only expected at the root of the tree? Can it be re
> > > -defined in
> > > sub-nodes?
> > 
> > yes it is defined only at the root.
> > > 
> > > 
> > > > +
> > > > +Ex:
> > > 
> > > s/Ex/Example:/, please
> > 
> > sure.
> > > 
> > > 
> > > > +       arm,associativity-reference-points = <0 1>;
> > > > +       The board Id(index 0) used first to calculate the
> > > > associativity
> > > > (node
> > > > +       distance), then follows the  socket id(index 1).
> > > > +
> > > > +       arm,associativity-reference-points = <1 0>;
> > > > +       The socket Id(index 1) used first to calculate the
> > > > associativity,
> > > > +       then follows the board id(index 0).
> > > > +
> > > > +       arm,associativity-reference-points = <0>;
> > > > +       Only the board Id(index 0) used to calculate the
> > > > associativity.
> > > > +
> > > > +       arm,associativity-reference-points = <1>;
> > > > +       Only socket Id(index 1) used to calculate the
> > > > associativity.
> > > > +
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +4 - Example dts
> > > > 
> > > > +==============================================================
> > > > ================
> > > > +
> > > > +Example: 2 Node system consists of 2 boards and each board
> > > > having one
> > > > socket
> > > > +and 8 core in each socket.
> > > > +
> > > > +       arm,associativity-reference-points = <0>;
> > > > +
> > > > +       memory at 00c00000 {
> > > > +               device_type = "memory";
> > > > +               reg = <0x0 0x00c00000 0x0 0x80000000>;
> > > > +               /* board 0, socket 0, no specific core */
> > > > +               arm,associativity = <0 0 0xffff>;
> > > > +       };
> > > > +
> > > > +       memory at 10000000000 {
> > > > +               device_type = "memory";
> > > > +               reg = <0x100 0x00000000 0x0 0x80000000>;
> > > > +               /* board 1, socket 0, no specific core */
> > > > +               arm,associativity = <1 0 0xffff>;
> > > > +       };
> > > > +
> > > > +       cpus {
> > > > +               #address-cells = <2>;
> > > > +               #size-cells = <0>;
> > > > +
> > > > +               cpu at 000 {
> > > > +                       device_type = "cpu";
> > > > +                       compatible =  "arm,armv8";
> > > > +                       reg = <0x0 0x000>;
> > > > +                       enable-method = "psci";
> > > > +                       /* board 0, socket 0, core 0*/
> > > > +                       arm,associativity = <0 0 0>;
> > > 
> > > We should specify w.r.t. memory and CPUs how the property is
> > > expected to
> > > be used (e.g. in the CPU nodes rather than the cpu-map, with
> > > separate
> > > memory nodes, etc). The generic description of arm,associativity
> > > isn't
> > > sufficient to limit confusion there.
> > 
> > ok, will add the details like which nodes can use this property.
> > 
> > > 
> > > 
> > > Thanks,
> > > Mark.
> > 
> > 
> > thanks
> > Ganapat
