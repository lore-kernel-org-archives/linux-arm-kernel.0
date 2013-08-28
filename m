From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 28 Aug 2013 21:07:52 +0100
Subject: [PATCH v4 10/10] xen/arm,arm64: enable SWIOTLB_XEN
In-Reply-To: <1376600325.9273.223.camel@hastur.hellion.org.uk>
References: <alpine.DEB.2.02.1308151200580.4470@kaball.uk.xensource.com>
 <1376565054-24153-10-git-send-email-stefano.stabellini@eu.citrix.com>
 <1376600325.9273.223.camel@hastur.hellion.org.uk>
Message-ID: <alpine.DEB.2.02.1308282104000.6397@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Aug 2013, Ian Campbell wrote:
> On Thu, 2013-08-15 at 12:10 +0100, Stefano Stabellini wrote:
> > At the moment always rely on swiotlb-xen, but when Xen starts supporting
> > hardware IOMMUs we'll be able to avoid it conditionally on the presence
> > of an IOMMU on the platform.
> 
> Do we have any idea how we are going to do this?
> 
> It's extra complicated if you consider that on some systems on some of
> the devices are behind an IOMMU :-/
> 
> I wonder if we can enumerate which devices have an IOMMU at boot time
> and force a ludicrous dma mask (such as 0) if one isn't present in order
> to force us to always take the exchange_and_pin path?

We don't need to worry about how to specify which devices need to go via
the swiotlb internally, because we have our own arm specific
dma_map_ops. At the moment they are just implemented using the
swiotlb-xen functions, but we could easily provide wrappers that check
our own internal whitelist/blacklist and go via swiotlb-xen only in
those cases.
