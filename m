From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 17 Nov 2010 10:15:01 -0500 (EST)
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
In-Reply-To: <20101117083842.GA32476@n2100.arm.linux.org.uk>
References: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
	<1289940829.3860.22.camel@localhost.localdomain>
	<AANLkTimvyo-2eHrvU=LNdBjrJfAxv9Jpza8Mh4iG4ts6@mail.gmail.com>
	<20101116223116.GG21926@n2100.arm.linux.org.uk>
	<AANLkTi=pa+oa3GXr5vfBtdrfnHpRc_2cwgBYQLJRvYXM@mail.gmail.com>
	<20101117083842.GA32476@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1011171004170.6448@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Nov 2010, Russell King - ARM Linux wrote:

> On Wed, Nov 17, 2010 at 09:34:56AM +0100, Linus Walleij wrote:
> > And the Tegra code in mach-tegra/timer.c:
> > 
> > static cycle_t tegra_clocksource_read(struct clocksource *cs)
> > {
> >         return cnt32_to_63(timer_readl(TIMERUS_CNTR_1US));
> > }
> > 
> > This just won't fly for long either, the mult for the clocksource is
> > usually something in the order of 20.
> 
> I thought John/Thomas said that using cnt32_to_63 in there wasn't a good
> idea - sounds like it needs to be killed.  Colin?

Exact.  The cnt32_to_63() should not be used for clock source as this is 
lying to the clock source core where there is already all the code 
needed to deal with limited hardware timer ranges with all the required 
accuracy.

Furthermore, the above usage of cnt32_to_63() is buggy.  It is 
explicitly mentioned in the cnt32_to_63() documentation that the top bit 
(the 64th one) is undefined and must be cleared by the caller as it 
_does_ contain a random value to the caller.  This is not done by 
cnt32_to_63() directly because its returned value often has to be 
multiplied by a scaling factor and therefore the 64th bit masking can be 
done implicitly by that multiplication, saving on a runtime instruction 
(remember this was designed for sched_clock() usage and the goal there 
is to be fast).


Nicolas
