From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 10:52:42 +0530
Subject: [PATCH v4 1/5] ARM: dts: enable hdmi for exynos5250 based snow
 board
In-Reply-To: <5373C6D7.8010802@gmail.com>
References: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
 <1400035562-16832-2-git-send-email-rahul.sharma@samsung.com>
 <5373C6D7.8010802@gmail.com>
Message-ID: <CAPdUM4Ndn9Y7=SF0BG-j16vCHt_4EDOZSuHEV36NTUovM7FcNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On 15 May 2014 01:11, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Rahul,
>
> On 14.05.2014 04:45, Rahul Sharma wrote:
>> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>>
>> Enable support for HDMI for exynos5250 based Snow board.
>>
>> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5250-cros-common.dtsi |    6 +++++-
>>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi     |    7 +++++++
>>  arch/arm/boot/dts/exynos5250-snow.dts         |    7 +++++++
>>  3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> index 2c1560d..89ac90f 100644
>> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> @@ -240,7 +240,7 @@
>>               samsung,i2c-sda-delay = <100>;
>>               samsung,i2c-max-bus-freq = <378000>;
>>
>> -             hdmiphy at 38 {
>> +             hdmiphy: hdmiphy at 38 {
>>                       compatible = "samsung,exynos4212-hdmiphy";
>>                       reg = <0x38>;
>>               };
>> @@ -304,6 +304,10 @@
>>
>>       hdmi {
>>               hpd-gpio = <&gpx3 7 0>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&hdmi_hpd_irq>;
>> +             phy = <&hdmiphy>;
>> +             ddc = <&i2c_2>;
>>       };
>>
>>       gpio-keys {
>> diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
>> index 9a49e68..da3ae66 100644
>> --- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
>> @@ -560,6 +560,13 @@
>>                       samsung,pin-pud = <0>;
>>                       samsung,pin-drv = <0>;
>>               };
>> +
>> +             hdmi_hpd_irq: hdmi-hpd-irq {
>> +                     samsung,pins = "gpx3-7";
>> +                     samsung,pin-function = <0>;
>> +                     samsung,pin-pud = <1>;
>> +                     samsung,pin-drv = <0>;
>> +             };
>
> Based on the fact that this is just being configured as input, I don't
> think this is a generic special function, but rather a board-specific
> GPIO, which should be defined in dts of respective board.
>

Ok.

>>       };
>>
>>       pinctrl at 13400000 {
>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>> index 1ce1088..696850a 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>> @@ -206,4 +206,11 @@
>>                       clock-frequency = <24000000>;
>>               };
>>       };
>> +
>> +     hdmi {
>> +             hdmi-en-supply = <&tps65090_fet7>;
>> +             vdd-supply = <&ldo8_reg>;
>> +             vdd_osc-supply = <&ldo10_reg>;
>> +             vdd_pll-supply = <&ldo8_reg>;
>
> Hmm, those regulators don't seem to be listed in
> Documentation/devicetree/bindings/video/exynos_hdmi.txt, at least in
> today's linux-next. The driver seems to use them, though.
>
> This isn't a problem with this patch, but if you're working on this,
> could you also fix the documentation in separate patch?
>

I will post another patch for documentation update.

Regards,
Rahul Sharma.

> Best regards,
> Tomasz
