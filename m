From: madalin.bucur@nxp.com (Madalin-Cristian Bucur)
Date: Wed, 22 Mar 2017 10:58:12 +0000
Subject: [PATCH v2 1/2] dts: arm64: add LS1043A DPAA support
In-Reply-To: <20170314070732.GH3618@dragon>
References: <1488382505-17554-1-git-send-email-madalin.bucur@nxp.com>
 <1488382505-17554-2-git-send-email-madalin.bucur@nxp.com>
 <20170314070732.GH3618@dragon>
Message-ID: <HE1PR04MB11297D944241012F44C0ADF8EC3C0@HE1PR04MB1129.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Tuesday, March 14, 2017 9:08 AM
> On Wed, Mar 01, 2017 at 05:35:04PM +0200, Madalin Bucur wrote:
> > Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> 
> Empty commit log is generally not welcome, especially when the commit
> adds so many files.

Hi Shawn, thank you for your time. I'll split this into several separate
patches, with better commit logs.

> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi | 41 +++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |  2 +
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  | 75
> ++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 73
> +++++++++++++++++++-
> >  .../boot/dts/freescale/qoriq-bman1-portals.dtsi    | 67
> ++++++++++++++++++
> >  .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    | 42 ++++++++++++
> >  .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     | 41 +++++++++++
> >  .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     | 41 +++++++++++
> >  .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     | 41 +++++++++++
> >  .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     | 41 +++++++++++
> >  .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     | 41 +++++++++++
> >  .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi     | 41 +++++++++++
> >  arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   | 80
> ++++++++++++++++++++++
> >  .../boot/dts/freescale/qoriq-qman1-portals.dtsi    | 76
> ++++++++++++++++++++
> >  14 files changed, 701 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman1-
> portals.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-
> 0.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-
> 0.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-
> 1.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-
> 2.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-
> 3.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-
> 4.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-
> 5.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman1-
> portals.dtsi
> 
> I'm not comfortable with so many and complex include level.  Can you
> please elaborate it a bit and help us understand the necessity of doing
> that?

The DPAA (Data Path Acceleration Architecture) 1.x was first introduced
on PowerPC QorIQ devices, where it was included in more than ten SoCs,
each with its own particular implementation of it. There are SoCs that
implement one FMan, others with two, some have none, some have one or
two 10G ports. In order to allow reuse and reduce redundancy, the DPAA
PPC component nodes were split into separate files a long time ago.
I'm just carrying over this layout to the DPAA 1.x ARM platforms.

> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
> > new file mode 100644
> > index 0000000..bf443d2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
> > @@ -0,0 +1,41 @@
> > +/*
> > + * QorIQ FMan v3 device tree nodes for ls1043
> > + *
> > + * Copyright 2015-2016 Freescale Semiconductor Inc.
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > + */
> 
> It's still controversial whether we should use SPDX tag.
> 
> https://lkml.org/lkml/2017/2/28/750
>

We're already making use of SPDX tags for u-boot updates and
internally this was accepted already. The remaining question is
if the SPDX tag use is or is not welcome in the kernel tree.

> > +
> > +&soc {
> > +
> > +/include/ "qoriq-fman3-0.dtsi"
> > +/include/ "qoriq-fman3-0-1g-0.dtsi"
> > +/include/ "qoriq-fman3-0-1g-1.dtsi"
> > +/include/ "qoriq-fman3-0-1g-2.dtsi"
> > +/include/ "qoriq-fman3-0-1g-3.dtsi"
> > +/include/ "qoriq-fman3-0-1g-4.dtsi"
> > +/include/ "qoriq-fman3-0-1g-5.dtsi"
> > +/include/ "qoriq-fman3-0-10g-0.dtsi"
> 
> We usually put the includes at the beginning of the file, and #include
> is more recommended than /include/.

I'm not making use of the header file inclusion feature #include provides
(nor plan to) in these files thus I've selected /include/ here.

> > +	fman at 1a00000 {
> > +		enet0: ethernet at e0000 {
> > +		};
> > +
> > +		enet1: ethernet at e2000 {
> > +		};
> > +
> > +		enet2: ethernet at e4000 {
> > +		};
> > +
> > +		enet3: ethernet at e6000 {
> > +		};
> > +
> > +		enet4: ethernet at e8000 {
> > +		};
> > +
> > +		enet5: ethernet at ea000 {
> > +		};
> > +
> > +		enet6: ethernet at f0000 {
> > +		};
> > +	};
> 
> I do not quite understand why these nodes are empty.

These nodes provide the aliases (and custom SoC mapping) for the
FMan ports that are used on this particular SoC. The particular
node details are found in the port dtsi file thus no information
is required here. Given the fact that the numbering and actual
ports that are in use can vary between SoCs, the aliases cannot
be included in the port dtsi nor in the FMan dtsi.

> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > index 0989d63..ee66bb2 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > @@ -181,3 +181,5 @@
> >  		reg = <0>;
> >  	};
> >  };
> > +
> > +/include/ "fsl-ls1043-post.dtsi"
> 
> Move it to header of the file.

This is to be included at the end, to make sure the references are
met and to allow overrides if needed.

> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> > index c37110b..d94f003 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> > @@ -139,3 +139,78 @@
> >  &duart1 {
> >  	status = "okay";
> >  };
> > +
> > +/include/ "fsl-ls1043-post.dtsi"
> > +
> 
> Ditto
> 
> > +&soc {
> > +	fman at 1a00000 {
> > +		ethernet at e0000 {
> 
> You defined enet0 label.  Why don't you use it?
>

The enet0 label is used by u-boot for fix-ups, providing the
actual offset here makes it easier to follow.

> > +			phy-handle = <&qsgmii_phy1>;
> > +			phy-connection-type = "qsgmii";
> > +		};
> > +
> > +		ethernet at e2000 {
> > +			phy-handle = <&qsgmii_phy2>;
> > +			phy-connection-type = "qsgmii";
> > +		};
> > +
> > +		ethernet at e4000 {
> > +			phy-handle = <&rgmii_phy1>;
> > +			phy-connection-type = "rgmii";
> > +		};
> > +
> > +		ethernet at e6000 {
> > +			phy-handle = <&rgmii_phy2>;
> > +			phy-connection-type = "rgmii";
> > +		};
> > +
> > +		ethernet at e8000 {
> > +			phy-handle = <&qsgmii_phy3>;
> > +			phy-connection-type = "qsgmii";
> > +		};
> > +
> > +		ethernet at ea000 {
> > +			phy-handle = <&qsgmii_phy4>;
> > +			phy-connection-type = "qsgmii";
> > +		};
> > +
> > +		ethernet at f0000 { /* 10GEC1 */
> > +			phy-handle = <&aqr105_phy>;
> > +			phy-connection-type = "xgmii";
> > +		};
> > +
> > +		mdio at fc000 {
> 
> Use label reference the node you already define, so that you do not have
> to maintain the device tree hierarchy for referencing the node.
> 
> > +			rgmii_phy1: ethernet-phy at 1 {
> > +				reg = <0x1>;
> > +			};
> > +
> > +			rgmii_phy2: ethernet-phy at 2 {
> > +				reg = <0x2>;
> > +			};
> > +
> > +			qsgmii_phy1: ethernet-phy at 3 {
> > +				reg = <0x4>;
> 
> The unit address in the node name should match 'reg' value.

This needs to be addressed.

> > +			};
> > +
> > +			qsgmii_phy2: ethernet-phy at 4 {
> > +				reg = <0x5>;
> > +			};
> > +
> > +			qsgmii_phy3: ethernet-phy at 5 {
> > +				reg = <0x6>;
> > +			};
> > +
> > +			qsgmii_phy4: ethernet-phy at 6 {
> > +				reg = <0x7>;
> > +			};
> > +		};
> > +
> > +		mdio at fd000 {
> > +			aqr105_phy: ethernet-phy at c {
> > +				compatible = "ethernet-phy-ieee802.3-c45";
> > +				interrupts = <0 132 4>;
> > +				reg = <0x1>;
> > +			};
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > index ec13a6e..ac1e0af 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > @@ -52,6 +52,17 @@
> >  	#address-cells = <2>;
> >  	#size-cells = <2>;
> >
> > +	aliases {
> > +		fman0 = &fman0;
> > +		ethernet0 = &enet0;
> > +		ethernet1 = &enet1;
> > +		ethernet2 = &enet2;
> > +		ethernet3 = &enet3;
> > +		ethernet4 = &enet4;
> > +		ethernet5 = &enet5;
> > +		ethernet6 = &enet6;
> > +	};
> > +
> >  	cpus {
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > @@ -106,6 +117,36 @@
> >  		      /* DRAM space 1, size: 2GiB DRAM */
> >  	};
> >
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		bman_fbpr: bman-fbpr {
> > +			size = <0 0x1000000>;
> > +			alignment = <0 0x1000000>;
> > +		};
> > +
> > +		qman_fqd: qman-fqd {
> > +			size = <0 0x400000>;
> > +			alignment = <0 0x400000>;
> > +		};
> > +
> > +		qman_pfdr: qman-pfdr {
> > +			size = <0 0x2000000>;
> > +			alignment = <0 0x2000000>;
> > +		};
> > +	};
> > +
> > +	bportals: bman-portals at 508000000 {
> > +		ranges = <0x0 0x5 0x08000000 0x8000000>;
> > +	};
> > +
> > +	qportals: qman-portals at 500000000 {
> > +		ranges = <0x0 0x5 0x00000000 0x8000000>;
> > +	};
> 
> Why are these two devices directly under root, not soc node?

We'll look into this during the patch split.

> > +
> > +
> >  	sysclk: sysclk {
> >  		compatible = "fixed-clock";
> >  		#clock-cells = <0>;
> > @@ -152,7 +193,7 @@
> >  		interrupts = <1 9 0xf08>;
> >  	};
> >
> > -	soc {
> > +	soc: soc {
> >  		compatible = "simple-bus";
> >  		#address-cells = <2>;
> >  		#size-cells = <2>;
> > @@ -333,6 +374,18 @@
> >  			};
> >  		};
> >
> > +		qman: qman at 1880000 {
> > +			compatible = "fsl,qman";
> > +			reg = <0x00 0x1880000 0x0 0x10000>;
> > +			interrupts = <0 45 0x4>;
> > +		};
> > +
> > +		bman: bman at 1890000 {
> > +			compatible = "fsl,bman";
> > +			reg = <0x00 0x1890000 0x0 0x10000>;
> > +			interrupts = <0 45 0x4>;
> > +		};
> > +
> >  		dspi0: dspi at 2100000 {
> >  			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-
> dspi";
> >  			#address-cells = <1>;
> > @@ -686,3 +739,21 @@
> >  	};
> >
> >  };
> > +
> > +&bman_fbpr {
> > +	compatible = "fsl,bman-fbpr";
> > +	alloc-ranges = <0 0 0x10000 0>;
> > +};
> > +
> > +&qman_fqd {
> > +	compatible = "fsl,qman-fqd";
> > +	alloc-ranges = <0 0 0x10000 0>;
> > +};
> > +
> > +&qman_pfdr {
> > +	compatible = "fsl,qman-pfdr";
> > +	alloc-ranges = <0 0 0x10000 0>;
> > +};
> 
> Why do you need to separate these from the nodes in reserved-memory?
> 
> I stop right here.  Honestly, I do not like the patch as its current
> form.  I guess you should do something to make the reviewing of the
> changes a bit easier.
> 
> Shawn

These will be moved there. The new patch set will allow easier reviewing
by splitting the changes into multiple patches.

Madalin
