From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 30 Nov 2015 14:13:52 +0200
Subject: [PATCH 1/4] dt-bindings: gpio: update desription of LPC32xx GPIO
 controller
In-Reply-To: <CACRpkdY4rZKi+1Ff=9cfxpspZmpTjN-B2X8qjXNcONtAFy5mhA@mail.gmail.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
 <1447982995-30231-2-git-send-email-vz@mleia.com>
 <CACRpkdY4rZKi+1Ff=9cfxpspZmpTjN-B2X8qjXNcONtAFy5mhA@mail.gmail.com>
Message-ID: <565C3D80.1090204@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 30.11.2015 12:40, Linus Walleij wrote:
> On Fri, Nov 20, 2015 at 2:29 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> 
>> For the purpose of better description of NXP LPC32xx GPIO controller
>> hardware in device tree format, extend the existing description with
>> device tree subnodes, which represent 6 GPIO banks within the
>> controller.
>>
>> Note, client interface to the GPIO controller is untouched.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> (...)
> 
>> +
>> +Required properties:
>> +- reg: should contain 3 integer values:
>> +   1) GPIO bank id from 0 to 5,
>> +   2) physical base address of this GPIO bank,
>> +   3) total size of the GPIO bank registers.
> 
> If each bank has a unique physical address, it should be a
> unique device with a compatible string.

thank you for review, this is the most broken GPIO controller I've ever
seen, so many common generalized concepts present in the kernel are not
applicable, unfortunately.

Here is just a short description of "the best hw design practices" from the
SoC documentation:

* 6 GPIO banks (similar properties of GPIO lines within a bank): P0 (8
lines), P1 (24 lines), P2 (13 lines), GPIO (6 lines), GPO (24 lines, output
only), GPI (22 lines, input only),

 - gpio-output-only property is for GPO,
 - gpio-input-only property is for GPI,

* but 4 mixed register spaces: P0 (holds controls of P0), P1 (controls of
P1), P2 (controls of P2 and GPIO), P3 (controls of GPIO, GPO and GPI),

Here is the first answer to your questions, not each bank has a unique
physical address, GPIO bank controls are in two register spaces and one
register space contains controls of 3 banks.

So there must be another way to address banks, I reused an existing one from
the legacy code, banks are enumerated from 0 to 5.

Also this "bank address" has been already used by the existing GPIO
consumers, I'd be glad to have one device per bank (and that's actually in
my plans for future), but this requires an update of all GPIO clients in DTS
files, I deliberately separate this task from the GPIO controller driver
update task.

* only P2 bank has controls to set output value, but has no register to read
out the set output value,

 -  gpio-no-output-state property is for P2,

* due to the fact that P2 register space has GPIO bank controls, one more
property is introduced:

 - gpio-offset property for GPIO,

* GPIO names in GPI bank are discrete (that caused a problem you've recently
applied a fix for), all other banks has continuous GPIO names,

* GPIO - 6 lines, each is capable to produce an interrupt, interrupt on GPIO
line can be IRQ_TYPE_EDGE_BOTH if the driver reads a line state out, but IRQ
chip itself does not support edge-both interrupts, this bank potentially can
be converted to use GPIOLIB_IRQCHIP, but please see the next point,

* GPI - 22 lines, but only 12 can produce an interrupt, so GPIOLIB_IRQCHIP
helper can not be used here, to keep the code smaller (one less exception
for the banks) I've shared the same mechanism of assigning GPIO lines to
IRQs from GPI bank to GPIO bank.

 - gpio-input-mask property of GPIO and GPI banks, mapping between lines and
interrupts

> Below: rethink this. All are named gpio-* which is the generic
> GPIO namespace and should be documented in
> Documentation/devicetree/bindings/gpio/gpio.txt
> so figure out if what you're adding is generic or not.

You may see that adding of 5 bank specific properties mentioned above allow
to generalize all 6 banks, any of the banks now can be converted to a
separate GPIO controller device with the same compatible in one step, but
this is postponed at the moment.

>> +Optional properties:
>> +- gpio-bank-name: human readable name of a GPIO bank,
> 
> The node name is unique enough and is what we use in device
> trees. Get rid of this.

The node name in most cases and in the example below is "gpio-controller",
at least in this particular case I find it insufficiently informative, P0
bank is sensibly different from P2, as well as it is different from GPI,
GPIO or GPO. A good mechanism to understand in userspace what particular
bank is involved is wanted here, probably I can add a "label" property? Or
should I replace gpio-controller at xxx device node names with p0 at xxx etc.?

>> +- gpio-no-output-state: property of P2 bank, which has special,
>> +  mapping of its control registers,
> 
> Looks like it should be nxp,no-output-state

Agree.

>> +- gpio-offset: property of P3/GPIO bank, offset of bits representing
>> +  GPIO lines in output and direction registers,
> 
> Explain more. I think this should probably be generic and
> described together with ngpios.

The necessity comes from the fact that there is an intersection of register
spaces for banks P2 and GPIO, when it concerns GPIO, DIR_CLR/DIR_STATE
registers has a bit offset to control GPIO bank lines.

>> +- gpios: number of GPIO lines per GPIO bank, if this property is
>> +  omitted, then gpio-input-mask must be present,
> 
> Use the generic ngpios, also one does not exclude the other, e.g
> if there is 32 gpios, offset it 8 ngpios is 8, we know that
> bits 8..15 are GPIO lines.

Ok, will use ngpios. Offset feature won't help, because there is no uniform
offset (except 0) for any of the banks...

>> +- gpio-input-mask: should contain two bitmasks, the first bitmask is
>> +  the mapping of GPIO lines to input status register, the second
>> +  bitmask should be a subset of the first bitmask and it represents
>> +  input GPIO lines, which may serve as an interrupt source,
>> +  if gpio-input-mask roperty is omitted, gpios property should be
>> +  present,
> 
> This is really hopeless to understand. This document needs a
> detailed description about how this GPIO block works so we
> have the background for this.

I'll add more info, shortly if you once find LPC32xx User's Manual (it is
public), this property contains two values, the first one repeats mapping of
P3_INP_STATE bits to bank specific lines, the second one (subset of the
first) lists input lines, which can produce an interrupt.

>> +- interrupts: list of parent interrupts mapped to input GPIO lines,
>> +- interrupts-extended: list of parent interrupts mapped to input GPIO
>> +  lines, used if parent interrupts are provided by more than one
>> +  interrupt controller, this option is used by GPI bank,
>> +- interrupt-controller: indicates that GPIO bank may serve as an
>> +  interrupt controller,
>> +- #interrupt-cells: if interrupt-controller property is present,
>> +  it should be 2, interrupt id and its flags.
> 
> You need to add a description of how the block maps IRQs
> to GPIO lines. It seems like it is doing some kind of
> phone-exchange type of thing and just latches the GPIO line
> out to an IRQ line on the interrupt controller, and that is
> why even setting up trigger type has to percolate up to
> the parent? Explain this in this document.

Will extend this description. Generally your understanding is correct, a
requested GPIO interrupt is propagated to an IRQ chip interrupt, the handled
IRQ chip interrupt is cascaded to the GPIO interrupt, but some specific
handling of both edges type of interrupt is done on GPIO interrupt
controller side, because IRQ chip interrupt can not support edge-both type
of interrupts.

>> +                       gpio-output-only;
> 
> You forgot to documen this property.

Ok.

Thanks for review. If you find that conceptually any other scheme of device
tree node properties or bank layout is more applicable in this particular
case, please let me know.

--
With best wishes,
Vladimir
