From: thierry.escande@collabora.com (Thierry Escande)
Date: Wed, 26 Oct 2016 19:04:08 +0200
Subject: [PATCH 2/2] ARM: dma-mapping: Handle prot with non-consistent dma
 attribute
In-Reply-To: <1477501448-30915-1-git-send-email-thierry.escande@collabora.com>
References: <1477501448-30915-1-git-send-email-thierry.escande@collabora.com>
Message-ID: <1477501448-30915-3-git-send-email-thierry.escande@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heng-Ruey Hsu <henryhsu@chromium.org>

With this change, __get_dma_pgprot() now returns the VMA access
protection passed directly instead of overriding it if called with
NON_CONSISTENT DMA attribute.

Signed-off-by: Heng-Ruey Hsu <henryhsu@chromium.org>
Tested-by: Heng-ruey Hsu <henryhsu@chromium.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 arch/arm/mm/dma-mapping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index dc42ca6..d608c185 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -640,6 +640,9 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 
 static inline pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot)
 {
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		return prot;
+
 	prot = (attrs & DMA_ATTR_WRITE_COMBINE) ?
 			pgprot_writecombine(prot) :
 			pgprot_dmacoherent(prot);
-- 
2.7.4
