From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 21:15:56 +0000
Subject: Locking in the clk API
In-Reply-To: <20110127210729.79eef2c1@lxorguk.ukuu.org.uk>
References: <AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>
	<4D386ABF.9060908@fluff.org>
	<20110120190822.GK6335@n2100.arm.linux.org.uk>
	<4D3932B4.8010904@codeaurora.org>
	<20110121094042.GD13235@n2100.arm.linux.org.uk>
	<4D40F5CC.6080809@codeaurora.org>
	<20110127085438.GA25239@n2100.arm.linux.org.uk>
	<4D41D5EC.6030405@codeaurora.org>
	<20110127204354.GB1597@n2100.arm.linux.org.uk>
	<20110127210729.79eef2c1@lxorguk.ukuu.org.uk>
Message-ID: <20110127211556.GD1597@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 09:07:29PM +0000, Alan Cox wrote:
> > > For internal tree purposes, does .set_termios need to be atomic? Can it  
> > > grab mutexes instead of spinlock?
> > 
> > I think I already answered that question above where I said "protect
> > against the interrupt handler accessing the port->* stuff".
> 
> I'm not sure you answered it correctly however as the locking nowdays is
> a bit different.

Oh, and the other bit to this is protecting the hardware against two
concurrent accesses if that's what's required.

Eg, 8250 having characters written to the 'transmit' register while
DLAB is set, thereby corrupting the divisor being programmed into it.
There's other UARTs which shouldn't have FIFOs loaded while the UART
is disabled across an update.

Can you guarantee without locks that writes to the UART registers by
the interrupt handler won't happen while the .set_termios is
reprogramming the UART?
