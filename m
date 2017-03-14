From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Mar 2017 15:07:34 +0800
Subject: [PATCH v2 1/2] dts: arm64: add LS1043A DPAA support
In-Reply-To: <1488382505-17554-2-git-send-email-madalin.bucur@nxp.com>
References: <1488382505-17554-1-git-send-email-madalin.bucur@nxp.com>
 <1488382505-17554-2-git-send-email-madalin.bucur@nxp.com>
Message-ID: <20170314070732.GH3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 05:35:04PM +0200, Madalin Bucur wrote:
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>

Empty commit log is generally not welcome, especially when the commit
adds so many files.

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi | 41 +++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |  2 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  | 75 ++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 73 +++++++++++++++++++-
>  .../boot/dts/freescale/qoriq-bman1-portals.dtsi    | 67 ++++++++++++++++++
>  .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    | 42 ++++++++++++
>  .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     | 41 +++++++++++
>  .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     | 41 +++++++++++
>  .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     | 41 +++++++++++
>  .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     | 41 +++++++++++
>  .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     | 41 +++++++++++
>  .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi     | 41 +++++++++++
>  arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   | 80 ++++++++++++++++++++++
>  .../boot/dts/freescale/qoriq-qman1-portals.dtsi    | 76 ++++++++++++++++++++
>  14 files changed, 701 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi

I'm not comfortable with so many and complex include level.  Can you
please elaborate it a bit and help us understand the necessity of doing
that?

> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
> new file mode 100644
> index 0000000..bf443d2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * QorIQ FMan v3 device tree nodes for ls1043
> + *
> + * Copyright 2015-2016 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */

It's still controversial whether we should use SPDX tag.

https://lkml.org/lkml/2017/2/28/750

> +
> +&soc {
> +
> +/include/ "qoriq-fman3-0.dtsi"
> +/include/ "qoriq-fman3-0-1g-0.dtsi"
> +/include/ "qoriq-fman3-0-1g-1.dtsi"
> +/include/ "qoriq-fman3-0-1g-2.dtsi"
> +/include/ "qoriq-fman3-0-1g-3.dtsi"
> +/include/ "qoriq-fman3-0-1g-4.dtsi"
> +/include/ "qoriq-fman3-0-1g-5.dtsi"
> +/include/ "qoriq-fman3-0-10g-0.dtsi"

We usually put the includes at the beginning of the file, and #include
is more recommended than /include/.

> +	fman at 1a00000 {
> +		enet0: ethernet at e0000 {
> +		};
> +
> +		enet1: ethernet at e2000 {
> +		};
> +
> +		enet2: ethernet at e4000 {
> +		};
> +
> +		enet3: ethernet at e6000 {
> +		};
> +
> +		enet4: ethernet at e8000 {
> +		};
> +
> +		enet5: ethernet at ea000 {
> +		};
> +
> +		enet6: ethernet at f0000 {
> +		};
> +	};

I do not quite understand why these nodes are empty.

> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> index 0989d63..ee66bb2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> @@ -181,3 +181,5 @@
>  		reg = <0>;
>  	};
>  };
> +
> +/include/ "fsl-ls1043-post.dtsi"

Move it to header of the file.

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> index c37110b..d94f003 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> @@ -139,3 +139,78 @@
>  &duart1 {
>  	status = "okay";
>  };
> +
> +/include/ "fsl-ls1043-post.dtsi"
> +

Ditto

> +&soc {
> +	fman at 1a00000 {
> +		ethernet at e0000 {

You defined enet0 label.  Why don't you use it?

> +			phy-handle = <&qsgmii_phy1>;
> +			phy-connection-type = "qsgmii";
> +		};
> +
> +		ethernet at e2000 {
> +			phy-handle = <&qsgmii_phy2>;
> +			phy-connection-type = "qsgmii";
> +		};
> +
> +		ethernet at e4000 {
> +			phy-handle = <&rgmii_phy1>;
> +			phy-connection-type = "rgmii";
> +		};
> +
> +		ethernet at e6000 {
> +			phy-handle = <&rgmii_phy2>;
> +			phy-connection-type = "rgmii";
> +		};
> +
> +		ethernet at e8000 {
> +			phy-handle = <&qsgmii_phy3>;
> +			phy-connection-type = "qsgmii";
> +		};
> +
> +		ethernet at ea000 {
> +			phy-handle = <&qsgmii_phy4>;
> +			phy-connection-type = "qsgmii";
> +		};
> +
> +		ethernet at f0000 { /* 10GEC1 */
> +			phy-handle = <&aqr105_phy>;
> +			phy-connection-type = "xgmii";
> +		};
> +
> +		mdio at fc000 {

Use label reference the node you already define, so that you do not have
to maintain the device tree hierarchy for referencing the node.

> +			rgmii_phy1: ethernet-phy at 1 {
> +				reg = <0x1>;
> +			};
> +
> +			rgmii_phy2: ethernet-phy at 2 {
> +				reg = <0x2>;
> +			};
> +
> +			qsgmii_phy1: ethernet-phy at 3 {
> +				reg = <0x4>;

The unit address in the node name should match 'reg' value.

> +			};
> +
> +			qsgmii_phy2: ethernet-phy at 4 {
> +				reg = <0x5>;
> +			};
> +
> +			qsgmii_phy3: ethernet-phy at 5 {
> +				reg = <0x6>;
> +			};
> +
> +			qsgmii_phy4: ethernet-phy at 6 {
> +				reg = <0x7>;
> +			};
> +		};
> +
> +		mdio at fd000 {
> +			aqr105_phy: ethernet-phy at c {
> +				compatible = "ethernet-phy-ieee802.3-c45";
> +				interrupts = <0 132 4>;
> +				reg = <0x1>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index ec13a6e..ac1e0af 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -52,6 +52,17 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		fman0 = &fman0;
> +		ethernet0 = &enet0;
> +		ethernet1 = &enet1;
> +		ethernet2 = &enet2;
> +		ethernet3 = &enet3;
> +		ethernet4 = &enet4;
> +		ethernet5 = &enet5;
> +		ethernet6 = &enet6;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -106,6 +117,36 @@
>  		      /* DRAM space 1, size: 2GiB DRAM */
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		bman_fbpr: bman-fbpr {
> +			size = <0 0x1000000>;
> +			alignment = <0 0x1000000>;
> +		};
> +
> +		qman_fqd: qman-fqd {
> +			size = <0 0x400000>;
> +			alignment = <0 0x400000>;
> +		};
> +
> +		qman_pfdr: qman-pfdr {
> +			size = <0 0x2000000>;
> +			alignment = <0 0x2000000>;
> +		};
> +	};
> +
> +	bportals: bman-portals at 508000000 {
> +		ranges = <0x0 0x5 0x08000000 0x8000000>;
> +	};
> +
> +	qportals: qman-portals at 500000000 {
> +		ranges = <0x0 0x5 0x00000000 0x8000000>;
> +	};

Why are these two devices directly under root, not soc node?

> +
> +
>  	sysclk: sysclk {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> @@ -152,7 +193,7 @@
>  		interrupts = <1 9 0xf08>;
>  	};
>  
> -	soc {
> +	soc: soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -333,6 +374,18 @@
>  			};
>  		};
>  
> +		qman: qman at 1880000 {
> +			compatible = "fsl,qman";
> +			reg = <0x00 0x1880000 0x0 0x10000>;
> +			interrupts = <0 45 0x4>;
> +		};
> +
> +		bman: bman at 1890000 {
> +			compatible = "fsl,bman";
> +			reg = <0x00 0x1890000 0x0 0x10000>;
> +			interrupts = <0 45 0x4>;
> +		};
> +
>  		dspi0: dspi at 2100000 {
>  			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
>  			#address-cells = <1>;
> @@ -686,3 +739,21 @@
>  	};
>  
>  };
> +
> +&bman_fbpr {
> +	compatible = "fsl,bman-fbpr";
> +	alloc-ranges = <0 0 0x10000 0>;
> +};
> +
> +&qman_fqd {
> +	compatible = "fsl,qman-fqd";
> +	alloc-ranges = <0 0 0x10000 0>;
> +};
> +
> +&qman_pfdr {
> +	compatible = "fsl,qman-pfdr";
> +	alloc-ranges = <0 0 0x10000 0>;
> +};

Why do you need to separate these from the nodes in reserved-memory?

I stop right here.  Honestly, I do not like the patch as its current
form.  I guess you should do something to make the reviewing of the
changes a bit easier.

Shawn

> +
> +/include/ "qoriq-qman1-portals.dtsi"
> +/include/ "qoriq-bman1-portals.dtsi"
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> new file mode 100644
> index 0000000..b007344
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> @@ -0,0 +1,67 @@
> +/*
> + * QorIQ BMan Portals device tree
> + *
> + * Copyright 2011-2016 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +&bportals {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "simple-bus";
> +
> +	bman-portal at 0 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x0 0x4000 0x4000000 0x4000>;
> +		interrupts = <0 173 0x4>;
> +	};
> +
> +	bman-portal at 10000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x10000 0x4000 0x4010000 0x4000>;
> +		interrupts = <0 175 0x4>;
> +	};
> +
> +	bman-portal at 20000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x20000 0x4000 0x4020000 0x4000>;
> +		interrupts = <0 177 0x4>;
> +	};
> +
> +	bman-portal at 30000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x30000 0x4000 0x4030000 0x4000>;
> +		interrupts = <0 179 0x4>;
> +	};
> +
> +	bman-portal at 40000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x40000 0x4000 0x4040000 0x4000>;
> +		interrupts = <0 181 0x4>;
> +	};
> +
> +	bman-portal at 50000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x50000 0x4000 0x4050000 0x4000>;
> +		interrupts = <0 183 0x4>;
> +	};
> +
> +	bman-portal at 60000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x60000 0x4000 0x4060000 0x4000>;
> +		interrupts = <0 185 0x4>;
> +	};
> +
> +	bman-portal at 70000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x70000 0x4000 0x4070000 0x4000>;
> +		interrupts = <0 187 0x4>;
> +	};
> +
> +	bman-portal at 80000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x80000 0x4000 0x4080000 0x4000>;
> +		interrupts = <0 189 0x4>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
> new file mode 100644
> index 0000000..ecdffe7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
> @@ -0,0 +1,42 @@
> +/*
> + * QorIQ FMan v3 10g port #0 device tree
> + *
> + * Copyright 2012-2015 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +fman at 1a00000 {
> +	fman0_rx_0x10: port at 90000 {
> +		cell-index = <0x10>;
> +		compatible = "fsl,fman-v3-port-rx";
> +		reg = <0x90000 0x1000>;
> +		fsl,fman-10g-port;
> +	};
> +
> +	fman0_tx_0x30: port at b0000 {
> +		cell-index = <0x30>;
> +		compatible = "fsl,fman-v3-port-tx";
> +		reg = <0xb0000 0x1000>;
> +		fsl,fman-10g-port;
> +	};
> +
> +	ethernet at f0000 {
> +		cell-index = <0x8>;
> +		compatible = "fsl,fman-memac";
> +		reg = <0xf0000 0x1000>;
> +		fsl,fman-ports = <&fman0_rx_0x10 &fman0_tx_0x30>;
> +		pcsphy-handle = <&pcsphy6>;
> +	};
> +
> +	mdio at f1000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xf1000 0x1000>;
> +
> +		pcsphy6: ethernet-phy at 0 {
> +			reg = <0x0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
> new file mode 100644
> index 0000000..d600786
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * QorIQ FMan v3 1g port #0 device tree
> + *
> + * Copyright 2012-2015 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +fman at 1a00000 {
> +	fman0_rx_0x08: port at 88000 {
> +		cell-index = <0x8>;
> +		compatible = "fsl,fman-v3-port-rx";
> +		reg = <0x88000 0x1000>;
> +	};
> +
> +	fman0_tx_0x28: port at a8000 {
> +		cell-index = <0x28>;
> +		compatible = "fsl,fman-v3-port-tx";
> +		reg = <0xa8000 0x1000>;
> +	};
> +
> +	ethernet at e0000 {
> +		cell-index = <0>;
> +		compatible = "fsl,fman-memac";
> +		reg = <0xe0000 0x1000>;
> +		fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
> +		ptp-timer = <&ptp_timer0>;
> +		pcsphy-handle = <&pcsphy0>;
> +	};
> +
> +	mdio at e1000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xe1000 0x1000>;
> +
> +		pcsphy0: ethernet-phy at 0 {
> +			reg = <0x0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
> new file mode 100644
> index 0000000..3c0b76d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * QorIQ FMan v3 1g port #1 device tree
> + *
> + * Copyright 2012-2015 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +fman at 1a00000 {
> +	fman0_rx_0x09: port at 89000 {
> +		cell-index = <0x9>;
> +		compatible = "fsl,fman-v3-port-rx";
> +		reg = <0x89000 0x1000>;
> +	};
> +
> +	fman0_tx_0x29: port at a9000 {
> +		cell-index = <0x29>;
> +		compatible = "fsl,fman-v3-port-tx";
> +		reg = <0xa9000 0x1000>;
> +	};
> +
> +	ethernet at e2000 {
> +		cell-index = <1>;
> +		compatible = "fsl,fman-memac";
> +		reg = <0xe2000 0x1000>;
> +		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
> +		ptp-timer = <&ptp_timer0>;
> +		pcsphy-handle = <&pcsphy1>;
> +	};
> +
> +	mdio at e3000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xe3000 0x1000>;
> +
> +		pcsphy1: ethernet-phy at 0 {
> +			reg = <0x0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
> new file mode 100644
> index 0000000..89633af
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * QorIQ FMan v3 1g port #2 device tree
> + *
> + * Copyright 2012-2015 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +fman at 1a00000 {
> +	fman0_rx_0x0a: port at 8a000 {
> +		cell-index = <0xa>;
> +		compatible = "fsl,fman-v3-port-rx";
> +		reg = <0x8a000 0x1000>;
> +	};
> +
> +	fman0_tx_0x2a: port at aa000 {
> +		cell-index = <0x2a>;
> +		compatible = "fsl,fman-v3-port-tx";
> +		reg = <0xaa000 0x1000>;
> +	};
> +
> +	ethernet at e4000 {
> +		cell-index = <2>;
> +		compatible = "fsl,fman-memac";
> +		reg = <0xe4000 0x1000>;
> +		fsl,fman-ports = <&fman0_rx_0x0a &fman0_tx_0x2a>;
> +		ptp-timer = <&ptp_timer0>;
> +		pcsphy-handle = <&pcsphy2>;
> +	};
> +
> +	mdio at e5000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xe5000 0x1000>;
> +
> +		pcsphy2: ethernet-phy at 0 {
> +			reg = <0x0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
> new file mode 100644
> index 0000000..87c2b70
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * QorIQ FMan v3 1g port #3 device tree
> + *
> + * Copyright 2012-2015 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +fman at 1a00000 {
> +	fman0_rx_0x0b: port at 8b000 {
> +		cell-index = <0xb>;
> +		compatible = "fsl,fman-v3-port-rx";
> +		reg = <0x8b000 0x1000>;
> +	};
> +
> +	fman0_tx_0x2b: port at ab000 {
> +		cell-index = <0x2b>;
> +		compatible = "fsl,fman-v3-port-tx";
> +		reg = <0xab000 0x1000>;
> +	};
> +
> +	ethernet at e6000 {
> +		cell-index = <3>;
> +		compatible = "fsl,fman-memac";
> +		reg = <0xe6000 0x1000>;
> +		fsl,fman-ports = <&fman0_rx_0x0b &fman0_tx_0x2b>;
> +		ptp-timer = <&ptp_timer0>;
> +		pcsphy-handle = <&pcsphy3>;
> +	};
> +
> +	mdio at e7000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xe7000 0x1000>;
> +
> +		pcsphy3: ethernet-phy at 0 {
> +			reg = <0x0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
> new file mode 100644
> index 0000000..8f4d74b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * QorIQ FMan v3 1g port #4 device tree
> + *
> + * Copyright 2012-2015 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +fman at 1a00000 {
> +	fman0_rx_0x0c: port at 8c000 {
> +		cell-index = <0xc>;
> +		compatible = "fsl,fman-v3-port-rx";
> +		reg = <0x8c000 0x1000>;
> +	};
> +
> +	fman0_tx_0x2c: port at ac000 {
> +		cell-index = <0x2c>;
> +		compatible = "fsl,fman-v3-port-tx";
> +		reg = <0xac000 0x1000>;
> +	};
> +
> +	ethernet at e8000 {
> +		cell-index = <4>;
> +		compatible = "fsl,fman-memac";
> +		reg = <0xe8000 0x1000>;
> +		fsl,fman-ports = <&fman0_rx_0x0c &fman0_tx_0x2c>;
> +		ptp-timer = <&ptp_timer0>;
> +		pcsphy-handle = <&pcsphy4>;
> +	};
> +
> +	mdio at e9000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xe9000 0x1000>;
> +
> +		pcsphy4: ethernet-phy at 0 {
> +			reg = <0x0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
> new file mode 100644
> index 0000000..d534f77
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * QorIQ FMan v3 1g port #5 device tree
> + *
> + * Copyright 2012-2015 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +fman at 1a00000 {
> +	fman0_rx_0x0d: port at 8d000 {
> +		cell-index = <0xd>;
> +		compatible = "fsl,fman-v3-port-rx";
> +		reg = <0x8d000 0x1000>;
> +	};
> +
> +	fman0_tx_0x2d: port at ad000 {
> +		cell-index = <0x2d>;
> +		compatible = "fsl,fman-v3-port-tx";
> +		reg = <0xad000 0x1000>;
> +	};
> +
> +	ethernet at ea000 {
> +		cell-index = <5>;
> +		compatible = "fsl,fman-memac";
> +		reg = <0xea000 0x1000>;
> +		fsl,fman-ports = <&fman0_rx_0x0d &fman0_tx_0x2d>;
> +		ptp-timer = <&ptp_timer0>;
> +		pcsphy-handle = <&pcsphy5>;
> +	};
> +
> +	mdio at eb000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xeb000 0x1000>;
> +
> +		pcsphy5: ethernet-phy at 0 {
> +			reg = <0x0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
> new file mode 100644
> index 0000000..a559441
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
> @@ -0,0 +1,80 @@
> +/*
> + * QorIQ FMan v3 device tree
> + *
> + * Copyright 2012-2015 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +fman0: fman at 1a00000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	cell-index = <0>;
> +	compatible = "fsl,fman";
> +	ranges = <0x0 0x00 0x1a00000 0x100000>;
> +	reg = <0x0 0x1a00000 0x0 0x100000>;
> +	interrupts = <0 44 0x4>, <0 45 0x4>;
> +	clocks = <&clockgen 3 0>;
> +	clock-names = "fmanclk";
> +	fsl,qman-channel-range = <0x800 0x10>;
> +
> +	muram at 0 {
> +		compatible = "fsl,fman-muram";
> +		reg = <0x0 0x60000>;
> +	};
> +
> +	fman0_oh_0x2: port at 82000 {
> +		cell-index = <0x2>;
> +		compatible = "fsl,fman-v3-port-oh";
> +		reg = <0x82000 0x1000>;
> +	};
> +
> +	fman0_oh_0x3: port at 83000 {
> +		cell-index = <0x3>;
> +		compatible = "fsl,fman-v3-port-oh";
> +		reg = <0x83000 0x1000>;
> +	};
> +
> +	fman0_oh_0x4: port at 84000 {
> +		cell-index = <0x4>;
> +		compatible = "fsl,fman-v3-port-oh";
> +		reg = <0x84000 0x1000>;
> +	};
> +
> +	fman0_oh_0x5: port at 85000 {
> +		cell-index = <0x5>;
> +		compatible = "fsl,fman-v3-port-oh";
> +		reg = <0x85000 0x1000>;
> +	};
> +
> +	fman0_oh_0x6: port at 86000 {
> +		cell-index = <0x6>;
> +		compatible = "fsl,fman-v3-port-oh";
> +		reg = <0x86000 0x1000>;
> +	};
> +
> +	fman0_oh_0x7: port at 87000 {
> +		cell-index = <0x7>;
> +		compatible = "fsl,fman-v3-port-oh";
> +		reg = <0x87000 0x1000>;
> +	};
> +
> +	mdio0: mdio at fc000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xfc000 0x1000>;
> +	};
> +
> +	xmdio0: mdio at fd000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> +		reg = <0xfd000 0x1000>;
> +	};
> +
> +	ptp_timer0: ptp-timer at fe000 {
> +		compatible = "fsl,fman-ptp-timer";
> +		reg = <0xfe000 0x1000>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi
> new file mode 100644
> index 0000000..4baec2c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi
> @@ -0,0 +1,76 @@
> +/*
> + * QorIQ QMan Portals device tree
> + *
> + * Copyright 2011-2016 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +&qportals {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "simple-bus";
> +
> +	qportal0: qman-portal at 0 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x0 0x4000 0x4000000 0x4000>;
> +		interrupts = <0 172 0x4>;
> +		cell-index = <0>;
> +	};
> +
> +	qportal1: qman-portal at 10000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x10000 0x4000 0x4010000 0x4000>;
> +		interrupts = <0 174 0x4>;
> +		cell-index = <1>;
> +	};
> +
> +	qportal2: qman-portal at 20000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x20000 0x4000 0x4020000 0x4000>;
> +		interrupts = <0 176 0x4>;
> +		cell-index = <2>;
> +	};
> +
> +	qportal3: qman-portal at 30000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x30000 0x4000 0x4030000 0x4000>;
> +		interrupts = <0 178 0x4>;
> +		cell-index = <3>;
> +	};
> +
> +	qportal4: qman-portal at 40000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x40000 0x4000 0x4040000 0x4000>;
> +		interrupts = <0 180 0x4>;
> +		cell-index = <4>;
> +	};
> +
> +	qportal5: qman-portal at 50000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x50000 0x4000 0x4050000 0x4000>;
> +		interrupts = <0 182 0x4>;
> +		cell-index = <5>;
> +	};
> +
> +	qportal6: qman-portal at 60000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x60000 0x4000 0x4060000 0x4000>;
> +		interrupts = <0 184 0x4>;
> +		cell-index = <6>;
> +	};
> +
> +	qportal7: qman-portal at 70000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x70000 0x4000 0x4070000 0x4000>;
> +		interrupts = <0 186 0x4>;
> +		cell-index = <7>;
> +	};
> +
> +	qportal8: qman-portal at 80000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x80000 0x4000 0x4080000 0x4000>;
> +		interrupts = <0 188 0x4>;
> +		cell-index = <8>;
> +	};
> +};
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
