From: robh@kernel.org (Rob Herring)
Date: Wed, 18 May 2016 11:42:59 -0500
Subject: [PATCH] drivers: nvmem: atmel-secumod: New driver for Atmel
 Secumod nvram
In-Reply-To: <1463429830-20539-1-git-send-email-davidm@egauge.net>
References: <alpine.LNX.2.00.1605121505320.21379@nippy.intranet>
 <1463429830-20539-1-git-send-email-davidm@egauge.net>
Message-ID: <20160518164259.GA28954@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 02:17:10PM -0600, David Mosberger-Tang wrote:
> Signed-off-by: David Mosberger <davidm@egauge.net>
> ---
>  .../devicetree/bindings/nvmem/atmel-secumod.txt    |  46 ++++++++
>  drivers/nvmem/atmel-secumod.c                      | 125 +++++++++++++++++++++
>  2 files changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
>  create mode 100644 drivers/nvmem/atmel-secumod.c
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
> new file mode 100644
> index 0000000..85db709
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
> @@ -0,0 +1,46 @@
> += Atmel Secumod device tree bindings =
> +
> +This binding is intended to represent Atmel's Secumod which is found
> +in SAMA5D2 and perhaps others.
> +
> +Required properties:
> +- compatible: should be "atmel,sama5d2-secumod"
> +- reg: Should contain registers location and length of the RAM, followed

registers or RAM location?

"Should contain RAM location and length, ..."

> +       by register location and length of the Secumod controller.
> +
> += Data cells =
> +Are child nodes of secumod, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +    secumod at fc040000 {
> +            compatible = "atmel,sama5d2-secumod";
> +            reg = <0xf8044000 0x1420
> +                   0xfc040000 0x4000>;

You are missing ranges property.

> +            status = "okay";
> +
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            secram_auto_erasable at 0000 {

Use '-' rather than '_' and drop leading 0s.

> +                    reg = <0x0000 0x1000>;
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
