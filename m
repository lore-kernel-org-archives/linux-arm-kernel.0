From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 13 Nov 2013 11:35:44 +0000
Subject: [Xen-devel] [PATCH 2/2] swiotlb-xen: xen_swiotlb_map_page: do
 not error out if dma_capable fails
In-Reply-To: <52828E17.2040801@gmail.com>
References: <alpine.DEB.2.02.1311121404590.26077@kaball.uk.xensource.com>
 <1384265520-6833-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <20131112144832.GC9435@phenom.dumpdata.com>
 <alpine.DEB.2.02.1311121704590.26077@kaball.uk.xensource.com>
 <52828E17.2040801@gmail.com>
Message-ID: <alpine.DEB.2.02.1311131135340.4714@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Nov 2013, Rob Herring wrote:
> On 11/12/2013 11:27 AM, Stefano Stabellini wrote:
> > Russell gave a great explanation of the issue so I am just going to
> > limit myself to answering to:
> > 
> > On Tue, 12 Nov 2013, Konrad Rzeszutek Wilk wrote:
> >>> Considering that we know that the swiotlb buffer has a low address,
> >>> skip the check.
> >>
> >> I am not following that sentence. Could you please explain to me
> >> how the SWIOTLB buffer low address guarantees that we don't need
> >> the check?
> > 
> > xen_swiotlb_fixup makes sure that the swiotlb buffer is lower than 4GB,
> > probably lower than 3GB, by passing dma_bits to
> > xen_create_contiguous_region.
> > This meets the requirements of most devices out there.
> > In fact we are not even running this check under the same conditions in
> > swiotlb_map_sg_attrs.
> > I admit that it is possible to come up with a scenario where the check
> > would be useful, but it is far easier to come up with scenarios where
> > not only is unneeded but it is even harmful.
> > 
> > Alternatively (without Rob's "of: set dma_mask to point to
> > coherent_dma_mask") Linux 3.13 is going to fail to get the network
> > running on Midway. It is going to avoid fs mounting failures just
> > because we don't do the same check in swiotlb_map_sg_attrs.
> > 
> > FYI given that Rob's patch is probably going upstream soon anyway, I
> > don't feel so strongly about this.
> 
> It is in Linus' tree now.
 
OK,  I'll drop this patch then.
