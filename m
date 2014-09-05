From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Fri, 05 Sep 2014 18:00:34 +0200
Subject: [PATCH v3] ARM: dts: qcom: Add initial IFC6540 board device tree
In-Reply-To: <070D3E01-139E-4EC2-928F-31B8CA5E1BD7@codeaurora.org>
References: <1409763031-16873-1-git-send-email-gdjakov@mm-sol.com>
 <5409C803.8060007@suse.de>
 <070D3E01-139E-4EC2-928F-31B8CA5E1BD7@codeaurora.org>
Message-ID: <5409DE22.3070506@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.09.2014 17:20, schrieb Kumar Gala:
> On Sep 5, 2014, at 9:26 AM, Andreas F?rber <afaerber@suse.de> wrote:
>> Am 03.09.2014 18:50, schrieb Georgi Djakov:
>>> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> index 21d01e5..1f130bc 100644
>>> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> @@ -3,6 +3,7 @@
>>> #include "skeleton.dtsi"
>>>
>>> #include <dt-bindings/clock/qcom,gcc-apq8084.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>>
>>> / {
>>> 	model = "Qualcomm APQ 8084";
>>> @@ -203,5 +204,27 @@
>>> 			clock-names = "core", "iface";
>>> 			status = "disabled";
>>> 		};
>>> +
>>> +		sdhci at f9824900 {
>>> +			compatible = "qcom,sdhci-msm-v4";
>>> +			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
>>> +			reg-names = "hc_mem", "core_mem";
>>> +			interrupts = <0 123 0>, <0 138 0>;
>>
>> I see that you've used GPIO_ACTIVE_* above. Is the trailing zero here
>> possibly IRQ_TYPE_NONE?
>>
>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>> +			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>>> +			clock-names = "core", "iface";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		sdhci at f98a4900 {
>>> +			compatible = "qcom,sdhci-msm-v4";
>>> +			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
>>> +			reg-names = "hc_mem", "core_mem";
>>> +			interrupts = <0 125 0>, <0 221 0>;
>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>> +			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
>>> +			clock-names = "core", "iface";
>>> +			status = "disabled";
>>> +		};
>>
>> If you assign labels to these two nodes, you can reference them in the
>> .dts as &labelname {...};. Same for the uart node. That avoids
>> duplicating the hierarchy, detects spelling mistakes at compile time and
>> reduces indentation. Cf. the recent ifc6410 patch.
> 
> Got no issues with introducing the labels, but I?d like to keep the hierarchy in the .dts file.

Any explanation why? The Samsung guys have been very strict to adopt
this new style, with inherited nodes sorted alphabetically after / {};,
and the ifc6540 is a new .dts we could apply the new pattern to.

But if you don't reference the node anywhere, there's no real benefit to
adding a label in the first place. It can still be done once needed.

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
