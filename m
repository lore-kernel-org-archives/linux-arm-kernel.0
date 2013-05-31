From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 31 May 2013 16:23:20 +0100
Subject: [PATCH RFC 5/6] arm64/xen: implement xen_remap on arm64
In-Reply-To: <alpine.DEB.2.02.1305311530440.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
 <1369930713-6063-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130531105915.GC18045@localhost.cambridge.arm.com>
 <alpine.DEB.2.02.1305311419280.4799@kaball.uk.xensource.com>
 <20130531141601.GC15551@arm.com>
 <alpine.DEB.2.02.1305311530440.4799@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1305311622150.4799@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 May 2013, Stefano Stabellini wrote:
> On Fri, 31 May 2013, Catalin Marinas wrote:
> > On Fri, May 31, 2013 at 02:21:16PM +0100, Stefano Stabellini wrote:
> > > On Fri, 31 May 2013, Catalin Marinas wrote:
> > > > On Thu, May 30, 2013 at 05:18:32PM +0100, Stefano Stabellini wrote:
> > > > > --- a/arch/arm/include/asm/xen/page.h
> > > > > +++ b/arch/arm/include/asm/xen/page.h
> > > > > @@ -90,6 +90,10 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
> > > > >  	return __set_phys_to_machine(pfn, mfn);
> > > > >  }
> > > > >  
> > > > > +#ifdef CONFIG_ARM64
> > > > > +#define xen_remap(cookie, size) __ioremap((cookie), (size), __pgprot(PROT_NORMAL))
> > > > > +#else
> > > > >  #define xen_remap(cookie, size) __arm_ioremap((cookie), (size), MT_MEMORY);
> > > > > +#endif
> > > > 
> > > > Now I saw the ARM-specific part. Can you not use something like
> > > > ioremap_cached() which would give normal cacheable memory (at least on
> > > > ARMv7).
> > > 
> > > No, I cannot because ioremap_cached uses MT_DEVICE_CACHED, while this
> > > needs to be MT_MEMORY. It is used for normal memory pages, not device
> > > memory.
> > 
> > MT_DEVICE_CACHED is Normal memory for ARMv7.
> 
> I didn't realize that MT_DEVICE_CACHED and MT_MEMORY end up having the
> same AttrIndx encoding!
> In that case yes, I should be able to use it.
> I take that I should just implement ioremap_cached on arm64 as well?
> 

Should just use MT_MEMORY and call it PROT_NORMAL?

#define PROT_NORMAL     (PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
#define ioremap_cached(addr, size)     __ioremap((addr), (size), __pgprot(PROT_NORMAL))
