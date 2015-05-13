From: tj@kernel.org (Tejun Heo)
Date: Wed, 13 May 2015 13:46:40 -0400
Subject: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
In-Reply-To: <20150513172828.GA8449@rric.localhost>
References: <20150513143353.GU11388@htj.duckdns.org>
 <20150513143906.GV11388@htj.duckdns.org>
 <20150513172828.GA8449@rric.localhost>
Message-ID: <20150513174640.GZ11388@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Robert.

On Wed, May 13, 2015 at 07:28:28PM +0200, Robert Richter wrote:
> > > This looks not very useful to do. Since irq is used only a single
> > > time, there is no reason to store it in the host's data structure. It
> > 
> > Doesn't really matter tho.
> 
> Since ahci_host_activate() is EXPORT_SYMBOL_GPL I really have concerns
> changing the i/f. But I will send you a patch for this.

It doesn't matter.  Please go ahead and change it.

> > Let's start with why we're doing this in the first place.
> 
> Right, the sata controller is connected to a pci ecam controller, both
> are on an SoC together with the processor. There are no external pci
> ports for the connection of external devices. Since all pci devices on
> the chip support msi-x, the controller is only capable to handle this
> and not INTx nor MSI. So for enabling of the sata hc we need msix
> support.

I see.  If you can get hold of an ahci controller which actually can
do multi-irq msix, it'd be the best.  If not, let's make it super
clear that this is a special case and use it as the last resort (which
also clers up the warning issue).

Thanks.

-- 
tejun
