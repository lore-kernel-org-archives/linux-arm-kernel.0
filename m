From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 10 Jan 2014 14:06:34 -0700
Subject: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
In-Reply-To: <20140110194550.GT19878@titan.lakedaemon.net>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140110182240.GK19878@titan.lakedaemon.net>
 <20140110190521.GI18269@obsidianresearch.com>
 <20140110194550.GT19878@titan.lakedaemon.net>
Message-ID: <20140110210634.GL18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 02:45:50PM -0500, Jason Cooper wrote:

> > IMHO the compatible string should represent a specific HW/SW ABI. So
> > you need a unique compatible string for every variation of that ABI.
> 
> My concern is that we tend to do things like "marvell,orion-sata" for
> the first version of the IP block we can work with.  orion5x, kirkwood,
> dove, and armada 370/xp all use that compatible string to refer to that
> IP block.

Right, absent guidance from the originators of the IP block that is
sort of all we are left with. But something like 'marvell,orion-sata'
is just a label to describe the ABI implemented by the HW on that
particular chip.

> Given that we look at it as 'and newer', '...-a0-i2c' would mean no
> offloading until we introduce '-b0-i2c'.  Or am I mis-understanding what
> you're saying?

I would stop thinking of this in terms of 'is newer' / 'is older'.

marvell,orion-sata means any HW that implements the same ABI as the
orion chip. 

When we get a different chip that has a compatible, but extended ABI
we introduce a new label:

 compatible = "marvell,foobar-sata", "marvell,orion-sata";

And if we get one that has a very similar, but incompatible ABI, we
still introduce a new label:

 compatible = "marvell,foobar2-sata";

And everything works properly.

> > We already have a compatible string defined for the ABI that B0
> > presents.
> 
> So 'mv78230-i2c' is newer than 'mv78230-a0-i2c', or are you referring to
> something else?

'mv78230-i2c' is the name that was picked to describe the ABI that
works as-documented in the manual
'mv78230-a0-i2c' is the name that was picked to describe the ABI that
works as-implemented in the A0 chip :)

There is no newer/older, they are just two different ABIs.

I guess it turns out that 'mv78230-a0-i2c' is a strict compatible
subset of 'mv78230-i2c' - but that doesn't really make a difference.

The 'mv78230-i2c' driver is guarenteed avaialble in all places where
the 'mv78230-a0-i2c' driver would be available.

Jason
