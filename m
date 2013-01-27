From: stigge@antcom.de (Roland Stigge)
Date: Sun, 27 Jan 2013 15:29:25 +0100
Subject: [PATCH 5/6 v14] gpio: Add device tree support to block GPIO API
In-Reply-To: <CAOY=C6E-+uKQGbRDjNh5ZP9Wrmd+PNbt7djkBTzwe29=qA1_PA@mail.gmail.com>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
 <1358856404-8975-6-git-send-email-stigge@antcom.de>
 <CAOY=C6E-+uKQGbRDjNh5ZP9Wrmd+PNbt7djkBTzwe29=qA1_PA@mail.gmail.com>
Message-ID: <510539C5.8000208@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/13 14:07, Stijn Devriendt wrote:
>> +Example:
>> +
>> +        blockgpio {
>> +                compatible = "linux,gpio-block";
>> +
>> +                block0 {
>> +                        gpios = <&gpio 3 0 0>,
>> +                                <&gpio 3 1 0>;
>> +                };
>> +                block1 {
>> +                        gpios = <&gpio 4 1 0>,
>> +                                <&gpio 4 3 0>,
>> +                                <&gpio 4 2 0>,
>> +                                <&gpio 4 4 0>,
>> +                                <&gpio 4 5 0>,
>> +                                <&gpio 4 6 0>,
>> +                                <&gpio 4 7 0>,
>> +                                <&gpio 4 8 0>,
>> +                                <&gpio 4 9 0>,
>> +                                <&gpio 4 10 0>,
>> +                                <&gpio 4 19 0>;
>> +                };
>> +        };
> 
> How do you see bindings for other kinds of drivers?
> 
> In my patchset, it's possible for other drivers to use gpio-blocks.
> One example we have is a power sequencer with 2 pins attached
> to GPIO pins. These 2 pins form a 2bit word to select power margining.
> These 2 pins need to be set synchronously (as otherwise when going
> from profile 0 to profile 3 you pass either profile 1 or profile 2 which
> could be bad for hardware)
> 
> In the device-tree this is specified as:
> 
> powr at 0x20 {
>    // other properties
> 
>   gpios = <&gpio 4 0
>                &gpio 5 0>;
> };
> 
> Is this kind of integration also possible?

You can reference the gpio block via a phandle, e.g.:

        blockgpio {
                compatible = "linux,gpio-block";

                selector1 {
                        gpios = <&gpio 4 0>,
                                <&gpio 5 0>;
                };
        };

        powr at 0x20 {
                // ...

                gpios = <&selector1>;
        };


In the driver, you can get the gpio block like this:

block = gpio_block_find_by_name(of_parse_phandle(powr, "gpios", 0)->name);

(Simplified by removed error/NULL handling!)

If this turns out to be a common pattern, I can add a convenience "get"
function for this.

Roland
