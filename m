From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 16 Dec 2014 13:56:26 +0100 (CET)
Subject: [PATCH 0/5] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <20141216122503.77c5632f@bbrezillon>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
 <2662748.NJbkr6jW7r@vostro.rjw.lan> <3542278.8lcJeXLMFm@vostro.rjw.lan>
 <20141216100715.57baeb65@bbrezillon>
 <alpine.DEB.2.11.1412161013570.17382@nanos>
 <20141216122503.77c5632f@bbrezillon>
Message-ID: <alpine.DEB.2.11.1412161349420.17382@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Dec 2014, Boris Brezillon wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > Install the timer interrupt as a demultiplexing interrupt.
> 
> I can try to hack the AIC irqchip driver to implement this demux logic,
> but this logic can't be placed in the PIT (Periodic Interval Timer)
> driver itself, because the shared IRQ line is used by the at91 clock
> controller (PMC) which is providing the clock to the PIT device.
> This gives the following dependency graph:
> 
> PIT =depends-on=> Master Clock =provided-by=> PMC =needs=> PMC IRQ.

It never can be a part of a device driver. This is a property of the
interrupt controller which fails to provide a proper demux for this
irq line in the first place.

So you fake the demux in the irq chip driver, where you provide the
pseudo chip and the demux logic. None of the device drivers (PIT, PMC,
UART ...) even knows about that.

|--------|             |--------|
| AIC    |-------------| Pseudo |---- PIT
|        |             | chip   |---- PMC
|        |             |        |---- UART
|        |             |--------|
|        |--- devX
|        |--- devY
|        |--- devZ
|--------|

So PIT, PMC and UART get interrupt numbers handed out which are
outside of the interrupt space of AIC.

Thanks,

	tglx
