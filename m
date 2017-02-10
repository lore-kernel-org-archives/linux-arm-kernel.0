From: robh@kernel.org (Rob Herring)
Date: Fri, 10 Feb 2017 09:43:54 -0600
Subject: [PATCH] reset: Add i.MX7 SRC reset driver
In-Reply-To: <20170206150836.10001-1-andrew.smirnov@gmail.com>
References: <20170206150836.10001-1-andrew.smirnov@gmail.com>
Message-ID: <20170210154354.nlcj2gq6dun7bc43@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 07:08:36AM -0800, Andrey Smirnov wrote:
> This driver exposes various reset faculties, impelented by System Reset
> Controller IP block, as a reset driver. Currently only PCIE related
> reset lines are implemented.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  47 +++++++
>  drivers/reset/Kconfig                              |   8 ++
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-imx7.c                         | 149 +++++++++++++++++++++
>  include/dt-bindings/reset/imx7-reset.h             |  28 ++++
>  5 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
>  create mode 100644 drivers/reset/reset-imx7.c
>  create mode 100644 include/dt-bindings/reset/imx7-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> new file mode 100644
> index 0000000..19a77f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> @@ -0,0 +1,47 @@
> +Freescale i.MX7 System Reset Controller
> +======================================
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: Should be "fsl,imx7-src", "syscon"

Doesn't match the example. This should be specific. I assume there's 
more than one i.MX7?

> +- reg: should be register base and length as documented in the
> +  datasheet
> +- interrupts: Should contain SRC interrupt
> +- #reset-cells: 1, see below
> +
> +example:
> +
> +src: src at 30390000 {

reset-controller at ...

> +     compatible = "fsl,imx7d-src", "syscon";
> +     reg = <0x30390000 0x10000>;

Really has 64KB of registers or that's just the block spacing. Assuming 
the actual size is smaller, you are eating up valuable lowmem space by 
mapping all 64KB.

> +     interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +     #reset-cells = <1>;
> +};
> +
> +
> +Specifying reset lines connected to IP modules
> +==============================================
> +
> +The system reset controller can be used to reset various set of
> +peripherals. Device nodes that need access to reset lines should
> +specify them as a reset phandle in their corresponding node as
> +specified in reset.txt.
> +
> +Example:
> +
> +	pcie: pcie at 0x33800000 {

Drop the 0x.

> +
> +		...
> +
> +		resets = <&src IMX7_RESET_PCIEPHY>,
> +			 <&src IMX7_RESET_PCIE_CTRL_APPS>;
> +		reset-names = "pciephy", "apps";
> +
> +		...
> +        };
> +
> +
> +For list of all valid reset indicies see
> +<dt-bindings/reset/imx7-reset.h>
