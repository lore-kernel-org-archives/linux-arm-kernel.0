From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:02 +0000
Subject: [PATCH 03/13] ARM: at91: use readl/writel relaxed instead of __raw
 for big endian
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for low-level uart debug when the system is running in
big endian mode by changing to use the readl_relaxed and writel_relaxed
calls instead of the __raw variants.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-at91/include/mach/uncompress.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 4ebb609..596696b 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -112,7 +112,7 @@ static inline const u32* decomp_soc_detect(void __iomem *dbgu_base)
 {
 	u32 cidr, socid;
 
-	cidr = __raw_readl(dbgu_base + AT91_DBGU_CIDR);
+	cidr = readl_relaxed(dbgu_base + AT91_DBGU_CIDR);
 	socid = cidr & ~AT91_CIDR_VERSION;
 
 	switch (socid) {
@@ -140,7 +140,7 @@ static inline const u32* decomp_soc_detect(void __iomem *dbgu_base)
 		return uarts_sam9x5;
 
 	case ARCH_ID_SAMA5:
-		cidr = __raw_readl(dbgu_base + AT91_DBGU_EXID);
+		cidr = readl_relaxed(dbgu_base + AT91_DBGU_EXID);
 		if (cidr & ARCH_EXID_SAMA5D3)
 			return uarts_sama5d3;
 		else if (cidr & ARCH_EXID_SAMA5D4)
@@ -180,7 +180,7 @@ static inline void arch_decomp_setup(void)
 		/* physical address */
 		at91_uart = (void __iomem *)usarts[i];
 
-		if (__raw_readl(at91_uart + ATMEL_US_BRGR))
+		if (readl_relaxed(at91_uart + ATMEL_US_BRGR))
 			return;
 		i++;
 	} while (usarts[i]);
@@ -200,9 +200,9 @@ static void putc(int c)
 	if (!at91_uart)
 		return;
 
-	while (!(__raw_readl(at91_uart + ATMEL_US_CSR) & ATMEL_US_TXRDY))
+	while (!(readl_relaxed(at91_uart + ATMEL_US_CSR) & ATMEL_US_TXRDY))
 		barrier();
-	__raw_writel(c, at91_uart + ATMEL_US_THR);
+	writel_relaxed(c, at91_uart + ATMEL_US_THR);
 }
 
 static inline void flush(void)
@@ -211,7 +211,7 @@ static inline void flush(void)
 		return;
 
 	/* wait for transmission to complete */
-	while (!(__raw_readl(at91_uart + ATMEL_US_CSR) & ATMEL_US_TXEMPTY))
+	while (!(readl_relaxed(at91_uart + ATMEL_US_CSR) & ATMEL_US_TXEMPTY))
 		barrier();
 }
 
-- 
2.1.4
