From: jagdish.gediya@nxp.com (Jagdish Gediya)
Date: Thu, 6 Sep 2018 07:08:16 +0000
Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
In-Reply-To: <20180904144627.1de264b6@bbrezillon>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
 <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
 <20180904144627.1de264b6@bbrezillon>
Message-ID: <AM0PR04MB4052840603E71673747DFA7B90010@AM0PR04MB4052.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Currently FlexSPI controller is present in ARM SoC but NXP is coming with PowerPC SoC with same FlexSPI controller.

We are trying to use same binding as defined in this patch-set(tested on ARM64 processors) for PowerPC.
Unfortunately, It is showing issue when driver tries to parse 'fspi_mmap'.

We did some investigation and figured out that for ARM device trees Peripherals nodes inside 'soc' node have absolute addresses. For in general NXP's PowerPC device trees, Peripheral nodes have the relative addresses to the unit-address of the parent 'soc' node.  

This creates issue for PowerPC if we follow implementation in this patch-set. 

Example of device tree used for upcoming PowerPC SoC with FlexSPI controller.

soc at f8000000 {
	ranges = <0x0 0x0 0xf8000000 0x4000000>;
	.
	fspi0: flexspi at 20c0000 {
		compatible = "nxp,XXX-fspi";
		reg = <0x20c0000 0x10000>, <0xC0000000 0x10000000>;
		reg-names = "fspi_base", "fspi_mmap";
		.
		.
	}
 } 

As we can see, Final address of 'fspi_base' (0xf8000000 + 0x20c0000) falls into the parent 'soc' range(CCSR) but 
for 'fspi_mmap', It is outside of 'soc' range(CCSR). It creates issue when driver tries to parse 'fspi_mmap'.

As per definition of ranges, this field can't be used to solve this problem. 
Please suggest how to implement the "fspi_mmap"(memory mapping address and length) in case of PowerPC.

Thanks,
Jagdish

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org <linux-kernel-
> owner at vger.kernel.org> On Behalf Of Boris Brezillon
> Sent: Tuesday, September 4, 2018 6:16 PM
> To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd at lists.infradead.org; marek.vasut at gmail.com; linux-
> spi at vger.kernel.org; devicetree at vger.kernel.org; robh at kernel.org;
> mark.rutland at arm.com; shawnguo at kernel.org; linux-arm-
> kernel at lists.infradead.org; computersforpeace at gmail.com;
> frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
> driver
> 
> On Mon, 3 Sep 2018 09:54:08 +0000
> Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:
> 
> > Dear Yogesh,
> >
> > > -----Original Message-----
> > > From: linux-kernel-owner at vger.kernel.org <linux-kernel-
> > > owner at vger.kernel.org> On Behalf Of Yogesh Gaur
> > > Sent: Friday, August 31, 2018 4:00 PM
> > > To: linux-mtd at lists.infradead.org; boris.brezillon at bootlin.com;
> > > marek.vasut at gmail.com; linux-spi at vger.kernel.org;
> > > devicetree at vger.kernel.org
> > > Cc: robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org;
> > > linux- arm-kernel at lists.infradead.org; computersforpeace at gmail.com;
> > > frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org; Yogesh
> > > Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP
> > > FlexSPI driver
> > >
> > > Add binding file for NXP FlexSPI driver.
> > >
> > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > ---
> > >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42
> > > ++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-
> > > fspi.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > new file mode 100644
> > > index 0000000..9f07116
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > @@ -0,0 +1,42 @@
> > > +* NXP Flex Serial Peripheral Interface (FSPI)
> > > +
> > > +Required properties:
> > > +  - compatible : Should be "nxp,lx2160a-fspi"
> > > +  - reg :        First contains the register location and length,
> > > +                 Second contains the memory mapping address and
> > > +length
> >
> > Why are we overriding reg property.  Is there any special requirement.
> >
> > Can we use "reg" and "ranges" property in device tree.
> > Here "reg" represents controller registers and "ranges" represent the
> memory address of flash.
> 
> No, ranges is not used for that. It's used when you need to convert from one
> address space to another, which is not what you're describing here. Check
> section 2.38 of this document [1] for more details.
> 
> [1]https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fe
> linux.org%2Fimages%2Fc%2Fcf%2FPower_ePAPR_APPROVED_v1.1.pdf&amp;
> data=02%7C01%7Cjagdish.gediya%40nxp.com%7C5bdb57713bd4403a39e90
> 8d6126472a0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63671
> 6619958727753&amp;sdata=TB4mbWEm0opk58oPAVEOQFM0xeAFxCsqdzw
> 37BPuE3A%3D&amp;reserved=0
