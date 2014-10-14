From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 14 Oct 2014 12:21:37 -0400
Subject: [PATCH v4 6/7] xen/arm/arm64: introduce xen_arch_need_swiotlb
In-Reply-To: <543D4B5C.2040502@citrix.com>
References: <alpine.DEB.2.02.1410101244090.17038@kaball.uk.xensource.com>
 <1412941908-5850-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <20141014160352.GF30965@laptop.dumpdata.com>
 <543D4B5C.2040502@citrix.com>
Message-ID: <20141014162137.GI30965@laptop.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 05:12:12PM +0100, David Vrabel wrote:
> On 14/10/14 17:03, Konrad Rzeszutek Wilk wrote:
> > On Fri, Oct 10, 2014 at 12:51:47PM +0100, Stefano Stabellini wrote:
> >> Introduce an arch specific function to find out whether a particular dma
> >> mapping operation needs to bounce on the swiotlb buffer.
> >>
> >> On ARM and ARM64, if the page involved is a foreign page and the device
> >> is not coherent, we need to bounce because at unmap time we cannot
> >> execute any required cache maintenance operations (we don't know how to
> >> find the pfn from the mfn).
> ...
> >> --- a/arch/x86/include/asm/xen/page.h
> >> +++ b/arch/x86/include/asm/xen/page.h
> >> @@ -236,4 +236,11 @@ void make_lowmem_page_readwrite(void *vaddr);
> >>  #define xen_remap(cookie, size) ioremap((cookie), (size));
> >>  #define xen_unmap(cookie) iounmap((cookie))
> >>  
> >> +static inline bool xen_arch_need_swiotlb(struct device *dev,
> >> +		                                 unsigned long pfn,
> >> +										 unsigned long mfn)
> >> +{
> >> +	return false;
> >> +}
> > 
> > Why not make this an macro?
> 
> Because macros are evil and inline functions are preferred.

<laughs>

Fair enough.
> 
> David
