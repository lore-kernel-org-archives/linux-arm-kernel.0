From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 17 Mar 2015 12:07:02 -0500
Subject: [PATCH v5 2/4] arm64: dts: Add Qualcomm MSM8916 SoC and
 evaluation board dts
In-Reply-To: <5507F2B4.2000105@linaro.org>
References: <1426262769-26758-1-git-send-email-galak@codeaurora.org>
 <5507F2B4.2000105@linaro.org>
Message-ID: <7BF42995-431A-4D01-A1E9-F6274BE1C0FA@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 17, 2015, at 4:24 AM, Stanimir Varbanov <stanimir.varbanov@linaro.org> wrote:

> On 03/13/2015 06:06 PM, Kumar Gala wrote:
>> Add initial device tree support for Qualcomm MSM8916 SoC and MTP8916
>> evaluation board.  At the current time we only boot up a single processor.
>> 
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> ---
>> v5:
>> * killed use of skeleton, moved to addr/size cells both being 2
>> * Added serial alias in prep of being able to spec uart params
>>  in chosen node
>> 
>> v4:
>> * Added chosen node so we dont need to spec everything for earlycon
>> * fixed up timer node to armv8, dropped clock-frequency
>> 
>> v3:
>> * Removed qcom,msm-id and qcom,board-id
>> * Added top level compat for "qcom,msm8916-mtp-smb1360"
>> 
>> v2:
>> * Updated to dropping CONFIG_ARCH_QCOM_MSM8916
>> * Updated to use qcom-ids.h
>> 
>> arch/arm64/boot/dts/Makefile              |   1 +
>> arch/arm64/boot/dts/qcom/Makefile         |   5 +
>> arch/arm64/boot/dts/qcom/msm8916-mtp.dts  |  21 ++++
>> arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi |  32 +++++
>> arch/arm64/boot/dts/qcom/msm8916.dtsi     | 195 ++++++++++++++++++++++++++++++
>> 5 files changed, 254 insertions(+)
>> create mode 100644 arch/arm64/boot/dts/qcom/Makefile
>> create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dts
>> create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
>> create mode 100644 arch/arm64/boot/dts/qcom/msm8916.dtsi
>> 
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index e0350ca..8517f15 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -5,5 +5,6 @@ dts-dirs += cavium
>> dts-dirs += exynos
>> dts-dirs += freescale
>> dts-dirs += mediatek
>> +dts-dirs += qcom
>> 
>> subdir-y	:= $(dts-dirs)
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> new file mode 100644
>> index 0000000..360ec4c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -0,0 +1,5 @@
>> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
>> +
>> +always		:= $(dtb-y)
>> +subdir-y	:= $(dts-dirs)
>> +clean-files	:= *.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
>> new file mode 100644
>> index 0000000..784ad92
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
>> @@ -0,0 +1,21 @@
>> +/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
> 
> multi line comment rules
> 
>> +*
>> +* This program is free software; you can redistribute it and/or modify
>> +* it under the terms of the GNU General Public License version 2 and
>> +* only version 2 as published by the Free Software Foundation.
>> +*
>> +* This program is distributed in the hope that it will be useful,
>> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +* GNU General Public License for more details.
>> +*/
>> +
>> +/dts-v1/;
>> +
>> +#include "msm8916-mtp.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
>> +	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp-smb1360",
>> +			"qcom,msm8916", "qcom,mtp";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
>> new file mode 100644
>> index 0000000..8dbb77f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
>> @@ -0,0 +1,32 @@
>> +/* Copyright (c) 2014-2014, The Linux Foundation. All rights reserved.
> 
> multi line comment rules and 2014-2015
> 
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include "msm8916.dtsi"
>> +
>> +/ {
>> +	aliases {
>> +		serial0 = &blsp1_uart2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0";
>> +	};
>> +
>> +	soc {
>> +		serial at 78b0000 {
>> +			status = "okay";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&blsp1_uart2_default>;
>> +			pinctrl-1 = <&blsp1_uart2_sleep>;
>> +		};
>> +	};
> 
> Why don't describe this as:
> 
> &blsp1_uart2 {
> 	status = "okay";
> 	pinctrl-names = xxxx;
> 	....
> };
> 
> it looks more readable and obvious. This is what the other boards doing
> as well.

I find the way it is more explicit and obvious, plus it works for cases that don?t have a label associated with them.

I?ll fixup the multiline comment issues.

- k
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
