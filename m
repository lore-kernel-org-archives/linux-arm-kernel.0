From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 15:20:53 +0000
Subject: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
In-Reply-To: <AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
	<20101202123304.GB10461@n2100.arm.linux.org.uk>
	<AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
Message-ID: <20101202152053.GC10461@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 08:50:07AM -0600, Guzman Lugo, Fernando wrote:
> On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrote:
> >> Hi Tony,
> >>
> >> The following changes since commit e8a7e48bb248a1196484d3f8afa53bded2b24e71:
> >> ? Linus Torvalds (1):
> >> ? ? ? ? Linux 2.6.37-rc4
> >>
> >> are available in the git repository at:
> >>
> >> ? git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.38
> >>
> >> Fernando Guzman Lugo (5):
> >> ? ? ? OMAP: mailbox: change full flag per mailbox queue instead of global
> >> ? ? ? omap: iovmm - no gap checking for fixed address
> >> ? ? ? omap: iovmm - add superpages support to fixed da address
> >> ? ? ? omap: iovmm - replace __iounmap with omap_iounmap
> >
> > This change is wrong. ?Nothing should be directly referencing omap_iounmap
> > nor for that matter omap_ioremap. ?Both are implementation details of the
> > standard ioremap/iounmap APIs.
> >
> > Use the official APIs rather than the implementation details behind them.
> 
> if you see where the function is used, you will see that it is not
> calling the function, it is use as a parameter in unmap_vm_area(), if
> I used iounmap which is a macro there I will get a compilation error.

Hmm, yes, because iounmap() is defined as a macro rather than iounmap.

The solution to this is to fix iounmap and __arch_iounmap macros so
they aren't macros which take arguments.  That will then allow them
to be used in the way you desire.

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 815efa2..91be1f8 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -245,13 +245,13 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define ioremap_nocache(cookie,size)	__arm_ioremap(cookie, size, MT_DEVICE)
 #define ioremap_cached(cookie,size)	__arm_ioremap(cookie, size, MT_DEVICE_CACHED)
 #define ioremap_wc(cookie,size)		__arm_ioremap(cookie, size, MT_DEVICE_WC)
-#define iounmap(cookie)			__iounmap(cookie)
+#define iounmap				__iounmap
 #else
 #define ioremap(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_nocache(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_cached(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE_CACHED)
 #define ioremap_wc(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE_WC)
-#define iounmap(cookie)			__arch_iounmap(cookie)
+#define iounmap				__arch_iounmap
 #endif
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 128b549..204865f 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -294,8 +294,8 @@ static inline void omap44xx_map_common_io(void)
 extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1);
 
-#define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
-#define __arch_iounmap(v)	omap_iounmap(v)
+#define __arch_ioremap	omap_ioremap
+#define __arch_iounmap	omap_iounmap
 
 void __iomem *omap_ioremap(unsigned long phys, size_t size, unsigned int type);
 void omap_iounmap(volatile void __iomem *addr);
