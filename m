From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 17 Jan 2018 20:15:33 -0600
Subject: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound
 traffic
In-Reply-To: <1516058925-46522-5-git-send-email-jim2101024@gmail.com>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com>
Message-ID: <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 5:28 PM, Jim Quinlan <jim2101024@gmail.com> wrote:
> The Broadcom STB PCIe host controller is intimately related to the
> memory subsystem.  This close relationship adds complexity to how cpu
> system memory is mapped to PCIe memory.  Ideally, this mapping is an
> identity mapping, or an identity mapping off by a constant.  Not so in
> this case.
>
> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
> of system memory.  Here is how the PCIe controller maps the
> system memory to PCIe memory:
>
>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>
> Although there are some "gaps" that can be added between the
> individual mappings by software, the permutation of memory regions for
> the most part is fixed by HW.  The solution of having something close
> to an identity mapping is not possible.
>
> The idea behind this HW design is that the same PCIe module can
> act as an RC or EP, and if it acts as an EP it concatenates all
> of system memory into a BAR so anything can be accessed.  Unfortunately,
> when the PCIe block is in the role of an RC it also presents this
> "BAR" to downstream PCIe devices, rather than offering an identity map
> between its system memory and PCIe space.
>
> Suppose that an endpoint driver allocs some DMA memory.  Suppose this
> memory is located at 0x6000_0000, which is in the middle of memc1-a.
> The driver wants a dma_addr_t value that it can pass on to the EP to
> use.  Without doing any custom mapping, the EP will use this value for
> DMA: the driver will get a dma_addr_t equal to 0x6000_0000.  But this
> won't work; the device needs a dma_addr_t that reflects the PCIe space
> address, namely 0xa000_0000.
>
> So, essentially the solution to this problem must modify the
> dma_addr_t returned by the DMA routines routines.  There are two
> ways (I know of) of doing this:
>
> (a) overriding/redefining the dma_to_phys() and phys_to_dma() calls
> that are used by the dma_ops routines.  This is the approach of
>
>         arch/mips/cavium-octeon/dma-octeon.c

MIPS is rarely an example to follow. :)

> In ARM and ARM64 these two routines are defiend in asm/dma-mapping.h
> as static inline functions.
>
> (b) Subscribe to a notifier that notifies when a device is added to a
> bus.  When this happens, set_dma_ops() can be called for the device.
> This method is mentioned in:
>
>     http://lxr.free-electrons.com/source/drivers/of/platform.c?v=3.16#L152

Why refer to an external website when you can just refer to the source
of the project this patch applies to directly.

> where it says as a comment
>
>     "In case if platform code need to use own special DMA
>     configuration, it can use Platform bus notifier and
>     handle BUS_NOTIFY_ADD_DEVICE event to fix up DMA
>     configuration."

In the current tree, this comment is in drivers/of/device.c.

> Solution (b) is what this commit does.  It uses its own set of
> dma_ops which are wrappers around the arch_dma_ops.  The
> wrappers translate the dma addresses before/after invoking
> the arch_dma_ops, as appropriate.
