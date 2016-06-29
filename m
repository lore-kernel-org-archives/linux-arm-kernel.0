From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2016 17:24:10 +0200
Subject: [PATCH 2/6] ARM: dts: nuc900: Add nuc970 dts files
In-Reply-To: <1466851042-22239-3-git-send-email-vw@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-3-git-send-email-vw@iommu.org>
Message-ID: <4179493.MLDazV8SdP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 25, 2016 6:37:18 PM CEST Wan Zongshun wrote:
> This patch is to add dts support for nuc970 platform.
> 
> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
>  .../devicetree/bindings/arm/nuvoton/nuc970.txt     |  30 +++
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/nuc970-evb.dts                   |  20 ++
>  arch/arm/boot/dts/nuc970.dtsi                      |  93 ++++++++
>  include/dt-bindings/clock/nuc970-clock.h           | 233 +++++++++++++++++++++
>  5 files changed, 377 insertions(+)

I'd suggest splitting this into multiple patches: the binding, the dts files and the header.

> +Boards with the NUC970 SoC shall have the following properties:
> +
> +Root node required properties:
> +- compatible: Should be "nuvoton,nuc970evb", "nuvoton,nuc970"

Better don't mention "nuvoton,nuc970evb", as that is the board specific
identifier: we don't want to have to list every single board.

> +Timer required properties:
> +- compatible: Should be "nuvoton,tmr"
> +- reg: Should contain registers location and length
> +- interrupts: hwirq is direct mapping to irq number
> +- clocks: phandle to input clock.
> +
> +Clock required properties:
> +- compatible: Should be "nuvoton,clk"
> +- reg: Should contain registers location and length
> +
> +Interrupt-controller required properties
> +- compatible: Should be "nuvoton,aic"
> +- reg: Should contain registers location and length
> +- interrupt-cells: set to 1
> +
> +GCR register required properties:
> +- compatible: Should be "nuvoton,gcr"
> +- reg: Should contain registers location and length

These compatible strings are all very generic, and should contain the
SoC name.

> diff --git a/arch/arm/boot/dts/nuc970.dtsi b/arch/arm/boot/dts/nuc970.dtsi
> new file mode 100644
> index 0000000..8a6c225
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuc970.dtsi
> @@ -0,0 +1,93 @@
> +/*
> + * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include "skeleton.dtsi"
> +#include <dt-bindings/clock/nuc970-clock.h>
> +
> +/ {
> +	compatible = "nuvoton,nuc970evb", "nuvoton,nuc970";
> +
> +	interrupt-parent = <&aic>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	memory {
> +		reg = <0x00000000 0x04000000>;
> +	};

Better split this into SoC-specific and board-specific contents, the
aliases and memory should go into the board.dts file, along with the
alias for the serial port.

> +	ahb at B0000000 {

Don't capatilize the hexadecimal numbers.

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0xB0000000 0x9000>;
> +		ranges;

A simple-bus should not have a 'reg' property. You can have a 'ranges'
though, to translate the addresses in the child nodes.

	Arnd
