From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 Jan 2013 12:57:43 -0500
Subject: [PATCH v3] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <1358174852-19752-1-git-send-email-florian@openwrt.org>
References: <3816648.2TVsTiMOWx@bender>
 <1358174852-19752-1-git-send-email-florian@openwrt.org>
Message-ID: <20130131175743.GF7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian,

On Mon, Jan 14, 2013 at 03:47:32PM +0100, Florian Fainelli wrote:
> This patch adds the DTS file to support the Marvell RD-A370-A1
> (Reference Design board) also known as RD-88F6710 board. It is almost
> entirely similar to the DB-A370 except on the following points:
> 
> - second Ethernet MAC is connected to a switch using RGMII
> - it only has 512MB of physical RAM
> - SDIO interface is enabled and working by default (no need for jumpers)
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Jason,
> 
> This is rebased against your mvebu/for-next branch, can you please drop v2 of
> the previous patch and take this one instead? Thanks!
> 
> Changes since v2:
> - rebased against Jason's mvebu/for-next
> - added SDIO bindings
> - changed commit message a bit

This breaks badly as sdio bindings aren't added until mvebu/dt.  Since
this is a new board, it goes in *before* mvebu/dt (mvebu/boards).  I'm
going to go ahead and pull v2 instead as there seems to be no
significant difference other than mvsdio being added.

If you want to get sdio support in for v3.9, please submit a separate
patch on top of your v2.

thx,

Jason.

> 
> Changes since v1:
> - added missing entry in arch/arm/boot/dts/Makefile to actually build the DTB
> 
>  arch/arm/boot/dts/Makefile          |    1 +
>  arch/arm/boot/dts/armada-370-rd.dts |   68 +++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
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
> index 0000000..f8e4855
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-370-rd.dts
> @@ -0,0 +1,68 @@
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
> +
> +		mvsdio at d00d4000 {
> +			pinctrl-0 = <&sdio_pins1>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +			/* No CD or WP GPIOs */
> +		};
> +	};
> +};
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
