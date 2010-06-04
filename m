From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 04 Jun 2010 14:08:55 -0400 (EDT)
Subject: [PATCH 4/4 v2] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <4C08A6A7.8010904@alcatel-lucent.com>
References: <4C08A6A7.8010904@alcatel-lucent.com>
Message-ID: <alpine.LFD.2.00.1006041401540.22319@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Jun 2010, Benjamin Zores wrote:

> The I/O Mapping has to be set conditionally. I'd propose the following
> approach:
> 
> /* I/O Mapping with 1 PEX controller */
> static struct map_desc kirkwood_io_desc_1[] __initdata = {
>     {
>         .virtual    = KIRKWOOD_PCIE_IO_VIRT_BASE,
>         .pfn        = __phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
>         .length        = KIRKWOOD_PCIE_IO_SIZE,
>         .type        = MT_DEVICE,
>     }, {
>         .virtual    = KIRKWOOD_REGS_VIRT_BASE,
>         .pfn        = __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
>         .length        = KIRKWOOD_REGS_SIZE,
>         .type        = MT_DEVICE,
>     },
> };
> 
> /* I/O Mapping with 2 PEX controllers */
> static struct map_desc kirkwood_io_desc_2[] __initdata = {
>     {
>         .virtual    = KIRKWOOD_PCIE_IO_VIRT_BASE,
>         .pfn        = __phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
>         .length        = KIRKWOOD_PCIE_IO_SIZE,
>         .type        = MT_DEVICE,
>     }, {
>     {
>         .virtual    = KIRKWOOD_PCIE1_IO_VIRT_BASE,
>         .pfn        = __phys_to_pfn(KIRKWOOD_PCIE1_IO_PHYS_BASE),
>         .length        = KIRKWOOD_PCIE1_IO_SIZE,
>         .type        = MT_DEVICE,
>     }, {
>         .virtual    = KIRKWOOD_REGS_VIRT_BASE,
>         .pfn        = __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
>         .length        = KIRKWOOD_REGS_SIZE,
>         .type        = MT_DEVICE,
>     },
> };

Please make the PCIE1 into a separate map_desc of its own rather than 
duplicating PCIE0 in both, and then do an additional call to 
iotable_init() when necessary.

> And 2nd PCIe PHY shutdown at init:
> 
> +    /* For PCIe #1: first shutdown the phy */
> +   if (!(kirkwood_clk_ctrl & CGC_PEX1)) {
> +        writel(readl(PCIE1_LINK_CTRL) | 0x10, PCIE1_LINK_CTRL);
> +       while (1)
> +          if (readl(PCIE1_STATUS) & 0x1)
> +             break;
> +    writel(readl(PCIE1_LINK_CTRL) & ~0x10, PCIE1_LINK_CTRL);
> +  }

You'd have to make sure you're actually on a 6282 before doing this I 
guess.

> Additionally, not sure it is needed for PCIe support but at least for F6282,
> you need to refine the MPP matrix in mpp.h. The 6282 MPP _really_ is different
> from 6281 one.
> I can send a patch for this if needed, I already have done the necessary
> changes in my tree.

That would be great.


Nicolas
