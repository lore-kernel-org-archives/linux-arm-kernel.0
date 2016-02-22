From: robh@kernel.org (Rob Herring)
Date: Sun, 21 Feb 2016 20:53:53 -0600
Subject: [PATCH] irqchip: irq-mvebu-odmi: new driver
In-Reply-To: <1455522162-16425-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455522162-16425-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160222025353.GD15973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 08:42:42AM +0100, Thomas Petazzoni wrote:
> This commits adds a new irqchip driver that handles the ODMI
> controller found on Marvell 7K/8K processors. The ODMI controller
> provide MSI interrupt functionality to on-board peripherals, much like
> the GIC-v2m.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../marvell,odmi-controller.txt                    |  36 +++
>  drivers/irqchip/Kconfig                            |   4 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-mvebu-odmi.c                   | 270 +++++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
>  create mode 100644 drivers/irqchip/irq-mvebu-odmi.c
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
> new file mode 100644
> index 0000000..a2470af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
> @@ -0,0 +1,36 @@
> +
> +* Marvell ODMI for MSI support
> +
> +Some Marvell SoCs have an On-Die Message Interrupt (ODMI) controller
> +which can be used by on-board peripheral for MSI interrupts.
> +
> +Required properties:
> +
> +- compatible	       : The value here should contain "marvell,odmi-controller".

SoC specific compatible too please.

> +
> +- interrupt,controller : Identifies the node as an interrupt controller.
> +
> +- msi-controller       : Identifies the node as an MSI controller.
> +
> +- marvell,odmi-frames  : Number of ODMI frames available. Each frame
> +                         provides a number of events.
> +
> +- reg		       : List of register definitions, one for each
> +                         ODMI frame.
> +
> +- marvell,spi-base     : List of GIC base SPI interrupts, one for each
> +                         ODMI frame.

Why not "interrupts" property?

> +
> +Example:
> +
> +	odmi: odmi at 300000 {
> +		compatible = "marvell,odmi-controller";
> +		interrupt-controller;
> +		msi-controller;
> +		marvell,odmi-frames = <4>;
> +		reg = <0x300000 0x4000>,
> +		      <0x304000 0x4000>,
> +		      <0x308000 0x4000>,
> +		      <0x30C000 0x4000>;
> +		marvell,spi-base = <128>, <136>, <144>, <152>;
> +	};
