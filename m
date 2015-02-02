From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 02 Feb 2015 19:33:01 +0100
Subject: [PATCH v2,
 RFC] RTC: PXA: Fix regression of interrupt before ioremap
In-Reply-To: <54CF90F1.4020703@tul.cz> (Petr Cvek's message of "Mon, 02 Feb
 2015 16:00:01 +0100")
References: <54CA1ECA.8050000@tul.cz> <87fvatnzl7.fsf@free.fr>
 <54CF90F1.4020703@tul.cz>
Message-ID: <87a90wb1uq.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> I agree that driver without .open looks ugly, but only thing in rtc-pxa .open
> were two request_irq and I don't think it is good idea to have them there
> (interrupts should be disabled trough register settings and not by handler
> freeing).
>
> I'm not familiar with the linux RTC subsystem, so I don't know if it is OK to
> get interrupt (and rtc_update_irq) without opened /dev/rtc. Intuitively I have
> feeling it is OK, but even if not disabling can be done with some register flag.
>
> BTW It seems that kernel have only around 9 drivers in drivers/rtc which contain
> .open function.
>
> OT: rtc-sa1100 seems to be compatible with PXAxxx (it is even in Kconfig). Are
> there any reasons to have two drivers for one SoC?
Yes, there is a reason :
  http://marc.info/?l=linux-arm-kernel&m=122306289606732&w=2

At that time we decided this were 2 different IPs (more or less) sharing the
same IO region and IRQ. 2 IPs for pxa27x and greater, only 1 IP for pxa25x and
lower.

Now you should know that both rtc-sa1100 and rtc-pxa should be able to work
together in the same kernel (at least that was the case so far). The open()
decided who got a grip on the interrupt. This lets userland choose which rtc it
relies on : either the increasing count, or the
day/month/year/hour/minute/second counters (which are independant).

Moreover, if there are multiple rtc device, how on earth can it work, ie. how
can an ioctl() be sent to a specific rtc device if there is no open() ???

Cheers.

--
Robert
