From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 19 May 2010 10:28:26 +1000
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1005180802010.12758@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
Message-ID: <20100519002826.GG25892@yookeroo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 08:24:06AM -0400, Nicolas Pitre wrote:
> On Tue, 18 May 2010, David Gibson wrote:
> > On Tue, May 18, 2010 at 01:24:43PM +0800, Jeremy Kerr wrote:
> > > Nicolas Pitre wrote:
[snip]
> > The only reason you'd need a subarchitecture number or equivalent is
> > if you need to do things differently in the very, very early asm boot
> > code.  We may need a minimal form of this on PowerPC if we ever
> > support multiple MMU families in the same kernel binary.
> 
> Exact.  For example, on ARM the machine ID is also used to figure out 
> the MMU mapping needed to be able to simply be able to debug the very 
> early assembly boot stage when there isn't even a stack available. While 
> this info is stored in the machine record, it is actually 
> subarchitecture specific and already half-digested for easy usage by 
> that initial MMU setup.  I just don't want to imagine what the 
> equivalent functionality with DT would look like.

Well, it wouldn't be *that* bad - you'd need a minimal asm-only tree
walker to find and look up the compatible property.  Quite possible
but, yes, fairly awkward.

Yeah, if you have to make really early MMU decisions based on
subarchitecture it probbaly makes sense to have a simple ID for
those.  So one thing to consider here is that we've contemplated
adding an "MMU family" ID to the device tree blob header for this
purpose on PowerPC.  If we did such a thing, it could also be used on
ARM for a similar purpose.  Then all the relevant machine information
is in one block, and it's just a simple fixed dereference to extract
the MMU type from the early asm.

I'd have to talk to Ben et al, but I think we'd be happy enough to
create a new dtb v18 which included that field, as well as a couple of
other small improvements to the header and blob internals.  ARM could
standardize on that as the minimum acceptable dtb version.

> > > Therefore, I don't think we need the machine ID at all: once the DT is 
> > > available, we can use that for any machine-specific stuff. Even though we're 
> > > not *configuring* it from the device tree, we can *select* it from there 
> > > instead.
> > 
> > Yes, absolutely.
> 
> Please see above why I disagree.

Well, I see your point for the early MMU stuff.  However, I'm betting
there's other, later platform related setup which could just as easily
be selected bsaed on the device tree, rather than on a magic ID.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
