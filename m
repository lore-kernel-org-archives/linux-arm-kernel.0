From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 16:29:13 +0200
Subject: [RFC v5 4/4] gpio: dt-bindings: add gpio-mmio bindings
In-Reply-To: <a0ded4d0161f7ab3cd1945741d95d2718dbe4f44.1461888822.git.chunkeey@googlemail.com>
References: <cover.1461888822.git.chunkeey@googlemail.com>
 <a0ded4d0161f7ab3cd1945741d95d2718dbe4f44.1461888822.git.chunkeey@googlemail.com>
Message-ID: <CACRpkdYXqcQ1a=S5c6Cev__nqfquo7tFA=3uJSu9wf96txfBwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 2:53 AM, Christian Lamparter
<chunkeey@googlemail.com> wrote:

> From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
>
> This patch adds the device tree bindings for the gpio-mmio.
> The gpio-mmio is already part of a the GPIO generic library.
>
> Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>

I share your ambition to create something generic for this class
of hardware(s).

> +Bindings for the generic driver for memory-mapped GPIO controllers.
> +
> +Required properties:
> +       - compatible: should be "linux,gpio-mmio"

Why?
"memory-mapped-gpio" sits nicely with me.

Read another very generic binding for inspiration:
Documentation/devicetree/bindings/leds/register-bit-led.txt

> +       - reg-names: must contain
> +               "dat" - data register
> +               may contain
> +               "set" - data set register
> +               "clr" - data clear register
> +               "dirout" - direction output register
> +               "dirin" - direction input register

I would just be more verbose:

data-in-register
data-out-set-register
data-out-clear-register
direction-output-register
direction-input-register

Some should be optional so we can support input-only
and output-only GPIO controllers too.

I would take this opportunity to add bindings also for stuff that
the generic MMIO driver does not support today but
could be made to support:

open-drain-register
open-source-register
debounce-register

etc

> +Optional properties:
> +       - ngpio: specifies the number of gpio mapped in the register.

Just reference the generic docs.

> +       - big-endian: force big endian register accesses.
> +       - big-endian-byte-order: assign GPIOs in reverse order.
> +       - unreadable-reg-set: data set register is not readable.
> +       - read-output-reg-set: cache value set for reads.
> +       - unreadable-reg-dir: dirout/dirin register is not readable.
> +       - no-output: GPIOs are read-only.

I think it's better to imply that if there is no data-in-register
specified, then it is output-only etc.

> +The GPIO generic library provides support for memory-mapped GPIO
> +controllers. The configuration is detected by which resources are present.
> +The simplest form of a GPIO controller that the driver support is just a
> +single "dat" register, where GPIO state can be read and/or written.
> +However, the driver supports far more:
> +       - 8/16/32/64 bits registers. The number of GPIOs is automatically
> +         determined by the width of the registers.
> +       - GPIO controllers with clear/set registers.
> +       - GPIO controllers with a single "dat" register.
> +       - Big endian bits/GPIOs ordering.


Skip this. It is Linux-specific.

Yours,
Linus Walleij
