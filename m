From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 21 Jul 2014 15:47:17 +0100
Subject: [PATCH RFC 6/9] arm: mm: Avoid ioremap_page_range() for non-secure
 mappings
In-Reply-To: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
References: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1405954040-30399-7-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ioremap_page_range() cannot provide us memory with the the non-secure
section flag set unfortunately at present ioremap+MT_DEVICE_NS will
fallback to this function and spuriously return a virtual pointer to
what is effectively MT_DEVICE memory.

This patch makes the fallback to ioremap_page_range() ineffective; to
allocate MT_DEVICE_NS memory we must rely instead on the platform startup
code providing a suitable static mapping.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/mm/ioremap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index d1e5ad7..1cb12f8 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -319,6 +319,10 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 		err = remap_area_sections(addr, pfn, size, type);
 	} else
 #endif
+	if (type->prot_sect & PMD_SECT_NS)
+		/* required section flag is not achievable; give up */
+		return NULL;
+	else
 		err = ioremap_page_range(addr, addr + size, paddr,
 					 __pgprot(type->prot_pte));
 
-- 
1.9.3
