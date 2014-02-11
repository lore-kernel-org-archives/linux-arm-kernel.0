From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 11 Feb 2014 18:01:25 +0100
Subject: [PATCH 2/2] ARM: shmobile: koelsch: add Ether DT support
In-Reply-To: <201402070114.27279.sergei.shtylyov@cogentembedded.com>
References: <201402070110.18561.sergei.shtylyov@cogentembedded.com>
 <201402070114.27279.sergei.shtylyov@cogentembedded.com>
Message-ID: <2679079.Rucv1O0jLA@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thanks a lot for the patch.

On Friday 07 February 2014 01:14:26 Sergei Shtylyov wrote:
> Define the Koelsch board dependent part of the Ether device node.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts |   31 +++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -2,7 +2,8 @@
>   * Device Tree Source for the Koelsch board
>   *
>   * Copyright (C) 2013 Renesas Electronics Corporation
> - * Copyright (C) 2013 Renesas Solutions Corp.
> + * Copyright (C) 2013-2014 Renesas Solutions Corp.
> + * Copyright (C) 2014 Cogent Embedded, Inc.
>   *
>   * This file is licensed under the terms of the GNU General Public License
>   * version 2.  This program is licensed "as is" without any warranty of any
> @@ -122,12 +123,40 @@
>  		renesas,function = "scif1";
>  	};
> 
> +	ether_pins: ether {
> +		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
> +		renesas,function = "eth";
> +	};
> +
> +	phy1_pins: phy1 {
> +		renesas,groups = "intc_irq0";
> +		renesas,function = "intc";
> +	};
> +
>  	qspi_pins: spi {
>  		renesas,groups = "qspi_ctrl", "qspi_data4";
>  		renesas,function = "qspi";
>  	};
>  };
> 
> +&ether {
> +	pinctrl-0 = <&ether_pins>;
> +	pinctrl-names = "default";
> +
> +	phy-handle = <&phy1>;
> +	renesas,ether-link-active-low;
> +	status = "ok";
> +
> +	phy1: ethernet-phy at 1 {
> +		reg = <1>;
> +		interrupt-parent = <&irqc0>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-0 = <&phy1_pins>;
> +		pinctrl-names = "default";

I think the PHY pins should be moved to the ethernet device. The reason for 
this is that the PHY device is discovered dynamically at runtime, and has thus 
no DT node associated with its struct device to control pinctrl automatically. 
This should probably be fixed, but in the meantime moving the PHY pins to the 
ethernet device should fix the problem.

As a last step we're missing a DT equivalent to our board code 
koelsch_ksz8041_fixup() workaround. Adding a property to specify LEDs usage to 
the PHY DT node shouldn't be difficult, but associating that node to the PHY 
device and handling the property in the PHY driver will require a bit of work. 
Is this on your to-do list ?

> +	};
> +};
> +
>  &sata0 {
>  	status = "okay";
>  };

-- 
Regards,

Laurent Pinchart
