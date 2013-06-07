From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 21:18:16 +0200
Subject: [PATCH 11/14] ARM: mvebu: Relocate Armada 370/XP DeviceBus device
 tree nodes
In-Reply-To: <1370623671-7748-12-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-12-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201306072118.16730.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Ezequiel Garcia wrote:
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -34,6 +34,51 @@
>                 compatible = "simple-bus";
>                 interrupt-parent = <&mpic>;
>  
> +               devbus-bootcs {
> +                       compatible = "marvell,mvebu-devbus";
> +                       reg = <0 0x10400 0x8>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&coreclk 0>;
> +                       status = "disabled";
> +               };
> +
...
>                internal-regs {
>                        compatible = "simple-bus";
>                        #address-cells = <1>;


I think you are missing a couple of things here:

* The mbus node needs #address-cells and #size-cells, and is no longer
  compatible="simple-bus"m since it's actually complex.

* The devbus-bootcs node and all other ones need "ranges" properties.

* The "reg" property of the devbus-bootcs device needs to be in
  mbus translated address space, so I assume the first cell would
  be something other than '0'.

* With the proposal I made for patch 3, you would actually
  need a ranges property for the mbus node as well.

	Arnd
