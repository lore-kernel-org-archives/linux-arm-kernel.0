From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Dec 2012 23:40:10 +0000
Subject: [PATCH] ARM: ixp4xx: Add "ask" handler for timer interrupts
In-Reply-To: <1354456544.242756864@f360.mail.ru>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
 <201212021313.37790.arnd@arndb.de> <1354456544.242756864@f360.mail.ru>
Message-ID: <201212032340.11053.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 December 2012, Alexander Shiyan wrote:
> > > > -#define IXP4XX_EXP_REG(x) ((volatile u32 __iomem *)(IXP4XX_EXP_CFG_BASE_VIRT+(x)))
> > > > +#define IXP4XX_EXP_REG(x) (IXP4XX_EXP_CFG_BASE_VIRT+(x))
> > > Modify this to:
> > > #define IXP4XX_EXP_REG(x) IOMEM(IXP4XX_EXP_CFG_BASE_VIRT+(x))
> > > to avoid compiler warnings.
> > > 
> > 
> > Hmm, not sure what went wrong here. Actually the definition of 
> > IXP4XX_EXP_CFG_BASE_VIRT itself should use the IOMEM() macro, like
> > all the other IXP4XX_*_BASE_VIRT do.
> 
> But without this is produce warnings:
>   CC      arch/arm/common/dmabounce.o
> In file included from arch/arm/mach-ixp4xx/include/mach/hardware.h:30,
>                  from arch/arm/mach-ixp4xx/include/mach/io.h:18,
>                  from /home/git/linux-next/arch/arm/include/asm/io.h:180,
>                  from include/linux/scatterlist.h:10,
>                  from include/linux/dma-mapping.h:9,
>                  from arch/arm/common/dmabounce.c:30:
> arch/arm/mach-ixp4xx/include/mach/cpu.h: In function 'ixp4xx_read_feature_bits':
> arch/arm/mach-ixp4xx/include/mach/cpu.h:41: warning: passing argument 1 of '__raw_readl' makes pointer from integer without a cast
> arch/arm/mach-ixp4xx/include/mach/cpu.h: In function 'ixp4xx_write_feature_bits':
> arch/arm/mach-ixp4xx/include/mach/cpu.h:55: warning: passing argument 2 of '__raw_writel' makes pointer from integer without a cast 
> 

I understand what the problem is, my point was that a better solution is to do

diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index c5bae9c..daf5c4e 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -65,7 +65,7 @@
  * Expansion BUS Configuration registers
  */
 #define IXP4XX_EXP_CFG_BASE_PHYS	0xC4000000
-#define IXP4XX_EXP_CFG_BASE_VIRT	0xFEF14000
+#define IXP4XX_EXP_CFG_BASE_VIRT	IOMEM(0xFEF14000)
 #define IXP4XX_EXP_CFG_REGION_SIZE	0x00001000
 
 #define IXP4XX_EXP_CS0_OFFSET	0x00



instead of your suggested fix, because that matches how all the other _VIRT macros in that
file are defined. I found now that it was correct until recently, but b7b23db72f accidentally
broke it while fixing the MMIO location.

	Arnd
