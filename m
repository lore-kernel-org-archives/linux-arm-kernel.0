From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 12:02:08 +0100
Subject: [RFC PATCH v2 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <54744F14.60004@linaro.org>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <5473FDA8.6080201@huawei.com> <54744F14.60004@linaro.org>
Message-ID: <2966212.dpWQ0OTb0A@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014 17:42:44 Hanjun Guo wrote:
> On 2014-11-25 11:55, Shannon Zhao wrote:
> > Hi,
> > 
> > On 2014/11/22 5:23, Ganapatrao Kulkarni wrote:
> [...]
> >> +==============================================================================
> >> +4 - Example dts
> >> +==============================================================================
> >> +
> >> +Example 1: 2 Node system each having 8 CPUs and a Memory.
> >> +
> >> +    numa-map {
> >> +            #address-cells = <2>;
> >> +            #size-cells = <1>;
> >> +            #node-count = <2>;
> >> +            mem-map =  <0x0 0x00000000 0>,
> >> +                       <0x100 0x00000000 1>;
> >> +
> >> +            cpu-map = <0 7 0>,
> >> +                      <8 15 1>;
> > 
> > The cpu range is continuous here. But if there is a situation like below:
> > 
> > 0 2 4 6 belong to node 0
> > 1 3 5 7 belong to node 1
> > 
> > This case is very common on X86. I don't know the real situation of arm as
> > I don't have a hardware with 2 nodes.
> > 
> > How can we generate a DTS about this situation? like below? Can be parsed?
> > 
> >               cpu-map = <0 2 4 6 0>,
> >                         <1 3 5 7 1>;
> 
> I think the binding proposed here can not cover your needs, and I think this
> binding is not suitable, there are some reasons.
> 
>  - CPU logical ID is allocated by OS, and it depends on the order of CPU node
>    in the device tree, so it may be in a clean order like this patch proposed,
>    or it will like the order Shannon pointed out.
> 
>  - Since CPU logical ID is allocated by OS, DTS file will not know these
>    numbers.

Also:

- you cannot support hierarchical NUMA topology

- you cannot have CPU-less or memory-less nodes

- you cannot associate I/O devices with NUMA nodes, only memory and CPU

> So the problem behind this is the mappings between CPUs and NUMA nodes,
> there is already mapping for CPU hardware ID (MPIDR) and CPU logical ID,
> and MPIDR will be not changed, why not using MPIDR for the mapping of
> NUMA node and CPU? then the mappings will be:
> 
> CPU logical ID <------> CPU MPIDR <-----> NUMA node ID <-----> proximity domain
> (allocated by OS)      (constant)       (allocated by OS)

No, don't hardcode ARM specifics into a common binding either. I've looked
at the ibm,associativity properties again, and I think we should just use
those, they can cover all cases and are completely independent of the
architecture. We should probably discuss about the property name though,
as using the "ibm," prefix might not be the best idea.

	Arnd
