From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 24 Oct 2013 11:32:26 +0100
Subject: [PATCH v8 18/19] swiotlb-xen: no need to do execute two
 bus_to_phys translations in a row
In-Reply-To: <20131023195335.GC28963@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
 <1382031814-8782-18-git-send-email-stefano.stabellini@eu.citrix.com>
 <20131023140150.GB27771@phenom.dumpdata.com>
 <alpine.DEB.2.02.1310231833560.26077@kaball.uk.xensource.com>
 <20131023195335.GC28963@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1310241129230.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Oct 2013, Konrad Rzeszutek Wilk wrote:
> On Wed, Oct 23, 2013 at 06:34:13PM +0100, Stefano Stabellini wrote:
> > > On Thu, Oct 17, 2013 at 06:43:33PM +0100, Stefano Stabellini wrote:
> > > > xen_unmap_single calls xen_bus_to_phys, then passes dev_addr to
> > > > is_xen_swiotlb_buffer that calls xen_bus_to_phys again.
> > > 
> > > It does?
> > > 
> > > I see it call mfn_to_local_pfn which calls pfn_to_mfn and
> > > get_phys_to_machine (which I presume is going to be a slow
> > > operation on ARM).
> > 
> > Yeah, I am trying to reduce the number of pfn_to_mfn and mfn_to_pfn
> > translations.
> > That said, this patch is not needed to have a fully functional
> > swiotlb-xen on arm and I would OK with postponing it.
> 
> OK, lets do that as it requires some hard thinking.

OK.


> > > I am bit uncomfortable with this - I recall when developing this
> > > that I had hit some odd cases of doing DMA of a page to a guest
> > > and it not always working. It was the case of not detecting whether
> > > the pfn was foreign or not. Sadly I can't recall the details.
> > > 
> > > I would think that this problem would also be present with ARM?
> > > But perhaps all the new changes in the pfn_to_mfn that had lately
> > > been done have fixed this?
> > 
> > No, because on ARM the guest is autotranslate so the pfn returned by
> > mfn_to_pfn is always "local".
> > However thanks to the m2p_override now we should get the "local" pfn
> > from mfn_to_pfn on x86 too.
> > I'll test this case though.
> 
> Right, so maybe the pfn_to_mfn_local test is useless nowadays?

Yes, I think so. This might be better handled by removing
mfn_to_local_pfn altogether.
