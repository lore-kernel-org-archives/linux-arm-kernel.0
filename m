From: khalasa@piap.pl (Krzysztof Halasa)
Date: Fri, 11 Mar 2016 12:32:14 +0100
Subject: [PATCH] CNS3xxx: Fix PCI cns3xxx_write_config()
Message-ID: <m360wtjlmp.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "where" offset was added twice, fix it.

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
Fixes: 498a92d42596 ("ARM: cns3xxx: pci: avoid potential stack overflow")

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 47905a5..318394e 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -220,13 +220,13 @@ static void cns3xxx_write_config(struct cns3xxx_pcie *cnspci,
 	u32 mask = (0x1ull << (size * 8)) - 1;
 	int shift = (where % 4) * 8;
 
-	v = readl_relaxed(base + (where & 0xffc));
+	v = readl_relaxed(base);
 
 	v &= ~(mask << shift);
 	v |= (val & mask) << shift;
 
-	writel_relaxed(v, base + (where & 0xffc));
-	readl_relaxed(base + (where & 0xffc));
+	writel_relaxed(v, base);
+	readl_relaxed(base);
 }
 
 static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
