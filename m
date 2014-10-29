From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Oct 2014 11:24:26 +0100
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <CACRpkdao2F1NK-3QpqSOLzFdvjWFVU4HqcqZPA2fXHpQN=BUsQ@mail.gmail.com>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <2988580.WvjMBY1UOc@wuerfel>
 <CACRpkdao2F1NK-3QpqSOLzFdvjWFVU4HqcqZPA2fXHpQN=BUsQ@mail.gmail.com>
Message-ID: <2178918.XVCQXOyoGA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 October 2014 10:52:47 Linus Walleij wrote:
> On Fri, Oct 24, 2014 at 3:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 24 October 2014 14:14:43 Linus Walleij wrote:
> > See the discussion I had on this. Yes, each line is connected to a
> > GIC SPI interrupt by itself. I've discussed this with Marc Zyngier
> > and Thomas Gleixner at the conference last week, and we concluded
> > that we will need a new generic interface to get data out of the
> > parent interrupt controller in a proper way. The current implementation
> > just maps the GIC registers and reads them directly, which of course
> > is not a proper way to do it.
> 
> Hmmmmmm. OK shall we hold this driver until the infrastructure
> issues are resolved?

Y could send a first version that does not support the IRQ lines
if he wants to speed up the process.

> The following is a recurring pattern among GPIO controllers:
> the GPIO controller can go offline (asycnhcronous) and while it
> is offline a secondary logic triggers an IRQ that wakes the system
> up, however the GPIO logic cannot really "see" that IRQ since
> it was sleeping when it arrived.
> 
> Thus a latent IRQ is pending in the wakeup logic. This concept
> exists in drivers/pinctrl/nomadik/pinctrl-nomadik.c and I strongly
> prefer to call these "latent irqs" as it's a clear unambigous
> terminology.
> 
> So is this a case of latent IRQs pending in the GIC?

I think this case is different, from what I understand, the GPIO
controller cannot implement gpio_chip->get() for any line that
is connected to the GIC, and it has to ask the GIC instead.
This seems independent of the online/offline state of the controller.

	Arnd
