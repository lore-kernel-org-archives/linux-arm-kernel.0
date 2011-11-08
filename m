From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 07 Nov 2011 23:24:39 -0500 (EST)
Subject: [02: PATCH 0/41] Platform arch_reset changes
In-Reply-To: <20111107135216.GP12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111106173939.GJ12913@n2100.arm.linux.org.uk>
 <20111107133847.GC5454@mudshark.cambridge.arm.com>
 <20111107135216.GP12913@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111072306340.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2011, Russell King - ARM Linux wrote:

> The final removal of mach/system.h depends on getting rid of the arch_idle
> thing.  While going through these headers, I was dismayed to find these:
> 
> arch/arm/mach-s3c2410/include/mach/system.h:void (*s3c24xx_idle)(void);
> arch/arm/plat-mxc/include/mach/system.h:extern void (*imx_idle)(void);
> 
> when we have a perfectly good pm_idle hook already in place - so there's
> no excuse for these especially when other platforms are already using
> pm_idle to hook their platform specific idle function into.  This is
> something that better be gone at the next merge window!

I saw those too and intended to get rid of those pointers.
I was just waiting for your arch_reset work to settle down before
respinning my arch-idle series.

> > I guess I should also ask whether or not the third series is a blocker for
> > merging the other two (given that it would leave those platforms broken).
> 
> That depends on your point of view.
> 
> My original plan was to see about merging the ground-work (part 1) in
> this merge window to avoid a dependency problem - but I think it grew
> too large to contemplate that (I might have a discussion with Linus
> in private over this, because not doing this could be quite hairy for
> us.)
> 
> Part 2 is fine up until the final patch - if we can get part 1 in, then
> the individual patches can be carried in the various maintainer trees
> independently.  In any case, patch 41 would have to be scheduled for
> the end of the merge window.

I'd recommend publishing all those patches in your tree and pushing them 
all in the next merge window.  The probability for conflicts with 
subarch trees is still relatively low. If conflicts are unavoidable then 
using your branch as a base would be the way to go. Whether platform 
code is then based on 3.2-rc1 or a particular branch in your tree is not 
much different at that point.

> As for whether patch 41 goes in with or without the remainder fixed 
> up, that depends what kind of a mood I'm in - over the weekend I was 
> feeling very pissed off with the state of the remaining platforms that 
> I was seriously thinking that I'd push it in anyway at the next merge 
> window and to hell with them.  (Just like the Greece holding the 
> eurozone to ransom, I don't want a few platforms holding the rest of 
> the ARM tree to ransom over this change!)

I agree with that.  However, if you merge those patches (including patch 
41) in your tree now, that means people have about 5 months before this 
change will show up in a released kernel, which should give plenty of 
time for interested parties to fix their problematic code.  The sooner 
this appears in linux-next the better.

> I've moderated a little bit over that - but only to the extent that
> there's going to be something like 12 weeks for other platforms to get
> their act together and if they don't show willing to address the
> concerns, then I'm really not going to care about breaking them at
> the next merge window.

Exactly.


Nicolas
