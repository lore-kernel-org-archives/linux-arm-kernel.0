From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 23:22:33 +0100
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131128211009.GA26447@obsidianresearch.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
Message-ID: <20131128222232.GF14689@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 02:10:09PM -0700, Jason Gunthorpe wrote:
> On Thu, Nov 28, 2013 at 09:33:23PM +0100, Thierry Reding wrote:
> 
> > >   - Describing masters that master through multiple different buses
> > > 
> > >   - How on Earth this fits in with the Linux device model (it doesn't)
> > > 
> > >   - Interaction with IOMMU bindings (currently under discussion)
> > 
> > This is all very vague. Perhaps everyone else knows what this is all
> > about, in which case it'd be great if somebody could clue me in.
> 
> It looks like an approach to describe an AXI physical bus topology in
> DT..

Thanks for explaining this. It makes a whole lot more sense now.

> AFAIK the issue is that the AXI toolkit arm provides encourages a
> single IP block to have several AXI ports - control, DMA, high speed
> MMIO, for instance. Each of those ports is hooked up into an AXI bus
> DAG that has little to do with the CPU address map.
> 
> Contrasted with something like PCI, where each IP has exactly one bus
> port into the system, so the MMIO register access address range
> directly implies the bus master DMA path.
> 
> To my mind, a sensble modeling would be to have the DT tree represent
> the AXI DAG flattened into a tree rooted at the CPU vertex. Separately
> in the DT would be the full AXI DAG represented with phandle
> connections.
> 
> Nodes in the DT would use phandles to indicate their connections into
> the AXI DAG.
> 
> Hugely roughly:
> soc 
> {
>    ranges = <Some quasi-real ranges indicating IP to CPU mapping>;
>    ip_block 
>    { 
>       reg = <...>
>       axi-ports = <mmio = &axi_low_speed_port0, dma = &axi_dma_port1, .. >;
>    }
> }
> 
> axi
> {
>    /* Describe a DAG of AXI connections here. */
>    cpu { downstream = &ax_switch,}
>    axi_switch {downstream = &memory,&low_speed}
>    memory {}
>    dma {downstream = &memory}
>    low_speed {}
> }

Correct me if I'm wrong, but the switch would be what the specification
refers to as "interconnect", while a port would correspond to what is
called an "interface" in the specification?

> I was just reading the Zynq manual which gives a pretty good
> description of what one vendor did using the ARM AXI toolkits..
> 
> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf
> Figure 5-1 pg 122
> 
> You can see it is a complex DAG of AXI busses. For instance if you
> want to master from a 'High Performance Port M0' to 'On Chip RAM' you
> follow the path AXI_HP[MO] -> Switch1[M2] -> OCM.
> 
> But you can't master from 'High Performance Port M0' to internal
> slaves, as there is no routing path.
> 
> Each switch block is an opportunity for the designer to provide
> address remapping/IO MMU hardware that needs configuring :)
> 
> Which is why I think encoding the AXI DAG directly in DT is probably
> the most future proof way to model this stuff - it sticks close to the
> tools ARM provides to the SOC designers, so it is very likely to be
> able to model arbitary SOC designs.

I'm not sure I agree with you fully here. At least I think that if what
we want to describe is an AXI bus topology, then we should be describing
it in terms of the AXI specification.

On the other hand I fear that this will lead to very many nodes and
properties that we need to add, with potentially no immediate gain. So I
think we should be cautious about what we do add, and restrict ourselves
to what we really need.

I mean, even though device tree is supposed to describe hardware, there
needs to be a limit to the amount of detail we put into it. After all it
isn't a hardware description language, but rather a language to describe
the hardware in a way that makes sense for operating system software to
use it.

Perhaps this is just another way of saying what Greg has already said.
If we continue down this road, we'll eventually end up having to
describe all sorts of nitty gritty details. And we'll need even more
code to deal with those descriptions and the hardware they represent. At
some point we need to start pushing some of the complexity back into
hardware so that we can keep a sane code-base.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/b640acb8/attachment.sig>
