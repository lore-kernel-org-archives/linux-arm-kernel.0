From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Sep 2018 11:12:13 +0100
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <20180913104241.65db8243@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
Message-ID: <20180924101213.GO30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 10:42:41AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 13 Sep 2018 10:20:45 +0200, Jan Kundr?t wrote:
> > On ?tvrtek 13. z??? 2018 9:45:15 CEST, Thomas Petazzoni wrote:
> > > What about something like the below. I tested it, including the error
> > > case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
> > > after pci_unmap_iospace(). Actually, I would prefer to use
> > > pci_remap_iospace() and pci_unmap_iospace() but for now this API
> > > doesn't allow overloading the memory type used for the mapping.  
> > 
> > Thanks for providing this fix so quickly, Thomas. I can confirm that this 
> > patch -- tested on top of 54eda9df17f3215b9ed16629ee71ea07413efdaf ("Merge 
> > tag 'pci-v4.19-fixes-1' of 
> > git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci"). Disclaimer: I 
> > have zero familiarity with Linux' PCI code.
> > 
> > Tested-by: Jan Kundr?t <jan.kundrat@cesnet.cz>
> 
> Thanks for the testing. I'll wait for Russell to say if he is happy
> (or not) with the addition of pci_unmap_io() in the ARM code, if that's
> the case, I'll send a proper patch to fix the issue.

I'd prefer not to provide an unmapping API, because it gives the
impression that it's okay to unmap the IO space mapping, and we'll
end up with drivers that decide to call it in their cleanup path.
IO space isn't expected to ever go away - eg, on a PC, it's always
present.

I've been toying with the idea of making pci_map_io() ignore
subsequent attempts to overwrite the mapping with an identical
mapping, and WARN() if there is an attempt to overwrite an existing
mapping with other physical address, but I'm not entirely happy
with that either (which is why I haven't responded sooner.)

At the moment, I don't have a way forward that I'm happy with for
this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
