From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 Feb 2016 10:25:50 +0100
Subject: [PATCH 2/3] clk: mvebu: add AP806 core clock driver
In-Reply-To: <CAL_Jsq+iiUBcTdnqzFWLJ+5jPvq0rmWgBboab4xyj1dQyDQE+Q@mail.gmail.com>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455521698-7905-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222025357.GE15973@rob-hp-laptop>
 <20160222091423.4756a579@free-electrons.com>
 <20160222141617.GA14970@lunn.ch>
 <20160222183203.2278.60153@quark.deferred.io>
 <CAL_Jsq+iiUBcTdnqzFWLJ+5jPvq0rmWgBboab4xyj1dQyDQE+Q@mail.gmail.com>
Message-ID: <20160223102550.2e0cba04@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 22 Feb 2016 13:42:49 -0600, Rob Herring wrote:

> >> Maybe add a big fat warning that the bindings are unstable, and the DT
> >> blob must be kept in sync with the kernel?
> >
> > +1 and feel free to blame the lack of documentation.  No one can expect
> > bindings to be finalized when the chip topology is not fully understood.
> 
> I can understand not understanding the full clock tree. I have "full"
> documentation of a Marvell chip and don't understand the clock tree
> fully. But I can't believe you don't have some sense of how many
> clocks you have to deal with. 10? 100? 1000? What I see is 2 nodes of
> a single register each for clocks at roughly the same address. That
> tells me your binding is too fine grained. If you really don't know
> what is right, then err on the side of a single clock provider node
> and don't put the clock details in DT.

I don't quite understand the reasoning behind this conclusion. We know
for sure that those two registers control only those core and ring
clocks. Maybe there are other registers controlling other clocks,  that
we don't know. But for sure, those two registers only give details
about those core and ring clocks, so I don't see what would be the
usefulness of merging that into a single DT node.

We would lose the fact that the relationship between the ring clocks
and one of the core clock is represented in the DT. Instead of having a
clear <&coreclk X> or <&ringclk Y> reference, we would have a
mysterious <&allclk XYZ> reference, which doesn't tell immediately
whether it's a core clock or ring clock.

So, while I definitely agree that a syscon is probably in order to
cover all the system registers, I don't see the point of having a
single node to cover all the clocks.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
