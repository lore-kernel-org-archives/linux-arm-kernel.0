From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 16:36:52 +0100
Subject: [PATCH v3 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <CAAfSe-uWvn4MX-+GKuvvd=G2MTfLDCFeLRoUGWp7vvc81wfu0w@mail.gmail.com>
References: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <3400511.2SONqVcoEr@wuerfel>
 <CAAfSe-uWvn4MX-+GKuvvd=G2MTfLDCFeLRoUGWp7vvc81wfu0w@mail.gmail.com>
Message-ID: <7773522.25QE5ibXJZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 23:23:17 Lyra Zhang wrote:
> 
> Yes, I saw this way in other serial drivers.
> But, if then, there are two questions for me:
> 1. Why did some serial drivers need an UN_SHARED irq?

A lot of drivers were written before we had shared IRQs, or
were copied from old drivers, or are for hardware that uses
edge-triggered interrupts instead of level-triggered interrupts.

Only level-triggered interrupts can be shared.

> 2. How can we choose a right way?

It never hurts to implement a shared interrupt handler. Only
if you have no way to find out whether the device triggered
the interrupt or not you have to leave out IRQF_SHARED, and then
you won't be able to return IRQ_NONE.

	Arnd
