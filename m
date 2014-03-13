From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Thu, 13 Mar 2014 14:04:07 +0100
Subject: imx-drm: ldb and display power on sequence
In-Reply-To: <CAH9NwWfZ2MFmoXe7aJrE5mA1tsyOaJxbpz_g-AL_-r0dh1LUiQ@mail.gmail.com>
References: <CAH9NwWcE=4OVHSMKCEuTrFA7JMGEdkxrbX_0OORZ96N1Roi2HQ@mail.gmail.com>
 <1394114410.3622.14.camel@paszta.hi.pengutronix.de>
 <CAH9NwWfz4tBtuKqaJx_E4Y-a5eYwBaBPg2RgO4CFnE1Dfddi8A@mail.gmail.com>
 <CAH9NwWfZ2MFmoXe7aJrE5mA1tsyOaJxbpz_g-AL_-r0dh1LUiQ@mail.gmail.com>
Message-ID: <CAH9NwWfcq86PPZMTBz0mvwnmd=Uo_52Ym_dJFo1vKYp2kMsKFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-03-11 9:51 GMT+01:00 Christian Gmeiner <christian.gmeiner@gmail.com>:
> 2014-03-07 12:18 GMT+01:00 Christian Gmeiner <christian.gmeiner@gmail.com>:
>> Hi Philipp,
>>
>>> Am Donnerstag, den 06.03.2014, 13:34 +0100 schrieb Christian Gmeiner:
>>>> Hi all.
>>>>
>>>> On our custom board design (imx6d) we are using a TFT-display
>>>> connceted via LVDS.
>>>> The datasheet [0] says that the display needs a defined power up
>>>> sequence. I need
>>>> to control the following stuff:
>>>>
>>>> - LCD_ON (gpio2 3)
>>>> - Backlight ON (gpio2 0)
>>>> - PMW for dimm
>>>>
>>>> At the moment I have the backlight suff ready:
>>>>
>>>>        backlight {
>>>>                compatible = "pwm-backlight";
>>>>                pwms = <&pwm4 0 50000>;
>>>>                enable-gpios = <&gpio2 0 0>;
>>>>
>>>>                brightness-levels = <0 1 2 3 4>;
>>>>                default-brightness-level = <4>;
>>>>        };
>>>>
>>>> Now I only need to enable the LCD_ON and wait 40ms before turning on
>>>> the LVDS clocks and data.
>>>
>>> This can be done by adding a regulator-enable-ramp-delay property to the
>>> gpio regulator.
>>>
>>
>> Correct.
>>
>>>> For this I tought to add a regulator support in
>>>> imx_ldb_encoder_commit(..) of imx-ldb.c.
>>>>That should give me the correct sequence for
>>>> LVDS on to LVDS data/clock. Now I only need to get the pwm-backlight
>>>> driver doing its work after ldb is ready.
>>>
>>> We should rather add drm_panel support to imx-ldb. I have just sent a
>>> patch for this.
>>> The simple-panel driver already supports regulator and backlight.
>>>
>>
>> I am still life in the world of a stable kernel called 3.13.6 :) Will
>> backport the simple-panel driver
>> and will have a look at your patches - today.
>>
>
> I backported your patch and updated my dts file. It looks better now
> but one thing is does not work.
> The datasheet says I need to enable the lcd, enable LVDS data and then
> I can enable the backlight.
> With the simple panel following happens:
>
> panel_simple_enable:
> - regulator_enable(p->supply);
> - gpio_set_value
> - backlight_update_status
>
> The result of this sequence are graphical glitches and a ghost picture
> on the panel. Need to think
> about it to find a good solution for it. Maybe there should be a 2 way
> init phase for a panel.
> - preinit - turn on power-supply and set gpio
> - init ipu
> - postinit - unblank backlight
>

Okay... I am getting everything to work as expected but I am using
some hacks, which I hope to get
rid of. There is one simple 'problem' with my pwm-backlight.

        backlight: backlight {
                compatible = "pwm-backlight";
                pwms = <&pwm4 0 50000>;
                enable-gpios = <&gpio2 0 0>;

                brightness-levels = <0 1 ... 100>
                default-brightness-level = <100>;
        };

        panel: panel {
                compatible = "simple-panel";
                power-supply = <&reg_lcd_on>;
                backlight = <&backlight>;
        };

The pwn-backlight driver gets loaded before imx-drm/simple panel
dirver. The result is that the backlight
gets turned on but the whole drm subsystem is not ready -> gohst
picture from last reboot get shown.
At the moment I removed the backlight_update_status(bl); call from the
pwm-backlight driver (probe function).
Is there a better way to do it?

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
