From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 5 Dec 2013 10:48:12 -0800
Subject: [PATCH v2 1/6] ARM: brcmstb: add infrastructure for ARM-based
 Broadcom STB SoCs
In-Reply-To: <201312031601.04997.arnd@arndb.de>
References: <1385511748-27869-1-git-send-email-marc.ceeeee@gmail.com>
 <1385511748-27869-2-git-send-email-marc.ceeeee@gmail.com>
 <201312031601.04997.arnd@arndb.de>
Message-ID: <CAGVrzcbxHA+S0yZbsrj8uMZR0hsb_ng=PB02zte7S0rCZWQpBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2013/12/3 Arnd Bergmann <arnd@arndb.de>:
>
>> +     addr = ioremap(BPHYSADDR(BCHP_IRQ0_IRQEN), sizeof(u32));
>> +     writel_relaxed(BCHP_IRQ0_IRQEN_uarta_irqen_MASK
>> +             | BCHP_IRQ0_IRQEN_uartb_irqen_MASK
>> +             | BCHP_IRQ0_IRQEN_uartc_irqen_MASK, addr);
>> +     iounmap(addr);
>
> What does this part do? Isn't that something that should have been set
> up by the boot loader?

The bootloader will typically use the UART in busy-looping mode and
not rely on interrupts, also the bootloader currently does not know
much about how many UARTs there are in the system and how they are
going to be used.

One possible way to solve this would be to write a very small irqchip
driver which only implements the "irq_enable" method to allow these
interrupts to be forwarded to the GIC. Somewhere in the Device Tree we
would have an interrupt-map property which describes the mapping
between the bits in BCHP_IRQ0_IRQEN and their corresponding
peripherals (UARTA, B, C).

Would that work?
-- 
Florian
