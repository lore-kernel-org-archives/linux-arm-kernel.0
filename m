From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Sep 2016 10:40:55 -0600
Subject: [PATCH 1/3] dt-bindings: Add a binding for the RPi firmware GPIO
 driver.
In-Reply-To: <87ponu931e.fsf@eliezer.anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
 <CACRpkdb-hRjD+FmyZ4SKurp94V=HR3L90OLNc-6eUKuy9AK_Rg@mail.gmail.com>
 <87ponu931e.fsf@eliezer.anholt.net>
Message-ID: <79e6dbb1-f76f-2a43-28d1-35ad04a35e14@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2016 07:08 AM, Eric Anholt wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> On Mon, Sep 19, 2016 at 6:13 PM, Eric Anholt <eric@anholt.net> wrote:
>>
>>> The RPi firmware exposes all of the board's GPIO lines through
>>> property calls.  Linux chooses to control most lines directly through
>>> the pinctrl driver, but for the FXL6408 GPIO expander on the Pi3, we
>>> need to access them through the firmware.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>
>> Aha
>>
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>>> @@ -0,0 +1,22 @@
>>> +Raspberry Pi power domain driver
>>
>> Really? :)
>
> Thanks.
>
>>> +Required properties:
>>> +
>>> +- compatible:          Should be "raspberrypi,firmware-gpio"
>>
>> Usually this is vendor,compat, is the vendors name "raspberrypi"?
>
> Yes, this driver is for part of the Raspberry Pi Foundation's firmware
> code (you can find the same pattern in the firmware and firmware power
> domain drivers).
>
>>> +- gpio-controller:     Marks the device node as a gpio controller
>>> +- #gpio-cells:         Should be <2> for GPIO number and flags
>>> +- ngpios:              Number of GPIO lines to control.  See gpio.txt
>>
>> Is this ever anything else than 8? Else omit it and hardcode
>> 8 in the driver instead.
>
> (see below)
>
>>> +- firmware:            Reference to the RPi firmware device node
>>
>> Reference the DT binding for this.
>>
>>> +- raspberrypi,firmware-gpio-offset:
>>> +                       Number the firmware uses for the first GPIO line
>>> +                         controlled by this driver
>>
>> Does this differ between different instances of this hardware or
>> can it just be open coded in the driver instead?
>
> This is which range (128-135) of the firmware's GPIOs we're controlling.
> If another GPIO expander appears later (quite believable, I think
> they're down to 1 spare line on this expander), then we would just make
> another node with a new offset and ngpios for that expander.

Why would we make another node for that? Wouldn't we always have a 
single node to represent the FW's control over GPIOs, and have that node 
expose all GPIOs that the FW supports. Which GPIO IDs clients actually 
use will simply be determined by the HW schematic, and kernel-side SW 
would just act as a conduit to pass those IDs between clients and the FW.

> Sort of related: I also worry that we have races with the firmware for
> the platform GPIO bits, since both ARM and firmware are doing RMWs (or,
> even worse, maybe just Ws?) of the registers controlled by the pinctrl
> driver.  Hopefully I can get the firmware to pass control of devices
> like this over to Linux, with firmware making requests to us, but I
> don't know if that will happen and we may need to access other GPIOs
> using this interface :(

Aren't there write-to-set/write-to-clear registers? If not, then either 
FW owns everything in a particular register or Linux does; the HW won't 
allow sharing.
