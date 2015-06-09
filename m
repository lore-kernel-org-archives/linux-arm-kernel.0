From: lee@kernel.org (Lee Jones)
Date: Tue, 9 Jun 2015 11:03:26 +0100
Subject: [PATCH v3 1/7] dt/bindings: Add binding for the Raspberry Pi
 clock provider
In-Reply-To: <1433807940-15328-1-git-send-email-eric@anholt.net>
References: <1433807940-15328-1-git-send-email-eric@anholt.net>
Message-ID: <20150609100326.GQ2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If I were the Clock Maintainer, I would have probably missed this
patch.  You _must_ intimate which subsystem you are submitting to.

> The hardware clocks are not controllable by the ARM, so we have to
> make requests to the firmware to do so from the VPU side.  This will
> let us replace fixed clocks in our DT with actual clock control (and
> correct frequency information).
> 
> v2: Include the dt-bindings header in this commit instead of the next
>     one.  Make the clock indices match the firmware clock IDs.  Rename
>     the binding's compat string.  Move the firmware phandle to be
>     under a vendor-specific namespace.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../clock/raspberrypi,bcm2835-firmware-clocks.txt  | 25 ++++++++++++++++++++++
>  include/dt-bindings/clk/raspberrypi.h              | 23 ++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,bcm2835-firmware-clocks.txt
>  create mode 100644 include/dt-bindings/clk/raspberrypi.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,bcm2835-firmware-clocks.txt b/Documentation/devicetree/bindings/clock/raspberrypi,bcm2835-firmware-clocks.txt
> new file mode 100644
> index 0000000..0972602
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/raspberrypi,bcm2835-firmware-clocks.txt
> @@ -0,0 +1,25 @@
> +Raspberry Pi firmware clock provider.
> +
> +The Raspberry Pi architecture doesn't provide direct access to the
> +CLOCKMAN peripheral from the ARM side, so Linux has to make requests
> +to the VPU firmware to program them.
> +
> +This binding uses the common clock binding:
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible:		Should be "raspberrypi,bcm2835-firmware-clocks"
> +
> +- #clock-cells:		Shall have value <1>.  The permitted clock-specifier
> +			  values can be found in
> +			  include/dt-bindings/clk/raspberrypi.h.
> +
> +- raspberrypi,firmware:	Phandle to the firmware driver node.

I think 'firmware' is a candidate for a generic phandle name.

Apart from that, binding looks pretty inert:

Acked-by: Lee Jones <lee@kernel.org>

> +Example:
> +
> +firmware_clocks: firmware-clocks {
> +	compatible = "raspberrypi,bcm2835-firmware-clocks";
> +	#clock-cells = <1>;
> +	raspberrypi,firmware = <&firmware>;
> +};
> diff --git a/include/dt-bindings/clk/raspberrypi.h b/include/dt-bindings/clk/raspberrypi.h
> new file mode 100644
> index 0000000..ceec90f
> --- /dev/null
> +++ b/include/dt-bindings/clk/raspberrypi.h
> @@ -0,0 +1,23 @@
> +#/*
> + *  Copyright ? 2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_RASPBERRYPI_H
> +#define _DT_BINDINGS_CLK_RASPBERRYPI_H
> +
> +#define RPI_CLOCK_EMMC	1
> +#define RPI_CLOCK_UART0	2
> +#define RPI_CLOCK_ARM	3
> +#define RPI_CLOCK_CORE	4
> +#define RPI_CLOCK_V3D	5
> +#define RPI_CLOCK_H264	6
> +#define RPI_CLOCK_ISP	7
> +#define RPI_CLOCK_SDRAM	8
> +#define RPI_CLOCK_PIXEL	9
> +#define RPI_CLOCK_PWM	10
> +
> +#endif
