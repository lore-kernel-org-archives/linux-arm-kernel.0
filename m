From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 19 May 2010 17:12:57 +1000
Subject: Boot interface for device trees on ARM
In-Reply-To: <20100519014118.GD2318@shareable.org>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
	<20100519002826.GG25892@yookeroo>
	<20100519014118.GD2318@shareable.org>
Message-ID: <20100519071257.GR25892@yookeroo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 02:41:18AM +0100, Jamie Lokier wrote:
> David Gibson wrote:
> > On Tue, May 18, 2010 at 08:24:06AM -0400, Nicolas Pitre wrote:
> > > On Tue, 18 May 2010, David Gibson wrote:
> > > > On Tue, May 18, 2010 at 01:24:43PM +0800, Jeremy Kerr wrote:
> > > > > Nicolas Pitre wrote:
> > [snip]
> > > > The only reason you'd need a subarchitecture number or equivalent is
> > > > if you need to do things differently in the very, very early asm boot
> > > > code.  We may need a minimal form of this on PowerPC if we ever
> > > > support multiple MMU families in the same kernel binary.
> > > 
> > > Exact.  For example, on ARM the machine ID is also used to figure out 
> > > the MMU mapping needed to be able to simply be able to debug the very 
> > > early assembly boot stage when there isn't even a stack available. While 
> > > this info is stored in the machine record, it is actually 
> > > subarchitecture specific and already half-digested for easy usage by 
> > > that initial MMU setup.  I just don't want to imagine what the 
> > > equivalent functionality with DT would look like.
> > 
> > Well, it wouldn't be *that* bad - you'd need a minimal asm-only tree
> > walker to find and look up the compatible property.  Quite possible
> > but, yes, fairly awkward.
> 
> I'm not entirely clear, is the DT intended to replace the command line
> for saying things like "console=XXX"?

Um.. well, in a DT based system, the bootloader typically passes the
command line to the kernel via the device tree (it goes in the
bootargs property of /chosen).

However, at least on PowerPC the default console is also specified
directly in the DT (via the linux,stdout-path property in /chosen), so
putting console= on the command line isn't usually necessary (if given
it will override the linux,stdout-path property for most purposes).

> Real example: I have a device where the bootloader decides which
> serial port will be the diagnostic boot console, if any, based on a
> specially wired serial cable detected at boot time, and it passes the
> decision to the kernel.

Setting linux,stdout-path in the device tree sounds like the right
thing to do here.

> In that case, does the console selection need to be easily accessible
> to that early asm code, for early printks?

Well, typically I wouldn't expect printk() to occur until you're in C
code at least, but I don't know about the ARM code.  Once you're in C
code it shouldn't be significantly harder to consult the device tree
than to parse the command line.

On PowerPC we do have a super-early debug printing mechanism, but when
that's enabled all the specifics are compile-time selected (it's
basically only recommended for use during bringup).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
