From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:31:08 +0100
Subject: [RFC PATCH 13/15] memory: samsung: endian fixes for IO
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <20160608183110.13851-14-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Use the relaxed versions of the IO accessors to avoid any issues
if running in big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Pavel Fedin <p.fedin@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: linux-arm-kernel at lists.codethink.co.uk
---
 drivers/memory/samsung/exynos-srom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index 96756fb..ac8f79c 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -91,11 +91,11 @@ static int exynos_srom_configure_bank(struct exynos_srom *srom,
 	if (width == 2)
 		cs |= 1 << EXYNOS_SROM_BW__DATAWIDTH__SHIFT;
 
-	bw = __raw_readl(srom->reg_base + EXYNOS_SROM_BW);
+	bw = readl_relaxed(srom->reg_base + EXYNOS_SROM_BW);
 	bw = (bw & ~(EXYNOS_SROM_BW__CS_MASK << bank)) | (cs << bank);
-	__raw_writel(bw, srom->reg_base + EXYNOS_SROM_BW);
+	writel_relaxed(bw, srom->reg_base + EXYNOS_SROM_BW);
 
-	__raw_writel(pmc | (timing[0] << EXYNOS_SROM_BCX__TACP__SHIFT) |
+	writel_relaxed(pmc | (timing[0] << EXYNOS_SROM_BCX__TACP__SHIFT) |
 		    (timing[1] << EXYNOS_SROM_BCX__TCAH__SHIFT) |
 		    (timing[2] << EXYNOS_SROM_BCX__TCOH__SHIFT) |
 		    (timing[3] << EXYNOS_SROM_BCX__TACC__SHIFT) |
-- 
2.8.3
