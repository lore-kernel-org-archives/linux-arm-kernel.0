From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jun 2012 20:19:07 +0000
Subject: Device Tree, abstraction of the SoC or the board?
In-Reply-To: <20120615201359.4ce9df82@skate>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <20120615100734.GJ26034@lunn.ch> <20120615201359.4ce9df82@skate>
Message-ID: <201206152019.08630.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 June 2012, Thomas Petazzoni wrote:
> Le Fri, 15 Jun 2012 12:07:34 +0200,
> Andrew Lunn <andrew@lunn.ch> a ?crit :
> 
> > So, it looks like the Marvell ASIC engineers moved it for the latest
> > SoCs. Could you add a child property of marvell,system-controller
> > which indicates where within the system controller the reset
> > subcontroller is? Since the two registers are always next to each
> > other, we just need one address.
> 
> I must say I'm a bit confused in my understanding of what category of
> information should be encoded in the Device Tree.
> 
> Do we want to encode all the register offsets, bit locations and so on
> in the Device Tree? I.e, is the Device Tree suppose to allow porting to
> a new SoC without any code modification? Or only to a new board with no
> code modification?

This is usually left up to the platform maintainer.

> For example http://article.gmane.org/gmane.linux.linaro.devel/10554
> seems to suggest that the Device Tree will only be used to encode
> board-level informations, but not SoC level informations. In that
> specific e-mail, the case of the internal SoC clocks are mentioned, and
> the OMAP maintainers seem to agree that all the internal SoC clocks
> should be listed in C code rather than inside the Device Tree.
> 
> On the other hand, the current suggestion of encoding register offsets
> inside the Device Tree seems to indicate that we want to encode
> SoC-level details inside the Device Tree, which to me (but I might have
> gotten everything wrong) contradicts the statement of the OMAP
> maintainers mentioned previously.
> 
> I'm kind of puzzled by where's the limit between what should be encoded
> in the Device Tree and what should remain C code, and I have the
> feeling (hopefully incorrect one) that the different sub-architectures
> maintainers do not have the same vision on this.
> 
> Could anyone show me the direction of the light? :-)

We definitely want to encode all or almost all of the differences between
boards in the device tree.

For anything that is part of the soc itself, it depends a lot on
how many different parts there are and how similar they are. The goal
should be to minimize the total amount of code that is necessary

In case of Tegra, we only have very few SoCs (tegra20, tegra30 so
far, a few more in the future), so it's usually easier to have large
parts of the differences hardcoded and just detected by the
"compatible" property. In case of at91, we have dozes of different
SoCs that are all quite similar, so it makes more sense to have a
rather generic abstraction in the source and put a lot of the
data into the device tree.

mvebu is somewhere in the middle between those, so either way makes
sense. In most cases, I would not want to go as far as describing
individual bits in the device tree, but I think it's reasonable to
fully abstract for instance the mvebu interrupt controller because
the only difference is the number and location of the 32-bit
blocks.

For the reset logic I believe we have three variants, so I would
suggest using different "compatible" values to tell these apart.

	Arnd
