From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 May 2014 09:21:18 -0400
Subject: [PATCHv3 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <1400145519-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400145519-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140515132118.GK27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:18:39AM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 375 and Armada 38x SOCs, which use the Cortex-A9
> CPU core, the PL310 cache and the Marvell PCIe hardware block are
> affected a L2/PCIe deadlock caused by a system erratum when hardware
> I/O coherency is used.
> 
> This deadlock can be avoided by mapping the PCIe memory areas as
> strongly-ordered (note: MT_UNCACHED is strongly-ordered), and by
> removing the outer cache sync done in software. This is done in this
> patch, thanks to the new bits of infrastructure added in 'ARM: mm:
> allow sub-architectures to override PCI I/O memory type' and 'ARM: mm:
> add support for HW coherent systems in PL310' respectively.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 01cfce6..5016c58 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -71,6 +71,49 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
>  	return 1;
>  }
>  
> +/*
> + * This ioremap hook is used on Armada 375/38x to ensure that PCIe
> + * memory areas are mapped as MT_MEMORY_RW_SO instead of
> + * MT_DEVICE. This is needed as a workaround for a deadlock issue
> + * between the PCIe interface and the cache controller.
> + */
> +static void __iomem *
> +armada_pcie_wa_ioremap_caller(phys_addr_t phys_addr, size_t size,
> +			      unsigned int mtype, void *caller)
> +{
> +	struct resource pcie_mem;
> +
> +	mvebu_mbus_get_pcie_mem_aperture(&pcie_mem);
> +
> +	if (pcie_mem.start <= phys_addr && (phys_addr + size) <= pcie_mem.end)
> +		mtype = MT_UNCACHED;
> +
> +	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
> +}
> +
> +/*
> + * When we are I/O coherent and we use the PL310 cache controller, we
> + * add the PL310 property "dma-coherent". This makes sure the outer
> + * sync operation is not used, which allows to workaround the system
> + * erratum that causes deadlocks when doing PCIe in an SMP situation
> + * on Armada 375 and Armada 38x.
> + */
> +static void __init mvebu_l2x0_pl310_coherent(void)
> +{
> +	struct device_node *np;
> +
> +	if (!coherency_available())
> +		return;
> +
> +	for_each_compatible_node(np, NULL, "arm,pl310-cache") {
> +		struct property *p;
> +
> +		p = kzalloc(sizeof(*p), GFP_KERNEL);
> +		p->name = kstrdup("dma-coherent", GFP_KERNEL);
> +		of_add_property(np, p);
> +	}
> +}
> +
>  static void __init mvebu_timer_and_clk_init(void)
>  {
>  	of_clk_init(NULL);
> @@ -78,6 +121,14 @@ static void __init mvebu_timer_and_clk_init(void)
>  	mvebu_scu_enable();
>  	coherency_init();
>  	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
> +
> +	if (of_machine_is_compatible("marvell,armada375") ||
> +	    of_machine_is_compatible("marvell,armada38x")) {
> +		arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
> +		pci_ioremap_set_mem_type(MT_UNCACHED);

iiuc, this patch depends on 1/3.  So how would you like to handle it?

thx,

Jason.
