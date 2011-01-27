From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 27 Jan 2011 21:07:29 +0000
Subject: Locking in the clk API
In-Reply-To: <20110127204354.GB1597@n2100.arm.linux.org.uk>
References: <201101111744.59712.jeremy.kerr@canonical.com>
	<20110111103929.GN24920@pengutronix.de>
	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>
	<4D386ABF.9060908@fluff.org>
	<20110120190822.GK6335@n2100.arm.linux.org.uk>
	<4D3932B4.8010904@codeaurora.org>
	<20110121094042.GD13235@n2100.arm.linux.org.uk>
	<4D40F5CC.6080809@codeaurora.org>
	<20110127085438.GA25239@n2100.arm.linux.org.uk>
	<4D41D5EC.6030405@codeaurora.org>
	<20110127204354.GB1597@n2100.arm.linux.org.uk>
Message-ID: <20110127210729.79eef2c1@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > For internal tree purposes, does .set_termios need to be atomic? Can it  
> > grab mutexes instead of spinlock?
> 
> I think I already answered that question above where I said "protect
> against the interrupt handler accessing the port->* stuff".

I'm not sure you answered it correctly however as the locking nowdays is
a bit different.

Architecturally the termios handling doesn't need a spin lock nor is it
called under one. In fact it's vital this is the case because of USB.

I see nothing in the 2.6.37 cpm_uart code that isn't trivially fixable.
There is already a mutex protecting termios serialization so all you seem
to need to do is call clk_set_rate after rather than before dropping the
lock surely ?

Oh if you are looking at the cpm_uart code and care about it the following
in the code isn't safe as tty could possibly go NULL and be freed under
you.

     struct tty_struct *tty = port->state->port.tty;

and you ought to be doing

	tty = tty_port_tty_get(&port->state->port);

	if (tty)
		blah;
	tty_kref_put(tty);	/* put NULL is a no-op anyway */


probably in the main irq handler and pass tty to the helpers that need it.


Alan
