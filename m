From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 Nov 2015 14:40:55 +0900
Subject: [PATCH 1/2] arm64: dts: exynos7: Add pmic s2mps15 device tree node
In-Reply-To: <563AEB2D.5000408@samsung.com>
References: <1446458641-4447-1-git-send-email-alim.akhtar@samsung.com>
 <CAJKOXPfrvuH8t3Pkf2Qt8VEfMR3qOeFKHrG0i3qUf94BR1y2tQ@mail.gmail.com>
 <56375EB1.2090504@samsung.com>
 <CAJKOXPcPQD+3QinbaKcREQSn1yJCf2kQG0C4rhJtCS=W_25Gmw@mail.gmail.com>
 <563AEB2D.5000408@samsung.com>
Message-ID: <563AEBE7.5040400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 14:37, Alim Akhtar wrote:
> Hi Krzysztof
> 
> On 11/02/2015 07:22 PM, Krzysztof Kozlowski wrote:
>> 2015-11-02 22:01 GMT+09:00 Alim Akhtar <alim.akhtar@samsung.com>:
>>>>>
>>>>>    arch/arm64/boot/dts/exynos/exynos7-espresso.dts |  349
>>>>> +++++++++++++++++++++++
>>>>>    1 file changed, 349 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>>>> b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>>>> index 838a3626dac1..8ce04a0ec928 100644
>>>>> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>>>> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>>>> @@ -53,6 +53,355 @@
>>>>>           status = "okay";
>>>>>    };
>>>>>
>>>>> +&hsi2c_4 {
>>>>> +       samsung,i2c-sda-delay = <100>;
>>>>> +       samsung,i2c-max-bus-freq = <200000>;
>>>>> +       status = "okay";
>>>>> +
>>>>> +       s2mps15_pmic at 66 {
>>>>> +               compatible = "samsung,s2mps15-pmic";
>>>>> +               reg = <0x66>;
>>>>> +               interrupts = <2 0>;
>>>>> +               interrupt-parent = <&gpa0>;
>>>>> +               pinctrl-names = "default";
>>>>> +               pinctrl-0 = <&pmic_irq>;
>>>>> +               wakeup-source;
>>>>> +
>>>>> +               s2mps15_osc: clocks {
>>>>> +                       compatible = "samsung,s2mps13-clk";
>>>>> +                       #clock-cells = <1>;
>>>>> +                       clock-output-names = "s2mps13_ap",
>>>>> "s2mps13_cp",
>>>>> +                               "s2mps13_bt";
>>>>> +               };
>>>>
>>>>
>>>> Don't you want to use one of these clocks for s3c-rtc (&rtc node)?
>>>>
>>> yes, you are right, rtc on this board is currently broken, mainly
>>> because of
>>> the introduction of rtc_src clock in the s3c-rtc driver.
>>> That is on my do list next. will take a look.
>>>
>>> Are you suggesting to remove this -clk node now and add along with rtc
>>> changes? I feel this should go in along with this patch.
>>
>> Just add it in consecutive patch in this series. You added here some
>> providers (clock and regulators) without consumers. This of course
>> looks good as a way of providing full description of the board but:
>> 1. For regulators always on: may be meaningless for kernel. Kernel
>> does not use it. Existence of regulator subnode will fulfill driver's
>> needs for probe.
>> 2. For clocks: actually will disable these clocks because of lack of
>> consumers... which is fine but probably not what you wanted.
>>
>> The standard approach is to add such providers when they are needed -
>> there are some consumers using them.
>>
> OK. for now will keep the pmic clock added as clock will be in disabled
> state, so it wont harm.
> - will keep system related regulator like supply to arm,mif,int etc ..
> will remove supplies to other peripherals IPs. Hope thats fine.

You don't have to remove other regulators (these without consumers).
Describe in DT all of regulators but:
1. Add to some of them consumers;
2. Disable these which are not needed (by not marking always-enabled).

Just like for all other boards.

Best regards,
Krzysztof
