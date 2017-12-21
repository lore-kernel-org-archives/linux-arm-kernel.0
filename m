From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Dec 2017 17:19:05 -0600
Subject: [PATCH v2 4/5] ARM: dts: Add support for emtrion emCON-MX6 series
In-Reply-To: <20171220134710.64479-5-jan.tuerk@emtrion.com>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
 <20171220134710.64479-1-jan.tuerk@emtrion.com>
 <20171220134710.64479-5-jan.tuerk@emtrion.com>
Message-ID: <20171221231905.e3fmhhbkzzrha5jg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 02:47:04PM +0100, jan.tuerk at emtrion.com wrote:
> From: Jan Tuerk <jan.tuerk@emtrion.com>
> 
> This patch adds support for the emtrion GmbH emCON-MX6 modules.
> They are available with imx.6 Solo, Dual-Lite, Dual and Quad
> equipped with Memory from 512MB to 2GB (configured by U-Boot).
> 
> Our default developer-Kit ships with the Avari baseboard and the
> EDT ETM0700G0BDH6 Display (imx6[q|dl]-emcon-avari).
> 
> The devicetree is split into the common part providing all module
> components and the basic support for all SoC versions
> (imx6qdl-emcon.dtsi) and parts which are i.mx6 S|DL and D|Q relevant.
> Finally the support for the avari baseboard in the developer-kit
> configuration is provided by the emcon-avari dts files.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
> Changes in v2:
>  - Fixed typo (reg_prallel.. --> reg_parallel)
>  - Removed trailing new-line
>  - Fix uppercase addresses as Rob H. noted
>  - Fix warning about lcd at di0 -> rename to disp0
>  - Renamed some nodes regarding Rob H.
> 
>  Documentation/devicetree/bindings/arm/emtrion.txt |  13 +
>  arch/arm/boot/dts/Makefile                        |   2 +
>  arch/arm/boot/dts/imx6dl-emcon-avari.dts          | 233 ++++++
>  arch/arm/boot/dts/imx6dl-emcon.dtsi               |  37 +
>  arch/arm/boot/dts/imx6q-emcon-avari.dts           | 233 ++++++
>  arch/arm/boot/dts/imx6q-emcon.dtsi                |  37 +
>  arch/arm/boot/dts/imx6qdl-emcon.dtsi              | 848 ++++++++++++++++++++++
>  7 files changed, 1403 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
>  create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-emcon.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-emcon.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi

[...]

> +	captouch: touchscreen at 38 {
> +		reg = <0x38>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_irq_touch2 &pinctrl_emcon_gpio4>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> +		compatible = "edt,edt-ft5406";

Put compatible as the first property.

> +		wake-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> +		wakeup-source;
> +	};
> +};

[...]

> +&rgb_panel {
> +	compatible = "edt,etm0700g0bdh6";
> +	status = "okay";

Having compatible here is a bit strange and fragile. It's assuming 2 
different panels have the same common properties.


> diff --git a/arch/arm/boot/dts/imx6q-emcon.dtsi b/arch/arm/boot/dts/imx6q-emcon.dtsi
> new file mode 100644
> index 000000000000..64fc0cd74c05
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-emcon.dtsi
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2017 emtrion GmbH
> + * Author: Jan Tuerk  <jan.tuerk@emtrion.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html

You don't need this if...

> + *
> + * SPDX-License-Identifier: GPL-2.0

You have this.

Also, the rules around this are getting a bit stricter saying the SPDX 
tag should be the first line of the file using a C++ style comment.

> + *
> + */
> +
> +/ {
> +	model = "emtrion SoM emCON-MX6 Dual/Quad";
> +	compatible = "emtrion,emcon-mx6","fsl,imx6q";

Need a space                             ^

> diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
> new file mode 100644
> index 000000000000..f87d8ed6a1b1
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
> @@ -0,0 +1,848 @@
> +/*
> + * Copyright (C) 2017 emtrion GmbH
> + * Author: Jan Tuerk  <jan.tuerk@emtrion.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +
> +	model = "emtrion SoM emCON-MX6";
> +	compatible = "emtrion,emcon-mx6","fsl,imx6q", "fsl,imx6dl";

Need a space                             ^
