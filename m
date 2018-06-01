From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 1 Jun 2018 10:31:01 -0700
Subject: [PATCH 2/3] dts: sunxi: A64: Add PWM controllers
In-Reply-To: <20180601091816.klmc3nfzynxprcso@flea>
References: <20180601062901.8052-1-anarsoul@gmail.com>
 <20180601062901.8052-3-anarsoul@gmail.com>
 <20180601091816.klmc3nfzynxprcso@flea>
Message-ID: <CA+E=qVeAetBCxm3vHjXP8a3H=XSZR+M8X9mKTy3ML9vcW=rn8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2018 at 2:18 AM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Thu, May 31, 2018 at 11:29:00PM -0700, Vasily Khoruzhick wrote:
>> From: Andre Przywara <andre.przywara@arm.com>
>>
>> The Allwinner A64 SoC features two PWM controllers, which are fully
>> compatible to the one used in the A13 and H3 chips.
>>
>> Add the nodes for the devices (one for the "normal" PWM, the other for
>> the one in the CPUS domain) and the pins their outputs are connected to.
>>
>> On the A64 the "normal" PWM is muxed together with one of the MDIO pins
>> used to communicate with the Ethernet PHY, so it won't be usable on many
>> boards. But the Pinebook laptop uses this pin for controlling the LCD
>> backlight.
>>
>> On Pine64 the CPUS PWM pin however is routed to the "RPi2" header,
>> at the same location as the PWM pin on the RaspberryPi.
>>
>> [vasily: fixed comment message as requested by Stefan Bruens]
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com> on Pinebook (only the "normal" PWM)
>> Tested-by: Harald Geyer <harald@ccbib.org> on Teres-I (only the "normal" PWM)
>
> Same thing, you should have your SoB there. And I'm not sure the
> Tested-by format is valid. This information would be better in the
> commit log itself.

OK

>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 28 +++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index b5e903ccf0ec..e94bfa8477f6 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -365,6 +365,11 @@
>>                               bias-pull-up;
>>                       };
>>
>> +                     pwm_pin: pwm_pin {
>> +                             pins = "PD22";
>> +                             function = "pwm";
>> +                     };
>> +
>
> Is there multiple options for that muxing? If not, add it to the PWM
> node by default.

OK

>
>>                       rmii_pins: rmii_pins {
>>                               pins = "PD10", "PD11", "PD13", "PD14", "PD17",
>>                                      "PD18", "PD19", "PD20", "PD22", "PD23";
>> @@ -630,6 +635,15 @@
>>                       #interrupt-cells = <3>;
>>               };
>>
>> +             pwm: pwm at 1c21400 {
>> +                     compatible = "allwinner,sun50i-a64-pwm",
>> +                                  "allwinner,sun5i-a13-pwm";
>> +                     reg = <0x01c21400 0x400>;
>> +                     clocks = <&osc24M>;
>> +                     #pwm-cells = <3>;
>> +                     status = "disabled";
>> +             };
>> +
>>               rtc: rtc at 1f00000 {
>>                       compatible = "allwinner,sun6i-a31-rtc";
>>                       reg = <0x01f00000 0x54>;
>> @@ -667,6 +681,15 @@
>>                       #size-cells = <0>;
>>               };
>>
>> +             r_pwm: pwm at 1f03800 {
>> +                     compatible = "allwinner,sun50i-a64-pwm",
>> +                                  "allwinner,sun5i-a13-pwm";
>> +                     reg = <0x01f03800 0x400>;
>> +                     clocks = <&osc24M>;
>> +                     #pwm-cells = <3>;
>> +                     status = "disabled";
>> +             };
>> +
>>               r_pio: pinctrl at 1f02c00 {
>>                       compatible = "allwinner,sun50i-a64-r-pinctrl";
>>                       reg = <0x01f02c00 0x400>;
>> @@ -687,6 +710,11 @@
>>                               pins = "PL8", "PL9";
>>                               function = "s_i2c";
>>                       };
>> +
>> +                     r_pwm_pin: pwm {
>> +                             pins = "PL10";
>> +                             function = "s_pwm";
>> +                     };
>
> Ditto.

OK

>
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
