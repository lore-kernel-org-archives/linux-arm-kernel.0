From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:35:59 +0100
Subject: [PATCH 08/15] ARM: S3C24XX: Identify S3C2416 if S3C2412/S3C2413 built
	in
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the ARMv5 ID code to deal with S3C2416 being built with
S3C2412/S3C2413 enabled, as these have their ID registers in a
different place.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c24xx/cpu.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 494f4f3..32db856 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -181,10 +181,18 @@ static struct map_desc s3c_iodesc[] __initdata = {
 
 static unsigned long s3c24xx_read_idcode_v5(void)
 {
+#if defined(CONFIG_CPU_S3C2416)
+	/* s3c2416 is v5, with S3C24XX_GSTATUS1 instead of S3C2412_GSTATUS1 */
+
+	u32 gs = __raw_readl(S3C24XX_GSTATUS1);
+
+	/* test for s3c2416 or similar device */
+	if ((gs >> 16) == 0x3245)
+		return gs;
+#endif
+
 #if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
 	return __raw_readl(S3C2412_GSTATUS1);
-#elif defined(CONFIG_CPU_S3C2416)
-	return __raw_readl(S3C24XX_GSTATUS1);
 #else
 	return 1UL;	/* don't look like an 2400 */
 #endif
-- 
1.6.3.3
