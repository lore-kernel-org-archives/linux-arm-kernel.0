From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 30 Jul 2013 13:13:41 -0300
Subject: [PATCH v9 30/30] PCI: mvebu: Adapt to the new device tree layout
In-Reply-To: <1374844687-19981-31-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1374844687-19981-31-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130730161340.GA26140@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 10:18:07AM -0300, Ezequiel Garcia wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> The new device tree layout encodes the window's target ID and attribute
> in the PCIe controller node's ranges property. This allows to parse
> such entries to obtain such information and use the recently introduced
> MBus API to create the windows, instead of using the current name based
> scheme.
> 
> Cc: devicetree at vger.kernel.org
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  .../devicetree/bindings/pci/mvebu-pci.txt          | 145 ++++++++++++++++-----
>  1 file changed, 109 insertions(+), 36 deletions(-)
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
> -- 
> 1.8.1.5
> 

Any feedback on this from the DT maintainers?

This patchset has been around for several months now and has been
extensively discussed with Jason Gunthorpe and Arnd Bergmann,
so we'd really like to have an Acked-by on the DT bindings and merge it.

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
