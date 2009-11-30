From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 30 Nov 2009 22:15:38 +0200
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130150100.GB7028@n2100.arm.linux.org.uk>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<1259589780.26472.18.camel@laptop>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
	<20091130144702.14bea0ee@lxorguk.ukuu.org.uk>
	<20091130150100.GB7028@n2100.arm.linux.org.uk>
Message-ID: <cd73a99e0911301215i7a61b468w3b49325bd1fda3ac@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> There is hardware out there (AT91) where
> the timer interrupt is shared with other peripherals, and you end
> up with a mixture of irqs-disabled and irqs-enabled handlers sharing
> the same interrupt.

For the AT91 case I don't think this shouldn't matter.

The AT91's have a priority-level interrupt controller, so:
  1. a lower-priority interrupt won't interrupt a higher-priority
  2. shared interrupts cannot interrupt each other until irq_finish()
is called (a write to AIC_EOICR)

Since the Timer, DBGU serial port (and other system peripherals) are
on the same priority level they cannot interrupt each other.
(ie, basically as-if always irqs-disabled).

The case of irqs-enabled does means that a higher-priority interrupt
could interrupt [*], but it's not a shared-IRQ in that case.

([*] The system peripherals have the highest priority by default, so
the user would need to override the defaults for this to occur)


Regards,
 Andrew Victor
