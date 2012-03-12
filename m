From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Mar 2012 10:03:45 +0000
Subject: [PATCH] serial: PL011: clear pending interrupts
In-Reply-To: <CAAMvbhF7-5FyzjgtK7EjFZSJg4KBxdMdd1jnTRTLA-LnsVhKyw@mail.gmail.com>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
 <CAAMvbhF7-5FyzjgtK7EjFZSJg4KBxdMdd1jnTRTLA-LnsVhKyw@mail.gmail.com>
Message-ID: <20120312100345.GX17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 09:27:28AM +0000, James Courtier-Dutton wrote:
> On 12 March 2012 08:25, Linus Walleij <linus.walleij@stericsson.com> wrote:
> > From: Linus Walleij <linus.walleij@linaro.org>
> >
> > Chanho Min reported that when the boot loader transfers
> > control to the kernel, there may be pending interrupts
> > causing the UART to lock up in an eternal loop trying to
> > pick tokens from the FIFO (since the RX interrupt flag
> > indicates there are tokens) while in practice there are
> > no tokens - in fact there is only a pending IRQ flag.
> >
> 
> I might be off base here, because I don't know this particular UART,
> but if an IRQ routine is called because the RX interrupt flag is set,
> shouldn't the IRQ routine be written in such a way that it can never
> lock up.

The problem is that there are two flags:

1. The receiver interrupt status flags
2. The fifo status flags

It appears that there's a condition where the receiver interrupt flags can
indicate that characters are pending, but the status flags say that there
are no characters pending in the receive buffer.

This occurs because it seems there's a hardware bug when switching from
FIFO mode to non-FIFO mode - this causes previously received characters
to be hidden from the FIFO status flags.
