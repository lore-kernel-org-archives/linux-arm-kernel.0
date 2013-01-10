From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 10 Jan 2013 07:55:37 +0100
Subject: [PATCH 00/14] Rewrite Tegra PCIe driver
In-Reply-To: <20130109222517.3c590553@skate>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130109222517.3c590553@skate>
Message-ID: <20130110065537.GC15212@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 10:25:17PM +0100, Thomas Petazzoni wrote:
> Dear Thierry Reding,
> 
> On Wed,  9 Jan 2013 21:43:00 +0100, Thierry Reding wrote:
> > This patch series contains an almost complete rewrite of the Tegra PCIe
> > driver. The code is moved to the drivers/pci/host directory and turned
> > into a proper platform driver, adding MSI and DT support while at it.
> > Other PCI host controller drivers can be added to that directory in an
> > attempt to make it easier to factor out common code.
> 
> Thanks!
> 
> I have started basing the Marvell PCIe code on some of your earlier
> versions. But apparently in this final version, you no longer have the
> emulated Host bridge. Why so?

The reason is that with the latest bindings the matching of root ports
to device tree nodes works as-is and nothing else indicates that the
emulated host bridge is actually required to make any of this work. So
in order not to introduce unneeded code I've left it out for now. If
somebody decides that we actually need this host bridge (for standards
compliance or whatnot) it could easily be added back.

However, before the emulated bridge implementation can be merged I think
the PCI ID issue needs to be resolved.

> For the Marvell PCIe code, I've used your emulated Host bridge, and
> added an emulated PCI-to-PCI bridge implementation, in order to get the
> following hierarchy:
> 
>  + Host Bridge
>    + PCI-to-PCI bridge
>      + PCI Device
>    + PCI-to-PCI bridge
>      + PCI device
> 
> So, I instantiate one unique emulated Host Bridge, and then one
> emulated PCI-to-PCI Bridge for each PCIe interface that I have.

Oh dear, that's even worse than on Tegra. The Marvell hardware doesn't
even expose the root ports as PCI devices on the bus?

> The nice thing about that is that I can then read the configuration
> space of the PCI-to-PCI bridge to find out how much I/O space and
> memory space is needed for the device connected to this interface, and
> at which address is has been mapped. This greatly helps my "address
> decoding" problem, and removes the ad-hoc virtual space allocator I had
> written.
> 
> Is there a reason for having given up on this idea? Is there still a
> hope for a different PCIe implementation to use this idea?

I suppose that in your case it really makes sense because you already
need the emulated PCI-to-PCI bridges and therefore adding an emulated
host bridge doesn't add much. As I said, for Tegra everything still
works without, so I didn't see a reason to add needless code.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/1bc70310/attachment.sig>
