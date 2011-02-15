From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Feb 2011 15:26:49 +0000
Subject: [PATCH v4 15/19] ARM: LPAE: use phys_addr_t instead of
	unsigned long for physical addresses
In-Reply-To: <20110215142339.GL4152@n2100.arm.linux.org.uk>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-16-git-send-email-catalin.marinas@arm.com>
	<20110212102803.GC15616@n2100.arm.linux.org.uk>
	<1297770742.21448.2.camel@e102144-lin.cambridge.arm.com>
	<20110215123522.GH4152@n2100.arm.linux.org.uk>
	<1297773569.14691.36.camel@e102109-lin.cambridge.arm.com>
	<1297777027.1293.2.camel@e102144-lin.cambridge.arm.com>
	<20110215142339.GL4152@n2100.arm.linux.org.uk>
Message-ID: <1297783609.23889.6.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, 2011-02-15 at 14:23 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 15, 2011 at 01:37:07PM +0000, Will Deacon wrote:
> > I should've spotted this either way. I've superseded the old patch with
> > 6674/1.
> 
> One additional thing that I think has been lost.  I said in the original
> reply to Catalin:
> | asm/memory.h will conflict non-trivially with p2v patch set, but I think
> | we can merge the changes to everything but __virt_to_phys/__phys_to_virt.
> 
> So 6670/1 which I'm intending to apply to the p2v branch can't be merged
> as-is.  The ideal solution would be a version of 6670/1 to apply on top
> of the existing p2v branch.
> 

The conflict with the p2v branch is fairly hefty, but something like
this should do (if you're happy I'll submit it to replace 6670/1):

Note that because the v2p macros only work for lowmem, I've not bothered
to add casts for the __v2p macros (rather, I've just changed the types
of the static inline functions). This simplifies the code and means we
can stay clear of the runtime fixup stuff.


diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 015fd5e..791cb3e 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -15,6 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/const.h>
+#include <linux/types.h>
 #include <mach/memory.h>
 #include <asm/sizes.h>
 
@@ -135,8 +136,8 @@
 /*
  * Convert a physical address to a Page Frame Number and back
  */
-#define        __phys_to_pfn(paddr)    ((paddr) >> PAGE_SHIFT)
-#define        __pfn_to_phys(pfn)      ((pfn) << PAGE_SHIFT)
+#define        __phys_to_pfn(paddr)    ((unsigned long)((paddr) >> PAGE_SHIFT))
+#define        __pfn_to_phys(pfn)      ((phys_addr_t)(pfn) << PAGE_SHIFT)
 
 /*
  * Convert a page to/from a physical address
@@ -234,12 +235,12 @@ static inline unsigned long __phys_to_virt(unsigned long x)
  * translation for translating DMA addresses.  Use the driver
  * DMA support - see dma-mapping.h.
  */
-static inline unsigned long virt_to_phys(void *x)
+static inline phys_addr_t virt_to_phys(void *x)
 {
        return __virt_to_phys((unsigned long)(x));
 }
 
-static inline void *phys_to_virt(unsigned long x)
+static inline void *phys_to_virt(phys_addr_t x)
 {
        return (void *)(__phys_to_virt((unsigned long)(x)));
 }


Cheers,

Will
