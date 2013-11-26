From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 25 Nov 2013 22:56:25 -0500 (EST)
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131125233654.GV16735@n2100.arm.linux.org.uk>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233654.GV16735@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.10.1311252254200.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Nov 2013, Russell King - ARM Linux wrote:

> On Mon, Nov 25, 2013 at 11:20:03PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 25, 2013 at 03:36:36PM -0700, Jason Gunthorpe wrote:
> > > Which is after your new inlines..
> > > 
> > > An elegant fix wasn't obvious to me :)
> > 
> > Same here... it's all rather complicated because of all those ifdefs.
> > Nothing easy comes to mind about how to fix this one.  I'll look into
> > it at some point.
> > 
> > If not, it's going to have to be a revert - or we bite the bullet and
> > start killing off some of these Kconfig options such as making
> > ARM_PATCH_PHYS_VIRT mandatory.
> 
> Actually, I think Nicolas' commit:
> 
> 1b9f95f8ade9efc2bd49f0e7b9dc61a038ac3eef
> 
> was wrong to remove PLAT_PHYS_OFFSET.  So, partially undoing Nicolas'
> patch, and reordering things a little, we end up with this, which if
> it weren't for the comment would be 5 lines shorter!
[...]

What about simply doing the following instead, which I'm sure used to 
work properly at some point:

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 9ecccc8650..2b8b8d3236 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -239,6 +239,14 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 
 #else
 
+#ifndef PHYS_OFFSET
+#ifdef PLAT_PHYS_OFFSET
+#define PHYS_OFFSET	PLAT_PHYS_OFFSET
+#else
+#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
+#endif
+#endif
+
 static inline phys_addr_t __virt_to_phys(unsigned long x)
 {
 	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
@@ -253,14 +261,6 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 #endif
 #endif /* __ASSEMBLY__ */
 
-#ifndef PHYS_OFFSET
-#ifdef PLAT_PHYS_OFFSET
-#define PHYS_OFFSET	PLAT_PHYS_OFFSET
-#else
-#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
-#endif
-#endif
-
 #ifndef __ASSEMBLY__
 
 /*
