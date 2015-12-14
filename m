From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 14 Dec 2015 09:45:48 -0600
Subject: [PATCH 1/3] Device tree binding documentation for gpio-switch
In-Reply-To: <CACRpkdYvU6YG5yRCLsyS7sq816t3shWw51OTR2-fkp-FqSeESg@mail.gmail.com>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
 <1449250275-23435-2-git-send-email-martyn.welch@collabora.co.uk>
 <CACRpkdYZ-PK9Fb2uq+EMz5RTrtX-isxYkiNvWm2QqAh5WZhpOw@mail.gmail.com>
 <CAL_JsqJ-dht=rCu2-Unm0yOdFfRoOSXd9fkO7eDeQmvWGkGfsQ@mail.gmail.com>
 <CACRpkdYvU6YG5yRCLsyS7sq816t3shWw51OTR2-fkp-FqSeESg@mail.gmail.com>
Message-ID: <CAL_JsqJXX71Bwbm21H3QAJxYDO60kyHgKVzXxxrH9ze6ZWYtXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 8:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Dec 11, 2015 at 3:06 PM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Fri, Dec 11, 2015 at 6:39 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Fri, Dec 4, 2015 at 6:31 PM, Martyn Welch
>>> <martyn.welch@collabora.co.uk> wrote:

[...]

>>> Markus Pargmann also did a series that add initial values to
>>> hogs, which is the inverse usecase of this, where you want to
>>> *output* something by default, then maybe also make it available
>>> to userspace.
>>>
>>> So what we need to see here is a patch series that does all of these
>>> things:
>>>
>>> - Name lines
>>>
>>> - Sets them to initial values
>>>
>>> - Mark them as read-only
>>>
>>> - Mark them as "not used by the operating system" so that they
>>>   can be default-exported to userspace.
>>
>> No! This should not be a DT property.
>>
>> Whether I want to control a GPIO in the kernel or userspace is not
>> known and can change over time. It could simply depend on kernel
>> config. There is also the case that a GPIO has no connection or kernel
>> driver until some time later when a DT overlay for an expansion board
>> is applied.
>
> That's correct. So from a DT point of view, what really matters is
> to give things a name, and the hogs and initvals syntax already
> has a structure for this that is in use
> (from Documentation/devicetree/bindings/gpio/gpio.txt):
>
>         qe_pio_a: gpio-controller at 1400 {
>                 compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
>                 reg = <0x1400 0x18>;
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
>                 line_b {
>                         gpio-hog;
>                         gpios = <6 0>;
>                         output-low;
>                         line-name = "foo-bar-gpio";
>                 };
>         };
>
> Markus use this also for initial values. That could easily be used in
> a budget version like this:
>
>                 line_b {
>                         /* Just naming */
>                         gpios = <6 0>;
>                         line-name = "foo-bar-gpio";
>                 };
>
> That could grow kind of big though. Or maybe not? How many
> GPIO lines are actually properly named in a typical system?

We should limit it to GPIOs with no connection to another node. For
example, I don't want to see a SD card detect in the list as that
should be in the SD host node. However, that is hard to enforce and
can change over time. Removing it would break userspace potentially.
Of course if the kernel starts own a signal that userspace used, then
that potentially breaks userspace regardless of the DT changing. OTOH,
using GPIOs in userspace is kind of use at your own risk.

The only real differences between this and Martyn's proposal are the
location of the nodes and having a compatible string. A compatible
string may be good to have. It indicates type of signal, but not
specific use. Similar to how gpio-key compatible defines the function,
but not what key code, or gpio-led does not say what color LED. A
compatible here could cover switches, mode/id/revision strapping
signals, jumpers, presence detect, etc.

> The problem is that naming is usually imposed by consumers (they
> are the ones who know how the line is used).
>
> And then I do not mean naming it after the pin on the capsule
> where it comes out as per the datasheet, but
> naming it after the actual use.

Right. We need a way to query "I need the GPIO that does X" which
works across boards.

> Naming it after the hardware specs is something the operating
> system can do, in Linux' case by the array char *names; inside the
> struct gpio_chip and should not be part of the bindings IMO.

Agreed. That just came up with STM32 gpio bindings[1].

> I would rather imagine this is something used in a top-level board
> file naming it: "header-2-22" for the 22nd pin on some second header
> on my BeagleBone Black or something like that. And those may not
> be so vast in numbers so they could be named using this pattern.

Exactly. This is one of the cases I care about. However, this is not
really a function, but it is SOC independent at least.

We also have to consider how to handle add-on boards. We probably need
a connector node which can remap connector signals to host signals in
order to have overlays independent of the host board DT. For GPIOs
this is probably a gpio-map property similar to interrupt-map. The
complicated part will be connectors that require pinmux setup of the
host.

Rob

[1] https://lkml.org/lkml/2015/12/11/600
