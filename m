From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 18 May 2010 21:28:38 -0400 (EDT)
Subject: Boot interface for device trees on ARM
In-Reply-To: <20100519002826.GG25892@yookeroo>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
	<20100519002826.GG25892@yookeroo>
Message-ID: <alpine.LFD.2.00.1005182109180.12758@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 May 2010, David Gibson wrote:

> On Tue, May 18, 2010 at 08:24:06AM -0400, Nicolas Pitre wrote:
> > On Tue, 18 May 2010, David Gibson wrote:
> > > On Tue, May 18, 2010 at 01:24:43PM +0800, Jeremy Kerr wrote:
> > > > Nicolas Pitre wrote:
> [snip]
> > > The only reason you'd need a subarchitecture number or equivalent is
> > > if you need to do things differently in the very, very early asm boot
> > > code.  We may need a minimal form of this on PowerPC if we ever
> > > support multiple MMU families in the same kernel binary.
> > 
> > Exact.  For example, on ARM the machine ID is also used to figure out 
> > the MMU mapping needed to be able to simply be able to debug the very 
> > early assembly boot stage when there isn't even a stack available. While 
> > this info is stored in the machine record, it is actually 
> > subarchitecture specific and already half-digested for easy usage by 
> > that initial MMU setup.  I just don't want to imagine what the 
> > equivalent functionality with DT would look like.
> 
> Well, it wouldn't be *that* bad - you'd need a minimal asm-only tree
> walker to find and look up the compatible property.  Quite possible
> but, yes, fairly awkward.
> 
> Yeah, if you have to make really early MMU decisions based on
> subarchitecture it probbaly makes sense to have a simple ID for
> those.  So one thing to consider here is that we've contemplated
> adding an "MMU family" ID to the device tree blob header for this
> purpose on PowerPC.  If we did such a thing, it could also be used on
> ARM for a similar purpose.  Then all the relevant machine information
> is in one block, and it's just a simple fixed dereference to extract
> the MMU type from the early asm.
> 
> I'd have to talk to Ben et al, but I think we'd be happy enough to
> create a new dtb v18 which included that field, as well as a couple of
> other small improvements to the header and blob internals.  ARM could
> standardize on that as the minimum acceptable dtb version.

I still don't get it.  Why on earth would you insist on replacing the 
already existing ID value that is _already_ passed to the kernel by all 
ARM bootloaders with something evidently far more complex?

Please let's step back a bit.

DT is a mean to help making the code more generic and reduce the amount 
of machine specific code, not to increase it in other ways.  While the 
ID passed in r1 makes perfect sense to me as it is simple and straight 
forward, using the DT for this provides absolutely no advantage.

Yet we still need the ID into r1 to distinguish between a DT boot from a 
legacy boot.  So it is much simpler to always have the ID to select 
whether a specific machine is being booted, or if the DT should later be 
used to configure the kernel for a specific machine.  No special code 
path is needed, etc.

Moving the ID into the DT just for the sake of it is not useful.


Nicolas
