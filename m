From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Nov 2009 15:27:57 +0000
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <20091129151840.GA30813@shareable.org>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
	<20091128200344.GA1272@pengutronix.de>
	<alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
	<20091129023118.GA21529@shareable.org>
	<20091129102635.GA22653@pengutronix.de>
	<20091129151840.GA30813@shareable.org>
Message-ID: <20091129152757.GF11445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 29, 2009 at 03:18:40PM +0000, Jamie Lokier wrote:
> Or we could do away with this silliness and just switch everything to
> threaded interrupts with RT-priorities ;-)

... thereby needlessly increasing the latency of all interrupt handling
and probably breaking some devices.

Some devices (eg, SMC91x, serial ports, PIO audio - AACI, MMCI) are
_extremely_ sensitive to interrupt latency due to lack of FIFO depth.

MMCI already sees overruns on ARM platforms if you try and clock the
cards at anything over about 500kHz.  Adding any more latency means
reducing the maximum clock rate there, and therefore crippling
throughput even more than it is already.
