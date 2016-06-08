From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:31:03 +0100
Subject: [RFC PATCH 08/15] ARM: samsung: fixup endian issues in cpu detection
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <20160608183110.13851-9-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

If the system is built for big endian, then the cpu identificaiton register
will be read in the wrong order. Fix this by using readl_relaxed() on the
register.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/plat-samsung/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
index 71333bb..bd12a55 100644
--- a/arch/arm/plat-samsung/cpu.c
+++ b/arch/arm/plat-samsung/cpu.c
@@ -29,14 +29,14 @@ EXPORT_SYMBOL(samsung_rev);
 
 void __init s3c64xx_init_cpu(void)
 {
-	samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0x118);
+	samsung_cpu_id = readl_relaxed(S3C_VA_SYS + 0x118);
 	if (!samsung_cpu_id) {
 		/*
 		 * S3C6400 has the ID register in a different place,
 		 * and needs a write before it can be read.
 		 */
-		__raw_writel(0x0, S3C_VA_SYS + 0xA1C);
-		samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0xA1C);
+		writel_relaxed(0x0, S3C_VA_SYS + 0xA1C);
+		samsung_cpu_id = readl_relaxed(S3C_VA_SYS + 0xA1C);
 	}
 
 	samsung_cpu_rev = 0;
@@ -46,7 +46,7 @@ void __init s3c64xx_init_cpu(void)
 
 void __init s5p_init_cpu(void __iomem *cpuid_addr)
 {
-	samsung_cpu_id = __raw_readl(cpuid_addr);
+	samsung_cpu_id = readl_relaxed(cpuid_addr);
 	samsung_cpu_rev = samsung_cpu_id & 0xFF;
 
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
-- 
2.8.3
