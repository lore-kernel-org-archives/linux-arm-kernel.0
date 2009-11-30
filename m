From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 30 Nov 2009 23:30:35 +0000
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <alpine.LFD.2.00.0911302255590.24119@localhost.localdomain>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<20091130143703.GA7028@n2100.arm.linux.org.uk>
	<20091130145122.7057a1e3@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.00.0911302255590.24119@localhost.localdomain>
Message-ID: <20091130233035.2a404f62@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Either that or we decide to push such beasts into the threaded irq
> space to keep them working until the last card hits the trashcan. I
> know that this would still need to disable the interrupt on the PIC
> level, but we have already mechanisms for that in the threaded code.

The 8390 is essentially a single thread device so treating interrupts as
events indicating work is to be done might make sense

Unfortunately you cannot check the interrupt flags on the chip without
switching to page 0, which will cause any parallel tx to crap itself and
potentially hang the box. It's a design from single CPU days and the
programming model is solely around 'stack the register window selected,
do stuff in irq, put it back', so any parallel execution ends in tears,
even peeking to see if the IRQ is ours.

These chips still keep popping up in old boxes although the rtl8139 seems
to have exterminated them at last in all the ultra-cheap devices.

Pushing them into threaded IRQ space with PIC masking seems to make
complete sense. The wonderously gothic IRQ magic becomes a mutex, the IRQ
handler may sleep blocking the IRQ during a transmit and the transmit
path may block during an IRQ thread execution. Reset works as a mutex and
all the crap and magic goes away.
