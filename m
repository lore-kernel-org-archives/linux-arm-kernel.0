From: stigge@antcom.de (Roland Stigge)
Date: Mon, 28 Jan 2013 13:29:15 +0100
Subject: [PATCH 5/6 v14] gpio: Add device tree support to block GPIO API
In-Reply-To: <CAOY=C6HTRFY=rXOAhTwuR3NvtaRFbfbkkpn7FeyK+eqG7sVcKg@mail.gmail.com>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
 <1358856404-8975-6-git-send-email-stigge@antcom.de>
 <CAOY=C6E-+uKQGbRDjNh5ZP9Wrmd+PNbt7djkBTzwe29=qA1_PA@mail.gmail.com>
 <510539C5.8000208@antcom.de>
 <CAOY=C6HTRFY=rXOAhTwuR3NvtaRFbfbkkpn7FeyK+eqG7sVcKg@mail.gmail.com>
Message-ID: <51066F1B.9010102@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2013 12:39 PM, Stijn Devriendt wrote:
>>> In the device-tree this is specified as:
>>>
>>> powr at 0x20 {
>>>    // other properties
>>>
>>>   gpios = <&gpio 4 0
>>>                &gpio 5 0>;
>>> };
>>>
>>> Is this kind of integration also possible?
>>
>> You can reference the gpio block via a phandle, e.g.:
>>
>>         blockgpio {
>>                 compatible = "linux,gpio-block";
>>
>>                 selector1 {
>>                         gpios = <&gpio 4 0>,
>>                                 <&gpio 5 0>;
>>                 };
>>         };
>>
>>         powr at 0x20 {
>>                 // ...
>>
>>                 gpios = <&selector1>;
>>         };
>>
>>
>> In the driver, you can get the gpio block like this:
>>
>> block = gpio_block_find_by_name(of_parse_phandle(powr, "gpios", 0)->name);
>>
>> (Simplified by removed error/NULL handling!)
>>
>> If this turns out to be a common pattern, I can add a convenience "get"
>> function for this.
> 
> Given the pick-up of device-tree in ARM and MIPS, I think this stands
> a good chance
> of becoming a common pattern. Do mind the "gpios" name; it's already used by the
> normal GPIO request functions...

Right, when providing the respective convenience function, I'll better
use sth. like "gpioblock" as property name.

Specifying a traditional list of GPIOs instead is easy, actually. The
respective driver just needs to allocate a gpio block explicitly
(insteady of implicitly via phandle as above). Unfortunately, gpio
blocks that should be exported and available to userspace can't be
specified this way. Therefore the strategy as above.

Roland
