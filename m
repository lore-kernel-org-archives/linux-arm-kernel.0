From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 10 Dec 2012 12:39:14 +0530
Subject: [PATCH 5/9] memory: emif: use restart if power_off not present when
 out of spec
In-Reply-To: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
References: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1355123358-5273-6-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Some machine or kernel variants might have missed implementation
of power off handlers. We DONOT want to let the system be in
"out of spec" state in this condition. So, WARN and attempt
a machine restart in the hopes of clearing the out-of-spec
temperature condition.

NOTE: This is not the safest option, but safer than leaving the
system in unstable conditions.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/memory/emif.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index ffbdf9e..625732d 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/pm.h>
 #include <memory/jedec_ddr.h>
 #include "emif.h"
 #include "of_memory.h"
@@ -1013,7 +1014,13 @@ static irqreturn_t emif_threaded_isr(int irq, void *dev_id)
 
 	if (emif->temperature_level == SDRAM_TEMP_VERY_HIGH_SHUTDOWN) {
 		dev_emerg(emif->dev, "SDRAM temperature exceeds operating limit.. Needs shut down!!!\n");
-		kernel_power_off();
+		/* If we have Power OFF ability, use it, else try restarting */
+		if (pm_power_off) {
+			kernel_power_off();
+		} else {
+			WARN(1, "FIXME: NO pm_power_off!!! trying restart\n");
+			kernel_restart("SDRAM Over-temp Emergency restart");
+		}
 		return IRQ_HANDLED;
 	}
 
-- 
1.7.9.5
