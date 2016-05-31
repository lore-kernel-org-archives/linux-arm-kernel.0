From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 22:05:06 +0200
Subject: [PATCH 5/6] ARM: dts: exynos: Configure PWM, usb3503, PMIC and
 thermal on Odroid XU board
In-Reply-To: <1ec0f7fc-f6e0-e4d6-e424-43289bf31b16@osg.samsung.com>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
 <1464719945-3417-5-git-send-email-krzk@kernel.org>
 <1ec0f7fc-f6e0-e4d6-e424-43289bf31b16@osg.samsung.com>
Message-ID: <CAJKOXPfDtp1GLCkQQSKmzRLs4qqwY9Y019rXpUXSeoYQny-sfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 9:36 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Krzysztof,
>
> On 05/31/2016 02:39 PM, Krzysztof Kozlowski wrote:
>> Extend the DTS for Exynos5410-based Odroid XU board with:
>> 1. Proper PWM outputs,
>> 2. usb3503 USB HUB (with integrated LAN9730 ethernet adapter (smsc95xx)),
>> 3. Maxim 77802 PMIC (regulators, 32 kHz clocks, RTC),
>> 4. CPU thermal (trip points are the same as in Odroid XU3/XU4 but
>>    cooling maps are different as there is no CPU freq and only one
>>    cluster available for now),
>> 5. Regulator supplies for USB 3.0.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>
> [snip]
>
>> +
>> +                     ldo10_reg: LDO10 {
>> +                             regulator-name = "vdd18_mipi";
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <1800000>;
>> +                             regulator-always-on;
>> +                     };
>> +
>
> [snip]
>
>> +
>> +                     ldo12_reg: LDO12 {
>> +                             regulator-name = "vdd33_usb3";
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-always-on;
>> +                     };
>> +
>
> [snip]
>
>> +
>> +                     ldo15_reg: LDO15 {
>> +                             regulator-name = "vdd10_usb3";
>> +                             regulator-min-microvolt = <1000000>;
>> +                             regulator-max-microvolt = <1000000>;
>> +                             regulator-always-on;
>> +                     };
>> +
>
> I see that LDO 10, 12 and 15 are used by still marked as always-on. Did
> you try not marking as always-on those or that also causes issues like
> in the other regulators were you added comments about being always-on?
>
> Besides that, patch looks good to me.

The LDO10 is supplying few more elements (MIPI, HDMI, ADC and
something called EFNAND). Having it non-always-on still works but
maybe because I did not test these elements.

LDO12 and LDO15 supply also VDD10_HSIC and UHOST (used by USB2.0 ports
and attached on board: usb3503 and lan9730) so if it is not enabled by
USB 3.0, then they won't work. I guess the usb 2.0 driver should also
take regulators.

So overall the board works after removing always-on but it is not
properly described in DT so I prefer to leave them.

Best regards,
Krzysztof
