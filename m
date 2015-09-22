From: B48286@freescale.com (Hou Zhiqiang)
Date: Tue, 22 Sep 2015 09:50:21 +0000
Subject: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <20150922012403.GA1535@svinekod>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
Message-ID: <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: 2015?9?22? 9:24
> To: Hou Zhiqiang-B48286; marc.zyngier at arm.com
> Cc: linux-arm-kernel at lists.infradead.org; Catalin Marinas; Will Deacon;
> linux-i2c at vger.kernel.org; linux-watchdog at vger.kernel.org; linux-
> doc at vger.kernel.org; linux-clk at vger.kernel.org; Xie Shaohui-B21989;
> corbet at lwn.net; Sharma Bhupesh-B45370; mturquette at baylibre.com; wsa at the-
> dreams.de; sboyd at codeaurora.org; wim at iguana.be; Song Wenbin-B53747; Wood
> Scott-B07421; Hu Mingkai-B21284; Li Yang-Leo-R58472
> Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
> 
> Hi,
> 
> > +/memreserve/ 0x80000000 0x00010000;
> 
> Why is this necessary?
 
This memory region is pre-reserved for the spin-table/psci, although didn't add
Enable method of secondary cores.

> If this is necessary, please add a comment stating what this is for.
> 
> > +               cpu at 3 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x0 0x3>;
> > +                       clocks = <&clockgen 1 0>;
> > +               };
> 
> Missing enable-method properties on all the secondary CPUs.
> 

There are two methods (spin-table and psci) to bring up secondary cores, which one
do you think is better?

> [...]
> 
> > +       gic: interrupt-controller at 1400000 {
> > +               compatible = "arm,gic-400";
> > +               #interrupt-cells = <3>;
> > +               interrupt-controller;
> > +               reg = <0x0 0x1401000 0 0x1000>, /* GICD */
> > +                     <0x0 0x1402000 0 0x1000>, /* GICC */
> > +                     <0x0 0x1404000 0 0x2000>, /* GICH */
> > +                     <0x0 0x1406000 0 0x2000>; /* GICV */
> > +               interrupts = <1 9 0xf08>;
> > +       };
> 
> These sizes don't look right.
> 
> To the best of my knowledge, GICC (and GICV) should be 0x2000 in size,
> while GICD and GICH should be 0x1000.

Thanks for your correction.

> 
> [...]
> 
> > +       ifc: ifc at 1530000 {
> > +               compatible = "fsl,ifc", "simple-bus";
> > +               reg = <0x0 0x1530000 0x0 0x10000>;
> > +               interrupts = <0 43 0x4>;
> > +       };
> 
> Why simple-bus?

There are 3 child node located in dtsi file that should be created and added
to platform device list.

> 
> > +       clockgen: clocking at 1ee1000 {
> > +               compatible = "fsl,ls1043a-clockgen";
> > +               reg = <0x0 0x1ee1000 0x0 0x1000>;
> > +               #clock-cells = <2>;
> > +               clocks = <&sysclk>;
> > +               sysclk: sysclk {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <100000000>;
> > +                       clock-output-names = "sysclk";
> > +               };
> > +       };
> 
> Why does this fixed clock live under the clockgen? It should live
> directly under the root node.
> 

Thanks and will move it out in v2.

> [...]
> 
> > +       pcie at 3400000 {
> > +               compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> > +               reg = <0x00 0x03400000 0x0 0x00100000   /* controller
> registers */
> > +                      0x40 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +               reg-names = "regs", "config";
> > +               interrupts = <0 118 0x4>, /* controller interrupt */
> > +                            <0 117 0x4>; /* PME interrupt */
> > +               interrupt-names = "intr", "pme";
> > +               #address-cells = <3>;
> > +               #size-cells = <2>;
> > +               device_type = "pci";
> > +               num-lanes = <4>;
> > +               bus-range = <0x0 0xff>;
> > +               ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0
> 0x00010000   /* downstream I/O */
> > +                         0x82000000 0x0 0x40000000 0x40 0x40000000 0x0
> 0x40000000>; /* non-prefetchable memory */
> > +               msi-parent = <&msi1>;
> > +               #interrupt-cells = <1>;
> > +               interrupt-map-mask = <0 0 0 7>;
> > +               interrupt-map = <0000 0 0 1 &gic 0 110 0x4>,
> > +                               <0000 0 0 2 &gic 0 111 0x4>,
> > +                               <0000 0 0 3 &gic 0 112 0x4>,
> > +                               <0000 0 0 4 &gic 0 113 0x4>;
> > +       };
> > +
> > +       pcie at 3500000 {
> > +               compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> > +               reg = <0x00 0x03500000 0x0 0x00100000   /* controller
> registers */
> > +                      0x48 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +               reg-names = "regs", "config";
> > +               interrupts = <0 128 0x4>,
> > +                            <0 127 0x4>;
> > +               interrupt-names = "intr", "pme";
> > +               #address-cells = <3>;
> > +               #size-cells = <2>;
> > +               device_type = "pci";
> > +               num-lanes = <2>;
> > +               bus-range = <0x0 0xff>;
> > +               ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0
> 0x00010000   /* downstream I/O */
> > +                         0x82000000 0x0 0x40000000 0x48 0x40000000 0x0
> 0x40000000>; /* non-prefetchable memory */
> > +               msi-parent = <&msi2>;
> > +               #interrupt-cells = <1>;
> > +               interrupt-map-mask = <0 0 0 7>;
> > +               interrupt-map = <0000 0 0 1 &gic 0 120  0x4>,
> > +                               <0000 0 0 2 &gic 0 121 0x4>,
> > +                               <0000 0 0 3 &gic 0 122 0x4>,
> > +                               <0000 0 0 4 &gic 0 123 0x4>;
> > +       };
> > +
> > +       pcie at 3600000 {
> > +               compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> > +               reg = <0x00 0x03600000 0x0 0x00100000   /* controller
> registers */
> > +                      0x50 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +               reg-names = "regs", "config";
> > +               interrupts = <0 162 0x4>,
> > +                            <0 161 0x4>;
> > +               interrupt-names = "intr", "pme";
> > +               #address-cells = <3>;
> > +               #size-cells = <2>;
> > +               device_type = "pci";
> > +               num-lanes = <2>;
> > +               bus-range = <0x0 0xff>;
> > +               ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0
> 0x00010000   /* downstream I/O */
> > +                         0x82000000 0x0 0x40000000 0x50 0x40000000 0x0
> 0x40000000>; /* non-prefetchable memory */
> > +               msi-parent = <&msi3>;
> > +               #interrupt-cells = <1>;
> > +               interrupt-map-mask = <0 0 0 7>;
> > +               interrupt-map = <0000 0 0 1 &gic 0 154 0x4>,
> > +                               <0000 0 0 2 &gic 0 155 0x4>,
> > +                               <0000 0 0 3 &gic 0 156 0x4>,
> > +                               <0000 0 0 4 &gic 0 157 0x4>;
> > +       };
> 
> You wait ages for a bus, then three show up at once...
> 
> > +
> > +       memory at 80000000 {
> > +               device_type = "memory";
> > +               reg = <0x0 0x80000000 0 0x80000000>;
> > +                     /* DRAM space 1 - 2 GB DRAM */
> 
> I don't understand the comment. This describes 2GB at 2GB.
> 

Yes, there is a 2GB space for DRAM from address 2G.
The DRAM address 0x0 will be remapped to SoC address 2G, this remap is done by hardware.

> Does the bootloader overwrite this?

No.
 
Thanks,
Zhiqiang
