From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 1 Feb 2011 15:29:06 +0100
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110121222930.GF23151@n2100.arm.linux.org.uk>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<20110121215110.GD23151@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101211655110.8580@xanadu.home>
	<20110121222930.GF23151@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimEBz6UK0X45cA2ihZddfcSTNqEPTJa=zGc+84S@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Jan 21, 2011 at 05:20:57PM -0500, Nicolas Pitre wrote:
>> The only solution in that case is to give top priority to the FIFO IRQ
>> and never disable IRQs when in interrupt context, except for that FIFO
>> servicing handler which should keep IRQs masked out throughout. ?In any
>> case this would certainly be only a hack for badly misdesigned hardware.
>
> Not possible anymore. ?The kernel's IRQ handling has changed such that
> generic code now ensures that IRQs are disabled irrespective of the
> IRQF_DISABLED flag. ?All IRQ handlers are called with IRQs disabled,
> and they remain that way until they call local_irq_enable().

Then the only way of assuring low latency on this one IRQ would
be to convert the IRQ handlers for all the *other* hardware in the
Vexpress to request_threaded_irq(), and that's what the RealTime
folks do all the time I believe.

[Pawel Moll]
> (...) so far the only time when problem happens is the timeout caused
> by ISP1761 handler.

Have you considered switching the ISP1761 handler to
request_threaded_irq() with IRQF_ONESHOT | IRQF_NO_SUSPEND
so it runs in process context with that IRQ masked off, until completion?

Linus Walleij
