From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 2 Nov 2015 22:52:43 +0900
Subject: [PATCH 1/2] arm64: dts: exynos7: Add pmic s2mps15 device tree node
In-Reply-To: <56375EB1.2090504@samsung.com>
References: <1446458641-4447-1-git-send-email-alim.akhtar@samsung.com>
 <CAJKOXPfrvuH8t3Pkf2Qt8VEfMR3qOeFKHrG0i3qUf94BR1y2tQ@mail.gmail.com>
 <56375EB1.2090504@samsung.com>
Message-ID: <CAJKOXPcPQD+3QinbaKcREQSn1yJCf2kQG0C4rhJtCS=W_25Gmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-02 22:01 GMT+09:00 Alim Akhtar <alim.akhtar@samsung.com>:
>>>
>>>   arch/arm64/boot/dts/exynos/exynos7-espresso.dts |  349
>>> +++++++++++++++++++++++
>>>   1 file changed, 349 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>> b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>> index 838a3626dac1..8ce04a0ec928 100644
>>> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>>> @@ -53,6 +53,355 @@
>>>          status = "okay";
>>>   };
>>>
>>> +&hsi2c_4 {
>>> +       samsung,i2c-sda-delay = <100>;
>>> +       samsung,i2c-max-bus-freq = <200000>;
>>> +       status = "okay";
>>> +
>>> +       s2mps15_pmic at 66 {
>>> +               compatible = "samsung,s2mps15-pmic";
>>> +               reg = <0x66>;
>>> +               interrupts = <2 0>;
>>> +               interrupt-parent = <&gpa0>;
>>> +               pinctrl-names = "default";
>>> +               pinctrl-0 = <&pmic_irq>;
>>> +               wakeup-source;
>>> +
>>> +               s2mps15_osc: clocks {
>>> +                       compatible = "samsung,s2mps13-clk";
>>> +                       #clock-cells = <1>;
>>> +                       clock-output-names = "s2mps13_ap", "s2mps13_cp",
>>> +                               "s2mps13_bt";
>>> +               };
>>
>>
>> Don't you want to use one of these clocks for s3c-rtc (&rtc node)?
>>
> yes, you are right, rtc on this board is currently broken, mainly because of
> the introduction of rtc_src clock in the s3c-rtc driver.
> That is on my do list next. will take a look.
>
> Are you suggesting to remove this -clk node now and add along with rtc
> changes? I feel this should go in along with this patch.

Just add it in consecutive patch in this series. You added here some
providers (clock and regulators) without consumers. This of course
looks good as a way of providing full description of the board but:
1. For regulators always on: may be meaningless for kernel. Kernel
does not use it. Existence of regulator subnode will fulfill driver's
needs for probe.
2. For clocks: actually will disable these clocks because of lack of
consumers... which is fine but probably not what you wanted.

The standard approach is to add such providers when they are needed -
there are some consumers using them.

>>> +
>>> +               regulators {
>>> +                       ldo1_reg: LDO1 {
>>> +                               regulator-name = "vdd_ldo1";
>>> +                               regulator-min-microvolt = <500000>;
>>> +                               regulator-max-microvolt = <900000>;
>>> +                               regulator-always-on;
>>> +                               regulator-enable-ramp-delay = <125>;
>>> +                       };

(...)

>>> +
>>> +                       buck10_reg: BUCK10 {
>>> +                               regulator-name = "vdd_buck10";
>>> +                               regulator-min-microvolt = <1000000>;
>>> +                               regulator-max-microvolt = <3000000>;
>>> +                               regulator-boot-on;
>>> +                               regulator-always-on;
>>> +                               regulator-ramp-delay = <25000>;
>>> +                               regulator-enable-ramp-delay = <250>;
>>> +                       };
>>
>>
>> All of these ldo3 and bucks in vendor tree for Espresso board have
>> ramp delay of 12000. Also they don't have enable-ramp-delay set and
>> voltages sometimes differ. I don't have S2MPS15 datasheet so I don't
>> know what is the true value... I'll leave it up to you but it looks
>> suspicious.
>>
> These values generally comes from our board design team, so I cann't really
> comment on that, it may vary from board revision etc.
> I will check if we have any updated version of recommended value and update
> accordingly.

Okay, just pointing the difference. I cannot verify them.

>
>>> +               };
>>> +       };
>>> +};
>>
>>
>> What will be the benefit of defining all of these regulators if they
>> are always on and without consumers? No one will disable them, no one
>> will change the voltage. Please provide some consumers.
>>
> As many drivers are not yet enabled in arm64 defconfig, that is one of the
> reason why we are not seeing many consumer for these nodes.

That is not a problem. Please send a patch changing the defconfig.
Usually defconfig (for armv7 this would be exynos and multi_v7) should
provide bootable and working environment for all of our supported
boards.

> This is the ground work being done for enabling those. If you insist will
> try to reduce what is being used now. Moreover this was used to verify
> functionality of pmic driver as well.

Actually as a verification I think even adding simple node
"regulators" is sufficient - driver will add all regulators anyway.
However seeing all regulators described for particular board is
good... but lack of consumers is disturbing because this may mean that
it was not really fully modeled.

>From my point of view - all of regulators in DT are welcomed but at
least some of them should have a consumer. This means that someone
took care and looked at the relationships between them.

Best regards,
Krzysztof
