From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 21 Nov 2012 13:56:52 -0500
Subject: [PATCH] ARM: Kirkwood: Support basic hotplug for PCI-E
In-Reply-To: <20121121184754.GB12822@obsidianresearch.com>
References: <20121121182528.GA12715@obsidianresearch.com>
 <20121121183527.GC15800@titan.lakedaemon.net>
 <20121121184754.GB12822@obsidianresearch.com>
Message-ID: <20121121185652.GD15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 11:47:54AM -0700, Jason Gunthorpe wrote:
> On Wed, Nov 21, 2012 at 01:35:27PM -0500, Jason Cooper wrote:
> > On Wed, Nov 21, 2012 at 11:25:28AM -0700, Jason Gunthorpe wrote:
> > > Unconditionally register the PCI-E bus, even if the link is currently
> > > down. 
> > 
> > How does this affect clock gating on boards without PCI-E devices?  Will
> > the SoC then power this unconditionally?
> 
> Hmm, interesting question.. This will definitely hold the clock lock
> on the PCI-E ports even if they are down at boot, and they will surely
> consume more power than if they were switched off.
> 
> However, if a board has no possible PCI-E devices, then it shouldn't
> be calling kirkwood_pcie_init, which will let things gate.

Ok, that's the good short-term answer.

> I guess another way to deal with this is to make the stuff in
> kirkwood/pcie.c an actual platform driver and hot attach the entire
> driver rather than using just using pci/rescan, but that is a fairly
> extensive change.. And I worry that powering down the interface in the
> interm will require re-initializing all the registers, which linux
> doesn't have the code to do at all.

The goal is to remove everything from mach-kirkwood/, mach-dove/, etc.
which means pcie will eventually become a real driver under drivers/.
We just aren't there yet.

I'll pull this in as is.  Thanks for the patch!

thx,

Jason.
