From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 25 Nov 2013 16:34:58 -0700
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131125232003.GU16735@n2100.arm.linux.org.uk>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
Message-ID: <20131125233458.GA19852@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:20:03PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 25, 2013 at 03:36:36PM -0700, Jason Gunthorpe wrote:
> > Which is after your new inlines..
> > 
> > An elegant fix wasn't obvious to me :)
> 
> Same here... it's all rather complicated because of all those ifdefs.
> Nothing easy comes to mind about how to fix this one.  I'll look into
> it at some point.
> 
> If not, it's going to have to be a revert - or we bite the bullet and
> start killing off some of these Kconfig options such as making
> ARM_PATCH_PHYS_VIRT mandatory.

This is enough to fix the build:

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index eaf428c..b886eba 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -239,15 +239,8 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 
 #else
 
-static inline phys_addr_t __virt_to_phys(unsigned long x)
-{
-       return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
-}
-
-static inline unsigned long __phys_to_virt(phys_addr_t x)
-{
-       return x - PHYS_OFFSET + PAGE_OFFSET;
-}
+#define __virt_to_phys(x)      ((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET)
+#define __phys_to_virt(x)      ((unsigned long)((phys_addr_t)(x) - PHYS_OFFSET + PAGE_OFFSET))

 #endif
 #endif

I don't seen an obvious major downside to loosing the inline, static
checking will have to be done with the ARM_PATCH_PHYS_VIRT branch..

I'm working on runtime testing this, let me know if you want a proper
patch.

Regards,
Jason
