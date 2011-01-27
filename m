From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 16:46:01 +0000
Subject: [PATCH v2] ARM: Avoid discarding sections that might have
	SMP_ON_UP fixups SMP_ON_UP fixups
In-Reply-To: <20110127143709.GA13735@arm.com>
References: <alpine.LFD.2.00.1101261617190.8580@xanadu.home>
	<20110127143709.GA13735@arm.com>
Message-ID: <20110127164601.GD26418@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 02:37:09PM +0000, Dave Martin wrote:
> On Wed, Jan 26, 2011 at 04:31:37PM -0500, Nicolas Pitre wrote:
> > Since discarded sections are by definition not used, we should at least 
> > put them into the .init section so to discard them at run time.  And 
> > only the EXIT_TEXT and EXIT_DATA would need to be kept (see x86 for 
> > example).
> > 
> > 
> > Nicolas
> 
> I'll check up on whether we need to care about writable data.
> For now I've just attempted to move stuff to .init.

You can keep the discarding of the unwind data for exit sections as
the exit sections don't depend on the unwind data.

It's all to do with sections being referenced from other sections.  If
a section being kept references a section being discarded, then the
linker will error out.  You need to keep any section that is being
referenced - but you don't need to keep sections which only reference
those being kept.

I'd also prefer to see a 'KEEP_EXIT' macro as I think we can discard
these sections in more cases than just SMP_ON_UP.  I think it's:

SMP_ON_UP && !DEBUG_SPINLOCK

which requires it.  So if you have spinlock debugging enabled you can
discard the exit sections.  See include/linux/spinlock.h.
