From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 29 Oct 2014 10:02:09 +0800
Subject: [PATCH 4/6] ARM: dts: sun9i: Add GPIO LEDs for A80 Optimus board
In-Reply-To: <54500866.7060909@suse.de>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
 <1414489843-2680-5-git-send-email-wens@csie.org>
 <20141028201605.GA9255@lukather> <54500866.7060909@suse.de>
Message-ID: <CAGb2v67VCYETh=1ioUroXL1qKazVjNpPiseFXBb1i-1Qfs9zyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 29, 2014 at 5:19 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi,
>
> Am 28.10.2014 um 21:16 schrieb Maxime Ripard:
>> Hi Chen-Yu,
>>
>> On Tue, Oct 28, 2014 at 05:50:41PM +0800, Chen-Yu Tsai wrote:
>>> The A80 Optimus board has 3 usable LEDs that are controlled via GPIO.
>>>
>>> This patch adds support for 2 of them which are driver by GPIOs in the
>>> main pin controller. The remaining one uses GPIO from the R_PIO
>>> controller, which we don't support yet.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>  arch/arm/boot/dts/sun9i-a80-optimus.dts | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
>>> index 25fe775..91eda76 100644
>>> --- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
>>> +++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
>>> @@ -64,6 +64,13 @@
>>>                              /* Enable internal pull-up */
>>>                              allwinner,pull = <1>;
>>>                      };
>>> +
>>> +                    led_pins_optimus: led_pins at 0 {
>
> Here too, led-pins at 0 would be more in line with DT conventions.

Ok. To be fair we were mixing usage in the past, with most of
them using underscores.

>>> +                            allwinner,pins = "PH0", "PH1";
>>> +                            allwinner,function = "gpio_out";
>>> +                            allwinner,drive = <0>;
>>> +                            allwinner,pull = <0>;
>>> +                    };
>>>              };
>>>
>>>              uart0: serial at 07000000 {
>>> @@ -78,4 +85,22 @@
>>>                      status = "okay";
>>>              };
>>>      };
>>> +
>>> +    leds {
>>> +            compatible = "gpio-leds";
>>> +            pinctrl-names = "default";
>>> +            pinctrl-0 = <&led_pins_optimus>;
>>> +
>>> +            led2 {
>>> +                    label = "a80_optimus:led2:usr";
>>
>> We're usually using a dash instead of an underscore as a separator.
>
> I wonder, why a80_? The board is labeled "Allwinner Tech Optimus Board",
> and the Cubietruck LEDs are not prefixed with a20_ either.

IIRC, The board was first marketed as "A80 Optimus Board". Merrii's
website now lists it as "A80 OptimusBoard", while as you said, the
board itself is labeled "Allwinner Tech Optimus Board"

Furthermore, the dts has model = "Merrii A80 Optimus Board".
Anyway, I'll drop the a80_ prefix, unless someone thinks we should
keep it.

>>> +                    gpios = <&pio 7 0 0>;
>>> +            };
>>> +
>>> +            /* led3 is on PM15, in R_PIO */
>>
>> You were saying that there is three LEDs, why start the numbering at
>> 2?
>
> They are labeled "LED2", "LED4", "LED3" right-to-left.
> Additionally there's a "PWR" LED, maybe that counts as number 1...
>
>>> +
>>> +            led4 {
>>> +                    label = "a80_optimus:led4:usr";
>>> +                    gpios = <&pio 7 1 0>;
>>> +            };
>>> +    };
>>>  };
>>
>> The rest of your patchset is fine for me, we just need to get the
>> pinctrl driver merged first :)

Cheers
ChenYu
