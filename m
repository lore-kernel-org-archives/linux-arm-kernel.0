From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 9 Aug 2014 11:57:56 -0400
Subject: [PATCH 2/6] ARM: mvebu: Add proper pin muxing on Globalscale
 Mirabox board
In-Reply-To: <20140809172149.59f54746@free-electrons.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140808171208.GC26751@lunn.ch>
 <20140808182156.GA16889@arch.cereza>
 <20140808192106.GD26751@lunn.ch>
 <20140809172149.59f54746@free-electrons.com>
Message-ID: <20140809155756.GB5427@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Sat, Aug 09, 2014 at 05:21:49PM +0200, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Fri, 8 Aug 2014 21:21:06 +0200, Andrew Lunn wrote:
> 
> > At least at the moment, it seems like RGMII is the norm, and SGMII is
> > the exception. So having the default as RGMII probably makes
> > sense. Boards which don't require it can then override this in there
> > .dts file. If we see this changes with time, we can swap it around.
> 
> I personally disagree with this approach. armada-370.dtsi is here to
> describe what happens at the *SoC* level, not to factorize some random
> board specific details that appear to be common between a certain
> number of boards (but not all).

It's my understanding that *possible* pinmux configurations are a
characteristic of the SoC.  Which configurations are used is an artifact
of the board.

I don't see the need to list all possible configurations in the SoC dtsi
file, but just the ones we have actually seen used.

> So I really, really, would prefer to keep the board-specific details
> such as which pin muxing is done for Ethernet in each individual .dts
> file.

So, wouldn't this be the phandle selection?

> .dtsi to describe the SoC, .dts to describe the board. It's clear and
> simple for everyone to understand, especially for new comers.

If you're strongly opposed to describing possible pinmux configurations
in the SoC dtsi file, how about an SoC-pinmux.dtsi?  I just see the
"Thar be dragons ahead" sign by describing pinmux in the board files.

Developers adding support for a new board will typically (for better or
for worse) start with a dts that's close (eg guruplug for dreamplug),
and edit it to fit their needs.  During the debugging process, if the
pinmux is described in the dts file, they might be more prone to tweak
it into a non-possible configuration for that SoC.  This is a lot less
likely if the possible pinmux configs are described in a dtsi file.  The
developer would be more likely to try different pinmux phandles in that
case.

fwiw, the possible pinmux configs are usually (always?) described in SoC
datasheets, so I think it logically belongs to the SoC dtsi.

thx,

Jason.
