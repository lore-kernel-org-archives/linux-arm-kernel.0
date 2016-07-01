From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Fri, 1 Jul 2016 18:53:09 +0000
Subject: [RFC 1/2] iommu/dma: Restrict IOVAs to physical memory layout
In-Reply-To: <5776AAD8.5030704@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
 <ac9b11493dfa3500889268488adfa8d4d5c34962.1467129314.git.robin.murphy@arm.com>
 <CALRxmdCuxLPogPTwpn2-B=PU=Ry0eNtgs2z+iZBPYtDc3NX-hQ@mail.gmail.com>
 <HE1PR04MB1641583BE6AFF39AF1BFCEFB8D250@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <57769724.4040801@arm.com> <5776AAD8.5030704@arm.com>
Message-ID: <HE1PR04MB16411F31EECC3023241496468D250@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Friday, July 01, 2016 12:40 PM
> To: Stuart Yoder <stuart.yoder@nxp.com>
> Cc: iommu at lists.linux-foundation.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC 1/2] iommu/dma: Restrict IOVAs to physical memory layout
> 
> On 01/07/16 17:15, Robin Murphy wrote:
> > On 01/07/16 17:03, Stuart Yoder wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Robin Murphy <robin.murphy@arm.com>
> >>> Date: Tue, Jun 28, 2016 at 11:18 AM
> >>> Subject: [RFC 1/2] iommu/dma: Restrict IOVAs to physical memory layout
> >>> To: iommu at lists.linux-foundation.org, linux-arm-kernel at lists.infradead.org
> >>>
> >>>
> >>> Certain peripherals may be bestowed with knowledge of the physical
> >>> memory map of the system in which they live, and refuse to handle
> >>> addresses that they do not think are memory, which causes issues when
> >>> remapping to arbitrary IOVAs. Sidestep the issue by restricting IOVA
> >>> domains to only allocate addresses within ranges which match the
> >>> physical memory layout.
> >>>
> >>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>> ---
> >>>
> >>> Posting this as an RFC because it's something I've been having to use
> >>> on Juno for all the PCI IOMMU development - it's pretty horrible, but I
> >>> can't easily think of a nicer solution...
> >>
> >> Maybe I'm not getting the implications of this looking at the patch
> >> in isolation, but how will this impact systems that have devices
> >> limited to 32-bit addressing?
> >>
> >> In our memory map we have physical memory regions at:
> >> 0x00_8000_0000
> >> 0x80_8000_0000
> >>
> >> Will devices with a 32-bit DMA mask still get 32-bit IOVAs?
> >
> > Assuming there's some free IOVA space between 0x80000000 and 0xffffffff,
> > yes, otherwise it gets nothing ;) This has no effect on the allocation
> > behaviour in general, it just makes sure that within that behaviour, we
> > avoid allocating any address that doesn't look "real". The primary issue
> > is with 64-bit DMA masks - since it's a top-down allocator, you
> > typically end up with the poor device issuing its first DMA transaction
> > to 0xfffffffffffff000 which on Juno a) gets silently eaten by the root
> > complex because it doesn't match any window in the PCI-AXI translation
> > table, or b) goes wrong anyway because it's beyond the input address
> > range of the SMMU (and there's something not quite right WRT
> > truncation/sign-extension which I've not looked into closely and am
> > semi-deliberately also sweeping under the rug thanks to the simpler
> > hardware issue...)
> >
> > As I say, it's hideous, but I can't see what else to do.
> 
> Urgh, thinking some more, this is OK on Juno and LS2085 only because
> there *is* some RAM below 4GB to begin with. On something like Seattle
> where it's all high up, 32-bit peripherals will be as screwed as if the
> IOMMU wasn't there :(

Can the "Restrict IOVAs to physical memory layout" be a quirk type
property on the SMMU node for hardware that has this issue?

Then it is conditional and seems to only be needed by the Juno
platform, for now.

Stuart
