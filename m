From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 08:54:38 +0000
Subject: Locking in the clk API
In-Reply-To: <4D40F5CC.6080809@codeaurora.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111103929.GN24920@pengutronix.de>
	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>
	<4D386ABF.9060908@fluff.org>
	<20110120190822.GK6335@n2100.arm.linux.org.uk>
	<4D3932B4.8010904@codeaurora.org>
	<20110121094042.GD13235@n2100.arm.linux.org.uk>
	<4D40F5CC.6080809@codeaurora.org>
Message-ID: <20110127085438.GA25239@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 08:34:20PM -0800, Saravana Kannan wrote:
> I'm not too familiar with serial/tty, does anyone know if the  
> .set_termios needs to be atmoic? If not, we could just change  
> cpm_uart/cpm_uart_core.c to use mutex instead of spinlock.

The locking is there to protect against the interrupt handler accessing
the port->* stuff (which seems to have been forgotten by the cpm driver).

I don't see any reason why clk_set_rate() needs to be under the spinlock
there - we need the reprogramming of the baud rate within the spinlock
on 8250 because of DLAB bit hiding the data registers.  It's also a good
idea that it _is_ within the spinlock along with uart_update_timeout()
to ensure timeouts and the baud rate are updated together.
