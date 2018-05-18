From: aford173@gmail.com (Adam Ford)
Date: Fri, 18 May 2018 07:50:57 -0500
Subject: [PATCH V5] ARM: dts: da850-evm: Enable LCD and Backlight
In-Reply-To: <2be19e7a-904e-379f-57d9-99e4c557241d@ti.com>
References: <20180518005935.29104-1-aford173@gmail.com>
 <2be19e7a-904e-379f-57d9-99e4c557241d@ti.com>
Message-ID: <CAHCN7xLYH5tgrYnogwBQMZfW6hBCppqW_weG8q5Or2zTAd5J4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 7:37 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> Hi Adam,
>
> On Friday 18 May 2018 06:29 AM, Adam Ford wrote:
>> When using the board files the LCD works, but not with the DT.
>> This adds enables the original da850-evm to work with the same
>> LCD in device tree mode.
>>
>> The EVM has a gpio for the regulator and a PWM for dimming the
>> backlight.  The LCD and the vpif display pins are mutually
>> exclusive, so if using the LCD, do not load the vpif driver.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Looks good mostly, some comments below.

Thanks.  I think this is cleaner too.
>
>> ---
>> V5:  Resync against v4.18/dt
>>
>> V4:  Move the backlight to PWM, so the driver can control the regulator allowing the
>>      regulator to power down and enabling the ability to change the brightness of the
>>      backlight
>>
>> V3:  Fix errant GPIO, label GPIO pins, and rename the regulator to be more explict to
>>      backlight which better matches the schematic.  Updated the description to explain
>>      that it cannot be used at the same time as the vpif driver.
>>
>> V2:  Add regulator and GPIO enable pins. Remove PWM backlight and replace with GPIO
>>
>> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
>> index 0e82bb988fde..5bf6ea513b12 100644
>> --- a/arch/arm/boot/dts/da850-evm.dts
>> +++ b/arch/arm/boot/dts/da850-evm.dts
>> @@ -27,6 +27,58 @@
>>               spi0 = &spi1;
>>       };
>>
>> +     backlight:backlight-pwm {
>
> Leave a space after the ':' as is the norm.
>
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&ecap2_pins>;
>> +             power-supply = <&backlight_reg>;
>> +             compatible = "pwm-backlight";
>> +             pwms = <&ecap2 0 50000 0>;
>> +             brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
>> +             default-brightness-level = <7>;
>
> Are you able to notice some brightness change at each of these levels?

I am and to change the brightness, but it won't work and pre-released
hardware, because the PWM pins moved around.  The schematic needs to
be 1015171 (15 March 2010), Rev A or newer.  I don't believe the older
versions were released to the public outside Logic PD or TI, but a lot
of that is before my time.  This patch should be the released
hardware.

The changes between the beta release and Rev A include:

Corrected connection of GND_PACK to U32
Connected AXR15 / EPWM0TZ[0] / ECAP2_APWM2 / GP0[7] to J2.99 and U25.46
Added R216-R221, Q10-Q11
Added SPI1_SCS[0] /EPWM1B/GP2[14] /TM64P3_IN12 to J3.36


>
>> +     };
>> +
>> +     panel {
>> +             compatible = "ti,tilcdc,panel";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&lcd_pins>;
>> +             /* The vpif and the LCD are mutually exclusive.
>> +              * To enable VPIF, change the status below to 'disabled' then
>> +              * then change the status of the vpif below to 'okay' */
>
> Please follow the multi-line comment style described in
> Documentation/process/coding-style.rst

I will look that up. Thanks

>
>> +             status = "okay";
>> +             enable-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>; /* lcd_panel_pwr */
>> +
>> +             panel-info {
>> +                     ac-bias         = <255>;
>> +                     ac-bias-intrpt  = <0>;
>> +                     dma-burst-sz    = <16>;
>> +                     bpp             = <16>;
>> +                     fdd             = <0x80>;
>> +                     sync-edge       = <0>;
>> +                     sync-ctrl       = <1>;
>> +                     raster-order    = <0>;
>> +                     fifo-th         = <0>;
>> +             };
>> +
>> +             display-timings {
>> +                     native-mode = <&timing0>;
>> +                     timing0: 480x272 {
>> +                             clock-frequency = <9000000>;
>> +                             hactive = <480>;
>> +                             vactive = <272>;
>> +                             hfront-porch = <3>;
>> +                             hback-porch = <2>;
>> +                             hsync-len = <42>;
>> +                             vback-porch = <3>;
>> +                             vfront-porch = <4>;
>> +                             vsync-len = <11>;
>> +                             hsync-active = <0>;
>> +                             vsync-active = <0>;
>> +                             de-active = <1>;
>> +                             pixelclk-active = <1>;
>> +                     };
>> +             };
>> +     };
>> +
>>       vbat: fixedregulator0 {
>>               compatible = "regulator-fixed";
>>               regulator-name = "vbat";
>> @@ -35,6 +87,15 @@
>>               regulator-boot-on;
>>       };
>>
>> +     backlight_reg: backlight-regulator {
>
> "backlight_lcd:" perhaps?

Sure

>
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "lcd_backlight_pwr";
>> +             regulator-min-microvolt = <3300000>;
>> +             regulator-max-microvolt = <3300000>;
>> +             gpio = <&gpio 47 GPIO_ACTIVE_HIGH>; /* lcd_backlight_pwr */
>> +             enable-active-high;
>> +     };
>> +
>>       sound {
>>               compatible = "simple-audio-card";
>>               simple-audio-card,name = "DA850/OMAP-L138 EVM";
>> @@ -63,6 +124,10 @@
>>       };
>>  };
>>
>> +&ecap2 {
>> +     status = "okay";
>> +};
>> +
>>  &pmx_core {
>>       status = "okay";
>>
>> @@ -109,6 +174,10 @@
>>       status = "okay";
>>  };
>>
>> +&lcdc {
>> +     status = "okay";
>> +};
>> +
>>  &i2c0 {
>>       status = "okay";
>>       clock-frequency = <100000>;
>> @@ -336,5 +405,8 @@
>>  &vpif {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
>> -     status = "okay";
>> +     /* The vpif and the LCD are mutually exclusive.
>> +      * To enable VPIF, disable the ti,tilcdc,panel then
>> +      * changed the status below to 'okay' */
>
> Here too, please follow the multi-line comment style.

will do.

>
>> +     status = "disabled";
>
> Thanks,
> Sekhar

Thank you

adam
