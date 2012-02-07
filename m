From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Feb 2012 16:51:58 +0000
Subject: Kirkwood, kernel 3.2, vmalloc region overlap, not starting up
In-Reply-To: <20120207161838.GF15165@lunn.ch>
References: <20120207152903.GA16238@lunn.ch>
 <4F314D0C.50501@kernelconcepts.de> <20120207161838.GF15165@lunn.ch>
Message-ID: <20120207165158.GD889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 05:18:38PM +0100, Andrew Lunn wrote:
> > Apart from my joy - the basic reason for that change would be still
> > interesting? Does this only apply to Kirwoods or my special board?
> 
> I think the conversation fizzled out without coming to a conclusion
> what is wrong. Look back in the archives and see what you can find.
> The problem hits kirkwood, but i don't know if it also affects other
> Orion based processors. u-boot also play a role in the problem...

I think what's going on (what's suggested by the uboot patch) is that
uboot leaves the L2 cache enabled, and then passes control over to
the kernel decompressor.

The kernel decompressor starts, and enables the L1 cache.  This
unexpectedly enables the L2 cache as well.  However, the decompressor
is not L2 cache aware, and only cleans the L1 cache.

The decompressor finishes, flushes the L1 cache, and disables the L1
cache (and, because of the way things work, disables the dirty L2
cache.)

We're now in the situation where the kernel text/data may or may not
be in RAM, and therefore may or may not be executable.

I don't think that's Nils problem.

But why you've both identified that turning off the V2P stuff fixes it,
I'm not sure.  It needs debugging (it needs me or someone else to cook
up a patch to get some information out of - explicitly - Nils system)
so that we can work out what's going on there.

The theory is, the V2P stuff should be able to calculate the physical
offset irrespective of the kernel placement, and so having it enabled
should be totally transparent.  Obviously, something is going wrong.
As yet we don't know what's causing Nils problem.

If no one gets there before me, then I'll post a patch for Nils to run
with to get some information from his kernel sometime in the next few
days, assuming these messages don't get too buried and I don't forget.
