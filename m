From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 13:38:48 +0100
Subject: [PATCH V3] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <5468032C.8020505@amd.com>
References: <5468032C.8020505@amd.com>
Message-ID: <59640336.2Jjg4YGMcT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 01:12:45 Suthikulpanit, Suravee wrote:
> On 11/13/14 18:29, Arnd Bergmann wrote:
> > On Tuesday 28 October 2014 08:36:54 suravee.suthikulpanit at amd.com wrote:
> >> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >>
> >> Initial revision of device tree for AMD Seattle platform
> >
> > Sorry for not looking at this earlier in enough detail.
> >
> >> +	dma0: dma at 0500000 {
> >> +		compatible = "arm,pl330", "arm,primecell";
> >> +		reg = <0 0x0500000 0 0x1000>;
> >> +		interrupts =
> >> +			<0 368 4>,
> >> +			<0 369 4>,
> >> +			<0 370 4>,
> >> +			<0 371 4>,
> >> +			<0 372 4>,
> >> +			<0 373 4>,
> >> +			<0 374 4>,
> >> +			<0 375 4>;
> >> +		clocks = <&dmaclk_500mhz>;
> >> +		clock-names = "apb_pclk";
> >> +		#dma-cells = <1>;
> >> +	};
> >
> > Is this device cache-coherent?
> >
> > Does it support larger than 32-bit DMA addresses?
> 
> The pl330 is only 32-bit DMA addressable, and need to be used with
> the smmu (not yet included here) before it can be used in the system.
> Therefore, it should be cache coherent by the virtue of the SMMU.
> 
> I?ll remove this until the SMMU stuff is tested and ready.

Ok, makes sense.

> >
> >> +	sata0: sata at 00300000 {
> >> +		compatible = "snps,dwc-ahci";
> >> +		reg = <0 0x300000 0 0x800>;
> >> +		interrupts = <0 355 4>;
> >> +		clocks = <&sataclk_333mhz>;
> >> +		clock-names = "apb_pclk";
> >> +		dma-coherent;
> >> +	};
> >
> > Same here: you list it as coherent, but not 64-bit DMA capable.
> > Is that intentional?
> 
> Correct me if I am wrong, but I didn't think that we need to specify
> here since the AHCI platform driver determines the DMA bitness by
> checking struct ahci_host_priv.cap for HOST_CAP_64 (see
> drivers/ata/libahci_platform.c).

No, the actual DMA mask that gets used is the combination of what
the device claims to support and what the bus can do. Without the
dma-ranges property, the bus will be seen as 32-bit only, so we won't
allow high DMA transfers for devices that can do it.

This is the same way we have to treat any PCI device as well, since
a lot of PCI devices can do 64-bit DMA, but they can also be connected
to a pci host bridge that sits on a 32-bit bus and has no supported
IOMMU.

> However, based on the conversation on the IRC, I?ll add the dma-ranges
> in the motherboard level.

Ok.

> >
> >> +	i2c at 1000000 {
> >> +		compatible = "snps,designware-i2c";
> >> +		reg = <0 0x01000000 0 0x1000>;
> >> +		interrupts = <0 357 4>;
> >> +		clocks = <&uartspiclk_100mhz>;
> >> +		clock-names = "apb_pclk";
> >> +	};
> >> +
> >> +	serial0: serial at 1010000 {
> >> +		compatible = "arm,pl011", "arm,primecell";
> >> +		reg = <0 0x1010000 0 0x1000>;
> >> +		interrupts = <0 328 4>;
> >> +		clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
> >> +		clock-names = "uartclk", "apb_pclk";
> >> +	};
> >> +
> >> +	ssp at 1020000 {
> >> +		compatible = "arm,pl022", "arm,primecell";
> >> +		#gpio-cells = <2>;
> >> +		reg = <0 0x1020000 0 0x1000>;
> >> +		spi-controller;
> >> +		interrupts = <0 330 4>;
> >> +		clocks = <&uartspiclk_100mhz>;
> >> +		clock-names = "apb_pclk";
> >> +	};
> >
> > Should these three be connected to the DMA engine?
> 
> It doesn't do DMA. Only PCI devices, XGBE, and SATA do DMA.

What is the pl330 connected to then? It's very common for pl011
and pl022 to be used in combination with a pl330 in order to
do DMA.

> >> +	pcie0: pcie-controller{
> >> +		compatible = "pci-host-ecam-generic";
> >> +		#address-cells = <3>;
> >> +		#size-cells = <2>;
> >> +		device_type = "pci";
> >> +		bus-range = <0 0xff>;
> >> +		reg = <0 0xf0000000 0 0x10000000>;
> >> +		dma-coherent;
> >> +		msi-parent = <&v2m0>;
> >
> > This surely needs a dma-ranges property to allow larger than 32-bit DMA.
> 
> So, I assume this will also need dma-range handling code to be added to
> the PCI generic host driver.

Yes, good point.


> I will made the changes accordingly.

thanks,

	Arnd
