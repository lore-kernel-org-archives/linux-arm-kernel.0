From: arasv@magellan-technology.com (Aras Vaichas)
Date: Tue, 2 Nov 2010 10:33:33 +1100
Subject: at91: input overruns question
In-Reply-To: <AANLkTi=AhMxUjN=0PfW+XKVDJBhok=f4YwpF6bf67Eza@mail.gmail.com>
References: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
	<AANLkTimHnxLydJC3u58kAuukjR80EEgRDj7ZEedNMKfd@mail.gmail.com>
	<AANLkTi=AhMxUjN=0PfW+XKVDJBhok=f4YwpF6bf67Eza@mail.gmail.com>
Message-ID: <AANLkTin3gSaf-EJx6=ojakYUAyH6CDpD4SnHyN=xLNb6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2010 22:19, Remy Bohmer <linux@bohmer.net> wrote:
> 2010/10/28 Aras Vaichas <arasv@magellan-technology.com>:
>> On 26 October 2010 17:19, Aras Vaichas <arasv@magellan-technology.com> wrote:
<SNIP>
>>
>> Configuration settings CONFIG_NO_HZ and CONFIG_HIGH_RES_TIMERS cause
>> the overrun(s) problems to get worse.
>
> Indeed. high-res timers and no-hz have a longer interrupt handling
> compared to the old fashioned ticking kernel.

<SNIP>

Thank you for that, I suspected as much, but I don't have trace
capability on my target to verify it.

Luckily the DBGU port is only used infrequently, most of the time the
connection to our product is via ethernet/usb.

I did manage to get ithe DBGU to work by changing the IRQ request flag
to NODELAY.

#ifndef CONFIG_RTC_DRV_AT91RM9200
    if ( machine_is_at91rm9200() && port->irq == 1 )
        retval = request_irq(port->irq, atmel_interrupt, IRQF_NODELAY,
            tty ? tty->name : "atmel_serial", port);
    else
#endif
        retval = request_irq(port->irq, atmel_interrupt, IRQF_SHARED,
            tty ? tty->name : "atmel_serial", port);

I understand the warnings and limitations of NODELAY for an RT kernel,
but this is a quick fix which allows me to continue to use the DBGU
for my development and I can remove it once I get to production
status.

There is a comment in the atmel_serial.c file which says that
"Transmit is IRQF_NODELAY safe" but I don't know if the Receive is as
well. Maybe the Receive isn't deemed safe because it is shared with
the RTC? If it is not shared, then maybe it is safe? I intend
investigate this myself I have any further problems.

Thanks again!

Aras
