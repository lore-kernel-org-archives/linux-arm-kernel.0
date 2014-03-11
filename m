From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 11 Mar 2014 11:09:25 +0100
Subject: [PATCH v3 4/5] ARM: dts: Add STiH407 SoC support
In-Reply-To: <20140310122830.GT14976@lee--X1>
References: <1394203251-25361-1-git-send-email-maxime.coquelin@st.com>
 <1394203251-25361-5-git-send-email-maxime.coquelin@st.com>
 <20140310122830.GT14976@lee--X1>
Message-ID: <531EE0D5.6030906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/2014 01:28 PM, Lee Jones wrote:
> On Fri, 07 Mar 2014, Maxime COQUELIN wrote:
>
>> The STiH407 is advanced multi-HD AVC processor with 3D graphics acceleration
>> and 1.5-GHz ARM Cortex-A9 SMP CPU.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> ---
>>   arch/arm/boot/dts/stih407-clock.dtsi   |  41 +++
>>   arch/arm/boot/dts/stih407-pinctrl.dtsi | 618 +++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/stih407.dtsi         | 250 +++++++++++++
>>   3 files changed, 909 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/stih407-clock.dtsi
>>   create mode 100644 arch/arm/boot/dts/stih407-pinctrl.dtsi
>>   create mode 100644 arch/arm/boot/dts/stih407.dtsi
>>
>> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
>> new file mode 100644
>> index 0000000..f50ac6f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
>> @@ -0,0 +1,41 @@
>
> Going to gloss over this, as you and Srini are the platform experts.
>
>> +/*
>> + * Copyright (C) 2013 STMicroelectronics R&D Limited
>
> s/2013/2014
>
>> + * <stlinux-devel@stlinux.com>
>
> Might consider submitting a MAINTAINERS entry for all of ST's DTS(I)
> files and removing this from them. Only if this ML is pretty
> stable/constant of course.

I prefer removing this ML.
The right one is kernel at stlinux.com as specified in the MAINTAINERS file.

ST's DTS files are being added to MAINTAINERS file with this patch from 
Srini: http://marc.info/?l=linux-arm-kernel&m=139384666716614&w=2


>

<snip>

>> +			PIO1: gpio at 09611000 {
>> +				gpio-controller;
>> +				#gpio-cells = <1>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +				reg = <0x1000 0x100>;
>
> Are there really these big gaps in the register space i.e 0x1100 -> 0x2000 etc?

Yes.

>

<snip>

>> +
>> +			gmac1 {
>> +				/*
>> +				  Almost all the boards based on STiH407 SoC have an embedded
>> +				  switch where the mdio/mdc have been used for managing the SMI
>> +				  iface via I2C. For this reason these lines can be allocated
>> +				  by using dedicated configuration (in case of there will be a
>> +				  standard PHY transceiver on-board).
>> +				*/
>
> Non-standard multi-line comment. Please fill in the remaining '*'s.
Right, this will be fixed in v4.

>
>> +				pinctrl_rgmii1: rgmii1-0 {
>> +					st,pins {
>> +
>> +						txd0 = <&PIO0 0 ALT1 OUT DE_IO 0 CLK_A>;
>> +						txd1 = <&PIO0 1 ALT1 OUT DE_IO 0 CLK_A>;
>> +						txd2 = <&PIO0 2 ALT1 OUT DE_IO 0 CLK_A>;
>> +						txd3 = <&PIO0 3 ALT1 OUT DE_IO 0 CLK_A>;
>> +						txen = <&PIO0 5 ALT1 OUT DE_IO 0 CLK_A>;
>> +						txclk = <&PIO0 6 ALT1 IN NICLK 0 CLK_A>;
>> +						rxd0 = <&PIO1 4 ALT1 IN DE_IO 0 CLK_A>;
>> +						rxd1 = <&PIO1 5 ALT1 IN DE_IO 0 CLK_A>;
>> +						rxd2 = <&PIO1 6 ALT1 IN DE_IO 0 CLK_A>;
>> +						rxd3 = <&PIO1 7 ALT1 IN DE_IO 0 CLK_A>;
>> +						rxdv = <&PIO2 0 ALT1 IN DE_IO 0 CLK_A>;
>> +						rxclk = <&PIO2 2 ALT1 IN NICLK 500 CLK_A>;
>> +						clk125 = <&PIO3 7 ALT4 IN NICLK 0 CLK_A>;
>> +						phyclk = <&PIO2 3 ALT4 OUT NICLK 1750 CLK_B>;
>> +					};
>> +				};
>> +
>> +				pinctrl_rgmii1_mdio: rgmii1-mdio {
>> +					st,pins {
>> +						mdio = <&PIO1 0 ALT1 OUT BYPASS 0>;
>> +						mdc = <&PIO1 1 ALT1 OUT NICLK 0 CLK_A>;
>> +						mdint = <&PIO1 3 ALT1 IN BYPASS 0>;
>> +					};
>> +				};
>> +
>> +				pinctrl_mii1: mii1 {
>> +					st,pins {
>> +						txd0 = <&PIO0 0 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
>> +						txd1 = <&PIO0 1 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
>> +						txd2 = <&PIO0 2 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
>> +						txd3 = <&PIO0 3 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
>> +						txer = <&PIO0 4 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
>> +						txen = <&PIO0 5 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
>> +						txclk = <&PIO0 6 ALT1 IN NICLK 0 CLK_A>;
>> +						col = <&PIO0 7 ALT1 IN BYPASS 1000>;
>> +
>> +						mdio = <&PIO1 0 ALT1 OUT BYPASS 1500>;
>> +						mdc = <&PIO1 1 ALT1 OUT NICLK 0 CLK_A>;
>> +						crs = <&PIO1 2 ALT1 IN BYPASS 1000>;
>> +						mdint = <&PIO1 3 ALT1 IN BYPASS 0>;
>> +						rxd0 = <&PIO1 4 ALT1 IN SE_NICLK_IO 0 CLK_A>;
>> +						rxd1 = <&PIO1 5 ALT1 IN SE_NICLK_IO 0 CLK_A>;
>> +						rxd2 = <&PIO1 6 ALT1 IN SE_NICLK_IO 0 CLK_A>;
>> +						rxd3 = <&PIO1 7 ALT1 IN SE_NICLK_IO 0 CLK_A>;
>> +
>> +						rxdv = <&PIO2 0 ALT1 IN SE_NICLK_IO 0 CLK_A>;
>> +						rx_er = <&PIO2 1 ALT1 IN SE_NICLK_IO 0 CLK_A>;
>> +						rxclk = <&PIO2 2 ALT1 IN NICLK 0 CLK_A>;
>> +						phyclk = <&PIO2 3 ALT1 OUT NICLK 0 CLK_A>;
>> +					};
>> +				};
>> +
>> +			};
>
> Superflous new line.

Fixed.

>

<snip>

>> +
>> +			pwm0 {
>> +				pinctrl_pwm0_chan0_default: pwm0-0-default {
>> +					st,pins {
>> +						pwm-out = <&PIO31 1 ALT1 OUT>;
>> +					};
>> +				};
>> +			};
>> +
>> +		};
>
> Extra new line above.
Fixed.

>
<snip>

>> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
>> new file mode 100644
>> index 0000000..2a0566b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/stih407.dtsi
>> @@ -0,0 +1,250 @@
>> +/*
>> + * Copyright (C) 2013 STMicroelectronics Limited.
>> + * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * publishhed by the Free Software Foundation.
>> + */
>> +#include "stih407-clock.dtsi"
>> +#include "stih407-pinctrl.dtsi"
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a9";
>> +			reg = <0>;
>> +		};
>> +		cpu at 1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a9";
>> +			reg = <1>;
>> +		};
>> +	};
>> +
>> +	intc: interrupt-controller at 08761000 {
>> +		compatible = "arm,cortex-a9-gic";
>> +		#interrupt-cells = <3>;
>> +		interrupt-controller;
>> +		reg = <0x08761000 0x1000>, <0x08760100 0x100>;
>> +	};
>> +
>> +	scu at 08760000 {
>> +		compatible = "arm,cortex-a9-scu";
>> +		reg = <0x08760000 0x1000>;
>> +	};
>> +
>> +	timer at 08760200 {
>> +		interrupt-parent = <&intc>;
>> +		compatible = "arm,cortex-a9-global-timer";
>> +		reg = <0x08760200 0x100>;
>> +		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&arm_periph_clk>;
>> +	};
>> +
>> +	L2: cache-controller {
>> +		compatible = "arm,pl310-cache";
>> +		reg = <0x08762000 0x1000>;
>> +		arm,data-latency = <3 3 3>;
>> +		arm,tag-latency = <2 2 2>;
>> +		cache-unified;
>> +		cache-level = <2>;
>> +	};
>> +
>> +	soc {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		interrupt-parent = <&intc>;
>> +		ranges;
>> +		compatible = "simple-bus";
>> +
>> +		syscfg_sbc:sbc-syscfg at 9620000{
>
> Space after colon and another after the address.
>
> Same for all of the nodes below and throughout the patch.

Fixed here and evrywhere in the file.


<snip>

>> +		serial at 9830000{
>> +			compatible = "st,asc";
>> +			status = "disabled";
>
> This might just be a personal thing, but I prefer to see the status at
> the base of the node with a new line above it, as it is only relevant
> to the node rather than the device.
>
>> +			reg = <0x9830000 0x2c>;
>> +			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pinctrl_serial0>;
>> +			clocks = <&CLK_EXT2F_A9>;
>> +		};
>
> Like this:
> 	serial at 9830000{
> 		compatible = "st,asc";
> 		reg = <0x9830000 0x2c>;
> 		interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&pinctrl_serial0>;
> 		clocks = <&CLK_EXT2F_A9>;
>
> 		status = "disabled";
> 	};

Okay. I made the change for all the nodes.

>

<snip>

>
> Not sure if this is Git playing around again, but the };s look
> misaligned in the submission.
>
> Wow, this is good work and a lot of code!
>
> Once my comments have been rectified, feel free to add my:
>    Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks for the review Lee.
I added your Ack.

Regards,
Maxime
>
