From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 13 Oct 2011 14:36:16 -0400 (EDT)
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111013140520.GV21648@n2100.arm.linux.org.uk>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
	<1837446.fiK2eIOO53@wuerfel>
	<20111013082836.GG21648@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110130932350.17040@xanadu.home>
	<20111013140520.GV21648@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1110131219580.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, Russell King - ARM Linux wrote:

> On Thu, Oct 13, 2011 at 09:39:03AM -0400, Nicolas Pitre wrote:
> > On Thu, 13 Oct 2011, Russell King - ARM Linux wrote:
> > 
> > > On Wed, Oct 12, 2011 at 10:30:11AM +0200, Arnd Bergmann wrote:
> > > > On Tuesday 11 October 2011 20:03:38 Nicolas Pitre wrote:
> > > > > On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> > > > > 
> > > > > > I've stuck them into the arm-soc tree for now, so we get linux-next
> > > > > > coverage, but I won't send them to Linus this way because then we
> > > > > > would get the same commits twice in the history.
> > > > > 
> > > > > Could you please do the same with the following:
> > > > > 
> > > > >   git://git.linaro.org/people/nico/linux.git mach_memory_h
> > > > > 
> > > > > Russell pulled it at some point, and dropped it due to concerns about 
> > > > > repeated conflict resolutions (or so I presume).  I just did a test 
> > > > > merge between your for-next branch and the above and that looked trivial 
> > > > > enough.
> > > > 
> > > > Ok, done.
> > > 
> > > Bypassing maintainers stinks - especially when there are unaddressed
> > > comments outstanding.  Nicolas has "simplified" my objections in this
> > > request for you to pull - and has completely ignored the problem that
> > > it breaks ZBOOT_ROM by deleting the zreladdr definitions on EP93xx
> > > with no way for that to be provided.
> > 
> > I also told you that EP93xx doesn't use ZBOOT_ROM anywhere, and that 
> > this was approved by the EP93xx maintainers.
> 
> It was not even discussed - or even the issue pointed out (I checked).
> In any case, how can *anyone* know whether ZBOOT_ROM is used or not?
> It's a facility that's there for users (not really for maintainers)
> to enable.

Please listen: I have no intention of killing ZBOOT_ROM.  If you 
remember correctly, I was the one who came up with the ability to run 
the decompressor from ROM in v2.3.23pre5 , before you reworked it with 
the introduction of ZBOOT_ROM in v2.5.9.  I don't know if this feature 
was ever used by anyone other than myself, but I usually don't tend to 
scrap my own features.

> > Furthermore I said that I intended to make ZBOOT_ROM dependent on 
> > CONFIG_PHYS_OFFSET, given that PHYS_OFFSEt and zreladdr are intimately 
> > related which I also explained previously.
> 
> Sorry, you're totally confused here - with your own work noless.
> 
> CONFIG_PHYS_OFFSET is a numeric setting, which is only available when the
> dynamic p:v stuff is disabled.  So, saying that ZBOOT_ROM is dependent on
> CONFIG_PHYS_OFFSET is insane - it's completely the wrong symbol.  So I'm
> going to assume that you actually meant CONFIG_ARM_PATCH_PHYS_VIRT instead.

Not exactly, but that's not the point (see below).

> Now, the *TECHNICAL* point is that there is absolutely nothing wrong with
> building a kernel with CONFIG_ARM_PATCH_PHYS_VIRT *enabled* and ZBOOT_ROM
> also enabled.  You get a kernel Image which can be loaded at different
> addresses, and it'll work.  You get a zImage which can also be loaded at
> different addresses, and it'll also work.  You can also put the zImage
> into read-only memory.

We can't agree more on this technical possibility.  *BUT* that doesn't 
mean that because we _can_ do it that this is something useful in 
practice.

> However, ZBOOT_ROM is completely *INCOMPATIBLE* with AUTO_ZRELADDR.  So
> if anything, ZBOOT_ROM should depend on !AUTO_ZRELADDR *only*.

I disagree on two levels.  First, practically, there is no advantage to 
activate ZBOOT_ROM which requires a fixed .bss address and a fixed 
zreladdr to work, and then have PATCH_PHYS_VIRT also enabled.  The 
purpose of the later is to avoid having a fixed address for RAM encoded 
in the kernel while the former forces you to know the RAM layout.  I 
just can't find a real life use case where people would want that 
combination of features.

Secondly, zreladdr is really getting in the way of a single zImage for 
multiple SOCs.  And we really want people to get rid of build-time 
hardcoded constants like zreladdr, PHYS_OFFSET and the like as much as 
possible.  Hence the mach/memory.h removal series.  Removing zreladdr is 
coming next.

HOWEVER I don't want to kill the ability to have a XIP kernel, nor do I 
want to kill ZBOOT_ROM.  But let's face it, the people who use either of 
those features must know what they're doing already.  They're obviously 
the minority users by far, and they should be able to know their 
hardware sufficiently enough to provide a value for ZBOOT_ROM_TEXT, 
ZBOOT_ROM_BSS, and/or XIP_PHYS_ADDR.  So, given that _practically_ the 
value in having ZBOOT_ROM and PATCH_PHYS_VIRT together is rather dubious 
(even if _technically_ this is entirely feasible), I'm looking at using 
CONFIG_PHYS_OFFSET to get rid of zreladdr because zreladdr is always 
equal to PHYS_OFFSET + TEXT_OFFSET.

Of course that means that ZBOOT_ROM and XIP_KERNEL should then depend on 
CONFIG_PHYS_OFFSET being configured, which is a consequence of 
!ARM_PATCH_PHYS_VIRT && !NEED_MACH_MEMORY_H.  Or maybe this should be 
the other way around i.e. ARM_PATCH_PHYS_VIRT depending on !XIP_KERNEL 
(which is already the case) and !ZBOOT_ROM.  But those are Kconfig 
details that can be discussed later.

You are right in saying that, strictly speaking, ZBOOT_ROM should depend 
on !AUTO_ZRELADDR.  But I want AUTO_ZRELADDR to be killed and simply be 
replaced by #ifndef CONFIG_ZBOOT_ROM in the code eventually, which would 
implies that (CONFIG_PHYS_OFFSET + TEXT_OFFSET) could be used in the 
#else part.  Why killing it? There is no more obstacles having the 
AUTO_ZRELADDR feature always enabled by default, except for ZBOOT_ROM.  
The only problematic platform was MSM because of its 2MB RAM offset, but 
that limitation has now been removed.

> Given your vehement response when I raised that point, you don't want to
> understand it, so I decided to postpone the issue until I had the
> motivation to go head-to-head with you like I'm now doing - to make you
> see sense.

Please.  I'm not that emotional about what should be a technical 
discussion.

> Moreover, because you're encouraging maintainers to accept patches which
> remove the zreladdr definitions and force-select AUTO_ZRELADDR, you're
> actively killing off ZBOOT_ROM support, even though you said otherwise.

See above. I do want to preserve it, but in a more convenient way from a 
maintenance perspective.  The only difference to the user configuring a 
kernel with ZBOOT_ROM is that an additional address value 
(CONFIG_PHYS_OFFSET) will be required, but I think this is a reasonable 
compromise for this feature.


Nicolas
