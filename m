From: sstabellini@kernel.org (Stefano Stabellini)
Date: Tue, 23 Aug 2016 14:06:20 -0700 (PDT)
Subject: [PATCH v05 54/72] include/uapi/xen/privcmd.h: fix compilation
 in userspace
In-Reply-To: <20160823203811.GO5399@lakka.kapsi.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
 <1471890809-4383-55-git-send-email-mikko.rapeli@iki.fi>
 <20160823100201.GG1041@n2100.armlinux.org.uk>
 <alpine.DEB.2.10.1608231100400.12392@sstabellini-ThinkPad-X260>
 <20160823203811.GO5399@lakka.kapsi.fi>
Message-ID: <alpine.DEB.2.10.1608231404210.12392@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2016, Mikko Rapeli wrote:
> On Tue, Aug 23, 2016 at 11:13:52AM -0700, Stefano Stabellini wrote:
> > On Tue, 23 Aug 2016, Russell King - ARM Linux wrote:
> > > On Mon, Aug 22, 2016 at 08:33:11PM +0200, Mikko Rapeli wrote:
> > > > xen/interface/xen.h is not exported from kernel headers so remove the
> > > > dependency and provide needed defines for domid_t and xen_pfn_t if they
> > > > are not already defined by some other e.g. Xen specific headers.
> > > 
> > > I'm confused.  How did we end up with a 64-bit PFN number on ARM?  It's
> > > insane - especially as the kernel uses "unsigned long" almost everywhere
> > > for PFNs - we can't have physical addresses more than 44 bits (32 bit
> > > pfn + 4k page size).
> > 
> > That's because xen_pfn_t is the type used to store pfns in structures
> > passed to Xen via hypercalls. The Xen hypercall ABI is shared between
> > ARM and ARM64. On x86_32 and x86_64 we have different sizes for pfn
> > types in the hypercall ABI and it caused quite a bit of trouble in the
> > past as it is possible to run 32bit domains on a 64bit hypervisor.
> > Having a common type for pfns on ARM and ARM64 helped a lot in that
> > respect.
> > 
> > 
> > > > Suggested by Andrew Cooper <andrew.cooper3@citrix.com> on lkml message
> > > > <5569F9C9.8000607@citrix.com>.
> > > > 
> > > > The ifdef for ARM is ugly but did not find better solutions for it.
> > > 
> > > #ifdef __arm__
> > > 
> > > maybe?  Even if not, the unsightly parens are not necessary.
> > 
> > Yes, I think it should be:
> > 
> > #if defined(__arm__) || defined(__aarch64__)
> 
> Thanks, I will send a new version with this change.
>  
> > > diff --git a/arch/arm/include/asm/xen/interface.h b/arch/arm/include/asm/xen/interface.h
> > > index 75d5968..6898ee1 100644
> > > --- a/arch/arm/include/asm/xen/interface.h
> > > +++ b/arch/arm/include/asm/xen/interface.h
> > > @@ -38,7 +38,7 @@
> > >   * fine since it simply wouldn't be able to create any sure pfns in
> > >   * the first place.
> > >   */
> > > -typedef uint64_t xen_pfn_t;
> > > +typedef __u64 xen_pfn_t;
> > >  #define PRI_xen_pfn "llx"
> > >  typedef uint64_t xen_ulong_t;
> > >  #define PRI_xen_ulong "llx"
> > 
> > Why this change?
> 
> I will double check but I think the other fix exposed then the common
> "<stdint.h> definitions not available in userspace <linux/types.h>" and this
> was needed to please the compiler. If so, I'll add this to commit message.

That would be strange, because I don't think
arch/arm/include/asm/xen/interface.h is exposed to userspace. If it
was, we would need to replace the other definitions there too.
