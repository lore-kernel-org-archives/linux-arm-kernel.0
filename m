From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 15:23:17 -0400
Subject: [GIT PULL 2/2] ARM: mvebu: MSI mvebu changes for v3.12
In-Reply-To: <20130814191011.GD13964@titan.lakedaemon.net>
References: <20130814191011.GD13964@titan.lakedaemon.net>
Message-ID: <20130814192317.GE13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This branch has a conflict with mvebu/drivers (the MBus dt binding work)
that is rather extensive.  I've attached the resolution that has been
in -next below the summary.

thx,

Jason.

The following changes since commit 6a4324ebf5cf412d55fd1ea259d4dd29fb8f90e8:

  PCI: msi: add default MSI operations for !HAVE_GENERIC_HARDIRQS platforms (2013-08-13 15:16:30 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/msi-mvebu-3.12

for you to fetch changes up to 57f1eafe6952ee3ebe5f16c850b497e3ca2b3d04:

  ARM: mvebu: link PCIe controllers to the MSI controller (2013-08-13 18:13:45 +0000)

----------------------------------------------------------------
mvebu-specific msi changes for v3.12

 - enable MSI on PCI for mvebu

Depends:

 - mvebu/msi_pci (tag msi-3.12)

----------------------------------------------------------------
Thomas Petazzoni (5):
      irqchip: armada-370-xp: properly request resources
      irqchip: armada-370-xp: implement MSI support
      ARM: mvebu: the MPIC now provides MSI controller features
      PCI: mvebu: add support for MSI
      ARM: mvebu: link PCIe controllers to the MSI controller

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   3 +
 .../devicetree/bindings/pci/mvebu-pci.txt          |   3 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |   1 +
 arch/arm/boot/dts/armada-370.dtsi                  |   1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   1 +
 drivers/irqchip/irq-armada-370-xp.c                | 202 ++++++++++++++++++++-
 drivers/pci/host/pci-mvebu.c                       |  26 +++
 9 files changed, 234 insertions(+), 5 deletions(-)


And the promised resolution:
-------------->8---------------------

commit 311ab2f64957f8cc701ea4f0fb224123172cd901
Merge: 116f97c 57f1eaf
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Wed Aug 14 17:54:15 2013 +0000

    Merge branch 'mvebu/msi_mvebu' into for-next
    
    Conflicts:
    	Documentation/devicetree/bindings/pci/mvebu-pci.txt
    	arch/arm/boot/dts/armada-370.dtsi
    	arch/arm/boot/dts/armada-xp-mv78230.dtsi
    	arch/arm/boot/dts/armada-xp-mv78260.dtsi
    	arch/arm/boot/dts/armada-xp-mv78460.dtsi
    	drivers/pci/host/pci-mvebu.c

diff --cc Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 9556e2f,77e0ffe..638673a
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@@ -11,49 -10,13 +11,51 @@@ Mandatory properties
  - #interrupt-cells, set to <1>
  - bus-range: PCI bus numbers covered
  - device_type, set to "pci"
 -- ranges: ranges for the PCI memory and I/O regions, as well as the
 -  MMIO registers to control the PCIe interfaces.
 +- ranges: ranges describing the MMIO registers to control the PCIe
 +  interfaces, and ranges describing the MBus windows needed to access
 +  the memory and I/O regions of each PCIe interface.
+ - msi-parent: Link to the hardware entity that serves as the Message
+   Signaled Interrupt controller for this PCI controller.
  
 -In addition, the Device Tree node must have sub-nodes describing each
 +The ranges describing the MMIO registers have the following layout:
 +
 +    0x82000000 0 r MBUS_ID(0xf0, 0x01) r 0 s
 +
 +where:
 +
 +  * r is a 32-bits value that gives the offset of the MMIO
 +  registers of this PCIe interface, from the base of the internal
 +  registers.
 +
 +  * s is a 32-bits value that give the size of this MMIO
 +  registers area. This range entry translates the '0x82000000 0 r' PCI
 +  address into the 'MBUS_ID(0xf0, 0x01) r' CPU address, which is part
 +  of the internal register window (as identified by MBUS_ID(0xf0,
 +  0x01)).
 +
 +The ranges describing the MBus windows have the following layout:
 +
 +    0x8t000000 s 0     MBUS_ID(w, a) 0 1 0
 +
 +where:
 +
 +   * t is the type of the MBus window (as defined by the standard PCI DT
 +   bindings), 1 for I/O and 2 for memory.
 +
 +   * s is the PCI slot that corresponds to this PCIe interface
 +
 +   * w is the 'target ID' value for the MBus window
 +
 +   * a the 'attribute' value for the MBus window.
 +
 +Since the location and size of the different MBus windows is not fixed in
 +hardware, and only determined in runtime, those ranges cover the full first
 +4 GB of the physical address space, and do not translate into a valid CPU
 +address.
 +
 +In addition, the device tree node must have sub-nodes describing each
  PCIe interface, having the following mandatory properties:
 +
  - reg: used only for interrupt mapping, so only the first four bytes
    are used to refer to the correct bus number and device number.
  - assigned-addresses: reference to the MMIO registers used to control
@@@ -86,41 -48,20 +88,42 @@@ pcie-controller 
  	#size-cells = <2>;
  
  	bus-range = <0x00 0xff>;
+ 	msi-parent = <&mpic>;
  
 -	ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
 -		  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
 -		  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000   /* Port 0.1 registers */
 -		  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000   /* Port 0.2 registers */
 -		  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000   /* Port 0.3 registers */
 -		  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000   /* Port 1.0 registers */
 -		  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000   /* Port 3.0 registers */
 -		  0x82000000 0 0xd0084000 0xd0084000 0 0x00002000   /* Port 1.1 registers */
 -		  0x82000000 0 0xd0088000 0xd0088000 0 0x00002000   /* Port 1.2 registers */
 -		  0x82000000 0 0xd008c000 0xd008c000 0 0x00002000   /* Port 1.3 registers */
 -		  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
 -		  0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
 +	ranges =
 +	       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000	/* Port 0.0 registers */
 +		0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000	/* Port 2.0 registers */
 +		0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000	/* Port 0.1 registers */
 +		0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000	/* Port 0.2 registers */
 +		0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000	/* Port 0.3 registers */
 +		0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000	/* Port 1.0 registers */
 +		0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000	/* Port 3.0 registers */
 +		0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000	/* Port 1.1 registers */
 +		0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000	/* Port 1.2 registers */
 +		0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000	/* Port 1.3 registers */
 +		0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
 +		0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
 +		0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
 +		0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
 +		0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
 +		0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
 +		0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
 +		0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
 +
 +		0x82000000 0x5 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
 +		0x81000000 0x5 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
 +		0x82000000 0x6 0     MBUS_ID(0x08, 0xd8) 0 1 0 /* Port 1.1 MEM */
 +		0x81000000 0x6 0     MBUS_ID(0x08, 0xd0) 0 1 0 /* Port 1.1 IO  */
 +		0x82000000 0x7 0     MBUS_ID(0x08, 0xb8) 0 1 0 /* Port 1.2 MEM */
 +		0x81000000 0x7 0     MBUS_ID(0x08, 0xb0) 0 1 0 /* Port 1.2 IO  */
 +		0x82000000 0x8 0     MBUS_ID(0x08, 0x78) 0 1 0 /* Port 1.3 MEM */
 +		0x81000000 0x8 0     MBUS_ID(0x08, 0x70) 0 1 0 /* Port 1.3 IO  */
 +
 +		0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
 +		0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */
 +
 +		0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
 +		0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;
  
  	pcie at 1,0 {
  		device_type = "pci";
diff --cc arch/arm/boot/dts/armada-370.dtsi
index 648e530,a60018d..d331e59
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@@ -29,66 -29,8 +29,67 @@@
  	};
  
  	soc {
 -		ranges = <0          0xd0000000 0x0100000 /* internal registers */
 -			  0xe0000000 0xe0000000 0x8100000 /* PCIe */>;
 +		compatible = "marvell,armada370-mbus", "simple-bus";
 +
 +		bootrom {
 +			compatible = "marvell,bootrom";
 +			reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
 +		};
 +
 +		pcie-controller {
 +			compatible = "marvell,armada-370-pcie";
 +			status = "disabled";
 +			device_type = "pci";
 +
 +			#address-cells = <3>;
 +			#size-cells = <2>;
 +
++			msi-parent = <&mpic>;
 +			bus-range = <0x00 0xff>;
 +
 +			ranges =
 +			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
 +				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000
 +				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
 +				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */
 +				0x82000000 0x2 0     MBUS_ID(0x08, 0xe8) 0       1 0 /* Port 1.0 MEM */
 +				0x81000000 0x2 0     MBUS_ID(0x08, 0xe0) 0       1 0 /* Port 1.0 IO  */>;
 +
 +			pcie at 1,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 +				reg = <0x0800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +                                ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 +                                          0x81000000 0 0 0x81000000 0x1 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 58>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 5>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 2,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
 +				reg = <0x1000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +                                ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 +                                          0x81000000 0 0 0x81000000 0x2 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 62>;
 +				marvell,pcie-port = <1>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 9>;
 +				status = "disabled";
 +			};
 +		};
 +
  		internal-regs {
  			system-controller at 18200 {
  				compatible = "marvell,armada-370-xp-system-controller";
diff --cc arch/arm/boot/dts/armada-xp-mv78230.dtsi
index e45e363,4a9a305..0963bc5
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@@ -44,124 -44,6 +44,125 @@@
  	};
  
  	soc {
 +		/*
 +		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
 +		 * configured as x4 or quad x1 lanes. One unit is
 +		 * x4/x1.
 +		 */
 +		pcie-controller {
 +			compatible = "marvell,armada-xp-pcie";
 +			status = "disabled";
 +			device_type = "pci";
 +
 +			#address-cells = <3>;
 +			#size-cells = <2>;
 +
++			msi-parent = <&mpic>;
 +			bus-range = <0x00 0xff>;
 +
 +			ranges =
 +			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
 +				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
 +				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
 +				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
 +				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
 +				0x82000000 0x1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
 +				0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
 +				0x82000000 0x2 0       MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
 +				0x81000000 0x2 0       MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
 +				0x82000000 0x3 0       MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
 +				0x81000000 0x3 0       MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
 +				0x82000000 0x4 0       MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
 +				0x81000000 0x4 0       MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
 +				0x82000000 0x9 0       MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
 +				0x81000000 0x9 0       MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */>;
 +
 +			pcie at 1,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 +				reg = <0x0800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 +					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 58>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 5>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 2,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
 +				reg = <0x1000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 +					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 59>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <1>;
 +				clocks = <&gateclk 6>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 3,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
 +				reg = <0x1800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 +					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 60>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <2>;
 +				clocks = <&gateclk 7>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 4,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
 +				reg = <0x2000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
 +					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 61>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <3>;
 +				clocks = <&gateclk 8>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 9,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
 +				reg = <0x4800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
 +					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 99>;
 +				marvell,pcie-port = <2>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 26>;
 +				status = "disabled";
 +			};
 +		};
 +
  		internal-regs {
  			pinctrl {
  				compatible = "marvell,mv78230-pinctrl";
diff --cc arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 6dc3921,dd23e96..78406da
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@@ -45,145 -45,6 +45,146 @@@
  	};
  
  	soc {
 +		/*
 +		 * MV78260 has 3 PCIe units Gen2.0: Two units can be
 +		 * configured as x4 or quad x1 lanes. One unit is
 +		 * x4/x1.
 +		 */
 +		pcie-controller {
 +			compatible = "marvell,armada-xp-pcie";
 +			status = "disabled";
 +			device_type = "pci";
 +
 +			#address-cells = <3>;
 +			#size-cells = <2>;
 +
++			msi-parent = <&mpic>;
 +			bus-range = <0x00 0xff>;
 +
 +			ranges =
 +			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
 +				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
 +				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
 +				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
 +				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
 +				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
 +				0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000   /* Port 3.0 registers */
 +				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
 +				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
 +				0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
 +				0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
 +				0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
 +				0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
 +				0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
 +				0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
 +				0x82000000 0x9 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
 +				0x81000000 0x9 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
 +				0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
 +				0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;
 +
 +			pcie at 1,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 +				reg = <0x0800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 +					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 58>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 5>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 2,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
 +				reg = <0x1000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +                                ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 +                                          0x81000000 0 0 0x81000000 0x2 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 59>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <1>;
 +				clocks = <&gateclk 6>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 3,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
 +				reg = <0x1800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 +					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 60>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <2>;
 +				clocks = <&gateclk 7>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 4,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
 +				reg = <0x2000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
 +					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 61>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <3>;
 +				clocks = <&gateclk 8>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 9,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
 +				reg = <0x4800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
 +					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 99>;
 +				marvell,pcie-port = <2>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 26>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 10,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x82000 0 0x2000>;
 +				reg = <0x5000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0xa 0 1 0
 +					  0x81000000 0 0 0x81000000 0xa 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 103>;
 +				marvell,pcie-port = <3>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 27>;
 +				status = "disabled";
 +			};
 +		};
 +
  		internal-regs {
  			pinctrl {
  				compatible = "marvell,mv78260-pinctrl";
diff --cc arch/arm/boot/dts/armada-xp-mv78460.dtsi
index a6661e3,77db2bc..3834fb4
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@@ -61,227 -61,6 +61,228 @@@
  	};
  
  	soc {
 +		/*
 +		 * MV78460 has 4 PCIe units Gen2.0: Two units can be
 +		 * configured as x4 or quad x1 lanes. Two units are
 +		 * x4/x1.
 +		 */
 +		pcie-controller {
 +			compatible = "marvell,armada-xp-pcie";
 +			status = "disabled";
 +			device_type = "pci";
 +
 +			#address-cells = <3>;
 +			#size-cells = <2>;
 +
++			msi-parent = <&mpic>;
 +			bus-range = <0x00 0xff>;
 +
 +			ranges =
 +			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
 +				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
 +				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
 +				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
 +				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
 +				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
 +				0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000   /* Port 3.0 registers */
 +				0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000   /* Port 1.1 registers */
 +				0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000   /* Port 1.2 registers */
 +				0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000   /* Port 1.3 registers */
 +				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
 +				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
 +				0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
 +				0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
 +				0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
 +				0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
 +				0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
 +				0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
 +
 +				0x82000000 0x5 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
 +				0x81000000 0x5 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
 +				0x82000000 0x6 0     MBUS_ID(0x08, 0xd8) 0 1 0 /* Port 1.1 MEM */
 +				0x81000000 0x6 0     MBUS_ID(0x08, 0xd0) 0 1 0 /* Port 1.1 IO  */
 +				0x82000000 0x7 0     MBUS_ID(0x08, 0xb8) 0 1 0 /* Port 1.2 MEM */
 +				0x81000000 0x7 0     MBUS_ID(0x08, 0xb0) 0 1 0 /* Port 1.2 IO  */
 +				0x82000000 0x8 0     MBUS_ID(0x08, 0x78) 0 1 0 /* Port 1.3 MEM */
 +				0x81000000 0x8 0     MBUS_ID(0x08, 0x70) 0 1 0 /* Port 1.3 IO  */
 +
 +				0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
 +				0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */
 +
 +				0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
 +				0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;
 +
 +			pcie at 1,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 +				reg = <0x0800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 +					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 58>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 5>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 2,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
 +				reg = <0x1000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 +					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 59>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <1>;
 +				clocks = <&gateclk 6>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 3,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
 +				reg = <0x1800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 +					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 60>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <2>;
 +				clocks = <&gateclk 7>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 4,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
 +				reg = <0x2000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
 +					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 61>;
 +				marvell,pcie-port = <0>;
 +				marvell,pcie-lane = <3>;
 +				clocks = <&gateclk 8>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 5,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
 +				reg = <0x2800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
 +					  0x81000000 0 0 0x81000000 0x5 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 62>;
 +				marvell,pcie-port = <1>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 9>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 6,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
 +				reg = <0x3000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x6 0 1 0
 +					  0x81000000 0 0 0x81000000 0x6 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 63>;
 +				marvell,pcie-port = <1>;
 +				marvell,pcie-lane = <1>;
 +				clocks = <&gateclk 10>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 7,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
 +				reg = <0x3800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x7 0 1 0
 +					  0x81000000 0 0 0x81000000 0x7 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 64>;
 +				marvell,pcie-port = <1>;
 +				marvell,pcie-lane = <2>;
 +				clocks = <&gateclk 11>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 8,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
 +				reg = <0x4000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x8 0 1 0
 +					  0x81000000 0 0 0x81000000 0x8 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 65>;
 +				marvell,pcie-port = <1>;
 +				marvell,pcie-lane = <3>;
 +				clocks = <&gateclk 12>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 9,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
 +				reg = <0x4800 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
 +					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 99>;
 +				marvell,pcie-port = <2>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 26>;
 +				status = "disabled";
 +			};
 +
 +			pcie at 10,0 {
 +				device_type = "pci";
 +				assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
 +				reg = <0x5000 0 0 0 0>;
 +				#address-cells = <3>;
 +				#size-cells = <2>;
 +				#interrupt-cells = <1>;
 +				ranges = <0x82000000 0 0 0x82000000 0xa 0 1 0
 +					  0x81000000 0 0 0x81000000 0xa 0 1 0>;
 +				interrupt-map-mask = <0 0 0 0>;
 +				interrupt-map = <0 0 0 0 &mpic 103>;
 +				marvell,pcie-port = <3>;
 +				marvell,pcie-lane = <0>;
 +				clocks = <&gateclk 27>;
 +				status = "disabled";
 +			};
 +		};
 +
  		internal-regs {
  			pinctrl {
  				compatible = "marvell,mv78460-pinctrl";
diff --cc drivers/pci/host/pci-mvebu.c
index 847c109,5715a97..6aa0daf
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@@ -733,50 -764,21 +742,65 @@@ mvebu_pcie_map_registers(struct platfor
  	return devm_request_and_ioremap(&pdev->dev, &regs);
  }
  
 +#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
 +#define    DT_TYPE_IO                 0x1
 +#define    DT_TYPE_MEM32              0x2
 +#define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
 +#define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
 +
 +static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 +			      unsigned long type, int *tgt, int *attr)
 +{
 +	const int na = 3, ns = 2;
 +	const __be32 *range;
 +	int rlen, nranges, rangesz, pna, i;
 +
 +	range = of_get_property(np, "ranges", &rlen);
 +	if (!range)
 +		return -EINVAL;
 +
 +	pna = of_n_addr_cells(np);
 +	rangesz = pna + na + ns;
 +	nranges = rlen / sizeof(__be32) / rangesz;
 +
 +	for (i = 0; i < nranges; i++) {
 +		u32 flags = of_read_number(range, 1);
 +		u32 slot = of_read_number(range, 2);
 +		u64 cpuaddr = of_read_number(range + na, pna);
 +		unsigned long rtype;
 +
 +		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
 +			rtype = IORESOURCE_IO;
 +		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
 +			rtype = IORESOURCE_MEM;
 +
 +		if (slot == PCI_SLOT(devfn) && type == rtype) {
 +			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
 +			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
 +			return 0;
 +		}
 +
 +		range += rangesz;
 +	}
 +
 +	return -ENOENT;
 +}
 +
+ static void __init mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
+ {
+ 	struct device_node *msi_node;
+ 
+ 	msi_node = of_parse_phandle(pcie->pdev->dev.of_node,
+ 				    "msi-parent", 0);
+ 	if (!msi_node)
+ 		return;
+ 
+ 	pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
+ 
+ 	if (pcie->msi)
+ 		pcie->msi->dev = &pcie->pdev->dev;
+ }
+ 
  static int __init mvebu_pcie_probe(struct platform_device *pdev)
  {
  	struct mvebu_pcie *pcie;
