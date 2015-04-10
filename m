From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Apr 2015 13:21:29 -0700
Subject: [PATCH v2 06/12] ARM: dts: apq8064: Add MDP support
In-Reply-To: <552826F6.5040105@linaro.org>
References: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1428669271-11032-1-git-send-email-srinivas.kandagatla@linaro.org>
 <552802B6.2040804@codeaurora.org> <552826F6.5040105@linaro.org>
Message-ID: <552830C9.4030601@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/15 12:39, Srinivas Kandagatla wrote:
>
>
> On 10/04/15 18:04, Stephen Boyd wrote:
>> On 04/10/15 05:34, Srinivas Kandagatla wrote:
>>> @@ -250,6 +265,18 @@
>>>               };
>>>           };
>>>
>>> +        ext_3p3v: regulator-fixed at 1 {
>>> +            compatible = "regulator-fixed";
>>> +            regulator-min-microvolt = <3300000>;
>>> +            regulator-max-microvolt = <3300000>;
>>> +            regulator-name = "ext_3p3v";
>>> +            regulator-type = "voltage";
>>> +            startup-delay-us = <0>;
>>> +            gpio = <&tlmm_pinmux 77 GPIO_ACTIVE_HIGH>;
>>> +            enable-active-high;
>>> +            regulator-boot-on;
>>> +        };
>>
>> This shouldn't be inside the SoC node because it doesn't have a reg
>> property. It should be in a 'regulators' node that's in the root of the
>> tree:
>
> Is this new DT requirement/style? I have not noticed such a dt style
> in the past. I might have missed it. Any advantage of doing this way?

It's a style. I'm not sure if it's new, but I feel like I've seen
mention of it before more than a year ago (see
arch/arm/boot/dts/tegra30-beaver.dts for an example). The advantage of
doing it this way is we can see all the gpio/fixed regulators in one
place and they're physically placed on a separate bus from the SoC bus.
Typically nodes have reg properties too, so making up fake reg
properties for the regulator nodes when they're on the SoC bus would be
wrong and confusing. If they're under some regulators container node we
can number them from 0 to N and use that for the reg property.

>>
>>     regulators {
>>         compatible = "simple-bus";
>>
>>         ext_3p3v: fixedregulator at 0 {
>>             compatible = "regulator-fixed";
>>             ...
>>         };
>>     };
>>
> I will move this to the suggested style in next version.

Thanks.

>>
>>> +
>>>           qcom,ssbi at 500000 {
>>>               compatible = "qcom,ssbi";
>>>               reg = <0x00500000 0x1000>;
>>> @@ -522,5 +549,82 @@
>>>               compatible = "qcom,tcsr-apq8064", "syscon";
>>>               reg = <0x1a400000 0x100>;
>>>           };
>>> +
>>> +        hdmi: qcom,hdmi-tx at 4a00000 {
>>> +            compatible = "qcom,hdmi-tx-8960";
>>> +            reg-names = "core_physical";
>>> +            reg = <0x04a00000 0x1000>;
>>> +            interrupts = <GIC_SPI 79 IRQ_TYPE_NONE>;
>>> +            clock-names =
>>> +                "core_clk",
>>> +                "master_iface_clk",
>>> +                "slave_iface_clk";
>>> +            clocks =
>>> +                <&mmcc HDMI_APP_CLK>,
>>> +                <&mmcc HDMI_M_AHB_CLK>,
>>> +                <&mmcc HDMI_S_AHB_CLK>;
>>> +            qcom,hdmi-tx-ddc-clk = <&tlmm_pinmux 70
>>> +                        GPIO_ACTIVE_HIGH>;
>>> +            qcom,hdmi-tx-ddc-data = <&tlmm_pinmux 71
>>> +                        GPIO_ACTIVE_HIGH>;
>>> +            qcom,hdmi-tx-hpd = <&tlmm_pinmux 72
>>> +                        GPIO_ACTIVE_HIGH>;
>>
>> This should be done via the *-gpios method. i.e. hdmi-tx-ddc-clk-gpios,
>> hdmi-tx-ddc-data-gpios, etc.
>>
> Thanks for the inputs,
>
> That's true, These are existing bindings, so I can't change it as part
> of this patch, However I will make another patch to fix this in both
> drivers and DT for good reasons. Just noticed that bindings are not
> consistent with the examples and the driver, which I guess is another
> issue.

Yes, the driver/binding should be fixed and then this patch can be
corrected and applied. There are no implementations of the DT for this
device upstream in the dts directory so there's no breakage or backwards
incompatibility problem by fixing the driver/binding.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
