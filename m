From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Aug 2013 18:22:32 -0500
Subject: [PATCH] ARM: highbank: make dma_zone_size depend on ARM_LPAE
Message-ID: <1376522552-11650-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

DMA zone on highbank should only be enabled for LPAE, but other platforms
can cause DMA zone to be selected resulting in this warning:

arch/arm/mach-highbank/highbank.c:180:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]

Fix this by making dma_zone_size setting also depend on CONFIG_ARM_LPAE.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index b5d0375..8dc5f98 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -178,7 +178,7 @@ static const char *highbank_match[] __initconst = {
 };
 
 DT_MACHINE_START(HIGHBANK, "Highbank")
-#ifdef CONFIG_ZONE_DMA
+#if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
 	.dma_zone_size	= (4ULL * SZ_1G),
 #endif
 	.smp		= smp_ops(highbank_smp_ops),
-- 
1.8.1.2
