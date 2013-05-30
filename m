From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 30 May 2013 17:18:32 +0100
Subject: [PATCH RFC 5/6] arm64/xen: implement xen_remap on arm64
In-Reply-To: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
Message-ID: <1369930713-6063-5-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/page.h |    4 ++++
 arch/arm64/include/asm/io.h     |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index cb2fa15..d995ece 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -90,6 +90,10 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 	return __set_phys_to_machine(pfn, mfn);
 }
 
+#ifdef CONFIG_ARM64
+#define xen_remap(cookie, size) __ioremap((cookie), (size), __pgprot(PROT_NORMAL))
+#else
 #define xen_remap(cookie, size) __arm_ioremap((cookie), (size), MT_MEMORY);
+#endif
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 2e12258..0e9c9ac 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -228,6 +228,7 @@ extern void __iounmap(volatile void __iomem *addr);
 #define PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_DIRTY)
 #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_DEVICE_nGnRE))
 #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL_NC))
+#define PROT_NORMAL		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
 
 #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
-- 
1.7.2.5
