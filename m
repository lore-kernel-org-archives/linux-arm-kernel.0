From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 01 Jun 2010 15:55:46 -0400 (EDT)
Subject: [PATCH 3/3] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <1275404968-12258-3-git-send-email-saeed@marvell.com>
References: <1275404968-12258-1-git-send-email-saeed@marvell.com>
	<1275404968-12258-2-git-send-email-saeed@marvell.com>
	<1275404968-12258-3-git-send-email-saeed@marvell.com>
Message-ID: <alpine.LFD.2.00.1006011447410.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Jun 2010, Saeed Bishara wrote:

> This patch extens the kirkwood's PCIe support up to 2 controllers as in the 6282 devices.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>

Comments below.

[...]
> diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
> index 5e6f711..6e67f3c 100644
> --- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
> +++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
> @@ -155,7 +155,7 @@ static void __init mv88f6281gtw_ge_init(void)
>  static int __init mv88f6281gtw_ge_pci_init(void)
>  {
>  	if (machine_is_mv88f6281gtw_ge())
> -		kirkwood_pcie_init();
> +		kirkwood_pcie_init(0, 1);

This is going to initialize the non existing PCIe1 and disable PCIe0.  
You made the same mistake multiple times.

[...]
> diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
> index dee1eff..5c33324 100644
> --- a/arch/arm/mach-kirkwood/pcie.c
> +++ b/arch/arm/mach-kirkwood/pcie.c
> @@ -21,26 +21,40 @@
>  
>  #define PCIE_BASE	((void __iomem *)PCIE_VIRT_BASE)

Is this PCIE_BASE still used?

> +struct pcie_port {
> +	u8			index;
> +	u8			root_bus_nr;
> +	void __iomem		*base;
> +	spinlock_t		conf_lock;
> +	char			io_space_name[16];
> +	char			mem_space_name[16];
> +	struct resource		res[2];
> +};
> +
> +static struct pcie_port pcie_port[2];
> +static int num_pcie_ports;
> +static struct pcie_port *bus_to_port(int bus);

You should move the actual function here allowing you to get rid of that 
forward declaration.


>  void __init kirkwood_pcie_id(u32 *dev, u32 *rev)
>  {
>  	*dev = orion_pcie_dev_id(PCIE_BASE);
>  	*rev = orion_pcie_rev(PCIE_BASE);
>  }
>  
> -static int pcie_valid_config(int bus, int dev)
> +static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
>  {
>  	/*
>  	 * Don't go out when trying to access --
>  	 * 1. nonexisting device on local bus
>  	 * 2. where there's no device connected (no link)
>  	 */
> -	if (bus == 0 && dev == 0)
> +	if (bus == pp->root_bus_nr && dev == 0)
>  		return 1;
>  
> -	if (!orion_pcie_link_up(PCIE_BASE))
> +	if (!orion_pcie_link_up(pp->base))
>  		return 0;
>  
> -	if (bus == 0 && dev != 1)
> +	if (bus == pp->root_bus_nr && dev != 1)
>  		return 0;
>  
>  	return 1;
> @@ -52,22 +66,22 @@ static int pcie_valid_config(int bus, int dev)
>   * and then reading the PCIE_CONF_DATA register. Need to make sure these
>   * transactions are atomic.
>   */
> -static DEFINE_SPINLOCK(kirkwood_pcie_lock);
>  
>  static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  			int size, u32 *val)
>  {
> +	struct pcie_port *pp = bus_to_port(bus->number);
>  	unsigned long flags;
>  	int ret;
>  
> -	if (pcie_valid_config(bus->number, PCI_SLOT(devfn)) == 0) {
> +	if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) == 0) {
>  		*val = 0xffffffff;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> -	spin_lock_irqsave(&kirkwood_pcie_lock, flags);
> -	ret = orion_pcie_rd_conf(PCIE_BASE, bus, devfn, where, size, val);
> -	spin_unlock_irqrestore(&kirkwood_pcie_lock, flags);
> +	spin_lock_irqsave(&pp->conf_lock, flags);
> +	ret = orion_pcie_rd_conf(pp->base, bus, devfn, where, size, val);
> +	spin_unlock_irqrestore(&pp->conf_lock, flags);
>  
>  	return ret;
>  }
> @@ -75,15 +89,16 @@ static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  			int where, int size, u32 val)
>  {
> +	struct pcie_port *pp = bus_to_port(bus->number);
>  	unsigned long flags;
>  	int ret;
>  
> -	if (pcie_valid_config(bus->number, PCI_SLOT(devfn)) == 0)
> +	if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) == 0)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> -	spin_lock_irqsave(&kirkwood_pcie_lock, flags);
> -	ret = orion_pcie_wr_conf(PCIE_BASE, bus, devfn, where, size, val);
> -	spin_unlock_irqrestore(&kirkwood_pcie_lock, flags);
> +	spin_lock_irqsave(&pp->conf_lock, flags);
> +	ret = orion_pcie_wr_conf(pp->base, bus, devfn, where, size, val);
> +	spin_unlock_irqrestore(&pp->conf_lock, flags);
>  
>  	return ret;
>  }
> @@ -96,51 +111,84 @@ static struct pci_ops pcie_ops = {
>  
>  static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
> -	struct resource *res;
>  	extern unsigned int kirkwood_clk_ctrl;
> +	struct pcie_port *pp;
> +
> +	if (nr >= num_pcie_ports)
> +		return 0;
> +
> +	pp = &pcie_port[nr];
> +	pp->root_bus_nr = sys->busnr;
>  
>  	/*
>  	 * Generic PCIe unit setup.
>  	 */
> -	orion_pcie_setup(PCIE_BASE, &kirkwood_mbus_dram_info);
> +	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
> +
> +	orion_pcie_setup(pp->base, &kirkwood_mbus_dram_info);
>  
> -	/*
> -	 * Request resources.
> -	 */
> -	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
> -	if (!res)
> -		panic("pcie_setup unable to alloc resources");
>  
>  	/*
>  	 * IORESOURCE_IO
>  	 */
> -	res[0].name = "PCIe I/O Space";
> -	res[0].flags = IORESOURCE_IO;
> -	res[0].start = KIRKWOOD_PCIE_IO_BUS_BASE;
> -	res[0].end = res[0].start + KIRKWOOD_PCIE_IO_SIZE - 1;
> -	if (request_resource(&ioport_resource, &res[0]))
> +	snprintf(pp->io_space_name, sizeof(pp->io_space_name),
> +		 "PCIe %d I/O", pp->index);
> +	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
> +	pp->res[0].name = pp->io_space_name;
> +	if (pp->index == 0) {
> +		pp->res[0].start = KIRKWOOD_PCIE_IO_PHYS_BASE;
> +		pp->res[0].end = pp->res[0].start + KIRKWOOD_PCIE_IO_SIZE - 1;
> +	} else {
> +		pp->res[0].start = KIRKWOOD_PCIE1_IO_PHYS_BASE;
> +		pp->res[0].end = pp->res[0].start + KIRKWOOD_PCIE1_IO_SIZE - 1;
> +	}
> +	pp->res[0].flags = IORESOURCE_IO;
> +	if (request_resource(&ioport_resource, &pp->res[0]))
>  		panic("Request PCIe IO resource failed\n");
> -	sys->resource[0] = &res[0];
> +	sys->resource[0] = &pp->res[0];
>  
>  	/*
>  	 * IORESOURCE_MEM
>  	 */
> -	res[1].name = "PCIe Memory Space";
> -	res[1].flags = IORESOURCE_MEM;
> -	res[1].start = KIRKWOOD_PCIE_MEM_BUS_BASE;
> -	res[1].end = res[1].start + KIRKWOOD_PCIE_MEM_SIZE - 1;
> -	if (request_resource(&iomem_resource, &res[1]))
> +	snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
> +		 "PCIe %d MEM", pp->index);
> +	pp->mem_space_name[sizeof(pp->mem_space_name) - 1] = 0;
> +	pp->res[1].name = pp->mem_space_name;
> +	if (pp->index == 0) {
> +		pp->res[1].start = KIRKWOOD_PCIE_MEM_PHYS_BASE;
> +		pp->res[1].end = pp->res[1].start + KIRKWOOD_PCIE_MEM_SIZE - 1;
> +	} else {
> +		pp->res[1].start = KIRKWOOD_PCIE1_MEM_PHYS_BASE;
> +		pp->res[1].end = pp->res[1].start + KIRKWOOD_PCIE1_MEM_SIZE - 1;
> +	}
> +	pp->res[1].flags = IORESOURCE_MEM;
> +	if (request_resource(&iomem_resource, &pp->res[1]))
>  		panic("Request PCIe Memory resource failed\n");
> -	sys->resource[1] = &res[1];
> +	sys->resource[1] = &pp->res[1];
>  
>  	sys->resource[2] = NULL;
>  	sys->io_offset = 0;
>  
> -	kirkwood_clk_ctrl |= CGC_PEX0;
> -
> +	if (nr == 0)
> +		kirkwood_clk_ctrl |= CGC_PEX0;
> +	else
> +		kirkwood_clk_ctrl |= CGC_PEX1;
>  	return 1;
>  }
>  
> +static struct pcie_port *bus_to_port(int bus)
> +{
> +	int i;
> +
> +	for (i = num_pcie_ports - 1; i >= 0; i--) {
> +		int rbus = pcie_port[i].root_bus_nr;
> +		if (rbus != -1 && rbus <= bus)
> +			break;
> +	}
> +
> +	return i >= 0 ? pcie_port + i : NULL;
> +}

I think this looks like a bit too much code for what this does.  To 
simplify things, you could:

1) Duplicate kirkwood_pcie_setup() into kirkwood_pcie0_setup() and 
   kirkwood_pcie1_setup() instead.  This will remove a couple
   "if (pp->index == 0)" and the snprintf() which could remain 
   purely static initializations.

2) Remove bus_to_port() entirely, and store the address of the appropriate 
   struct pcie_port instance into the sysdata pointer of the pci_bus 
   structure.  This struct pcie_port could even be kmalloc'd as needed.

>  static void __devinit rc_pci_fixup(struct pci_dev *dev)
>  {
>  	/*
> @@ -163,7 +211,7 @@ kirkwood_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  {
>  	struct pci_bus *bus;
>  
> -	if (nr == 0) {
> +	if (nr < num_pcie_ports) {
>  		bus = pci_scan_bus(sys->busnr, &pcie_ops, sys);
>  	} else {
>  		bus = NULL;
> @@ -175,18 +223,45 @@ kirkwood_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  
>  static int __init kirkwood_pcie_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
>  {
> -	return IRQ_KIRKWOOD_PCIE;
> +	struct pcie_port *pp = bus_to_port(dev->bus->number);
> +
> +	return pp->index ? IRQ_KIRKWOOD_PCIE1 : IRQ_KIRKWOOD_PCIE;

Maybe having pp->irq and returning that directly would be better.

>  static struct hw_pci kirkwood_pci __initdata = {
> -	.nr_controllers	= 1,
> +	.nr_controllers	= 2,

I think this should be initialized at run time to 2 only when running on 
a 6282.

>  	.swizzle	= pci_std_swizzle,
>  	.setup		= kirkwood_pcie_setup,
>  	.scan		= kirkwood_pcie_scan_bus,
>  	.map_irq	= kirkwood_pcie_map_irq,
>  };
>  
> -void __init kirkwood_pcie_init(void)
> +static void __init add_pcie_port(int index, unsigned long base)
>  {
> +	printk(KERN_INFO "Kirkwood PCIe port %d: ", index);
> +
> +	if (orion_pcie_link_up((void __iomem *)base)) {
> +		struct pcie_port *pp = &pcie_port[num_pcie_ports++];
> +
> +		printk(KERN_INFO "link up\n");
> +
> +		pp->index = index;
> +		pp->root_bus_nr = -1;
> +		pp->base = (void __iomem *)base;
> +		spin_lock_init(&pp->conf_lock);
> +		memset(pp->res, 0, sizeof(pp->res));
> +	} else {
> +		printk(KERN_INFO "link down, ignoring\n");
> +	}
> +}
> +
> +void __init kirkwood_pcie_init(int init_port0, int init_port1)

And instead of having (int init_port0, int init_port1), this should be 
(int port) which is much less error prone as demonstrated by your own 
kirkwood_pcie_init(0, 1) usage.  Those machines with both PCIe ports 
would simply have to call this twice.


Nicolas
