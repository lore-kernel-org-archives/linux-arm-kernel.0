From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 24 Sep 2018 13:46:29 +0100
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <20180924141203.3df9707a@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
 <20180924111341.GP30658@n2100.armlinux.org.uk>
 <20180924141203.3df9707a@windsurf>
Message-ID: <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 02:12:03PM +0200, Thomas Petazzoni wrote:

[...]

> > Trying to address a regression with further development means that
> > _that_ development needs thought and review, which is a slower
> > process.
> > 
> > I do understand the desire to keep moving forward and never take a
> > step backwards, but sometimes backwards steps are the best way to
> > resolve a regression.  But I also do appreciate that a simple revert
> > in this case is not possible.
> 
> Well, I can revert:
> 
> 42342073e38b50113354944cd51dcfed28d857a1 PCI: mvebu: Convert to use
> pci_host_bridge directly ee1604381a371b3ea6aec7d5e43b6e3f5e153854 PCI:
> mvebu: Only remap I/O space if configured
> 
> so it's not a big deal either. I can revert those, and then resubmit a
> more complete series later on that moves pci-mvebu to use
> pci_remap_iospace().
> 
> > I'll accept your patch on the condition that the ARM private
> > pci_ioremap_io() will go away in the very near future (please _try_
> > to get agreement on that before this patch is merged.)
> 
> Bjorn, Lorenzo, what do you prefer ? 
> 
> If we want to get rid of pci_ioremap_io(), then we need a way to tell
> pci_remap_iospace() the memory attributes that should be used for the
> mapping, because on Armada 38x, we need to map the I/O space mapped
> MT_UNCACHED instead of MT_DEVICE. I'm not sure how to achieve this yet.
> Should pgprot_device() be changed to return MT_UNCACHED on a
> platform-specific basis ? Any other idea ?

I think we should address Russell's concern, he has more insights into
code that predates the PCI host developments.

What I think you can do short term, given that AFAICS MVEBU is not
removable, instead of using pci_host_probe() you move part of its code
into the driver and make sure that you remap IO as last operation before
probe completion (ie after scanning the host bridge) so that you do not
need to unmap it on failure; write a commit log summarising/linking this
thread please and when v4.20 lands we will give this a more thorough
look as Russell requested.

How does that sound ?

Thanks,
Lorenzo
