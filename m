From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 9 Jul 2013 14:20:26 -0400
Subject: [PATCH v7 11/22] PCI: mvebu: Adapt to the new device tree layout
In-Reply-To: <1373388084-29520-12-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373388084-29520-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1373388084-29520-12-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130709182026.GJ11908@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On Tue, Jul 09, 2013 at 01:41:13PM -0300, Ezequiel Garcia wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> The new device tree layout encodes the window's target ID and attribute
> in the PCIe controller node's ranges property. This allows to parse
> such entries to obtain such information and use the recently introduced
> MBus API to create the windows, instead of using the current name based
> scheme.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/pci/mvebu-pci.txt          | 145 ++++++++++++++++-----
>  drivers/pci/host/pci-mvebu.c                       | 113 +++++++++++-----
>  2 files changed, 193 insertions(+), 65 deletions(-)

After my conversation with tglx a few days ago [1], I'm even more
inclined to push patches like this to the correct maintainers.  However,
looking at how this patch fits into the series, it may be better if we
take it through mvebu/arm-soc with your Ack.

It depends on the patches before it, and the patches after it depend on
it.  Unless I'm reading this wrong, I would have a branch that you would
pull and base this patch on, which I would then pull and base the rest
of the series on. Reshuffling the series to alleviate this wouldn't work
in this case. :-/

Are you ok with that?  (fwiw, the code changes are isolated to
pci-mvebu.c)

thx,

Jason.

[1] http://www.spinics.net/lists/arm-kernel/msg257447.html

> 
> diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> index f8d4058..9556e2f 100644
> --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> @@ -1,6 +1,7 @@
>  * Marvell EBU PCIe interfaces
>  
>  Mandatory properties:
> +
>  - compatible: one of the following values:
>      marvell,armada-370-pcie
>      marvell,armada-xp-pcie
> @@ -10,11 +11,49 @@ Mandatory properties:
>  - #interrupt-cells, set to <1>
>  - bus-range: PCI bus numbers covered
>  - device_type, set to "pci"
> -- ranges: ranges for the PCI memory and I/O regions, as well as the
> -  MMIO registers to control the PCIe interfaces.
> +- ranges: ranges describing the MMIO registers to control the PCIe
> +  interfaces, and ranges describing the MBus windows needed to access
> +  the memory and I/O regions of each PCIe interface.
> +
> +The ranges describing the MMIO registers have the following layout:
> +
> +    0x82000000 0 r MBUS_ID(0xf0, 0x01) r 0 s
> +
> +where:
> +
> +  * r is a 32-bits value that gives the offset of the MMIO
> +  registers of this PCIe interface, from the base of the internal
> +  registers.
> +
> +  * s is a 32-bits value that give the size of this MMIO
> +  registers area. This range entry translates the '0x82000000 0 r' PCI
> +  address into the 'MBUS_ID(0xf0, 0x01) r' CPU address, which is part
> +  of the internal register window (as identified by MBUS_ID(0xf0,
> +  0x01)).
> +
> +The ranges describing the MBus windows have the following layout:
> +
> +    0x8t000000 s 0     MBUS_ID(w, a) 0 1 0
> +
> +where:
> +
> +   * t is the type of the MBus window (as defined by the standard PCI DT
> +   bindings), 1 for I/O and 2 for memory.
>  
> -In addition, the Device Tree node must have sub-nodes describing each
> +   * s is the PCI slot that corresponds to this PCIe interface
> +
> +   * w is the 'target ID' value for the MBus window
> +
> +   * a the 'attribute' value for the MBus window.
> +
> +Since the location and size of the different MBus windows is not fixed in
> +hardware, and only determined in runtime, those ranges cover the full first
> +4 GB of the physical address space, and do not translate into a valid CPU
> +address.
> +
> +In addition, the device tree node must have sub-nodes describing each
>  PCIe interface, having the following mandatory properties:
> +
>  - reg: used only for interrupt mapping, so only the first four bytes
>    are used to refer to the correct bus number and device number.
>  - assigned-addresses: reference to the MMIO registers used to control
> @@ -26,7 +65,8 @@ PCIe interface, having the following mandatory properties:
>  - #address-cells, set to <3>
>  - #size-cells, set to <2>
>  - #interrupt-cells, set to <1>
> -- ranges, empty property.
> +- ranges, translating the MBus windows ranges of the parent node into
> +  standard PCI addresses.
>  - interrupt-map-mask and interrupt-map, standard PCI properties to
>    define the mapping of the PCIe interface to interrupt numbers.
>  
> @@ -47,27 +87,50 @@ pcie-controller {
>  
>  	bus-range = <0x00 0xff>;
>  
> -	ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
> -		  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
> -		  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000   /* Port 0.1 registers */
> -		  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000   /* Port 0.2 registers */
> -		  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000   /* Port 0.3 registers */
> -		  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000   /* Port 1.0 registers */
> -		  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000   /* Port 3.0 registers */
> -		  0x82000000 0 0xd0084000 0xd0084000 0 0x00002000   /* Port 1.1 registers */
> -		  0x82000000 0 0xd0088000 0xd0088000 0 0x00002000   /* Port 1.2 registers */
> -		  0x82000000 0 0xd008c000 0xd008c000 0 0x00002000   /* Port 1.3 registers */
> -		  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
> -		  0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
> +	ranges =
> +	       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000	/* Port 0.0 registers */
> +		0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000	/* Port 2.0 registers */
> +		0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000	/* Port 0.1 registers */
> +		0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000	/* Port 0.2 registers */
> +		0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000	/* Port 0.3 registers */
> +		0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000	/* Port 1.0 registers */
> +		0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000	/* Port 3.0 registers */
> +		0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000	/* Port 1.1 registers */
> +		0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000	/* Port 1.2 registers */
> +		0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000	/* Port 1.3 registers */
> +		0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
> +		0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
> +		0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
> +		0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
> +		0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
> +		0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
> +		0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
> +		0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
> +
> +		0x82000000 0x5 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
> +		0x81000000 0x5 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
> +		0x82000000 0x6 0     MBUS_ID(0x08, 0xd8) 0 1 0 /* Port 1.1 MEM */
> +		0x81000000 0x6 0     MBUS_ID(0x08, 0xd0) 0 1 0 /* Port 1.1 IO  */
> +		0x82000000 0x7 0     MBUS_ID(0x08, 0xb8) 0 1 0 /* Port 1.2 MEM */
> +		0x81000000 0x7 0     MBUS_ID(0x08, 0xb0) 0 1 0 /* Port 1.2 IO  */
> +		0x82000000 0x8 0     MBUS_ID(0x08, 0x78) 0 1 0 /* Port 1.3 MEM */
> +		0x81000000 0x8 0     MBUS_ID(0x08, 0x70) 0 1 0 /* Port 1.3 IO  */
> +
> +		0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
> +		0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */
> +
> +		0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
> +		0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;
>  
>  	pcie at 1,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
> +		assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
>  		reg = <0x0800 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> +			  0x81000000 0 0 0x81000000 0x1 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 58>;
>  		marvell,pcie-port = <0>;
> @@ -78,12 +141,13 @@ pcie-controller {
>  
>  	pcie at 2,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82001000 0 0xd0044000 0 0x2000>;
> +		assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
>  		reg = <0x1000 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> +			  0x81000000 0 0 0x81000000 0x2 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 59>;
>  		marvell,pcie-port = <0>;
> @@ -94,12 +158,13 @@ pcie-controller {
>  
>  	pcie at 3,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82001800 0 0xd0048000 0 0x2000>;
> +		assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
>  		reg = <0x1800 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
> +			  0x81000000 0 0 0x81000000 0x3 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 60>;
>  		marvell,pcie-port = <0>;
> @@ -110,12 +175,13 @@ pcie-controller {
>  
>  	pcie at 4,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82002000 0 0xd004c000 0 0x2000>;
> +		assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
>  		reg = <0x2000 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
> +			  0x81000000 0 0 0x81000000 0x4 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 61>;
>  		marvell,pcie-port = <0>;
> @@ -126,12 +192,13 @@ pcie-controller {
>  
>  	pcie at 5,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82002800 0 0xd0080000 0 0x2000>;
> +		assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
>  		reg = <0x2800 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
> +			  0x81000000 0 0 0x81000000 0x5 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 62>;
>  		marvell,pcie-port = <1>;
> @@ -142,12 +209,13 @@ pcie-controller {
>  
>  	pcie at 6,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82003000 0 0xd0084000 0 0x2000>;
> +		assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
>  		reg = <0x3000 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x6 0 1 0
> +			  0x81000000 0 0 0x81000000 0x6 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 63>;
>  		marvell,pcie-port = <1>;
> @@ -158,12 +226,13 @@ pcie-controller {
>  
>  	pcie at 7,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82003800 0 0xd0088000 0 0x2000>;
> +		assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
>  		reg = <0x3800 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x7 0 1 0
> +			  0x81000000 0 0 0x81000000 0x7 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 64>;
>  		marvell,pcie-port = <1>;
> @@ -174,12 +243,13 @@ pcie-controller {
>  
>  	pcie at 8,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82004000 0 0xd008c000 0 0x2000>;
> +		assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
>  		reg = <0x4000 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x8 0 1 0
> +			  0x81000000 0 0 0x81000000 0x8 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 65>;
>  		marvell,pcie-port = <1>;
> @@ -187,14 +257,16 @@ pcie-controller {
>  		clocks = <&gateclk 12>;
>  		status = "disabled";
>  	};
> +
>  	pcie at 9,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82004800 0 0xd0042000 0 0x2000>;
> +		assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
>  		reg = <0x4800 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
> +			  0x81000000 0 0 0x81000000 0x9 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 99>;
>  		marvell,pcie-port = <2>;
> @@ -205,12 +277,13 @@ pcie-controller {
>  
>  	pcie at 10,0 {
>  		device_type = "pci";
> -		assigned-addresses = <0x82005000 0 0xd0082000 0 0x2000>;
> +		assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
>  		reg = <0x5000 0 0 0 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> -		ranges;
> +		ranges = <0x82000000 0 0 0x82000000 0xa 0 1 0
> +			  0x81000000 0 0 0x81000000 0xa 0 1 0>;
>  		interrupt-map-mask = <0 0 0 0>;
>  		interrupt-map = <0 0 0 0 &mpic 103>;
>  		marvell,pcie-port = <3>;
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 13a633b..424a7b8 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -123,6 +123,10 @@ struct mvebu_pcie_port {
>  	u32 port;
>  	u32 lane;
>  	int devfn;
> +	unsigned int mem_target;
> +	unsigned int mem_attr;
> +	unsigned int io_target;
> +	unsigned int io_attr;
>  	struct clk *clk;
>  	struct mvebu_sw_pci_bridge bridge;
>  	struct device_node *dn;
> @@ -307,10 +311,9 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  			    (port->bridge.iolimitupper << 16)) -
>  			    iobase);
>  
> -	mvebu_mbus_add_window_remap_flags(port->name, port->iowin_base,
> -					  port->iowin_size,
> -					  iobase,
> -					  MVEBU_MBUS_PCI_IO);
> +	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
> +					  port->iowin_base, port->iowin_size,
> +					  iobase);
>  
>  	pci_ioremap_io(iobase, port->iowin_base);
>  }
> @@ -342,10 +345,8 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>  		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
>  		port->memwin_base;
>  
> -	mvebu_mbus_add_window_remap_flags(port->name, port->memwin_base,
> -					  port->memwin_size,
> -					  MVEBU_MBUS_NO_REMAP,
> -					  MVEBU_MBUS_PCI_MEM);
> +	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
> +				    port->memwin_base, port->memwin_size);
>  }
>  
>  /*
> @@ -755,12 +756,54 @@ mvebu_pcie_map_registers(struct platform_device *pdev,
>  	return devm_request_and_ioremap(&pdev->dev, &regs);
>  }
>  
> +#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
> +#define    DT_TYPE_IO                 0x1
> +#define    DT_TYPE_MEM32              0x2
> +#define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
> +#define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
> +
> +static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
> +			      unsigned long type, int *tgt, int *attr)
> +{
> +	const int na = 3, ns = 2;
> +	const __be32 *range;
> +	int rlen, nranges, rangesz, pna, i;
> +
> +	range = of_get_property(np, "ranges", &rlen);
> +	if (!range)
> +		return -EINVAL;
> +
> +	pna = of_n_addr_cells(np);
> +	rangesz = pna + na + ns;
> +	nranges = rlen / sizeof(__be32) / rangesz;
> +
> +	for (i = 0; i < nranges; i++) {
> +		u32 flags = of_read_number(range, 1);
> +		u32 slot = of_read_number(range, 2);
> +		u64 cpuaddr = of_read_number(range + na, pna);
> +		unsigned long rtype;
> +
> +		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
> +			rtype = IORESOURCE_IO;
> +		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
> +			rtype = IORESOURCE_MEM;
> +
> +		if (slot == PCI_SLOT(devfn) && type == rtype) {
> +			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
> +			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
> +			return 0;
> +		}
> +
> +		range += rangesz;
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  static int __init mvebu_pcie_probe(struct platform_device *pdev)
>  {
>  	struct mvebu_pcie *pcie;
>  	struct device_node *np = pdev->dev.of_node;
> -	struct of_pci_range range;
> -	struct of_pci_range_parser parser;
>  	struct device_node *child;
>  	int i, ret;
>  
> @@ -771,29 +814,25 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pdev = pdev;
>  
> -	if (of_pci_range_parser_init(&parser, np))
> +	/* Get the PCIe memory and I/O aperture */
> +	mvebu_mbus_get_pcie_mem_aperture(&pcie->mem);
> +	if (resource_size(&pcie->mem) == 0) {
> +		dev_err(&pdev->dev, "invalid memory aperture size\n");
>  		return -EINVAL;
> +	}
>  
> -	/* Get the I/O and memory ranges from DT */
> -	for_each_of_pci_range(&parser, &range) {
> -		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
> -		if (restype == IORESOURCE_IO) {
> -			of_pci_range_to_resource(&range, np, &pcie->io);
> -			of_pci_range_to_resource(&range, np, &pcie->realio);
> -			pcie->io.name = "I/O";
> -			pcie->realio.start = max_t(resource_size_t,
> -						   PCIBIOS_MIN_IO,
> -						   range.pci_addr);
> -			pcie->realio.end = min_t(resource_size_t,
> -						 IO_SPACE_LIMIT,
> -						 range.pci_addr + range.size);
> -		}
> -		if (restype == IORESOURCE_MEM) {
> -			of_pci_range_to_resource(&range, np, &pcie->mem);
> -			pcie->mem.name = "MEM";
> -		}
> +	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
> +	if (resource_size(&pcie->io) == 0) {
> +		dev_err(&pdev->dev, "invalid I/O aperture size\n");
> +		return -EINVAL;
>  	}
>  
> +	pcie->realio.flags = pcie->io.flags;
> +	pcie->realio.start = PCIBIOS_MIN_IO;
> +	pcie->realio.end = min_t(resource_size_t,
> +				  IO_SPACE_LIMIT,
> +				  resource_size(&pcie->io));
> +
>  	/* Get the bus range */
>  	ret = of_pci_parse_bus_range(np, &pcie->busn);
>  	if (ret) {
> @@ -841,6 +880,22 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>  		if (port->devfn < 0)
>  			continue;
>  
> +		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_MEM,
> +					 &port->mem_target, &port->mem_attr);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for mem window\n",
> +				port->port, port->lane);
> +			continue;
> +		}
> +
> +		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_IO,
> +					 &port->io_target, &port->io_attr);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for io window\n",
> +				port->port, port->lane);
> +			continue;
> +		}
> +
>  		port->base = mvebu_pcie_map_registers(pdev, child, port);
>  		if (!port->base) {
>  			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
