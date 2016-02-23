From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 Feb 2016 16:56:03 +0100
Subject: [PATCH 2/3] clk: mvebu: add AP806 core clock driver
In-Reply-To: <20160223102550.2e0cba04@free-electrons.com>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455521698-7905-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222025357.GE15973@rob-hp-laptop>
 <20160222091423.4756a579@free-electrons.com>
 <20160222141617.GA14970@lunn.ch>
 <20160222183203.2278.60153@quark.deferred.io>
 <CAL_Jsq+iiUBcTdnqzFWLJ+5jPvq0rmWgBboab4xyj1dQyDQE+Q@mail.gmail.com>
 <20160223102550.2e0cba04@free-electrons.com>
Message-ID: <20160223165603.74576dca@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob, Michael, Stephen,

On Tue, 23 Feb 2016 10:25:50 +0100, Thomas Petazzoni wrote:

> > >> Maybe add a big fat warning that the bindings are unstable, and the DT
> > >> blob must be kept in sync with the kernel?
> > >
> > > +1 and feel free to blame the lack of documentation.  No one can expect
> > > bindings to be finalized when the chip topology is not fully understood.
> > 
> > I can understand not understanding the full clock tree. I have "full"
> > documentation of a Marvell chip and don't understand the clock tree
> > fully. But I can't believe you don't have some sense of how many
> > clocks you have to deal with. 10? 100? 1000? What I see is 2 nodes of
> > a single register each for clocks at roughly the same address. That
> > tells me your binding is too fine grained. If you really don't know
> > what is right, then err on the side of a single clock provider node
> > and don't put the clock details in DT.
> 
> I don't quite understand the reasoning behind this conclusion. We know
> for sure that those two registers control only those core and ring
> clocks. Maybe there are other registers controlling other clocks,  that
> we don't know. But for sure, those two registers only give details
> about those core and ring clocks, so I don't see what would be the
> usefulness of merging that into a single DT node.
> 
> We would lose the fact that the relationship between the ring clocks
> and one of the core clock is represented in the DT. Instead of having a
> clear <&coreclk X> or <&ringclk Y> reference, we would have a
> mysterious <&allclk XYZ> reference, which doesn't tell immediately
> whether it's a core clock or ring clock.
> 
> So, while I definitely agree that a syscon is probably in order to
> cover all the system registers, I don't see the point of having a
> single node to cover all the clocks.

So, I had a discussion with Marvell engineers and a closer look at the
matter. It turns out that those two clock registers are in the middle
of an area called DFX (Design for Testability), which contain registers
to fine tune the silicon and detect manufacturing issues. This area of
registers is most likely never going to be publicly documented, and the
fact that those two clock-related registers were placed there was more
an oversight than a real architecture choice.

For this reason, there is in fact no real benefit in mapping the entire
area using a syscon, and having the two DT nodes for the core clocks
and ring clocks, mapping just their own registers is by far the
simplest solution considering the register layout.

We would prefer to keep things as proposed in terms of DT
representation, with the understanding that the submission of the Linux
support for this platform comes very early in the chip development
cycle, and that as such, the DT bindings should be considered unstable.

Thanks a lot,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
