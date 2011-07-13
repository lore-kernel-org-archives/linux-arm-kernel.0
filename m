From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 07:57:16 +0900
Subject: [PATCH 1/4] dt: omap3: add SoC file for handling i2c controllers
In-Reply-To: <1310592975-25773-2-git-send-email-manjugk@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-2-git-send-email-manjugk@ti.com>
Message-ID: <CACxGe6u3D=ZgK2TpLP7waCwH=MA_5UR+YBRSgVE9QBVyvkF32A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
>
> Add omap3 SoC file for handling omap3 SoC i2c controllers existing
> on l4-core bus.
>
> Out of three i2c controllers, first i2c controller is interfaced with
> PMIC on all the boards of OMAP3. The clock for i2c controllers are
> controlled through omap hwmod framework hence first i2c controller
> device registration through dt is disabled till hwmod dependencies
> are resolved.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> ?arch/arm/boot/dts/omap3-soc.dtsi | ? 65 ++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 65 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
>
> diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/omap3-soc.dtsi
> new file mode 100644
> index 0000000..f186a32
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-soc.dtsi
> @@ -0,0 +1,65 @@
> +/*
> + * Device Tree Source for OMAP3 SoC
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. ?This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "skeleton.dtsi"
> +
> +/ {
> + ? ? ? #address-cells = <1>;
> + ? ? ? #size-cells = <1>;
> + ? ? ? model = "ti,omap3";

You can drop the model property here since this doesn't define a board.

> + ? ? ? compatible = "ti,omap3";
> +
> + ? ? ? intc: interrupt-controller at 0x48200000 {
> + ? ? ? ? ? ? ? compatible = "ti,omap3-intc", "arm,intc";

Which arm intc controller?  For any new 'compatible' value you define,
the patch needs to include documentation for it in
Documentation/devicetree/bindings.

> + ? ? ? ? ? ? ? interrupt-controller;
> + ? ? ? ? ? ? ? #interrupt-cells = <1>;
> + ? ? ? ? ? ? ? reg = <0x48200000 0x1000>;
> + ? ? ? };
> +
> + ? ? ? l4-core {
> + ? ? ? ? ? ? ? compatible = "ti,l4-core";

Probably should be "ti,omap3-l4-core"?

> + ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? #size-cells = <1>;
> + ? ? ? ? ? ? ? ranges = <0 0x48000000 0x1000000>;
> +
> + ? ? ? ? ? ? ? i2c at 1 {
> + ? ? ? ? ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? ? ? ? ? #size-cells = <0>;
> + ? ? ? ? ? ? ? ? ? ? ? compatible = "ti,omap3-i2c";
> + ? ? ? ? ? ? ? ? ? ? ? reg = <0x70000 0x100>;
> + ? ? ? ? ? ? ? ? ? ? ? interrupts = < 88 >;
> + ? ? ? ? ? ? ? ? ? ? ? status = "disabled";

Drop the 'status' properties.  I know the current tegra code does
this, but I'd prefer devices to be enabled by default and for boards
to explicitly disable them instead of the other way around.

> + ? ? ? ? ? ? ? };
> +
> + ? ? ? ? ? ? ? i2c at 2 {
> + ? ? ? ? ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? ? ? ? ? #size-cells = <0>;
> + ? ? ? ? ? ? ? ? ? ? ? compatible = "ti,omap3-i2c";
> + ? ? ? ? ? ? ? ? ? ? ? reg = <0x72000 0x100>;
> + ? ? ? ? ? ? ? ? ? ? ? interrupts = < 89 >;
> + ? ? ? ? ? ? ? };
> +
> + ? ? ? ? ? ? ? i2c at 3 {
> + ? ? ? ? ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? ? ? ? ? #size-cells = <0>;
> + ? ? ? ? ? ? ? ? ? ? ? compatible = "ti,omap3-i2c";
> + ? ? ? ? ? ? ? ? ? ? ? reg = <0x60000 0x100>;
> + ? ? ? ? ? ? ? ? ? ? ? interrupts = < 93 >;
> + ? ? ? ? ? ? ? };
> + ? ? ? };
> +
> + ? ? ? l4-per {
> + ? ? ? ? ? ? ? compatible = "ti,l4-per";
> + ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? #size-cells = <1>;
> + ? ? ? ? ? ? ? ranges = <0 0x49000000 0x100000>;
> + ? ? ? };
> +};
> --
> 1.7.4.1
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
