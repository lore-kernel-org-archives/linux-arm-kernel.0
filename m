From: stefan@agner.ch (Stefan Agner)
Date: Mon, 22 May 2017 09:15:55 -0700
Subject: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <1495177545-23006-5-git-send-email-aisheng.dong@nxp.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <5e78ef100319f229a87e33804384e5b3@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-19 00:05, Dong Aisheng wrote:
> i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports,
> IOMUXC1 for A7 ports and IOMUXC DDR for DDR interface.
> 
> This patch adds the IOMUXC1 support for A7.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
> v1->v2:
>  * add more descriptions in binding doc
>  * add missed prefix for private properties.
>  * move dt-bindings/pinctrl/imx7ulp-pinfunc.h to arch/arm/boot/dts
> ---
>  .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       |  63 +++
>  arch/arm/boot/dts/imx7ulp-pinfunc.h                | 468 +++++++++++++++++++++
>  2 files changed, 531 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
>  create mode 100644 arch/arm/boot/dts/imx7ulp-pinfunc.h
> 
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
> new file mode 100644
> index 0000000..7fbf367
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
> @@ -0,0 +1,63 @@
> +* Freescale i.MX7ULP IOMUX Controller
> +
> +i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports, IOMUXC1 for A7
> +ports and IOMUXC DDR for DDR interface.
> +
> +Note:
> +This binding doc is only for the IOMUXC1 support in A7 Domain and it only
> +supports generic pin config.
> +
> +Please also refer to fsl,imx-pinctrl.txt in this directory for IMX common
> +binding part and pinctrl-bindings.txt for the generic config binding.
> +
> +=== Pin Controller Node ===
> +
> +Required properties:
> +- compatible:	"fsl,imx7ulp-iomuxc1"
> +- reg:		Should contain the base physical address and size of the iomuxc
> +		registers.
> +
> +=== Pin Configuration Node ===
> +- pins: One integers array, represents a group of pins mux setting.
> +	The format is fsl,pins = <PIN_FUNC_ID>, PIN_FUNC_ID is a pin working on
> +	a specific function.
> +
> +	NOTE: i.MX7ULP PIN_FUNC_ID consists of 4 integers as it shares one mux
> +	and config register as follows:
> +	<mux_conf_reg input_reg mux_mode input_val>
> +
> +	Refer to imx7ulp-pinfunc.h in in device tree source folder for all
> +	available imx7ulp PIN_FUNC_ID.
> +
> +Optional Properties:
> +- nxp,output-buffer-enable:	Bool. Output buffer enabled
> +- nxp,input-buffer-enable:	Bool. Input buffer enabled
> +- drive-strength		Integer. Controls Drive Strength
> +					0: Standard
> +					1: Hi Driver
> +- drive-push-pull		Bool. Enable Pin Push-pull
> +- drive-open-drain		Bool. Enable Pin Open-drian
> +- slew-rate:			Integer. Controls Slew Rate
> +					0: Standard
> +					1: Slow
> +- bias-disable:			Bool. Pull disabled
> +- bias-pull-down:		Bool. Pull down on pin
> +- bias-pull-up:			Bool. Pull up on pin
> +
> +Examples:
> +#include "imx7ulp-pinfunc.h"
> +
> +/* Pin Controller Node */
> +iomuxc1: iomuxc at 40ac0000 {
> +	compatible = "fsl,imx7ulp-iomuxc1";
> +	reg = <0x40ac0000 0x1000>;
> +
> +	/* Pin Configuration Node */
> +	pinctrl_lpuart4: lpuart4grp {
> +		pins = <
> +			ULP1_PAD_PTC3__LPUART4_RX
> +			ULP1_PAD_PTC2__LPUART4_TX
> +		>;
> +		bias-pull-up;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx7ulp-pinfunc.h
> b/arch/arm/boot/dts/imx7ulp-pinfunc.h
> new file mode 100644
> index 0000000..cafd3ed
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7ulp-pinfunc.h
> @@ -0,0 +1,468 @@
> +/*
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __DTS_IMX7ULP_PINFUNC_H
> +#define __DTS_IMX7ULP_PINFUNC_H
> +
> +/*
> + * The pin function ID is a tuple of
> + * <mux_conf_reg input_reg mux_mode input_val>
> + */
> +
> +#define ULP1_PAD_PTC0__PTC0                                      
> 0x0000 0x0000 0x1 0x0


For consistency with other SoCs, can we add MX7 to the define? E.g.
MX7ULP1?

--
Stefan
