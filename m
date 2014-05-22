From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 23 May 2014 00:34:43 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <201405091244.02066.arnd@arndb.de>
 <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
Message-ID: <537E7B83.4020900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2014 09:41 AM, Linus Walleij wrote:
> On Fri, May 9, 2014 at 12:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> +++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
>>
>> Can you split this up into an arm-realview.dtsi file for the common parts and
>> a pb1176 specific file for the rest?
> 
> I wonder if that makes any kind of sense. The RealView platforms does not
> really share much more than the name, sadly. For example: IP blocks
> aren't even at the same address.
> 
> I could create a .dtsi file but it would be empty :-(
> 
>>> +     soc {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +             compatible = "simple-bus";
>>> +             ranges;
>>> +
>>> +             syscon: syscon at 10000000 {
>>> +                     compatible = "arm,realview-pb1176-syscon", "syscon";
>>> +                     reg = <0x10000000 0x1000>;
>>> +             };
>>
>> Hmm, in order to have a proper reset driver, we probably want a separate
>> node for the reset controller. I believe the x-gene people have just
>> posted a generic reset driver based on syscon. Let's see if we can share
>> that.
> 
> I have looked at it. Patch titled
> "power: reset: Add generic SYSCON register mapped reset"
> 
> Sadly it does not work for our case. This is because it assumes that
> reboot will be triggered by writing one value to one register. The RealViews
> need you to *first* write to a special unlock register, then write a magic
> value to a magic register.
> 
> So of course we could extend the syscon regmap reset driver by
> starting to encode a jam table such as a sequence of register writes
> to a sequence of registers, but we have refused such code in the past
> because as I recall Grant said, it is the beginning of a byte code
> interpreter and then we could as well bite the bullet and start
> implementing open firmware.
> 
> This is exactly the type of thing that ACPI AML code usually does
> by the way so what he says makes a *lot* of sense.
> 
> So for now I keep to our special driver.

+1 for drivers/soc _and_ of_xlate for regmap instead of syscon.

driven by Mike Turquette's request to join mach-berlin clock node into a
single node, we currently use pinctrl driver (that must be somewhere in
Linus inbox) as a crutch to register a regmap for other drivers.

I also saw that Arnd requested to not chop chip registers into tiny
pieces for Linux subsystems but rather have a single DT node and make
the drivers use it.

Mike also mentioned he is fine with different subsystem drivers reusing
the same node property-wise, i.e. reset and clock in a single node.

With Berlin (and other SoCs for sure) ultimately there will be a bunch
of drivers that require the io resource and the node early and
non-early. Now, using syscon would still require dummy nodes for each
subsystem, as there will be only one driver registered to a single DT
node.

With a drivers/soc we'd have a good place for those messy, SoC-specific
registers to put a driver that hooks up to a single node and takes care
of registering e.g. pinctrl and reset the plain-old platform_device
way. It will be a little bit like arm/mach-foo before, but maybe we
have to admit that on SoCs there will always be some amount of
very specific, non-probable, non-describable registers that simply need
special treatment.

Sebastian
