From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 31 Jan 2014 12:50:11 +0000
Subject: [PATCH 3/4] ARM: dts: Add support of STid127 Soc.
In-Reply-To: <1391093744-19905-4-git-send-email-patrice.chotard@st.com>
References: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
 <1391093744-19905-4-git-send-email-patrice.chotard@st.com>
Message-ID: <52EB9C03.70009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice,

On 30/01/14 14:55, Patrice CHOTARD wrote:
> From: Alexandre TORGUE <alexandre.torgue@st.com>
> 
> The STid127 integrates all harware components to function as a cable modem
s/harware/hardware/

s/STid127/STiD127

Please fix other instances too.

> or, in combination with a back end device, as a Gateway set top boxe.
s/boxe/box/
> 
> Supported devices:
> 	-UART0
> 	-UART2
> 
> Signed-off-by: alexandre torgue <alexandre.torgue@st.com>
> ---
>  arch/arm/boot/dts/stid127-clock.dtsi   |   31 ++++
>  arch/arm/boot/dts/stid127-pinctrl.dtsi |  245 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/stid127.dtsi         |  130 +++++++++++++++++
>  3 files changed, 406 insertions(+)
>  create mode 100644 arch/arm/boot/dts/stid127-clock.dtsi
>  create mode 100644 arch/arm/boot/dts/stid127-pinctrl.dtsi
>  create mode 100644 arch/arm/boot/dts/stid127.dtsi
> 
> diff --git a/arch/arm/boot/dts/stid127-clock.dtsi b/arch/arm/boot/dts/stid127-clock.dtsi
> new file mode 100644
> index 0000000..c6cafa9
> --- /dev/null
> +++ b/arch/arm/boot/dts/stid127-clock.dtsi
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (C) 2013 STMicroelectronics (R&D) Limited

2014

> + * Author(s): Giuseppe Cavallaro <peppe.cavallaro@st.com>
> + *	      Alexandre Torgue <alexandre.torgue@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/ {Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> +	clocks {
> +		/*
> +		 * ARM Peripheral clock for timers
> +		 */
> +		arm_periph_clk: arm_periph_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <100000000>;
> +		};
> +		/*
> +		 * Bootloader initialized system infrastructure clock for
> +		 * serial devices.
> +		 */
> +		CLK_IC_LP_HD: clockgenA0 at 29 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <100000000>;
> +			clock-output-names = "CLK_IC_LP_HD";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/stid127-pinctrl.dtsi b/arch/arm/boot/dts/stid127-pinctrl.dtsi
> new file mode 100644
> index 0000000..3fa66f3
> --- /dev/null
> +++ b/arch/arm/boot/dts/stid127-pinctrl.dtsi
> @@ -0,0 +1,245 @@
> +/*
> + * Copyright (C) 2012 STMicroelectronics Limited.

2014

> + * Author(s): Giuseppe Cavallaro <peppe.cavallaro@st.com>
> + *	      Alexandre Torgue <alexandre.torgue@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.

s/publishhed/published/

> + */
> +#include "st-pincfg.h"
> +/ {
> +	aliases {
> +		gpio0	= &PIO0;
> +		gpio1	= &PIO1;
> +		gpio2	= &PIO2;
> +		gpio3	= &PIO3;
> +		gpio4	= &PIO4;
> +		gpio5	= &PIO5;
> +		gpio6	= &PIO6;
> +		gpio7	= &PIO7;
> +		gpio8	= &PIO8;
> +		gpio9	= &PIO9;
> +		gpio10	= &PIO10;
> +		gpio11	= &PIO11;
> +		gpio12	= &PIO12;
> +		gpio13	= &PIO13;
> +		gpio14	= &PIO14;
> +		gpio15	= &PIO15;
> +		gpio16	= &PIO16;
> +		gpio17	= &PIO17;
> +		gpio18	= &PIO18;
> +		gpio19	= &PIO19;
> +		gpio20	= &PIO20;
> +		gpio21	= &PIO21;
> +		gpio22	= &PIO22;
> +
> +	};
> +
> +	soc {
> +		pin-controller-pwest {
> +			#address-cells	= <1>;
> +			#size-cells	= <1>;
> +			compatible	= "st,stid127-pwest-pinctrl";
> +			st,syscfg	= <&syscfg_pwest>;
> +			ranges		= <0 0xfebe0000 0x8000>;

Can you add interrupt controller support to the pin controller.

Patches are in : https://lkml.org/lkml/2014/1/16/342
All these patches are due to be in v3.15.

> +
> +			PIO0: gpio at febe0000 {
> +				gpio-controller;
> +				#gpio-cells = <1>;
> +				reg = <0 0x100>;
> +				interrupts =  <0 149 0>;
> +				st,bank-name  = "PIO0";
> +			};
> +						rx	= <&PIO3 0 ALT2	IN>;
> +					};
> +				};
> +			};
> +
> +		};
unnecessary empty line  here.

> diff --git a/arch/arm/boot/dts/stid127.dtsi b/arch/arm/boot/dts/stid127.dtsi
> new file mode 100644
> index 0000000..a6f0b8fe
> --- /dev/null
> +++ b/arch/arm/boot/dts/stid127.dtsi
> @@ -0,0 +1,130 @@
> +/*
> + * Copyright (C) 2013 STMicroelectronics Limited.
2014
> + * Author(s): Giuseppe Cavallaro <peppe.cavallaro@st.com>
> + *	      Alexandre Torgue <alexandre.torgue@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.

s/publishhed/published/

> + */
> +#include "stid127-pinctrl.dtsi"
> +#include "stid127-clock.dtsi"
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +		};
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <1>;
> +		};
> +	};
> +
> +	intc: interrupt-controller at fffe1000 {
> +		compatible = "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0xfffe1000 0x1000>,
> +		      <0xfffe0100 0x100>;
> +	};
> +
> +	scu at fffe0000 {
> +		compatible = "arm,cortex-a9-scu";
> +		reg = <0xfffe0000 0x1000>;
> +	};
> +
> +	timer at fffe0200 {
> +			interrupt-parent = <&intc>;
> +			compatible = "arm,cortex-a9-global-timer";
> +			reg = <0xfffe0200 0x100>;
> +			interrupts = <1 11 0x04>;
> +			clocks = <&arm_periph_clk>;

Fix the tab spacing here.

Thanks,
srini
> 
