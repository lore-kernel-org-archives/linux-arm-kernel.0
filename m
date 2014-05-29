From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 29 May 2014 12:10:15 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <CACRpkdap1U19EiULnq11udhY91UnnNu_-5MnLby3idbdjzBj4Q@mail.gmail.com>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <201405091244.02066.arnd@arndb.de>
 <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
 <537E7B83.4020900@gmail.com>
 <CACRpkdap1U19EiULnq11udhY91UnnNu_-5MnLby3idbdjzBj4Q@mail.gmail.com>
Message-ID: <53870787.3030202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2014 11:44 AM, Linus Walleij wrote:
> On Fri, May 23, 2014 at 12:34 AM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>> On 05/22/2014 09:41 AM, Linus Walleij wrote:
>>> So for now I keep to our special driver.
>>
>> +1 for drivers/soc _and_ of_xlate for regmap instead of syscon.
>>
>> driven by Mike Turquette's request to join mach-berlin clock node into a
>> single node, we currently use pinctrl driver (that must be somewhere in
>> Linus inbox) as a crutch to register a regmap for other drivers.
> 
> I've merged it actually, I think. Else hit me on any missed patches.

Yeah, you did. Thanks, no more patches on this one.

>> With a drivers/soc we'd have a good place for those messy, SoC-specific
>> registers to put a driver that hooks up to a single node and takes care
>> of registering e.g. pinctrl and reset the plain-old platform_device
>> way. It will be a little bit like arm/mach-foo before, but maybe we
>> have to admit that on SoCs there will always be some amount of
>> very specific, non-probable, non-describable registers that simply need
>> special treatment.
> 
> Hmmmm well I want to see that code before I believe it ... but
> I get what you mean.

Well, the register set on Berlin I was thinking about tackles pinctrl,
padmux, clock, reset and some other freaky stuff I cannot recall. The
mess in it is that there is no order you can apply to split it up into
separate nodes. Moreover, the next SoC has some registers just shoved
into it, moving some other registers.

It is already painful to deal with in code, and I have been through
several iterations of the clk driver with both choppy-DT and one-DT node
approaches.

At some point, Linux subsystem driven DT node tailoring isn't the
answer. Sometimes it fits very well, sometimes you will either end up
with gazillions of "clocks"/"clock-names" properties (just think of
a pll with 2x8 outputs) or the same amount of "reg" properties to
collect e.g. all registers dealing with reset.

The way we will go for it on Berlin is now:

(a) have a single node for the whole chip-ctrl register set
(b) register clk driver on it (early, as it provides timer clk)
(c) register one chip-ctrl driver on it that will
    (d) reserve the iomap,
    (e) register a regmap-mmio,
    (f) register platform_devices for {pinctrl,reset,...} that will
        use regmap-mmio and read their properties from the single
        node

The individual drivers should stay in their respective drivers/ folder,
but (c) needs a good home. It would have been mach-foo in the past, and
could be drivers/soc now. In (f), I tend to just lookup regmap by name,
no DT involved at all.

BTW, syscon is of no use here at all, once it registers itself as a
driver for the node, there will be no other drivers registered. That
would at least require (again subsystem driven) dummy-nodes for
pinctrl, clk, reset.

Also, using some of_xlate as we already have for clk, gpio, pinctrl ...
would put an end to syscon's syscon_get_regmap_from_{foo,bar,baz,...}
that gets a new helper every cycle.

Sebastian
