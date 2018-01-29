From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 29 Jan 2018 13:48:48 +0530
Subject: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
In-Reply-To: <20180126221808.GE28313@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
Message-ID: <086251c4-b012-236c-33e2-9cab551a4594@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/27/2018 03:48 AM, Stephen Boyd wrote:
> On 01/25, Rajendra Nayak wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>> new file mode 100644
>> index 000000000000..b97f99e6f4b4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>> @@ -0,0 +1,32 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +&tlmm {
> 
> I'm not the maintainer, but I find this approach to the pins
> really annoying. I have to flip to another file to figure out how
> a board has configured the pins. And we may bring in a bunch of
> settings that we don't ever use on some board too. Why can't we
> put the settings in the board file directly?

I was just keeping it consistent with how things are for other
qualcomm platforms. I can move this to the board dts if no one else
sees any issues.

> 
>> +	qup_uart2_default: qup_uart2_default {
>> +		pinmux {
>> +			function = "qup9";
>> +			pins = "gpio4", "gpio5";
>> +		};
>> +
>> +		pinconf {
>> +			pins = "gpio4", "gpio5";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	qup_uart2_sleep: qup_uart2_sleep {
>> +		pinmux {
>> +			function = "gpio";
>> +			pins = "gpio4", "gpio5";
>> +		};
>> +
>> +		pinconf {
>> +			pins = "gpio4", "gpio5";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index a21f4912b3e2..529f4ba3a1db 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -4,6 +4,7 @@
>>   */
>>  
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-sdm845.h>
>>  
>>  / {
>>  	model = "Qualcomm Technologies, Inc. SDM845";
> 
> I'd expect some sort of serial alias node stuff here too.

yes, will add.

> 
>> @@ -304,5 +305,26 @@
>>  			cell-index = <0>;
>>  		};
>>  
>> +		qup_1: qcom,geni_se at ac0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0xac0000 0x6000>;
>> +		};
>> +
>> +		qup_uart2: serial at a84000 {
>> +			compatible = "qcom,geni-console", "qcom,geni-uart";
>> +			reg = <0xa84000 0x4000>;
>> +			reg-names = "se_phys";
>> +			clock-names = "se-clk", "m-ahb", "s-ahb";
>> +			clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>,
>> +				 <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
>> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&qup_uart2_default>;
>> +			pinctrl-1 = <&qup_uart2_sleep>;
>> +			interrupts = <GIC_SPI 354 IRQ_TYPE_NONE>;
>> +			qcom,wrapper-core = <&qup_1>;
> 
> Is this binding still being reviewed? Ugly.

yes, its still being reviewed

> 
>> +			status = "disabled";
>> +		};
>>  	};
>>  };
>> +#include "sdm845-pins.dtsi"
> 
> Why at the bottom?

Again keeping it consistent with how things are in msm8916/msm8992/msm8996 dtsi files.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
