From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 11 Jan 2018 16:33:50 +0000
Subject: [PATCH 2/3] dt-bindings: pinctrl: Add a ngpios-ranges property
In-Reply-To: <CACRpkdaN6vmV4L4U76DvD5BN+j1RYCQakTysA+GGPdT8Chc-iw@mail.gmail.com>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-3-sboyd@codeaurora.org>
 <CACRpkdaN6vmV4L4U76DvD5BN+j1RYCQakTysA+GGPdT8Chc-iw@mail.gmail.com>
Message-ID: <CACxGe6vA652LCosMc+AsQ2Gb_mgiApx+Gxu9judXnO_p3AFcsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 1:37 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jan 10, 2018 at 2:58 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> Some qcom platforms make some GPIOs or pins unavailable for use
>> by non-secure operating systems, and thus reading or writing the
>> registers for those pins will cause access control issues.
>> Introduce a DT property to describe the set of GPIOs that are
>> available for use so that higher level OSes are able to know what
>> pins to avoid reading/writing.

What level of access control is implemented here? Is there access
control for each GPIO individually, or is it done by banks of GPIOs?
Just asking to make sure I understand the problem domain.

>>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>
> I like the idea, let's check what we think about the details regarding
> naming and semantics, I need feedback from some DT people
> in particular.
>
> Paging in Grant on this as he might have some input.
>
>> I stuck this inside msm8996, but maybe it can go somewhere more generic?
>
> Yeah just put it in Documentation/devicetree/bindings/gpio/gpio.txt
> Everyone and its dog doing GPIO reservations "from another world"
> will need to use this.
>
>> +- ngpios-ranges:
>> +       Usage: optional
>> +       Value type: <prop-encoded-array>
>> +       Definition: Tuples of GPIO ranges (base, size) indicating
>> +                   GPIOs available for use.
>> +
>>  Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
>>  a general description of GPIO and interrupt bindings.
>
> I like the tuples syntax. That's fine. It's like gpio-ranges we have
> already to map between pin controllers and GPIO.
>
> I don't think we can reuse gpio-ranges because that is
> exclusively for pin control ATM, it would be fine if the ranges
> were for a specific device, like pin control does, like:
>
> gpio-ranges = <&secure_world_thing 0 20 10>;
>
> But you definately would need a node to tie it to, so that the
> driver for that node can specify that it's gonna take the
> GPIOs.
>
> But I think the semantics should be the inverse. That you
> point out "holes" with the lines we *can't* use.
>
> We already support a generic property "ngpios" that says how
> many of the GPIOs (counted from zero) that can be used,
> so if those should be able to use this as a generic property it
> is better with the inverse semantics and say that the
> "reserved-gpio-ranges", "secureworld-gpio-ranges"
> (or whatever we decide to call it) takes precedence over
> ngpios so we don't end up in ambigous places.

Heh, I just went down the same thought process on the naming before I
read the above. Yes I agree. The property name should have something
like "reserved" in it. I vote for "gpio-reserved-ranges" because it
puts the binding owner (gpio) at the front of the name, it indicates
that the list is unavailable GPIOs, and that the format is a set of
ranges.

The fiddly bit is it assumes the GPIOs are described by a single
number. It works fine as long as the GPIO controllers can use a single
cell to describe a gpio number (instead of having #gpio-cells = 3 with
the first cell being bank, the second being number in bank, and the
third being flags).

>
> Then, will it be possible to put the parsing, handling and
> disablement of these ranges into drivers/gpio/gpiolib-of.c
> where we handle the ranges today, or do we need to
> do it in the individual drivers?

I certainly would prefer parsing this in common code, and not in
individual drivers, but again it becomes hard for any driver using
multiple cells to describe the local GPIO number. I think the guidance
here needs to be that the property is relevant when the internal GPIO
number representation fits within a uint32, which realistically should
never be a problem.

g.
