From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 30 Nov 2009 20:39:33 +0000
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <20091129152757.GF11445@n2100.arm.linux.org.uk>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
	<20091128200344.GA1272@pengutronix.de>
	<alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
	<20091129023118.GA21529@shareable.org>
	<20091129102635.GA22653@pengutronix.de>
	<20091129151840.GA30813@shareable.org>
	<20091129152757.GF11445@n2100.arm.linux.org.uk>
Message-ID: <20091130203933.GC5560@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Sun, Nov 29, 2009 at 03:18:40PM +0000, Jamie Lokier wrote:
> > Or we could do away with this silliness and just switch everything to
> > threaded interrupts with RT-priorities ;-)
> 
> ... thereby needlessly increasing the latency of all interrupt handling
> and probably breaking some devices.

It's not that cut and dried.  RT gives you priorities where you might
not have had them before, so in some cases can reduce worst-case
latency for critical devices.  IRQF_DISABLED is a cheap two-level
priority scheme; RT threaded interrupts extend it.

The extra processing increases latency, yes, but that is in a sense a
scheduling fast-path problem; it's not _intrinsic_ to threaded
interrupts that they have to have higher latency (you don't have to
use the normal calculation or task switch to get equivalent
behaviour), but undoubtedly trying to optimise that leads to very
twisty code and state representations, and I don't see it happening in
Linux any time soon.

-- Jamie
