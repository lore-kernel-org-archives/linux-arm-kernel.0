From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 15:15:10 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110705135424.GC32718@e102109-lin.cambridge.arm.com>
References: <20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704215507.GH8286@n2100.arm.linux.org.uk>
	<20110705092600.GB25956@e102109-lin.cambridge.arm.com>
	<20110705104858.GV8286@n2100.arm.linux.org.uk>
	<20110705135424.GC32718@e102109-lin.cambridge.arm.com>
Message-ID: <20110705141510.GG8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 02:54:24PM +0100, Catalin Marinas wrote:
> On Tue, Jul 05, 2011 at 11:48:58AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Jul 05, 2011 at 10:26:00AM +0100, Catalin Marinas wrote:
> > > AFAIK the branch predictor is transparent on Cortex-A9 and the BTB
> > > maintenance are no-ops. You wouldn't notice any issues if you remove
> > > them (you can check ID_MMFR1[31:28].
> > 
> > It's not transparent:
> > 
> > CPU: MMFR0=0x00100103 MMFR1=0x20000000 MMFR2=0x01230000 MMFR3=0x00102111
> > 
> > 0b0010 Branch predictor requires flushing on:
> > 	? enabling or disabling the MMU
> > 	? writing new data to instruction locations
> > 	? writing new mappings to the translation tables
> > 	? any change to the TTBR0, TTBR1, or TTBCR registers without a
> > 	  corresponding change to the FCSE ProcessID or ContextID.
> 
> OK, it makes sense. But what's really confusing - the A8 has the same
> value for ID_MMFR1 (according to the TRM) but the BTB instructions are
> no-ops (can can be enabled by the ACTLR.IBE bit). I suspect the ID_MMFR1
> is wrong in this case.

Grumble.  This kind of thing worries me.

If the ID registers are wrong, then they can't be relied upon by software
making decisions about what can be skipped.  So how can we be confident
that MMFR3 23:20 != 0 really does mean that we don't need to clean the
cache when writing the page tables, and is not a result of some bug?
