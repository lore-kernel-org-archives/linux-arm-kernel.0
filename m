From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 23:24:21 +0000
Subject: request_irq in I2C driver causes kernel to freeze during
	probe, but if done later - no problem!
In-Reply-To: <4BAD406A.7070208@atmel.com>
References: <4BAD406A.7070208@atmel.com>
Message-ID: <20100326232421.GG29179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 27, 2010 at 12:16:58AM +0100, Ulf Samuelsson wrote:
> If the interrupt is executing, then we would see some I2C communication
> as a result, but we do not see this, before the kernel freezes.
> 
> The interrupt is (and should be) called on the falling edge of the
> interrupt.
> 
> I am currently scratching my head, and need help with ideas...

Do you always return IRQ_HANDLED from this handler, or do you return
IRQ_NONE if it does no work?

If you always return IRQ_HANDLED even if no work was done, it could be
that you're spinning on this interrupt, and because you're returning
IRQ_HANDLED, the core interrupt handling code thinks progress is being
made.

If you return IRQ_NONE, then the "bad IRQ" detection code will kick in
and disable the IRQ, which should result in some further progress.
