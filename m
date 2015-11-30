From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 11:40:29 +0100
Subject: [PATCH 1/4] dt-bindings: gpio: update desription of LPC32xx GPIO
 controller
In-Reply-To: <1447982995-30231-2-git-send-email-vz@mleia.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
 <1447982995-30231-2-git-send-email-vz@mleia.com>
Message-ID: <CACRpkdY4rZKi+1Ff=9cfxpspZmpTjN-B2X8qjXNcONtAFy5mhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 2:29 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> For the purpose of better description of NXP LPC32xx GPIO controller
> hardware in device tree format, extend the existing description with
> device tree subnodes, which represent 6 GPIO banks within the
> controller.
>
> Note, client interface to the GPIO controller is untouched.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

(...)

> +
> +Required properties:
> +- reg: should contain 3 integer values:
> +   1) GPIO bank id from 0 to 5,
> +   2) physical base address of this GPIO bank,
> +   3) total size of the GPIO bank registers.

If each bank has a unique physical address, it should be a
unique device with a compatible string.

Below: rethink this. All are named gpio-* which is the generic
GPIO namespace and should be documented in
Documentation/devicetree/bindings/gpio/gpio.txt
so figure out if what you're adding is generic or not.

> +Optional properties:
> +- gpio-bank-name: human readable name of a GPIO bank,

The node name is unique enough and is what we use in device
trees. Get rid of this.

> +- gpio-no-output-state: property of P2 bank, which has special,
> +  mapping of its control registers,

Looks like it should be nxp,no-output-state

> +- gpio-offset: property of P3/GPIO bank, offset of bits representing
> +  GPIO lines in output and direction registers,

Explain more. I think this should probably be generic and
described together with ngpios.

> +- gpios: number of GPIO lines per GPIO bank, if this property is
> +  omitted, then gpio-input-mask must be present,

Use the generic ngpios, also one does not exclude the other, e.g
if there is 32 gpios, offset it 8 ngpios is 8, we know that
bits 8..15 are GPIO lines.

> +- gpio-input-mask: should contain two bitmasks, the first bitmask is
> +  the mapping of GPIO lines to input status register, the second
> +  bitmask should be a subset of the first bitmask and it represents
> +  input GPIO lines, which may serve as an interrupt source,
> +  if gpio-input-mask roperty is omitted, gpios property should be
> +  present,

This is really hopeless to understand. This document needs a
detailed description about how this GPIO block works so we
have the background for this.

> +- interrupts: list of parent interrupts mapped to input GPIO lines,
> +- interrupts-extended: list of parent interrupts mapped to input GPIO
> +  lines, used if parent interrupts are provided by more than one
> +  interrupt controller, this option is used by GPI bank,
> +- interrupt-controller: indicates that GPIO bank may serve as an
> +  interrupt controller,
> +- #interrupt-cells: if interrupt-controller property is present,
> +  it should be 2, interrupt id and its flags.

You need to add a description of how the block maps IRQs
to GPIO lines. It seems like it is doing some kind of
phone-exchange type of thing and just latches the GPIO line
out to an IRQ line on the interrupt controller, and that is
why even setting up trigger type has to percolate up to
the parent? Explain this in this document.

> +                       gpio-output-only;

You forgot to documen this property.

Yours,
Linus Walleij
