From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 16:34:30 +0100
Subject: [PATCH 1/4] dt-bindings: gpio: update desription of LPC32xx GPIO
 controller
In-Reply-To: <565C3D80.1090204@mentor.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
 <1447982995-30231-2-git-send-email-vz@mleia.com>
 <CACRpkdY4rZKi+1Ff=9cfxpspZmpTjN-B2X8qjXNcONtAFy5mhA@mail.gmail.com>
 <565C3D80.1090204@mentor.com>
Message-ID: <CACRpkdbOwXkR3_VPKB96RibZZgt4fZL+cH30c3xAp44tob1JHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 1:13 PM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> [Me]
>> The node name is unique enough and is what we use in device
>> trees. Get rid of this.
>
> The node name in most cases and in the example below is "gpio-controller",
> at least in this particular case I find it insufficiently informative, P0
> bank is sensibly different from P2, as well as it is different from GPI,
> GPIO or GPO. A good mechanism to understand in userspace what particular
> bank is involved is wanted here, probably I can add a "label" property? Or
> should I replace gpio-controller at xxx device node names with p0 at xxx etc.?

Userspace is supposed to use the whole filepath in sysfs to identify
a device. That should be enough, no matter what name the chip has.

Also: see the ongoing discussion and proposed patch for a new
userspace ABI based on a character device. We're not too happy about
new userspace usecases for GPIO right now, we need to fix the ABI.

>>> +- gpio-offset: property of P3/GPIO bank, offset of bits representing
>>> +  GPIO lines in output and direction registers,
>>
>> Explain more. I think this should probably be generic and
>> described together with ngpios.
>
> The necessity comes from the fact that there is an intersection of register
> spaces for banks P2 and GPIO, when it concerns GPIO, DIR_CLR/DIR_STATE
> registers has a bit offset to control GPIO bank lines.

So do we think that other hardware will have this property too or is it an
nxp,* thing?

>>> +- gpios: number of GPIO lines per GPIO bank, if this property is
>>> +  omitted, then gpio-input-mask must be present,
>>
>> Use the generic ngpios, also one does not exclude the other, e.g
>> if there is 32 gpios, offset it 8 ngpios is 8, we know that
>> bits 8..15 are GPIO lines.
>
> Ok, will use ngpios. Offset feature won't help, because there is no uniform
> offset (except 0) for any of the banks...

OK let's look closer at it.

>>> +- gpio-input-mask: should contain two bitmasks, the first bitmask is
>>> +  the mapping of GPIO lines to input status register, the second
>>> +  bitmask should be a subset of the first bitmask and it represents
>>> +  input GPIO lines, which may serve as an interrupt source,
>>> +  if gpio-input-mask roperty is omitted, gpios property should be
>>> +  present,
>>
>> This is really hopeless to understand. This document needs a
>> detailed description about how this GPIO block works so we
>> have the background for this.
>
> I'll add more info, shortly if you once find LPC32xx User's Manual (it is
> public), this property contains two values, the first one repeats mapping of
> P3_INP_STATE bits to bank specific lines, the second one (subset of the
> first) lists input lines, which can produce an interrupt.

OK, and should it be an nxp,* property?

>>> +- interrupts: list of parent interrupts mapped to input GPIO lines,
>>> +- interrupts-extended: list of parent interrupts mapped to input GPIO
>>> +  lines, used if parent interrupts are provided by more than one
>>> +  interrupt controller, this option is used by GPI bank,
>>> +- interrupt-controller: indicates that GPIO bank may serve as an
>>> +  interrupt controller,
>>> +- #interrupt-cells: if interrupt-controller property is present,
>>> +  it should be 2, interrupt id and its flags.
>>
>> You need to add a description of how the block maps IRQs
>> to GPIO lines. It seems like it is doing some kind of
>> phone-exchange type of thing and just latches the GPIO line
>> out to an IRQ line on the interrupt controller, and that is
>> why even setting up trigger type has to percolate up to
>> the parent? Explain this in this document.
>
> Will extend this description. Generally your understanding is correct, a
> requested GPIO interrupt is propagated to an IRQ chip interrupt, the handled
> IRQ chip interrupt is cascaded to the GPIO interrupt, but some specific
> handling of both edges type of interrupt is done on GPIO interrupt
> controller side, because IRQ chip interrupt can not support edge-both type
> of interrupts.

OMG that sounds so weird.

Yours,
Linus Walleij
