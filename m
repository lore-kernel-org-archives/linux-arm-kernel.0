From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 28 Apr 2016 14:02:28 +0100
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
In-Reply-To: <20160428141336.60aa4be1@free-electrons.com>
References: <20160427225827.GC17629@localhost>
 <20160428120624.GV28464@e106497-lin.cambridge.arm.com>
 <20160428141336.60aa4be1@free-electrons.com>
Message-ID: <20160428130228.GW28464@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 02:13:36PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 28 Apr 2016 13:06:24 +0100, Liviu Dudau wrote:
> 
> > I am OK with the suggestion that Thomas has to add a parameter to
> > pci_remap_iospace() to pass on the pgprot_t value one wants and get rid of
> > pci_remap_io(), but I would suggest first to him to convert the ARMADA XP
> > platform to generic PCI code and see if it doesn't work OK by default. We
> > (well, Lorenzo driven nowadays) are pushing in that direction for a while now.
> 
> Armada XP itself is not affected by the HW issue that requires use to
> use strongly-ordered mappings, it's only the Cortex-A9 based SoC, i.e
> Armada 375, 38x and 39x.

Sorry, I blame my unfamiliarity with the Armada family of devices when I
said Armada XP (I know the name better than any other).

> 
> That being said, could you point to me to which bits of the generic PCI
> code I should convert our PCI support to? I'd be happy to take a look.

Hmm, looking at the DT bindings there seem to be a lot of custom stuff in there.
I would start with trying to see if you can replace the custom parsing of
ranges with the generic of_pci_range_to_resource() and then look at the
pcie-designware.c how they got rid of the pci_common_init_dev() and the
need to use hw_pci structure. You want to end up with calling
of_pci_get_host_bridge_resources() to get back your list of MEM and IO
resources (it parses the bus ranges as well) and then use those to map IO
space and start the root bus scanning.

Best regards,
Liviu

> 
> Thanks!
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
