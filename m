From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  5 May 2014 16:20:31 +0200
Subject: [PATCH 5/5] ARM: mvebu: conditionalize Armada 375 coherency workaround
In-Reply-To: <1399299631-30825-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399299631-30825-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399299631-30825-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 375 coherency workaround only needs to be applied to the Z1
revision of the SoC. The A0 and later revisions have been fixed, and
no longer need this workaround.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 489edd1..673c830 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -33,6 +33,7 @@
 #include <asm/cacheflush.h>
 #include "armada-370-xp.h"
 #include "coherency.h"
+#include "mvebu-soc-id.h"
 
 unsigned long coherency_phys_base;
 static void __iomem *coherency_base;
@@ -361,12 +362,16 @@ int __init coherency_init(void)
 static int __init coherency_late_init(void)
 {
 	int type = coherency_type();
+	u32 dev, rev;
 
 	if (type == COHERENCY_FABRIC_TYPE_NONE)
 		return 0;
 
-	if (type == COHERENCY_FABRIC_TYPE_ARMADA_375)
-		armada_375_coherency_init_wa();
+	if (type == COHERENCY_FABRIC_TYPE_ARMADA_375) {
+		if (mvebu_get_soc_id(&dev, &rev) == 0 &&
+		    rev == ARMADA_375_Z1_REV)
+			armada_375_coherency_init_wa();
+	}
 
 	bus_register_notifier(&platform_bus_type,
 			      &mvebu_hwcc_platform_nb);
-- 
1.9.2
