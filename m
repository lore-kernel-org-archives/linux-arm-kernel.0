From: slash.tmp@free.fr (Mason)
Date: Sat, 15 Jul 2017 15:06:06 +0200
Subject: [RFC PATCH v2] irqchip: Add support for tango interrupt router
In-Reply-To: <dfb86360-2247-65bb-602b-5c21029709fd@free.fr>
References: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
 <20170606175219.34ef62b9@free-electrons.com>
 <d8a4d8ad-a9f3-07eb-9e2a-a4bbec01961e@free.fr>
 <dfb86360-2247-65bb-602b-5c21029709fd@free.fr>
Message-ID: <c0bd235a-9035-2002-31eb-e68710b076fd@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2017 18:39, Mason wrote:

> 128 inputs, 24 outputs (to GIC SPI 0-23)
> 
> There might be a few things wrong with this driver. When I
> cat /proc/interrupts the interrupt count appears to be bogus
> (as if level IRQ counts are added to edge IRQ counts).

OK, I found the issue.

It occurred on the interrupt lines that stay high when
the HW block is idle, so I mishandled them on every
level interrupt.

I have two remaining issues:

1) In the ISR, I get the hwirq from the GIC. What is the
API to translate that to the SPI? I'm currently just
subtracting 32.

2) I'm currently using a single domain, with a
handle_simple_irq domain handler. That's probably
wrong. Should I define two domains, one for edge
IRQs and one for level IRQs, and use the appropriate
handler?  Should both domain have 128 entries?
(I.e. are they indexed by the hwirq?)
And should I use linear or tree?

Regards.
