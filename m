From: jroedel@suse.de (jroedel at suse.de)
Date: Mon, 27 Oct 2014 17:33:57 +0100
Subject: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20141027160216.GY8768@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <4572757.M4IDlCz5Vc@avalon> <20141027105158.GE8768@arm.com>
 <14012645.olm9XxYoII@avalon> <20141027160216.GY8768@arm.com>
Message-ID: <20141027163357.GF9734@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:02:16PM +0000, Will Deacon wrote:
> On Mon, Oct 27, 2014 at 11:30:33AM +0000, Laurent Pinchart wrote:
> > I'm not sure to follow you here. Aren't we already exposing masters that 
> > master through multiple IOMMUs as single instances of struct device ?
> 
> Hmm, yes, now you've confused me too! The conclusion was certainly that
> dma-mapping should not be the one dealing with the I/O topology. Domain
> allocation would then be an iommu callback (something like
> ->get_default_domain), but the rest of the details weren't fleshed out.

The idea is that the IOMMU core code will allocate a default domain for
each iommu-group at initialization time. This domain can be requested
later by a new iommu-api function and used for DMA-API mappings.

A device still can be assigned to another domain by driver code (like
VFIO). But if the device is later de-assigned the IOMMU core-code
automatically puts it back into the default domain.


	Joerg
