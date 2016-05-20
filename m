From: robh@kernel.org (Rob Herring)
Date: Fri, 20 May 2016 14:21:01 -0500
Subject: [PATCH] drivers: nvmem: atmel-secumod: New driver for Atmel
 Secumod nvram
In-Reply-To: <1463605564-14397-1-git-send-email-davidm@egauge.net>
References: <20160518164259.GA28954@rob-hp-laptop>
 <1463605564-14397-1-git-send-email-davidm@egauge.net>
Message-ID: <20160520192101.GA15615@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 03:06:04PM -0600, David Mosberger-Tang wrote:
> Signed-off-by: David Mosberger <davidm@egauge.net>
> ---
>  .../devicetree/bindings/nvmem/atmel-secumod.txt    |  47 +++++++
>  drivers/nvmem/Kconfig                              |   7 +
>  drivers/nvmem/Makefile                             |   2 +
>  drivers/nvmem/atmel-secumod.c                      | 143 +++++++++++++++++++++
>  4 files changed, 199 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
>  create mode 100644 drivers/nvmem/atmel-secumod.c
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
> new file mode 100644
> index 0000000..d65cad5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
> @@ -0,0 +1,47 @@
> += Atmel Secumod device tree bindings =
> +
> +This binding is intended to represent Atmel's Secumod which is found
> +in SAMA5D2 and perhaps others.
> +
> +Required properties:
> +- compatible: should be "atmel,sama5d2-secumod"
> +- reg: Should contain RAM location and length, followed
> +       by register location and length of the Secumod controller.
> +
> += Data cells =
> +Are child nodes of secumod, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +    secumod at fc040000 {

This unit-address should match the first reg address.

> +            compatible = "atmel,sama5d2-secumod";
> +            reg = <0xf8044000 0x1420>, <0xfc040000 0x4000>;
> +            reg-names = "SECURAM", "SECUMOD";
> +            status = "okay";
> +
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;

Sorry, to be clear, you need values here too.

> +
> +            secram-auto-erasable at 0 {
> +                    reg = <0x0000 0x1000>;

The 0 here is address 0xf8044000, right? So ranges is what is used to 
translate from child address of 0 to the parent address.

> +            };
> +            secram at 1000 {
> +                    reg = <0x1000 0x400>;
> +            };
> +            ram at 1400 {
> +                    reg = <0x1400 0x20>;
> +            };
> +    };
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +For example:
> +
> +	ram {
> +		...
> +		nvmem-cells = <&ram>;
> +		nvmem-cell-names = "RAM";
> +	};
