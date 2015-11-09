From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 09:59:04 +0100
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <564046B3.8090505@suse.de>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <1447034266-28003-2-git-send-email-okaya@codeaurora.org>
 <564046B3.8090505@suse.de>
Message-ID: <4041362.9GKaSPm9gs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 08:09:39 Hannes Reinecke wrote:
> On 11/09/2015 02:57 AM, Sinan Kaya wrote:
> > Current code gives up when 32 bit DMA is not supported.
> > This problem has been observed on systems without any
> > memory below 4 gig.
> > 
> > This patch tests 64 bit support before bailing out to find
> > a working combination.
> > 
> That feels decidedly odd.
> 
> Why do you probe for 64bit if 32bit fails?

32-bit DMA mask on PCI cannot fail, we rely on that in all sorts
of places. If the machine has all of its RAM visible above 4GB
PCI bus addresses, it must use an IOMMU.

> Typically it's the other way round, on the grounds that 64bit DMA
> should be preferred over 32bit.
> Can you explain why it needs to be done the other way round here?

Something else is odd here, the driver already checks for
dma_get_required_mask(), which will return the smallest mask
that fits all of RAM. If the machine has any memory above 4GB,
it already uses the 64-bit mask, and only falls back to
the 32-bit mask if that fails or if all memory fits within the
first 4GB.

So both the description and the patch are wrong. :(

	Arnd
