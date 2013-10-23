From: msalter@redhat.com (Mark Salter)
Date: Wed, 23 Oct 2013 09:46:12 -0400
Subject: [PATCH] arm64: allow ioremap_cache() to use existing RAM mappings
In-Reply-To: <1382519898.10408.1.camel@mbp>
References: <1382362594-24947-1-git-send-email-msalter@redhat.com>
 <1382519898.10408.1.camel@mbp>
Message-ID: <1382535972.1768.68.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-23 at 10:18 +0100, Catalin Marinas wrote:
> On Mon, 2013-10-21 at 14:36 +0100, msalter at redhat.com wrote:
> > diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> > index 1725cd6..fb44b3d 100644
> > --- a/arch/arm64/mm/ioremap.c
> > +++ b/arch/arm64/mm/ioremap.c
> > @@ -79,6 +79,21 @@ void __iounmap(volatile void __iomem *io_addr)
> >  {
> >  	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
> >  
> > +	/* Nothing to do for normal memory. See ioremap_cache() */
> > +	if (pfn_valid(__virt_to_phys(addr) >> PAGE_SHIFT))
> > +		return;
> 
> addr here can be some I/O address mapped previously, so __virt_to_phys()
> is not valid (you don't actually get the pfn by shifting).
> 

Yeah, that's ugly. The thought was that only the kernel mapping of RAM
would yield a valid address from __virt_to_phys(). Anything else, like
a mapping of I/O space would lead to an invalid PFN. There's probably a
clearer way of doing that that. Other than that, is the general concept
of the patch reasonable?

--Mark
