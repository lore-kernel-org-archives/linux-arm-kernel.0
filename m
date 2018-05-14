From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 May 2018 18:05:14 +0530
Subject: [PATCH V3] ARM: dts: da850-evm: Enable LCD and Backlight
In-Reply-To: <CAHCN7xJgTBGHL_VzhXGz1HEmEn-LW8pcG0BWJDysx0pkHXT-Mg@mail.gmail.com>
References: <20180513232033.22571-1-aford173@gmail.com>
 <aba13450-1e8f-4aed-6248-16b71abcc0dd@ti.com>
 <CAHCN7xJgTBGHL_VzhXGz1HEmEn-LW8pcG0BWJDysx0pkHXT-Mg@mail.gmail.com>
Message-ID: <825847d0-c29c-859b-43fd-0987f94e28a5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2018 04:22 PM, Adam Ford wrote:
> On Mon, May 14, 2018 at 12:29 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> Hi Adam,
>>
>> On Monday 14 May 2018 04:50 AM, Adam Ford wrote:
>>> When using the board files the LCD works, but not with the DT.
>>> This adds enables the original da850-evm to work with the same
>>> LCD in device tree mode.
>>>
>>> The EVM has a gpio for the regulator and a gpio enable.  The LCD and
>>> the vpif display pins are mutually exclusive, so if using the LCD,
>>> do not load the vpif driver.
>>
>> Its not sufficient just note this in patch description.
>>
>> a) Disable (status = "disabled") the VPIF node which clashes for pins
>> with LCD.
>> b) Add a comment on top of the status = "disabled" giving information on
>> how user can enable it (disable lcdc node and then change to status =
>> "okay").
>>
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>> V3:  Fix errant GPIO, label GPIO pins, and rename the regulator to be more explict to
>>>      backlight which better matches the schematic.  Updated the description to explain
>>>      that it cannot be used at the same time as the vpif driver.
>>>
>>> V2:  Add regulator and GPIO enable pins. Remove PWM backlight and replace with GPIO
>>>
>>> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
>>> index 2e817da37fdb..3f1c8be07efe 100644
>>> --- a/arch/arm/boot/dts/da850-evm.dts
>>> +++ b/arch/arm/boot/dts/da850-evm.dts
>>> @@ -27,6 +27,50 @@
>>>               spi0 = &spi1;
>>>       };
>>>
>>> +     backlight {
>>> +             compatible = "gpio-backlight";
>>> +             enable-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>; /* GP0[7] */
>>
>> The gpio-backlight binding does not describe a property called
>> enable-gpios. It should just be gpios.
> 
> I will fix that.
> 
>>
>> a) Are you using gpio-backlight because you are not able to get the PWM
>> to work?
>>
> Yes,  You told me not to worry about doing a PWM backlight because the
> legacy board does not PWM either.

Yeah, I meant not to add backlight control till the time we are able to
get it working using PWM. Is this needed for the basic LCD functionality
to work? I would like to avoid the churn of adding it using GPIO now and
changing to PWM later, if possible.

> 
>> b) What is GP0[7] connected to in the schematic you have? In the
>> schematic I have I see LCD_PWM0 is connected to
>> SPI1_SCS[0]/EPWM1B/GP2[14]/TM64P3_IN12.
> 
> I have schematic 1016572 dated Wednesday, August 18, 2010.  According
> to it, AXR15 / EPWMN0_TZ[0] / ECAP2_APWM2 / GPIO0[7] connects to U25,
> Pin 46 to generate M_LCD_PWM0.  You might have one of the early,
> pre-release versions.

Ah, okay. In your schematic, is GP2[14] connected to anything?

> 
>>
>> c) The /* GP0[7] */ comment is not really useful on its own as it can be
>> computed. What I wanted to see is the schematic symbol like "LCD_PWM0".
>> Same for other places like this below.
> 
> I can do that.
>>
>>> @@ -35,6 +79,16 @@
>>>               regulator-boot-on;
>>>       };
>>>
>>> +     backlight_reg: backlight-regulator {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "lcd_backlight_pwr";
>>> +             regulator-min-microvolt = <3300000>;
>>> +             regulator-max-microvolt = <3300000>;
>>> +             gpio = <&gpio 47 GPIO_ACTIVE_HIGH>; /* GP2[15] */
>>> +             regulator-always-on;
>>
>> Why should this regulator never be disabled?
> 
> The gpio-backlight does not have a way that I can see to associate the
> regulator to it.  I read through the bindings, but I didn't see an
> option to associate a regulator it.  I use this regulator to drive
> lcd_backlight_pwr and the backlight driver to write lcd_pwm0.  Without
> this option, the system disables lcd_backlight_pwr and the screen is
> blank

It sounds like this is a hack to enable backlight on this board. I think
either the backlight driver needs to gain functionality to enable the
GPIO. Or backlight could be treated as part of the panel and enabled
using enable-gpios property in the panel. TBH, I will be okay either
way. Can you check with Jyri, Tomi and rest of the DRM folks on what
should be right way of dealing with this?

Thanks,
Sekhar
