From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 Dec 2014 13:45:48 -0800
Subject: [PATCH] ARM: bcm: fix __iomem annotation on kona_smc
Message-ID: <1418075148-8752-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following sparse warning:
arch/arm/mach-bcm/bcm_kona_smc.c:145:21: warning: incorrect type in initializer (different address spaces)
arch/arm/mach-bcm/bcm_kona_smc.c:145:21:    expected unsigned int [usertype] *args
arch/arm/mach-bcm/bcm_kona_smc.c:145:21:    got void [noderef] <asn:2>*static [toplevel] [assigned] bcm_smc_buffer
arch/arm/mach-bcm/bcm_kona_smc.c:151:9: warning: incorrect type in argument 2 (different address spaces)
arch/arm/mach-bcm/bcm_kona_smc.c:151:9:    expected void volatile [noderef] <asn:2>*addr
arch/arm/mach-bcm/bcm_kona_smc.c:151:9:    got unsigned int [usertype] *
[+ 2 more instances]

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Florian, should we just apply this directly on arm-soc?


-Olof

 arch/arm/mach-bcm/bcm_kona_smc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index a55a7ec..d506d17 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -142,7 +142,7 @@ static int bcm_kona_do_smc(u32 service_id, u32 buffer_phys)
 static void __bcm_kona_smc(void *info)
 {
 	struct bcm_kona_smc_data *data = info;
-	u32 *args = bcm_smc_buffer;
+	u32 __iomem *args = bcm_smc_buffer;
 
 	BUG_ON(smp_processor_id() != 0);
 	BUG_ON(!args);
-- 
1.7.10.4
