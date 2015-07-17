From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 17 Jul 2015 14:20:55 +0100
Subject: [Xen-devel] [PATCH v2 09/20] xen/biomerge: Don't allow biovec
 to be merge when Linux is not using 4KB page
In-Reply-To: <55A7D8AD.1090102@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-10-git-send-email-julien.grall@citrix.com>
 <20150710191245.GA31063@l.oracle.com>
 <alpine.DEB.2.02.1507161627010.17378@kaball.uk.xensource.com>
 <55A7D8AD.1090102@citrix.com>
Message-ID: <alpine.DEB.2.02.1507171418260.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015, Julien Grall wrote:
> Hi Stefano,
> 
> On 16/07/2015 16:33, Stefano Stabellini wrote:
> > On Fri, 10 Jul 2015, Konrad Rzeszutek Wilk wrote:
> > > On Thu, Jul 09, 2015 at 09:42:21PM +0100, Julien Grall wrote:
> > > > When Linux is using 64K page granularity, every page will be slipt in
> > > > multiple non-contiguous 4K MFN (page granularity of Xen).
> > > 
> > > But you don't care about that on the Linux layer I think?
> > > 
> > > As in, is there an SWIOTLB that does PFN to MFN and vice-versa
> > > translation?
> > > 
> > > I thought that ARM guests are not exposed to the MFN<->PFN logic
> > > and trying to figure that out to not screw up the DMA engine
> > > on a PCIe device slurping up contingous MFNs which don't map
> > > to contingous PFNs?
> > 
> > Dom0 is mapped 1:1, so pfn == mfn normally, however grant maps
> > unavoidably screw up the 1:1, so the swiotlb jumps in to save the day
> > when a foreign granted page is involved in a dma operation.
> > 
> > Regarding xen_biovec_phys_mergeable, we could check that all the pfn ==
> > mfn and return true in that case.
> 
> I mentioned it in the commit message. Although, we would have to loop on every
> pfn which is slow on 64KB (16 times for every page). Given the biovec is
> called often, I don't think we can do a such things.

We would have to run some benchmarks, but I think it would still be a
win. We should write an ad-hoc __pfn_to_mfn translation function that
operates on a range of pfns and simply checks whether an entry is
present in that range. It should be just as fast as __pfn_to_mfn. I
would definitely recommend it.
