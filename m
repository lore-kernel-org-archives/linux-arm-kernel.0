From: hs@denx.de (Heiko Schocher)
Date: Wed, 20 May 2015 13:13:54 +0200
Subject: [PATCH v3] arm, imx6, dts: add DT for aristainetos2 board
In-Reply-To: <1432118319.4466.40.camel@pengutronix.de>
References: <1432099863-8642-1-git-send-email-hs@denx.de>
 <1432118319.4466.40.camel@pengutronix.de>
Message-ID: <555C6C72.2060302@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philipp,

Am 20.05.2015 12:38, schrieb Philipp Zabel:
> Hi Heiko,
>
> Am Mittwoch, den 20.05.2015, 07:31 +0200 schrieb Heiko Schocher:
> [...]
>> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
>> new file mode 100644
>> index 0000000..780fc42
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
>> @@ -0,0 +1,174 @@
>> +/*
>> + * support fot the imx6 based aristainetos2 board
>
> Typo, "support for".

Oh, thanks! Fixed (for all files)

>> + *
>> + * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of
>> + *     the License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + *     You should have received a copy of the GNU General Public
>> + *     License along with this file; if not, write to the Free
>> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
>> + *     MA 02110-1301 USA
>
> checkpatch warns that you should not include this paragraph because the
> mail address might change in the future and it is contained in COPYING.

Hmm... Shawn mentioned to change it to the "GPL/X11 dual licence"
as in the arch/arm/boot/dts/imx6sl-warp.dts file ... so I copied this
from there ... is there a better option for this?

> [...]
>> +/dts-v1/;
>> +#include "imx6dl.dtsi"
>> +#include "imx6qdl-aristainetos2.dtsi"
>> +
>> +/ {
>> +	model = "aristainetos2 i.MX6 Dual Lite Board 4";
>> +	compatible = "fsl,imx6dl";
>
> Doesn't this board get its own compatible?

Hmm... why?

> [...]
>> +	display0: display at di0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		compatible = "fsl,imx-parallel-display";
>> +		interface-pix-fmt = "rgb24";
>
> It's ok to keep this property for now, but in the future I'd like it to
> be removed. The panel driver should provide all necessary information
> using drm_display_info_set_bus_formats. The imx parallel-display driver
> then needs to be made aware of the connector display_info->bus_formats.

Ok.

> [...]
>> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
>> new file mode 100644
>> index 0000000..14cf4e8
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
>> @@ -0,0 +1,103 @@
>> +/*
>> + * support fot the imx6 based aristainetos2 board
>
> Typo, "support for".

fixed.

>> + * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of
>> + *     the License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + *     You should have received a copy of the GNU General Public
>> + *     License along with this file; if not, write to the Free
>> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
>> + *     MA 02110-1301 USA
>
> Same comment as above.
>
> [...]
>> +/ {
>> +	model = "aristainetos2 i.MX6 Dual Lite Board 7";
>> +	compatible = "fsl,imx6dl";
>
> Same comment as above.
>
>> +&ldb {
>> +	status = "okay";
>> +
>> +	lvds-channel at 0 {
>> +		fsl,data-mapping = "spwg";
>> +		fsl,data-width = <24>;
>> +		status = "okay";
>> +
>> +		display-timings {
>> +			native-mode = <&timing0>;
>> +			timing0: 800x480p60 {
>> +				clock-frequency = <33246000>;
>> +				hactive = <800>;
>> +				vactive = <480>;
>> +				hfront-porch = <88>;
>> +				hback-porch = <88>;
>> +				hsync-len = <80>;
>> +				vback-porch = <10>;
>> +				vfront-porch = <10>;
>> +				vsync-len = <25>;
>> +			};
>> +		};
>> +	};
>
> What panel is this? I'd prefer if you used the panel-simple driver here
> and connected it to the ldb channel using OF graph bindings same as the
> parallel display above. That would allow to remove the fsl,data-mapping
> and fsl,data-width properties and the display-timings node.

It is an Display from LG, MODEL LB070WV8, SUFFIX SL01
I try to add it to the panel-simple driver

>> +};
>> diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
>> new file mode 100644
>> index 0000000..eac7c3b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
>> @@ -0,0 +1,634 @@
>> +/*
>> + * support fot the imx6 based aristainetos2 board
>
> Typo, "support for". Also, maybe s/board/boards/ as this contains the
> common parts for both the 4 and 7 variant?

Yep, fixed.

>> + *
>> + * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of
>> + *     the License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + *     You should have received a copy of the GNU General Public
>> + *     License along with this file; if not, write to the Free
>> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
>> + *     MA 02110-1301 USA
>
> Same comment as above.
>
> [...]
>> +&i2c1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	status = "okay";
>> +
>> +	pmic at 58 {
>> +		compatible = "dialog,da9063";
>
> This should be "dlg,da9063" as per
> Documentation/devicetree/bindings/mfd/da9063.txt.

fixed.

> [...]
>> +&i2c4 {
>> +	clocks = <&clks IMX6DL_CLK_I2C4>;
>
i> The clocks property is already contained in imx6dl.dtsi

removed.

> [...]
>> +&fec
>> +&gpmi
>> +&pcie
>> +&pwm1
>> +&uart1
>> +&uart2
>> +&uart3
>> +&uart4
>> +&usbh1
>> +&usbotg
>> +&usdhc1
>> +&usdhc2
>> +&iomuxc
>
> Do all aristainetos2 boards have all of these ports routed out? (Should
> the status = "okay" properties be set here, or in the per-board .dts
> files?)

All aristainetos2 variants use this ports, yes.

Thanks for your review!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
