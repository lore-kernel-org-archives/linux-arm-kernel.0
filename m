From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Jan 2013 13:51:42 +0100
Subject: [PATCH v2] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <3816648.2TVsTiMOWx@bender>
References: <1588881.pi23bvqp7D@bender> <3816648.2TVsTiMOWx@bender>
Message-ID: <50EEB95E.3070407@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 08:56 PM, Florian Fainelli wrote:
> This patch adds the DTS file to support the Marvell RD-A370-A1
> (Reference Design board) also known as RD-88F6710 board. It is almost
> entirely similar to the DB-A370 board except that the first Ethernet PHY
> is SGMII-wired and the second is a switch which is RGMII-wired.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Thomas, Cl?ment, as support for other peripherals gets merged, I will update
> this DTS file to reflect this. Thanks!
> 
> Changes since v1:
> - added missing entry in arch/arm/boot/dts/Makefile to actually build the DTB
> 
>  arch/arm/boot/dts/Makefile          |    1 +
>  arch/arm/boot/dts/armada-370-rd.dts |   61 +++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-370-rd.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b7246d6..7a75171 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>  	msm8960-cdp.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>  	armada-370-mirabox.dtb \
> +	armada-370-rd.dtb \
>  	armada-xp-db.dtb \
>  	armada-xp-openblocks-ax3-4.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
> diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
> new file mode 100644
> index 0000000..d62dfac
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-370-rd.dts
> @@ -0,0 +1,61 @@
> +/*
> + * Device Tree file for Marvell Armada 370 Reference Design board
> + * (RD-88F6710-A1)
> + *
> + *  Copied from arch/arm/boot/dts/armada-370-db.dts
> + *
> + *  Copyright (C) 2013 Florian Fainelli <florian@openwrt.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "armada-370.dtsi"
> +
> +/ {
> +	model = "Marvell Armada 370 Reference Design";
> +	compatible = "marvell,a370-rd", "marvell,armada370", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512 MB */
Hi Florian,

As you based your file on our (erroneous) dts, could you confirm that
the RD-A370-A1 board have "only" 512MB?

Thanks,

> +	};
> +
> +	soc {
> +		serial at d0012000 {
> +			clock-frequency = <200000000>;
> +			status = "okay";
> +		};
> +		sata at d00a0000 {
> +			nr-ports = <2>;
> +			status = "okay";
> +		};
> +
> +		mdio {
> +			phy0: ethernet-phy at 0 {
> +				reg = <0>;
> +			};
> +
> +			phy1: ethernet-phy at 1 {
> +				reg = <1>;
> +			};
> +		};
> +
> +		ethernet at d0070000 {
> +			status = "okay";
> +			phy = <&phy0>;
> +			phy-mode = "sgmii";
> +		};
> +		ethernet at d0074000 {
> +			status = "okay";
> +			phy = <&phy1>;
> +			phy-mode = "rgmii-id";
> +		};
> +	};
> +};
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
