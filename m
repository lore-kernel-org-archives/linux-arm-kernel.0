From: ajaynumb@gmail.com (Ajay kumar)
Date: Mon, 4 Aug 2014 14:22:06 +0530
Subject: [PATCH V2] ARM: dts: Add DT changes for display on peach_pi
In-Reply-To: <53DBC641.3090601@suse.de>
References: <1406910258-28036-1-git-send-email-ajaykumar.rs@samsung.com>
 <53DBC641.3090601@suse.de>
Message-ID: <CAEC9eQNskPt_BFZd7Ed2Faii4dEbjj597HArK2sYMyWL4Sk7UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

Thanks for the comments.

On Fri, Aug 1, 2014 at 10:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi,
>
> Am 01.08.2014 18:24, schrieb Ajay Kumar:
>> Add DT nodes for panel-simple "auo,b133htn01" panel.
>> Add backlight enable pin and backlight power supply for pwm-backlight.
>> Also add panel phandle needed by dp to enable display on peach_pi.
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> ---
>> Changes since V1:
>> Remove "simple-panel" compatible string and use only ""auo,b133htn01".
>>
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts |   27 ++++++++++-----------------
>>  1 file changed, 10 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> index f3ee48b..f8c2e61 100644
>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> @@ -28,11 +28,13 @@
>>               i2c20 = "/spi at 12d40000/cros-ec at 0/i2c-tunnel";
>>       };
>>
>> -     backlight {
>> +     backlight: backlight {
>>               compatible = "pwm-backlight";
>>               pwms = <&pwm 0 1000000 0>;
>>               brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
>>               default-brightness-level = <7>;
>> +             enable-gpios = <&gpx2 2 0>;
>
> For Spring I was asked to use GPIO_ACTIVE_* - here that would mean
> s/0/GPIO_ACTIVE_HIGH/ IIUC and if necessary
> #include <dt-bindings/gpio/gpio.h> before the .dtsi #include.
Ok. I will use  it.

> A modified version of your patch for Snow, rebased onto my cleanups, can
> be found on my spring-next branch.
>
>> +             power-supply = <&tps65090_fet1>;
>>               pinctrl-0 = <&pwm0_out>;
>>               pinctrl-names = "default";
>>       };
>> @@ -98,6 +100,12 @@
>>               regulator-boot-on;
>>               regulator-always-on;
>>       };
>> +
>> +     panel: panel-simple {
>
> Nit: panel-simple seems backwards in English language, and given that
> simple-panel would be referring to the implementation, I used just
> "panel" for Spring.
Right. All the platforms just use "panel". I will use the same.

>> +             compatible = "auo,b133htn01";
>
> FWIW this depends on auo,b133htn01 getting added to Documentation and
> panel-simple, which I think hasn't happened yet?
>
> https://patchwork.kernel.org/patch/4625321/
This version is already old ;)
Latest version is here:
http://www.spinics.net/lists/devicetree/msg44158.html
I hope it will be(is?) merged!

Ajay

>> +             power-supply = <&tps65090_fet6>;
>> +             backlight = <&backlight>;
>> +     };
>>  };
>>
>>  &dp {
>> @@ -111,22 +119,7 @@
>>       samsung,link-rate = <0x0a>;
>>       samsung,lane-count = <2>;
>>       samsung,hpd-gpio = <&gpx2 6 0>;
>> -
>> -     display-timings {
>> -             native-mode = <&timing1>;
>> -
>> -             timing1: timing at 1 {
>> -                     clock-frequency = <150660000>;
>> -                     hactive = <1920>;
>> -                     vactive = <1080>;
>> -                     hfront-porch = <60>;
>> -                     hback-porch = <172>;
>> -                     hsync-len = <80>;
>> -                     vback-porch = <25>;
>> -                     vfront-porch = <10>;
>> -                     vsync-len = <10>;
>> -             };
>> -     };
>> +     panel = <&panel>;
>>  };
>>
>>  &fimd {
>
> Regards,
> Andreas
>
> --
> SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
