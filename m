From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 21:11:51 +0000
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
Message-ID: <20110127211151.GC1597@n2100.arm.linux.org.uk>
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
> 
> Architecturally the termios handling doesn't need a spin lock nor is it
> called under one. In fact it's vital this is the case because of USB.

It needs to protect against the read_status_mask and ignore_status_mask
being read half-way through an update by the interrupt handler, otherwise
you can end up with god-knows-what coming through from each termios
change.

Eg, you could see an effective CREAD flip when the state of CREAD wasn't
actually changed.
