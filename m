From: linux@bohmer.net (Remy Bohmer)
Date: Tue, 2 Nov 2010 15:11:15 +0100
Subject: at91: input overruns question
In-Reply-To: <AANLkTin3gSaf-EJx6=ojakYUAyH6CDpD4SnHyN=xLNb6@mail.gmail.com>
References: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
	<AANLkTimHnxLydJC3u58kAuukjR80EEgRDj7ZEedNMKfd@mail.gmail.com>
	<AANLkTi=AhMxUjN=0PfW+XKVDJBhok=f4YwpF6bf67Eza@mail.gmail.com>
	<AANLkTin3gSaf-EJx6=ojakYUAyH6CDpD4SnHyN=xLNb6@mail.gmail.com>
Message-ID: <AANLkTi=3T4cw9-i0ybst6BQN3FQnS2jhUUAbQ2BQZL5U@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> I did manage to get ithe DBGU to work by changing the IRQ request flag
> to NODELAY.
>
> #ifndef CONFIG_RTC_DRV_AT91RM9200
> ? ?if ( machine_is_at91rm9200() && port->irq == 1 )
> ? ? ? ?retval = request_irq(port->irq, atmel_interrupt, IRQF_NODELAY,
> ? ? ? ? ? ?tty ? tty->name : "atmel_serial", port);
> ? ?else
> #endif
> ? ? ? ?retval = request_irq(port->irq, atmel_interrupt, IRQF_SHARED,
> ? ? ? ? ? ?tty ? tty->name : "atmel_serial", port);
>
> I understand the warnings and limitations of NODELAY for an RT kernel,
> but this is a quick fix which allows me to continue to use the DBGU
> for my development and I can remove it once I get to production
> status.
>

I was looking through my own patch repo and I use on 2.6.33-rt the
patch attached (since 2.6.31) (for Atmel at91sam9261), but for a
different reason then you run into now! (see patch header)

Notice that the DBGU is shared with the system timer (ST) on rm9200.
The interrupt of the ST is shared with the DBGU.
This means that everything the interrupt handler for ST does bothers the DBGU.
BUT: The ST has its interrupt handler installed with IRQF_TIMER (see
arch/arm/mach-at91/at91rm9200_time.c). IRQF_TIMER implies
IRQF_NODELAY.
Without NODELAY set, the IRQ-thread of the DBGU will only run if the
ST-interrupt is completed, causing your troubles.
The driver of the DBGU was adapted such that it runs properly in
NODELAY context. You can keep it set, even in production use.

> There is a comment in the atmel_serial.c file which says that
> "Transmit is IRQF_NODELAY safe" but I don't know if the Receive is as
> well.

Especially the receive was important to make safe for that context.
That one will drop data if it is not executed fast enough!
We do that only for receive. For transmit only there would have been
no reason to make it nodelay safe, since that would only imply a
bottleneck on throughput in case it runs from IRQ-thread. (you won' t
get buffer overflows on transmit...)

> Maybe the Receive isn't deemed safe because it is shared with
> the RTC? If it is not shared, then maybe it is safe? I intend
> investigate this myself I have any further problems.

Only the interrupt handler marked nodelay run in IRQ context (like ST
and DBGU now), all others in thread context.(like PMC and RTC)
All other shared interrupts, like RTC and PMC, slow down the interrupt
handling of the DBGU and ST, since the IRQ-thread must first run,
before the interrupt can be enabled again at AIC level.

The best solution is to adapt all shared handlers to use the
request_threaded_irq() API and only do in the top-half context what is
absolutely necessary. (Only the ST-handler cannot be modified though)

Kind regards,

Remy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: make-atmel-serial-irq-nodelay.patch
Type: text/x-patch
Size: 1197 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101102/242ded5e/attachment.bin>
