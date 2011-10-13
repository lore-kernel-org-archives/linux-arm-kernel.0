From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 15:05:20 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <alpine.LFD.2.02.1110130932350.17040@xanadu.home>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
	<1837446.fiK2eIOO53@wuerfel>
	<20111013082836.GG21648@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110130932350.17040@xanadu.home>
Message-ID: <20111013140520.GV21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 09:39:03AM -0400, Nicolas Pitre wrote:
> On Thu, 13 Oct 2011, Russell King - ARM Linux wrote:
> 
> > On Wed, Oct 12, 2011 at 10:30:11AM +0200, Arnd Bergmann wrote:
> > > On Tuesday 11 October 2011 20:03:38 Nicolas Pitre wrote:
> > > > On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> > > > 
> > > > > I've stuck them into the arm-soc tree for now, so we get linux-next
> > > > > coverage, but I won't send them to Linus this way because then we
> > > > > would get the same commits twice in the history.
> > > > 
> > > > Could you please do the same with the following:
> > > > 
> > > >   git://git.linaro.org/people/nico/linux.git mach_memory_h
> > > > 
> > > > Russell pulled it at some point, and dropped it due to concerns about 
> > > > repeated conflict resolutions (or so I presume).  I just did a test 
> > > > merge between your for-next branch and the above and that looked trivial 
> > > > enough.
> > > 
> > > Ok, done.
> > 
> > Bypassing maintainers stinks - especially when there are unaddressed
> > comments outstanding.  Nicolas has "simplified" my objections in this
> > request for you to pull - and has completely ignored the problem that
> > it breaks ZBOOT_ROM by deleting the zreladdr definitions on EP93xx
> > with no way for that to be provided.
> 
> I also told you that EP93xx doesn't use ZBOOT_ROM anywhere, and that 
> this was approved by the EP93xx maintainers.

It was not even discussed - or even the issue pointed out (I checked).
In any case, how can *anyone* know whether ZBOOT_ROM is used or not?
It's a facility that's there for users (not really for maintainers)
to enable.

> Furthermore I said that I intended to make ZBOOT_ROM dependent on 
> CONFIG_PHYS_OFFSET, given that PHYS_OFFSEt and zreladdr are intimately 
> related which I also explained previously.

Sorry, you're totally confused here - with your own work noless.

CONFIG_PHYS_OFFSET is a numeric setting, which is only available when the
dynamic p:v stuff is disabled.  So, saying that ZBOOT_ROM is dependent on
CONFIG_PHYS_OFFSET is insane - it's completely the wrong symbol.  So I'm
going to assume that you actually meant CONFIG_ARM_PATCH_PHYS_VIRT instead.

Now, the *TECHNICAL* point is that there is absolutely nothing wrong with
building a kernel with CONFIG_ARM_PATCH_PHYS_VIRT *enabled* and ZBOOT_ROM
also enabled.  You get a kernel Image which can be loaded at different
addresses, and it'll work.  You get a zImage which can also be loaded at
different addresses, and it'll also work.  You can also put the zImage
into read-only memory.

However, ZBOOT_ROM is completely *INCOMPATIBLE* with AUTO_ZRELADDR.  So
if anything, ZBOOT_ROM should depend on !AUTO_ZRELADDR *only*.

Given your vehement response when I raised that point, you don't want to
understand it, so I decided to postpone the issue until I had the
motivation to go head-to-head with you like I'm now doing - to make you
see sense.

Moreover, because you're encouraging maintainers to accept patches which
remove the zreladdr definitions and force-select AUTO_ZRELADDR, you're
actively killing off ZBOOT_ROM support, even though you said otherwise.
I suspect in a years time it won't be worth having anymore - because in
order to use it you'd have to hack the select statements out of the
Kconfig files.

>  This doesn't have to go in 
> right away though.  But if this is one of your _requirements_, I'd have 
> appreciated you made it clearer instead of letting me to dry without any 
> feedback, especially when I re-re-re-pinged you last week and before.

Stop overstating your position.  You never 're-re-re-pinged' - you sent
_one_ reminder only, which I did think about responding to, but in the
end I decided I didn't need any more flames from you at that time
(because I wouldn't be around to respond).
