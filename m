From: ajaynumb@gmail.com (Ajay kumar)
Date: Mon, 25 Aug 2014 11:38:56 +0530
Subject: [PATCH 1/3] ARM: dts: Add DT changes for display on snow
In-Reply-To: <53F8713E.5040408@suse.de>
References: <1406317464-7525-1-git-send-email-ajaykumar.rs@samsung.com>
 <1406317464-7525-2-git-send-email-ajaykumar.rs@samsung.com>
 <53F8713E.5040408@suse.de>
Message-ID: <CAEC9eQNrTW8TJsCNwtQv6Tr15gfz1HJbJkSfUR8NLchvCGbVOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 4:17 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 25.07.2014 21:44, schrieb Ajay Kumar:
>> Add DT nodes for ptn3460 bridge chip and panel-simple panel.
>
> "simple-panel"
Ok.

>> Add backlight enable pin and backlight power supply for pwm-backlight.
>> Also add bridge phandle needed by dp to enable display on snow.
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5250-snow.dts |   40 +++++++++++++++++----------------
>>  1 file changed, 21 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>> index 6c36d41..f57f993 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>> @@ -270,7 +270,7 @@
>>                                       dcdc3 {
>>                                               ti,enable-ext-control;
>>                                       };
>> -                                     fet1 {
>> +                                     fet1: fet1 {
>>                                               regulator-name = "vcd_led";
>>                                               ti,overcurrent-wait = <3>;
>>                                       };
>> @@ -293,7 +293,7 @@
>>                                               regulator-always-on;
>>                                               ti,overcurrent-wait = <3>;
>>                                       };
>> -                                     fet6 {
>> +                                     fet6: fet6 {
>>                                               regulator-name = "lcd_vdd";
>>                                               ti,overcurrent-wait = <3>;
>>                                       };
>> @@ -342,6 +342,15 @@
>>                       pinctrl-0 = <&max98095_en>;
>>                       pinctrl-names = "default";
>>               };
>> +
>> +             ptn3460: ptn3460-bridge at 20 {
>
> "lvds-bridge"? (AF)
Ok.
>> +                     compatible = "nxp,ptn3460";
>> +                     reg = <0x20>;
>> +                     powerdown-gpios = <&gpy2 5 0>;
>> +                     reset-gpios = <&gpx1 5 0>;
>> +                     edid-emulation = <5>;
>> +                     panel = <&panel>;
>> +             };
>>       };
>>
>>       i2s0: i2s at 03830000 {
>> @@ -389,11 +398,13 @@
>>               vdd_pll-supply = <&ldo8_reg>;
>>       };
>>
>> -     backlight {
>> +     backlight: backlight {
>>               compatible = "pwm-backlight";
>>               pwms = <&pwm 0 1000000 0>;
>>               brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
>>               default-brightness-level = <7>;
>> +             enable-gpios = <&gpx3 0 0>;
>> +             power-supply = <&fet1>;
>>               pinctrl-0 = <&pwm0_out>;
>>               pinctrl-names = "default";
>>       };
>> @@ -403,6 +414,12 @@
>>               samsung,invert-vclk;
>>       };
>>
>> +     panel: panel-simple {
>
> Just "panel"? (AF)
>
>> +             compatible = "simple-panel";
>
> Use something more concrete than "simple-panel"? (Thierry)
Right.
>> +             power-supply = <&fet6>;
>> +             backlight = <&backlight>;
>> +     };
>> +
>>       dp-controller at 145B0000 {
>>               status = "okay";
>>               pinctrl-names = "default";
>> @@ -414,21 +431,6 @@
>>               samsung,link-rate = <0x0a>;
>>               samsung,lane-count = <2>;
>>               samsung,hpd-gpio = <&gpx0 7 0>;
>> -
>> -             display-timings {
>> -                     native-mode = <&timing1>;
>> -
>> -                     timing1: timing at 1 {
>> -                             clock-frequency = <70589280>;
>> -                             hactive = <1366>;
>> -                             vactive = <768>;
>> -                             hfront-porch = <40>;
>> -                             hback-porch = <40>;
>> -                             hsync-len = <32>;
>> -                             vback-porch = <10>;
>> -                             vfront-porch = <12>;
>> -                             vsync-len = <6>;
>> -                     };
>> -             };
>> +             bridge = <&ptn3460>;
>>       };
>>  };
>
> This patch will trivially conflict with my Snow cleanup [1]; ptn3460
> would go into the appropriate &i2c_* and this hunk into &dp then.
Yes, display-timings node should be removed from the DP DT node.
Should I rebase these DT patches on top of your cleanup series?

Ajay
