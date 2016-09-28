From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 28 Sep 2016 11:54:46 -0600
Subject: [PATCH 1/3] dt-bindings: Add a binding for the RPi firmware GPIO
 driver.
In-Reply-To: <1748463691.140438.2f32d916-fa80-4bce-8581-e02e1b204bda.open-xchange@email.1und1.de>
References: <20160919161314.25858-1-eric@anholt.net>
 <1903581972.81288.e9d48a65-997b-4986-a9d0-10632895df40.open-xchange@email.1und1.de>
 <fa11c543-2ad3-b2ae-f816-62a1acd42911@wwwdotorg.org>
 <1748463691.140438.2f32d916-fa80-4bce-8581-e02e1b204bda.open-xchange@email.1und1.de>
Message-ID: <00930ed5-52ca-1635-e09b-fdc836edccac@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2016 12:42 PM, Stefan Wahren wrote:
>
>> Stephen Warren <swarren@wwwdotorg.org> hat am 26. September 2016 um 18:38
>> geschrieben:
>>
>>
>> On 09/23/2016 12:39 PM, Stefan Wahren wrote:
>>> Hi Eric,
>>>
>>>> Eric Anholt <eric@anholt.net> hat am 19. September 2016 um 18:13
>>>> geschrieben:
>>>>
>>>>
>>>> The RPi firmware exposes all of the board's GPIO lines through
>>>> property calls.  Linux chooses to control most lines directly through
>>>> the pinctrl driver, but for the FXL6408 GPIO expander on the Pi3, we
>>>> need to access them through the firmware.
>>>>
>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>> ---
>>>>  .../bindings/gpio/gpio-raspberrypi-firmware.txt    | 22
>>>> ++++++++++++++++++++++
>>>>  1 file changed, 22 insertions(+)
>>>>  create mode 100644
>>>> Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>>>> b/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>>>> new file mode 100644
>>>> index 000000000000..2b635c23a6f8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>>>> @@ -0,0 +1,22 @@
>>>> +Raspberry Pi power domain driver
>>>> +
>>>> +Required properties:
>>>> +
>>>> +- compatible:		Should be "raspberrypi,firmware-gpio"
>>>
>>> i think the compatible should be more specific like
>>>
>>> raspberrypi,rpi3-firmware-gpio
>>>
>>> and all information which aren't requestable from the firmware should be
>>> stored
>>> in a info structure. This makes the driver easier to extend in the future by
>>> adding new compatibles and their info structures.
>>
>> Is this actually specific to the Pi3 at all?
>
> AFAIK only the Raspberry Pi 3 has a GPIO expander which is accessible via the
> common FW. My suggestion tries to follow the basic guideline "A precise
> compatible string is better than a vague one" from Device Tree for Dummies [1].
> So in case the next Raspberry Pi would have a different GPIO expander with
> different parameters we could add a new compatible.
>
> But you are right the word order in "rpi3-firmware-gpio" suggests that there are
> different FW which is wrong. At the end it's only a compatible string. So no
> strong opinion about the naming.
>
> [1] -
> https://events.linuxfoundation.org/sites/events/files/slides/petazzoni-device-tree-dummies.pdf

To deal with that requirement, what you'd want is the following:

RPi 1:
"raspberrypi,firmware-gpio"

RPi 2:
"raspberrypi,rpi2-firmware-gpio", "raspberrypi,firmware-gpio"

RPi 3:
"raspberrypi,rpi3-firmware-gpio", "raspberrypi,firmware-gpio"

Compatible values should always list both the most specific value and 
the baseline value that it's 100% backwards compatible with.

However, I don't think this argument applies in this case. It isn't the 
case that there's a separate Pi1 FW, Pi2 FW, Pi3 FW. Rather, there is a 
single FW image that runs on all (currently existing) Pis. As such, I 
believe that using solely "raspberrypi,firmware-gpio" is appropriate 
everywhere, since the thing being described is always the exact same 
thing with no variance.

This contrasts with HW modules in the SoC, since the different Pis 
really do have a different SoC, and hence potentially different HW 
modules, so e.g. compatible = "brcm,bcm2837-i2c", "brcm,bcm2835-i2c" 
could actually be useful.

>> Isn't the FW the same
>> across all Pis; the part that's specific to the Pi3 is whether it's
>> useful to use that API?
>>
>> As such, I'd suggest just raspberrypi,firmware-gpio as the compatible value.
