From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Dec 2015 15:28:12 +0100
Subject: [PATCH 1/3] Device tree binding documentation for gpio-switch
In-Reply-To: <CAL_JsqJ-dht=rCu2-Unm0yOdFfRoOSXd9fkO7eDeQmvWGkGfsQ@mail.gmail.com>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
 <1449250275-23435-2-git-send-email-martyn.welch@collabora.co.uk>
 <CACRpkdYZ-PK9Fb2uq+EMz5RTrtX-isxYkiNvWm2QqAh5WZhpOw@mail.gmail.com>
 <CAL_JsqJ-dht=rCu2-Unm0yOdFfRoOSXd9fkO7eDeQmvWGkGfsQ@mail.gmail.com>
Message-ID: <CACRpkdYvU6YG5yRCLsyS7sq816t3shWw51OTR2-fkp-FqSeESg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 3:06 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Fri, Dec 11, 2015 at 6:39 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Dec 4, 2015 at 6:31 PM, Martyn Welch
>> <martyn.welch@collabora.co.uk> wrote:
>>
>>> This patch adds documentation for the gpio-switch binding. This binding
>>> provides a mechanism to bind named links to gpio, with the primary
>>> purpose of enabling standardised access to switches that might be standard
>>> across a group of devices but implemented differently on each device.
>>>
>>> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
>>
>> As mentioned in the comment to the second patch, this solves the
>> following generic problem:
>>
>> Expose a GPIO line to userspace using a specific name
>>
>> That means basically naming GPIO lines and marking them as
>> "not used by the operating system".
>>
>> This is something that has been proposed before, and postponed
>> because the kernel lacks the right infrastructure.
>
> That doesn't necessarily mean we can't define a binding.

Yeah that's true. just saying that the other stuff was not merged
for this reason, but then we can have a look at Markus' bindings
in parallell, Markus can you repost them to this audience? Only
the bindings I mean.

>> Markus Pargmann also did a series that add initial values to
>> hogs, which is the inverse usecase of this, where you want to
>> *output* something by default, then maybe also make it available
>> to userspace.
>>
>> So what we need to see here is a patch series that does all of these
>> things:
>>
>> - Name lines
>>
>> - Sets them to initial values
>>
>> - Mark them as read-only
>>
>> - Mark them as "not used by the operating system" so that they
>>   can be default-exported to userspace.
>
> No! This should not be a DT property.
>
> Whether I want to control a GPIO in the kernel or userspace is not
> known and can change over time. It could simply depend on kernel
> config. There is also the case that a GPIO has no connection or kernel
> driver until some time later when a DT overlay for an expansion board
> is applied.

That's correct. So from a DT point of view, what really matters is
to give things a name, and the hogs and initvals syntax already
has a structure for this that is in use
(from Documentation/devicetree/bindings/gpio/gpio.txt):

        qe_pio_a: gpio-controller at 1400 {
                compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
                reg = <0x1400 0x18>;
                gpio-controller;
                #gpio-cells = <2>;

                line_b {
                        gpio-hog;
                        gpios = <6 0>;
                        output-low;
                        line-name = "foo-bar-gpio";
                };
        };

Markus use this also for initial values. That could easily be used in
a budget version like this:

                line_b {
                        /* Just naming */
                        gpios = <6 0>;
                        line-name = "foo-bar-gpio";
                };

That could grow kind of big though. Or maybe not? How many
GPIO lines are actually properly named in a typical system?

The problem is that naming is usually imposed by consumers (they
are the ones who know how the line is used).

And then I do not mean naming it after the pin on the capsule
where it comes out as per the datasheet, but
naming it after the actual use.

Naming it after the hardware specs is something the operating
system can do, in Linux' case by the array char *names; inside the
struct gpio_chip and should not be part of the bindings IMO.

I would rather imagine this is something used in a top-level board
file naming it: "header-2-22" for the 22nd pin on some second header
on my BeagleBone Black or something like that. And those may not
be so vast in numbers so they could be named using this pattern.

Yours,
Linus Walleij
