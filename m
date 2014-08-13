From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Aug 2014 11:31:34 +0200
Subject: [PATCH 2/6] leds: add device tree bindings for syscon LEDs
In-Reply-To: <CAL_Jsq+-G68wjBLDbELHRDFcGYRa65-Hx9WoD6HypXNjJKVDvA@mail.gmail.com>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <1406294628-16079-3-git-send-email-linus.walleij@linaro.org>
 <CAL_Jsq+-G68wjBLDbELHRDFcGYRa65-Hx9WoD6HypXNjJKVDvA@mail.gmail.com>
Message-ID: <CACRpkdYrzsBrvW3dSGDS5yT3YLzpoL+sgAgUJaczR09NfohsdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 4:07 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 25, 2014 at 8:23 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> This adds the device tree bindings used by syscon-based LEDs.
(...)
>> +Device Tree Bindings for Syscon LEDs
>> +
>> +Required properties:
>> +- compatible : must be "syscon-leds".
>
> Not really happy with the name... More below.

[copy paste]

> I think the compatible should be something like
> "register-bit-led" (perhaps someone has a better name) as syscon is
> somewhat linux specific term and you could use this binding for any
> LEDs that have a single register bit control.

Hm... this driver:
drivers/gpio/gpio-syscon.c

Has some bindings specific to a certain controller here:
Documentation/devicetree/bindings/gpio/cirrus,clps711x-mctrl-gpio.txt

Maybe I should think of something generic for that one
along the same lines then, so we get some consensus on
this.

Documentation/devicetree/bindings/mfd/syscon.txt
Specifies the string "syscon" for such regmap ranges, maybe
it should rather use the compatible string "misc-register-range"
or something.

>> +LED sub-node properties:
>> +- offset : register offset to the register controlling this LED
>> +- mask : bit mask for the bit controlling this LED in the register
>> +  typically 0x01, 0x02, 0x04 ...
>
> This would be a single bit, right? What about inverted bits (i.e. 0 is
> on or 1 is on)?

I can of course add inversion bindings, but cannot add it to
the driver as I can't test it. Just an "active-low;" string would
do I guess.

>> +- label : (optional)
>
> Please group all required and optional properties under those headings.

OK.

>> +Example:
>> +
>> +leds: leds at 08 {
>> +       compatible = "syscon-leds";
>> +       regmap = <&syscon>;
>> +
>> +       led at bit0 {
>
> Perhaps we can define a way to express unit address as offset+bit like
> <offset>_<bit> or <offset>.<bit>.

I'll come up with something. We don't really have a place to
document such schemas do we?

> I think we should get rid of the leds node and put this within the
> syscon device node and each node here should have a compatible
> property.

OK. But then I guess you also expect to get rid of the
phandle <&syscon> from the node, so that it implicitly uses
the syscon it's embedded in? Or is it OK to keep? Or should
it be optional, so the (syscon) driver will look upward when
locating the syscon for a node?

Like I need to add a new function
syscon_regmap_lookup_by_hierarchy() to syscon.c...
It already has like three ways to look up syscons, now
we add another one.

I know that is a Linux implementation detail but it reflects the
fact that similar code will be needed in all operating systems
using syscon-type things, if it's a case-by-case question
whether a phandle or hierarchy traversal is to be used for
getting hold of the interface.

Your,
Linus Walleij
