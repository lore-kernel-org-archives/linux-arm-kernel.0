From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 19:32:39 +0200
Subject: [PATCH/RFT v2 12/17] USB: ochi-da8xx: Use a regulator for
 vbus/overcurrent
In-Reply-To: <09a4391e-63b6-1622-f964-4aff0ecae87c@lechnology.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-13-ahaslam@baylibre.com>
 <672c1f1a-58b7-6947-7fb2-acd38fab8597@lechnology.com>
 <CAKXjFTOxQ58rThpPw9t73k-BBZ8YKGvMhWfAG1r+3kC=GJVxWg@mail.gmail.com>
 <09a4391e-63b6-1622-f964-4aff0ecae87c@lechnology.com>
Message-ID: <CAKXjFTNrmmP++_xRq74G0Kx52R5w5TjTRukC=uB7rGwz8+EqUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 6:53 PM, David Lechner <david@lechnology.com> wrote:
> On 10/25/2016 03:24 AM, Axel Haslam wrote:
>>
>> On Tue, Oct 25, 2016 at 3:39 AM, David Lechner <david@lechnology.com>
>> wrote:
>>>
>>> On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
>>>>
>>>>
>>>> From: Axel Haslam <ahaslam@baylibre.com>
>>>>
>>>> Currently, the da8xx ohci driver uses a set of gpios and callbacks in
>>>> board files to handle vbus and overcurrent irqs form the power supply.
>>>> However, this does not play nice when moving to a DT based boot were
>>>> we wont have board files.
>>>>
>>>> Instead of requesting and handling the gpio, use the regulator framework
>>>> to take care of enabling and disabling vbus power.
>>>> This has the benefit
>>>> that we dont need to pass any more platform data to the driver:
>>>>
>>>> These will be handled by the regulator framework:
>>>> set_power   ->  regulator_enable/regulator_disable
>>>> get_power   ->  regulator_is_enabled
>>>> get_oci     ->  regulator_get_mode
>>>> ocic_notify ->  regulator notification
>>>>
>>>> We can keep the default potpgt and use the regulator start delay
>>>> instead:
>>>> potpgt      -> regulator startup delay time
>>>>
>>>> The hawk board does not have a GPIO/OVERCURRENT gpio to control vbus,
>>>> (they should not have been decleared/reserved) so, just remove those
>>>> definitions from the hwk board file.
>>>>
>>>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>>>> ---
>>>
>>>
>>>
>>>
>>> How do you recover after an overcurrent event?
>>>
>>> I have configured a fixed-regulator using device-tree, but similar to the
>>> configuration in the board files here. However, when I shorted out the
>>> VBUS
>>> and caused an overcurrent event, I see nothing in the kernel log saying
>>> that
>>> there was an overcurrent event and after I remove the short, the
>>> regulator
>>> is never turned back on.
>>>
>>>
>>
>> You should have the patch to fix gpiolib, and you should declare the
>> over current gpio on the regulator as such:
>> (if the pin is enabled high you should add oc-active-high);
>>
>>        vbus_fixed: fixed-regulator-vbus {
>>                compatible = "regulator-fixed";
>>                gpio = <&gpio 109 0>;
>>                oc-gpio = <&gpio 36 0>;
>>                regulator-boot-on;
>>                enable-active-high;
>>                regulator-name = "vbus";
>>                regulator-min-microvolt = <5000000>;
>>                regulator-max-microvolt = <5000000>;
>>        };
>>
>>
>> Question: Do you see that the over current gpio was requested
>> in debugfs/gpio? and, do you see the interrupt in /proc/interrupts?
>>
>> If you unplug and plug in back the usb device it should work again.
>> also you can unbind and bind it should also start to work:
>> something like:
>>
>> echo usb1 >/sys/bus/usb/drivers/usb/unbind
>> echo usb1 >/sys/bus/usb/drivers/usb/bind
>>
>>
>
> I have added oc-active-high and I get different results, but it is still not
> quite right. When I short the VBUS, I can see that my overcurrent gpio
> changes state. However, the driver does not turn of the VBUS. When I remove
> the short, I get an overcurrent error in the kernel log. I would expect this
> when I create the short, not when I remove it. I also tried adding
> GPIO_ACTIVE_LOW to the oc-gpio, but this did not change the behavior. In
> either case, the oc_gpio shows as high under normal conditions, so perhaps
> there is a problem with the gpio-davinci driver not picking up
> GPIO_ACTIVE_LOW from the device tree.
>
>
> My regulator is basically the same. My device just uses different gpios.
>
>         vbus_reg: vbus-reg {
>                 compatible = "regulator-fixed";
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&usb11_pins>;
>                 gpio = <&gpio 101 GPIO_ACTIVE_LOW>;
>                 oc-gpio = <&gpio 99 0>;
>                 enable-active-high;
>                 oc-active-high;
>                 regulator-name = "vbus";
>                 regulator-min-microvolt = <5000000>;
>                 regulator-max-microvolt = <5000000>;
>         }
>
>
> It seems to me though that I should not have oc-active-high since under
> normal conditions, the oc_gpio is high and during an overcurrent event, the

in my board the over current gpio is active low too, i was just mentiontioning
to add that in case yours  was not.

> oc_gpio is low. Double-checking the behavior without oc-active-high, I see
> that the vbus gpio is turned off in response to the overcurrent event, but I
> don't get the overcurrent message in the kernel log. Perhaps this is because
> as soon as there is an overcurrent event the vbus turns off and the oc_gpio
> returns to normal before the usb driver has a chance to poll the overcurrent
> state?

Perhaps. i dont have a board that has overcurrent, or that i can
switch vbus off.
what is exactly the log you are refering to?

im wondering, was the behavior different before the patches?
it should be the same without the patches.

>
> Also, unplugging the device and plugging it back in does nothing. Unbinding
> and binding the driver does work, but that does not seem like a very nice
> way to have to recover from an overcurrent event.

im guessing that unplug and plug wont work as vbus is gone and
we cannot detect it anymore (contrary to my setup were i always have vbus)
sorry for suggesting that before.

we could recover vbus automatically form the notification,
(when the over-current condition disappears) but then im afraid we
might oscillate, even if we retry after some timeout. so perhaps
bind/unbind is the right thing to do, as it requires the user to correct
the problem. I dont know if there is a better solution.


>
>
>
