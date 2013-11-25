From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 25 Nov 2013 11:33:56 +0000
Subject: ACPI
In-Reply-To: <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
Message-ID: <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:07 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Mon, Nov 25, 2013 at 1:42 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On 24 Nov 2013 17:14, "Linus Walleij" <linus.walleij@linaro.org> wrote:
>
>>> For devicetree we have a bit of standardization in
>>> Documentation/devicetree/bindings/pinctrl and if I'm not mistaken,
>>> nothing of the sort exist in the ACPI spec.
>>
>> No, none of that exists in ACPI. We're looking at entirely new
>> territory for ACPI.
>>
>> It seems there are two ways we can approach ACPI. 1) we could treat
>> ACPI exactly like DT and expect DT bindings to carry over verbatim
>> into the ACPI namespace. That means everything we've done with DT we
>> expect to show up in ACPI trees including clocks, regulators, pin
>> control, etc. Or, 2) assume that if ACPI is being used, then the
>> intent is to push responsibility for the platform as a whole
>> (system-wide details as opposed to individual devices) out of the
>> kernel.
>
> Or (3): ACPI redefined on top of each subsystem. But I get
> from the sound of this that this approach is not liked,
> because (I assume?) we want to cut some corners.
>
> Example from another architecture:
> drivers/gpio/gpio-lynxpoint.c
> with infrastructure in:
> drivers/gpio/gpiolib-acpi.c
>
> It is a "pure", embedded ACPI driver of the type that Intel is
> pushing. They have been very helpful in integrating this
> deeply with the GPIO subsystem and are now switching all
> relevant drivers to using decriptors rather than GPIO numbers
> for embedded x86 which is a big win.
>
> So would ARM ACPI systems with GPIO drivers *not* use this
> nice infrastructure ...? (Maybe not your stance but the
> sound I hear from some places in this discussion.)

No, that's not my stance. ACPI5 does define a GPIO address space and
it makes sense to work with that. When I say that the bindings be
identical between DT and ACPI implementations it is with the
understanding that DT or ACPI native references are used where
appropriate. ie. the DT version would use the gpios= property value,
but the ACPI implementation would use an ACPI native GPIO reference.

Regulators, clocks and pincontrol are all brand new areas. There is no
existing ACPI infrastructure or details in the spec on how to deal
with them. I honestly don't know what the best approach here is. Not
knowing enough about ACPI, I am concerned that the DT data model for
clocks, regulator, etc, bindings will interact badly with the ACPI
power management model.

> And I cannot see how Intels or anyones pin control, regulator,
> clock etc drivers would be any different from this code.
>
> Well, they have indicated that they would prefer to hide some
> complex things behind an behind-the-scenes abstraction like
> D-states or so, but I have my doubts about that approach,
> they may prove me wrong.

What I'm assuming here is that on ACPI the pinctrl setup and
management would be performed by the platform in AML methods so that
the kernel isn't aware of them at all. All it know is that it has a
(for example) SPI bus and as far as it is concerned the pins are
correctly attached when the SPI bus is active. My understanding is
that historically this is how ACPI has been used.

g.
