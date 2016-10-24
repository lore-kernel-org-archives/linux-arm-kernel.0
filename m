From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 02:13:55 +0200
Subject: [PATCH v2] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <CAPoCmYKrUBEdyNXt8yRMFq_aCmb8WyK-x4a7og66zfeFYX4rQg@mail.gmail.com>
References: <CAPoCmYJC1TebBrspD_=mTETULSjg9or5a0Yda8p945y6ZWL99Q@mail.gmail.com>
 <CACRpkdb++5Xb6a=0Zz5eZURNmrkfVyvsBR-pLK9iRiyTu1g8Rw@mail.gmail.com>
 <CAPoCmYKrUBEdyNXt8yRMFq_aCmb8WyK-x4a7og66zfeFYX4rQg@mail.gmail.com>
Message-ID: <CACRpkdaBADx3yzeWwqU1Z3K6+Y-YGwmNkotkZeE+RFAZk1r5Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 6:58 PM, Gottfried Haider
<gottfried.haider@gmail.com> wrote:

> Somewhat off topic: is it planned to add
> support for setting GENERIC_PINCONF style pull-up/pull-down resistors
> throigh the new ABI?

Not planned, as in "I will do the job" but anticipated.

I expect that someone will come up with that usecase (indeed even the
Arduino is doing it) so that we will have to support it.

It's better than inventing a separate userspace ABI for pin control
anyways.

> (The bcm28xx drivers would still need to
> converted to this as well.)

All drivers that want to support it need converting I suspect.

>>> Regarding the proposed format using the header pin numbers: From what I've
>>> seen in terms of existing educational materials, it seems the overwhelming
>>> majority ends up using GPIO numbers instead of physical pin header
>>> numbering. (e.g. [1] [2])
>>
>> What does that number mean? If you are referring to the global
>> GPIO numberspace it is obsolete and just reflecting the fact that
>> people up until now was referring to Linux-internal GPIO numbers.
>
> I am referring to the name of the various GPIO lines as per datasheet
> ("GPIO0", "GPIO1", ...). So far, I believe those matched the global
> GPIO numberspace.

Aha. Yeah that is matching somewhat by chance these days, because:

static struct gpio_chip bcm2835_gpio_chip = {
        .label = MODULE_NAME,
(...)
        .base = -1,
(...)
};

That means this number is dynamicallly assigned and depend on
things like probe order or another GPIO chip failing etc.

> I understand that Linux can't guarantee a certain global GPIO number -
> but I fear that the board manufacturers also might not think of the
> pin headers as something set in stone (that the can't rearrange in a
> future revision/product).

Depends on which manufacturer. For 96boards there exist a document
specifying how they should be arranged and named:
https://github.com/96boards/documentation

Rpi would be wise to come up with something similar, but I have no
high hopes. We do need standardization and interoperability, but
it is not creating itself. :/

> Would there be a reason against _naming_ the pin "GPIO0"? (even if it
> ends up with a different global, internal number)

No not if it makes electronic sense, like if the schematic or SoC
uses that name, then use that if the board maintainer likes the idea.

Yours,
Linus Walleij
