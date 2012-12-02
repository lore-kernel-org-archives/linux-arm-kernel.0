From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 02 Dec 2012 17:55:44 +0400
Subject: =?UTF-8?B?UmVbNF06IFtQQVRDSF0gQVJNOiBpeHA0eHg6IEFkZCAiYXNrIiBoYW5kbGVy?=
 =?UTF-8?B?IGZvciB0aW1lciBpbnRlcnJ1cHRz?=
In-Reply-To: <201212021313.37790.arnd@arndb.de>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
 <1354428123.119115041@f313.mail.ru> <201212021313.37790.arnd@arndb.de>
Message-ID: <1354456544.242756864@f360.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sunday 02 December 2012, Alexander Shiyan wrote:
> > > diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> > > index eb68b61..2522ab0 100644
> > > --- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> > > +++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> > > @@ -92,7 +92,7 @@
> > >  /*
> > >   * Expansion Bus Controller registers.
> > >   */
> > > -#define IXP4XX_EXP_REG(x) ((volatile u32 __iomem *)(IXP4XX_EXP_CFG_BASE_VIRT+(x)))
> > > +#define IXP4XX_EXP_REG(x) (IXP4XX_EXP_CFG_BASE_VIRT+(x))
> > Modify this to:
> > #define IXP4XX_EXP_REG(x) IOMEM(IXP4XX_EXP_CFG_BASE_VIRT+(x))
> > to avoid compiler warnings.
> > 
> 
> Hmm, not sure what went wrong here. Actually the definition of 
> IXP4XX_EXP_CFG_BASE_VIRT itself should use the IOMEM() macro, like
> all the other IXP4XX_*_BASE_VIRT do.

But without this is produce warnings:
  CC      arch/arm/common/dmabounce.o
In file included from arch/arm/mach-ixp4xx/include/mach/hardware.h:30,
                 from arch/arm/mach-ixp4xx/include/mach/io.h:18,
                 from /home/git/linux-next/arch/arm/include/asm/io.h:180,
                 from include/linux/scatterlist.h:10,
                 from include/linux/dma-mapping.h:9,
                 from arch/arm/common/dmabounce.c:30:
arch/arm/mach-ixp4xx/include/mach/cpu.h: In function 'ixp4xx_read_feature_bits':
arch/arm/mach-ixp4xx/include/mach/cpu.h:41: warning: passing argument 1 of '__raw_readl' makes pointer from integer without a cast
arch/arm/mach-ixp4xx/include/mach/cpu.h: In function 'ixp4xx_write_feature_bits':
arch/arm/mach-ixp4xx/include/mach/cpu.h:55: warning: passing argument 2 of '__raw_writel' makes pointer from integer without a cast 

---
