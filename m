From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Fri, 23 Feb 2018 15:57:17 +0100
Subject: [RFC PATCH] ARM: dts: ls1021a: add size-cells and address-cells
 to scfg and dcfg nodes
In-Reply-To: <20180223133114.7091-1-rasmus.villemoes@prevas.dk>
References: <20180223133114.7091-1-rasmus.villemoes@prevas.dk>
Message-ID: <ad7dde07-9a11-09fb-61c0-8ec97e35bb63@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-02-23 14:31, Rasmus Villemoes wrote:
> A single u32 is sufficient to specify a register in the Device
> Configuration Unit/Supplemental Configuration Unit. Moreover, they only
> consist of 32 bit registers (for the DCFG we even have "These registers
> only support 32-bit accesses." according to the reference manual), so no
> size specification is needed.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> None of the in-tree .dts files using ls1021a.dtsi currently define a
> subnode of either node. It is possible, though somewhat unlikely, that
> some out-of-tree .dts file is built against the in-tree ls1021a.dtsi,
> and I don't know if such files are treated the same as out-of-tree
> modules (i.e., they get to fix the breakage).
> 
> The reason I'm proposing to add these is that I'm about to add a subnode
> of scfg with a reg property, and if possible I'd like to avoid the
> somewhat clumsy
> 
>   reg = <0 0x1ac 0 4>;

Ah, apparently I've misunderstood how address-cells/size-cells worked; I
thought they would be taken from the nearest ancestor node specifying
them, so that 2/2 would apply to scfg. But it seems they have to be
present in the parent node itself, otherwise defaulting to 2/1. So the
above should be <0 0x1ac 4>, which is still clumsier than needed.

Rasmus
