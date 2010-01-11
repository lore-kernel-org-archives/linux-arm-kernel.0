From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:24 -0800
Subject: [RFC 05/18] arm: msm: implement ioremap_strongly_ordered
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-6-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Larry Bassel <lbassel@quicinc.com>

Both the clean and invalidate functionality needed
for the video encoder and 7x27 barrier code
need to have a strongly ordered mapping set up
so that one may perform a write to strongly ordered
memory. The generic ARM code does not provide this.

The generic ARM code does provide MT_DEVICE, which starts
as strongly ordered, but the code later turns the buffered flag
on for ARMv6 in order to make the device shared. This is not
suitable for my purpose, so this patch adds code for a
MT_DEVICE_STRONGLY_ORDERED mapping type.

Signed-off-by: Larry Bassel <lbassel@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/include/asm/io.h       |    2 ++
 arch/arm/include/asm/mach/map.h |    1 +
 arch/arm/mm/mmu.c               |    6 ++++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d2a59cf..05b281e 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -222,12 +222,14 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #ifndef __arch_ioremap
 #define ioremap(cookie,size)		__arm_ioremap(cookie, size, MT_DEVICE)
 #define ioremap_nocache(cookie,size)	__arm_ioremap(cookie, size, MT_DEVICE)
+#define ioremap_strongly_ordered(cookie,size)  __arm_ioremap(cookie, size, MT_DEVICE_STRONGLY_ORDERED)
 #define ioremap_cached(cookie,size)	__arm_ioremap(cookie, size, MT_DEVICE_CACHED)
 #define ioremap_wc(cookie,size)		__arm_ioremap(cookie, size, MT_DEVICE_WC)
 #define iounmap(cookie)			__iounmap(cookie)
 #else
 #define ioremap(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE)
 #define ioremap_nocache(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE)
+#define ioremap_strongly_ordered(cookie,size)  __arch_ioremap((cookie), (size), MT_DEVICE_STRONGLY_ORDERED)
 #define ioremap_cached(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE_CACHED)
 #define ioremap_wc(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE_WC)
 #define iounmap(cookie)			__arch_iounmap(cookie)
diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 742c2aa..ddff29f 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -27,6 +27,7 @@ struct map_desc {
 #define MT_MEMORY		9
 #define MT_ROM			10
 #define MT_MEMORY_NONCACHED	11
+#define MT_DEVICE_STRONGLY_ORDERED 12
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 1708da8..bcbf774 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -201,6 +201,12 @@ static struct mem_type mem_types[] = {
 		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_S,
 		.domain		= DOMAIN_IO,
 	},
+	[MT_DEVICE_STRONGLY_ORDERED] = {  /* Guaranteed strongly ordered */
+		.prot_pte	= PROT_PTE_DEVICE,
+		.prot_l1	= PMD_TYPE_TABLE,
+		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_UNCACHED,
+		.domain		= DOMAIN_IO,
+	},
 	[MT_DEVICE_NONSHARED] = { /* ARMv6 non-shared device */
 		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_NONSHARED,
 		.prot_l1	= PMD_TYPE_TABLE,
-- 
1.6.3.3
