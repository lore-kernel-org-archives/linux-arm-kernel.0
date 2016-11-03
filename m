From: adouglas@cadence.com (Alan Douglas)
Date: Thu, 3 Nov 2016 14:24:15 +0000
Subject: Use of GICv3/ITS with PCIe host-generic driver - resizing ITS
 MAPD?
In-Reply-To: <8637j9iomo.fsf@arm.com>
References: <CY1PR07MB2506C5C771B446139A743B99D8A10@CY1PR07MB2506.namprd07.prod.outlook.com>
 <861syvkqcr.fsf@arm.com>
 <CY1PR07MB2506C9B4133B1CE185AD0260D8A00@CY1PR07MB2506.namprd07.prod.outlook.com>
 <8637j9iomo.fsf@arm.com>
Message-ID: <CY1PR07MB250619340531C246B8A87767D8A30@CY1PR07MB2506.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,
> >> > When setting up bus 0, the ITS device is created, and
> >> > its_build_map_cmd() sets the size of the ITS MAPD based on the
> >> > number of interrupts claimed by bus 0.  When subsequent buses are
> >> > enumerated, the ITS device will be reused, however we do not
> >> > increase the number of supported interrupts to allow for the
> >> > additional interrupts claimed by the additional devices being
> >> > enumerated.  (This can be seen in its_msi_prepare(), which is
> >> > called for each device which has MSI/MSI-X enabled, and will reuse
> >> > an existing ITS. )
> >>
> >> Am I right in understanding that all the PCIe devices in your system
> >> end-up aliasing to the same RequesterID? If so, that's a major issue.
> >> The ITS is designed so that each device exposes its *own* RID, and
> >> have its own Interrupt Translation Table (ITT).
> >>
> >> In your case, you seem to first discover the root port, which is not
> >> upstream of anything, so it doesn't alias with anything at that
> >> point. We allocate the corresponding ITT, and it's all fine. Until we
> >> start probing the rest, and ugly things happen.
> >>
> > Yes, your understanding is correct.  I will dig into this a bit
> > further to see what is wrong then send an update.  I suspect my DTS
> > msi mapping.
> 
> Right. That would explain a lot of what you're seeing. In general, and unless
> you have some funky remapping going on, you're better off having a very
> straightforward msi-map property in your RC node (such as example
> #1 in Documentation/devicetree/bindings/pci/pci-msi.txt).
The problem was that I had an msi-map-mask specified such that all
requester IDs were seen as zero.  Now fixed that and checked that the
requester ID for each device is being correctly provided by HW to the GIC, 
and all is now working correctly with without any patches required.
Thanks for your help.

Alan
