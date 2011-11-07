From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2011 13:52:16 +0000
Subject: [02: PATCH 0/41] Platform arch_reset changes
In-Reply-To: <20111107133847.GC5454@mudshark.cambridge.arm.com>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111106173939.GJ12913@n2100.arm.linux.org.uk>
 <20111107133847.GC5454@mudshark.cambridge.arm.com>
Message-ID: <20111107135216.GP12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 01:38:47PM +0000, Will Deacon wrote:
> Russell,
> 
> On Sun, Nov 06, 2011 at 05:39:39PM +0000, Russell King - ARM Linux wrote:
> > Part 2. These are the platform updates, so far.
> > 
> > The first patch combines the individual files in mach-clps711x which
> > contain one or two functions or data structures before changing the
> > arch_reset stuff.
> > 
> > The majority of the remaining patches address each group of platforms
> > individually.
> > 
> > The final patch removes the resulting empty arch_reset() functions,
> > its call site and associated code.  XXX NOTE XXX This results in
> > anything left with an arch_reset() function having non-functional
> > restart capability.
> 
> I was dreading the thought of having to go digging around in each platform
> again, so thanks for doing this. Apart from the troublesome platforms
> (partially addressed in your third series), is there anything else that
> needs looking at?

In direct connection with this - that said, although I've build-tested a
number of these (which is why I found things like the trailing , on the
previous initializers - and had to rework some of the patches as a result),
I've also boot tested the Versatile Express and OMAP3 but not tried a
'reboot' on them yet.

The final removal of mach/system.h depends on getting rid of the arch_idle
thing.  While going through these headers, I was dismayed to find these:

arch/arm/mach-s3c2410/include/mach/system.h:void (*s3c24xx_idle)(void);
arch/arm/plat-mxc/include/mach/system.h:extern void (*imx_idle)(void);

when we have a perfectly good pm_idle hook already in place - so there's
no excuse for these especially when other platforms are already using
pm_idle to hook their platform specific idle function into.  This is
something that better be gone at the next merge window!

> I guess I should also ask whether or not the third series is a blocker for
> merging the other two (given that it would leave those platforms broken).

That depends on your point of view.

My original plan was to see about merging the ground-work (part 1) in
this merge window to avoid a dependency problem - but I think it grew
too large to contemplate that (I might have a discussion with Linus
in private over this, because not doing this could be quite hairy for
us.)

Part 2 is fine up until the final patch - if we can get part 1 in, then
the individual patches can be carried in the various maintainer trees
independently.  In any case, patch 41 would have to be scheduled for
the end of the merge window.

As for whether patch 41 goes in with or without the remainder fixed up,
that depends what kind of a mood I'm in - over the weekend I was feeling
very pissed off with the state of the remaining platforms that I was
seriously thinking that I'd push it in anyway at the next merge window
and to hell with them.  (Just like the Greece holding the eurozone to
ransom, I don't want a few platforms holding the rest of the ARM tree
to ransom over this change!)

I've moderated a little bit over that - but only to the extent that
there's going to be something like 12 weeks for other platforms to get
their act together and if they don't show willing to address the
concerns, then I'm really not going to care about breaking them at
the next merge window.
