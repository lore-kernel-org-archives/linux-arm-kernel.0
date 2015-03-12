From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 12 Mar 2015 12:56:04 +0000
Subject: [PATCH REPOST 2/2] serial/amba-pl011: Leave the TX IRQ alone
 when the UART is not open
In-Reply-To: <20150312110441.GM8656@n2100.arm.linux.org.uk>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
 <1425472054-7543-3-git-send-email-Dave.Martin@arm.com>
 <20150312110441.GM8656@n2100.arm.linux.org.uk>
Message-ID: <20150312125604.GB15596@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 11:04:41AM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 04, 2015 at 12:27:34PM +0000, Dave Martin wrote:
> > Getting the TX IRQ re-asserted from scratch can be inefficient in
> > some setups.
> > 
> > This patch avoids clearing the TX IRQ across pl011_shutdown()...
> > pl011_startup(), so that if the port is closed and reopened, the
> > IRQ will still work afterwards without having to bootstrap it again.
> 
> So if a port is being used as the console, we end up spraying the system
> with transmit interrupts?  This can't be right.

Nope, if the port is not open theough serial_core then TXIS remains
asserted but is masked off in IMSC.

This should be  just the same as the way we avoid a screaming TX interrupt
when the port *is* open but the transmitter is idle.


My commit message could have explained that better...

Cheers
---Dave
