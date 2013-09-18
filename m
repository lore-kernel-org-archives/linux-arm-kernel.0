From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed, 18 Sep 2013 14:46:01 +0200
Subject: [PATCH 2/4] ARM: STi: Supply I2C configuration to STiH416 SoC
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-3-git-send-email-maxime.coquelin@st.com>
 <20130918120340.GF16984@lee--X1>
Message-ID: <84625B87D65BCF478CC1E9C886A4C314DEF1BD9578@SAFEX1MAIL4.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 02:03 PM, Lee Jones wrote:
>> This patch supplies I2C configuration to STiH416 SoC.
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>> ---
>>  arch/arm/boot/dts/stih416-pinctrl.dtsi |   35 ++++++++++++++++++++
>>  arch/arm/boot/dts/stih416.dtsi         |   57 ++++++++++++++++++++++++++++++++
>>  2 files changed, 92 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
> I genuinely don't know the answer to this question, but are these
> nodes identical to the ones you've just put in the stih415 DTSI file?
> If so, I think it will be worth creating a stih41x DTSI rather than
> duplicating lots of stuff unnecessarily.
There are close to be identical indeed.
For the clocks and pinctrl, the references names are the same, but they are
pointing on different nodes, as STiH415 and STiH416 have their own
clocks and pinctrl dtsi files.

Srini, what is opinion about this?
>
>> index 0f246c9..b29ff4b 100644
>> --- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
>> +++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
>> @@ -97,6 +97,24 @@
>>  					};
>>  				};
>>  			};
>> +
>> +			sbc_i2c0 {
>> +				pinctrl_sbc_i2c0_default: sbc_i2c0-default {
>> +					st,pins {
>> +						sda = <&PIO4 6 ALT1 BIDIR>;
>> +						scl = <&PIO4 5 ALT1 BIDIR>;
>> +					};
>> +				};
>> +			};
>> +
>> +			sbc_i2c1 {
>> +				pinctrl_sbc_i2c1_default: sbc_i2c1-default {
>> +					st,pins {
>> +						sda = <&PIO3 2 ALT2 BIDIR>;
>> +						scl = <&PIO3 1 ALT2 BIDIR>;
>> +					};
>> +				};
>> +			};
>>  		};
>>  
>>  		pin-controller-front {
>> @@ -175,6 +193,23 @@
>>  				};
>>  			};
>>  
>> +			i2c0 {
>> +				pinctrl_i2c0_default: i2c0-default {
>> +					st,pins {
>> +						sda = <&PIO9 3 ALT1 BIDIR>;
>> +						scl = <&PIO9 2 ALT1 BIDIR>;
>> +					};
>> +				};
>> +			};
>> +
>> +			i2c1 {
>> +				pinctrl_i2c1_default: i2c1-default {
>> +					st,pins {
>> +						sda = <&PIO12 1 ALT1 BIDIR>;
>> +						scl = <&PIO12 0 ALT1 BIDIR>;
>> +					};
>> +				};
>> +			};
>>  		};
>>  
>>  		pin-controller-rear {
>> diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
>> index 1a0326e..8856470 100644
>> --- a/arch/arm/boot/dts/stih416.dtsi
>> +++ b/arch/arm/boot/dts/stih416.dtsi
>> @@ -9,6 +9,7 @@
>>  #include "stih41x.dtsi"
>>  #include "stih416-clock.dtsi"
>>  #include "stih416-pinctrl.dtsi"
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>  / {
>>  	L2: cache-controller {
>>  		compatible = "arm,pl310-cache";
>> @@ -92,5 +93,61 @@
>>  			pinctrl-0 	= <&pinctrl_sbc_serial1>;
>>  			clocks          = <&CLK_SYSIN>;
>>  		};
>> +
>> +		i2c0: i2c at fed40000{
> Same issues here. I assume most of this is copy paste.
Yes indeed. This will be fixed in next version.
>
>> +			compatible	= "st,comms-i2c";
>> +			status		= "disabled";
>> +			reg		= <0xfed40000 0x110>;
>> +			interrupts	=  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
>> +			clocks		= <&CLK_S_ICN_REG_0>;
>> +			clock-frequency = <400000>;
>> +			pinctrl-names	= "default";
>> +			pinctrl-0	= <&pinctrl_i2c0_default>;
>> +			st,glitches;
>> +			st,glitch-clk	= <500>;
>> +			st,glitch-dat	= <500>;
>> +		};
>> +
>> +		i2c1: i2c at fed41000{
>> +			compatible	= "st,comms-i2c";
>> +			status		= "disabled";
>> +			reg		= <0xfed41000 0x110>;
>> +			interrupts	=  <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>;
>> +			clocks		= <&CLK_S_ICN_REG_0>;
>> +			clock-frequency = <400000>;
>> +			pinctrl-names	= "default";
>> +			pinctrl-0	= <&pinctrl_i2c1_default>;
>> +			st,glitches;
>> +			st,glitch-clk	= <500>;
>> +			st,glitch-dat	= <500>;
>> +		};
>> +
>> +		sbc_i2c0: i2c at fe540000{
>> +			compatible	= "st,comms-i2c";
>> +			status		= "disabled";
>> +			reg		= <0xfe540000 0x110>;
>> +			interrupts	=  <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>;
>> +			clocks		= <&CLK_SYSIN>;
>> +			clock-frequency = <400000>;
>> +			pinctrl-names	= "default";
>> +			pinctrl-0	= <&pinctrl_sbc_i2c0_default>;
>> +			st,glitches;
>> +			st,glitch-clk	= <500>;
>> +			st,glitch-dat	= <500>;
>> +		};
>> +
>> +		sbc_i2c1: i2c at fe541000{
>> +			compatible	= "st,comms-i2c";
>> +			status		= "disabled";
>> +			reg		= <0xfe541000 0x110>;
>> +			interrupts	=  <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>;
>> +			clocks		= <&CLK_SYSIN>;
>> +			clock-frequency = <400000>;
>> +			pinctrl-names	= "default";
>> +			pinctrl-0	= <&pinctrl_sbc_i2c1_default>;
>> +			st,glitches;
>> +			st,glitch-clk	= <500>;
>> +			st,glitch-dat	= <500>;
>> +		};
>>  	};
>>  };
Thanks,
Maxime
