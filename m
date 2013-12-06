From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 6 Dec 2013 14:12:03 -0800
Subject: [PATCH v2 1/6] ARM: brcmstb: add infrastructure for ARM-based
 Broadcom STB SoCs
In-Reply-To: <201312052107.07197.arnd@arndb.de>
References: <1385511748-27869-1-git-send-email-marc.ceeeee@gmail.com>
 <201312031601.04997.arnd@arndb.de>
 <CAGVrzcbxHA+S0yZbsrj8uMZR0hsb_ng=PB02zte7S0rCZWQpBg@mail.gmail.com>
 <201312052107.07197.arnd@arndb.de>
Message-ID: <CAGVrzcYha7y2pQ-tFtu19ZAN3DVWVAJOt_0UPEU6e5KfuBnMjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/5 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 05 December 2013, Florian Fainelli wrote:
>> 2013/12/3 Arnd Bergmann <arnd@arndb.de>:
>> >
>> >> +     addr = ioremap(BPHYSADDR(BCHP_IRQ0_IRQEN), sizeof(u32));
>> >> +     writel_relaxed(BCHP_IRQ0_IRQEN_uarta_irqen_MASK
>> >> +             | BCHP_IRQ0_IRQEN_uartb_irqen_MASK
>> >> +             | BCHP_IRQ0_IRQEN_uartc_irqen_MASK, addr);
>> >> +     iounmap(addr);
>> >
>> > What does this part do? Isn't that something that should have been set
>> > up by the boot loader?
>>
>> The bootloader will typically use the UART in busy-looping mode and
>> not rely on interrupts, also the bootloader currently does not know
>> much about how many UARTs there are in the system and how they are
>> going to be used.
>
> Well, it should at least know how many ports are wire up and be able
> to set them up to a working state.
>
>> One possible way to solve this would be to write a very small irqchip
>> driver which only implements the "irq_enable" method to allow these
>> interrupts to be forwarded to the GIC. Somewhere in the Device Tree we
>> would have an interrupt-map property which describes the mapping
>> between the bits in BCHP_IRQ0_IRQEN and their corresponding
>> peripherals (UARTA, B, C).
>>
>> Would that work?
>
> I think that would work, but it's getting into the overdesign territory.
> Can you clarify why this register exists in the first place and what
> makes it necessary to set it up? Are there similar registers for all
> other IRQs?

This BCHP_IRQ0 register is kind of special and only acts as an
interrupt forwarder. Not enabling the IRQEN bit will prevent the UART
interrupts to be raised at the GIC level. Now that I think about this
some more, we might just go with some sort of special node which
contains a mask of the interrupts and apply this mask to the
corresponding hardware register? There is no need for this to be
modelled as an interrupt controller because this really is not a real
one.
-- 
Florian
