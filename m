From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 06 Aug 2015 10:16:34 +0800
Subject: [PATCH RFT] ata: ahci_brcmstb: Fix misuse of IS_ENABLED
Message-ID: <1438827394.19066.1.camel@ingics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While IS_ENABLED() is perfectly fine for CONFIG_* symbols, it is not
for other symbols such as __BIG_ENDIAN that is provided directly by
the compiler.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
I don't have a big endian machine to test this, so I'd appreciate if
someone can review and test this patch.

A similar misuse of IS_ENABLED is reported and fixed in:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/mv_xor.c?id=0ec9ebc706fbd394bc233d87ac7aaad1c4f3ab54

 drivers/ata/ahci_brcmstb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 42b6cf4..fc6413f 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -92,19 +92,21 @@ static inline u32 brcm_sata_readreg(void __iomem *addr)
 	 * Other architectures (e.g., ARM) either do not support big endian, or
 	 * else leave I/O in little endian mode.
 	 */
-	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
-		return __raw_readl(addr);
-	else
-		return readl_relaxed(addr);
+#if defined(__BIG_ENDIAN) && IS_ENABLED(CONFIG_MIPS)
+	return __raw_readl(addr);
+#else
+	return readl_relaxed(addr);
+#endif
 }
 
 static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
 {
 	/* See brcm_sata_readreg() comments */
-	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
-		__raw_writel(val, addr);
-	else
-		writel_relaxed(val, addr);
+#if defined(__BIG_ENDIAN) && IS_ENABLED(CONFIG_MIPS)
+	__raw_writel(val, addr);
+#else
+	writel_relaxed(val, addr);
+#endif
 }
 
 static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
-- 
2.1.0
