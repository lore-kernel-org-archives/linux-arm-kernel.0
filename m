From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 7 Dec 2014 23:18:28 +0800
Subject: [PATCH 08/10] ARM: dts: sun9i: Enable mmc0 on A80 Optimus Board
In-Reply-To: <20141207150249.GG12434@lukather>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-9-git-send-email-wens@csie.org>
 <20141207150249.GG12434@lukather>
Message-ID: <CAGb2v67w6gQki1Vjvzr_OYYAdMU0tefS0_c2qCrpQs2Po=-qZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 7, 2014 at 11:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Wed, Dec 03, 2014 at 02:36:03PM +0800, Chen-Yu Tsai wrote:
>> Enable the micro-sd slot on the A80 Optimus Board, which is connected to
>> mmc0. This adds the card-detect gpio and enables mmc0.
>>
>> This patch also adds a 3V fixed regulator, which is the default I/O
>> voltage level.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  arch/arm/boot/dts/sun9i-a80-optimus.dts | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
>> index 506948f..02a4aa7 100644
>> --- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
>> +++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
>> @@ -59,6 +59,16 @@
>>       };
>>
>>       soc {
>> +             mmc0: mmc at 01c0f000 {
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_optimus>;
>> +                     vmmc-supply = <&reg_vcc3v0>;
>> +                     bus-width = <4>;
>> +                     cd-gpios = <&pio 7 18 0>; /* PH8 */
>> +                     cd-inverted;
>> +                     status = "okay";
>> +             };
>> +
>>               pio: pinctrl at 06000800 {
>>                       i2c3_pins_a: i2c3 at 0 {
>>                               /* Enable internal pull-up */
>> @@ -72,6 +82,13 @@
>>                               allwinner,pull = <0>;
>>                       };
>>
>> +                     mmc0_cd_pin_optimus: mmc0_cd_pin at 0 {
>> +                             allwinner,pins = "PH18";
>> +                             allwinner,function = "gpio_in";
>> +                             allwinner,drive = <0>;
>> +                             allwinner,pull = <1>;
>> +                     };
>> +
>>                       uart4_pins_a: uart4 at 0 {
>>                               /* Enable internal pull-up */
>>                               allwinner,pull = <1>;
>> @@ -116,4 +133,11 @@
>>                       gpios = <&pio 7 0 0>;
>>               };
>>       };
>> +
>> +     reg_vcc3v0: vcc3v0 {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "vcc3v0";
>> +             regulator-min-microvolt = <3000000>;
>> +             regulator-max-microvolt = <3000000>;
>> +     };
>
> There's already such a regulator in sunxi-common-regulators.

I cannot include sunxi-common-regulators, not without a lot of work.
sunxi-common-regulators includes a soc/pio node, but the addresses,
and thus the node names are different. This results in:

ERROR (duplicate_label): Duplicate label 'pio' on
/soc at 01c00000/pinctrl at 01c20800 and /soc/pinctrl at 06000800

If we move to preprocessor-based includes and phandle referencing
(&pio { .... })
to override/add nodes and properties, then it would work. But that is
a lot of work
going through all of our DTs.

I'd prefer getting things working first, and do the rework later. As far as DT
compatibility goes, there shouldn't be any difference in the DTB.

ChenYu
