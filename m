From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu, 4 Feb 2016 18:57:44 -0500
Subject: [PATCH v7 4/7] ARM: dts: imx: Add support for Advantech/GE Bx50v3
In-Reply-To: <20160203145256.GR8307@tiger>
References: <1454109558-22800-1-git-send-email-akshay.bhat@timesys.com>
 <1454109558-22800-5-git-send-email-akshay.bhat@timesys.com>
 <20160203145256.GR8307@tiger>
Message-ID: <56B3E578.2080209@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/03/2016 09:52 AM, Shawn Guo wrote:
> On Fri, Jan 29, 2016 at 06:19:15PM -0500, Akshay Bhat wrote:
>> From: Justin Waters <justin.waters@timesys.com>
>>
>> Advantech has 3 carrier boards (B450v3, B650v3, B850v3) which use
>> the Advantech BA-16 module (based on iMX6D). This file has the
>> devicetree entries that are common to all 3 boards.
>>
>> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
>> Signed-off-by: Justin Waters <justin.waters@timesys.com>
>> ---
>>   arch/arm/boot/dts/imx6q-bx50v3.dtsi | 239 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 239 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/imx6q-bx50v3.dtsi
>>
>> diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
>> new file mode 100644
>> index 0000000..a44b074
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
>> @@ -0,0 +1,239 @@
>> +/*
>> + * Copyright 2015 Timesys Corporation.
>> + * Copyright 2015 General Electric Company
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License
>> + *     version 2 as published by the Free Software Foundation.
>> + *
>> + *     This file is distributed in the hope that it will be useful
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include "imx6q-ba16.dtsi"
>> +
>> +/ {
>> +	clocks {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>
> These are already specified in imx6qdl.dtsi.
>

Will fix this. Once it is removed, should I have a new line before the 
child node?
eg:

clocks {

	mclk: clock at 0 {
		compatible = "fixed-clock";
>> +
>> +		mclk: clock at 0 {
>> +			compatible = "fixed-clock";
>> +			reg = <0>;
>> +			#clock-cells = <0>;
>> +			clock-frequency = <22000000>;
>> +		};
>> +	};
>
> <snip>
>
>> +&i2c1 {
>> +	pca9547: mux at 70 {
>> +		compatible = "nxp,pca9547";
>> +		reg = <0x70>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		mux1_i2c1: i2c at 0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x0>;
>> +
>> +			ads7830: ads7830 at 48 {
>> +				compatible = "ti,ads7830";
>> +				reg = <0x48>;
>> +			};
>> +
>> +			mma8453: mma8453 at 1c {
>> +				compatible = "fsl,mma8453";
>> +				reg = <0x1c>;
>> +			};
>> +		};
>> +
>> +		mux1_i2c2: i2c at 1 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x1>;
>> +
>> +			eeprom: eeprom at 50 {
>> +				compatible = "atmel,24c08";
>> +				reg = <0x50>;
>> +			};
>> +
>> +			mpl3115: mpl3115 at 60 {
>> +				compatible = "fsl,mpl3115";
>> +				reg = <0x60>;
>> +			};
>> +		};
>> +
>> +		mux1_i2c3: i2c at 2 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x2>;
>> +		};
>> +
>> +		mux1_i2c4: i2c at 3 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x3>;
>> +
>> +			codec: sgtl5000 at 0a {
>
> I think the naming schema below matches DT convention better, i.e. the
> node name should be generic.
>
> 			sgtl5000: codec at 0a {
>

Will update the naming.

>> +				compatible = "fsl,sgtl5000";
>> +				reg = <0x0a>;
>> +				clocks = <&mclk>;
>> +				VDDA-supply = <&reg_1p8v>;
>> +				VDDIO-supply = <&reg_3p3v>;
>> +			};
>> +		};
>
> <snip>
>
>> +&usdhc4 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc4>;
>> +	bus-width = <4>;
>> +	vmmc-supply = <&reg_wl18xx_vmmc>;
>> +	no-1-8-v;
>> +	non-removable;
>> +	wakeup-source;
>> +	keep-power-in-suspend;
>> +	cap-power-off-card;
>> +	max-frequency = <25000000>;
>> +	status = "okay";
>> +
>
> Drop this new line and have 'status' be the last property.
>

Will update the same.

>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>
> I'm not sure why this and a 'reg' property in sub-nodes are necessary at
> all, but ...
>

Most other devicetrees that use ti wlcore had the above properties along 
with a 'reg' property in the sub-node. So I used them as reference. 
Since there is a single child node here, is it preferred to change this to:

&usdhc4 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usdhc4>;
	bus-width = <4>;
	vmmc-supply = <&reg_wl18xx_vmmc>;
	no-1-8-v;
	non-removable;
	wakeup-source;
	keep-power-in-suspend;
	cap-power-off-card;
	max-frequency = <25000000>;
	status = "okay";

	wlcore {
		compatible = "ti,wl1837";
		interrupt-parent = <&gpio2>;
		interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
		tcxo-clock-frequency = <26000000>;
	};	
};

>> +
>> +	wlcore: wlcore at 0 {
>> +		compatible = "ti,wl1837";
>> +		reg = <2>;
>
> ... at least the 'reg' property should match the unit-address after node
> name.
>
> Shawn
>
Will fix this.

Thanks,
Akshay

>> +		interrupt-parent = <&gpio2>;
>> +		interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
>> +		tcxo-clock-frequency = <26000000>;
>> +	};
>> +};
>> --
>> 2.7.0
>>
>>
