From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Sep 2016 15:13:53 +0100
Subject: [PATCH 2/2] arm-cci: Do not probe the CCI ports if booted from HYP
In-Reply-To: <1474380833-30121-1-git-send-email-marc.zyngier@arm.com>
References: <1474380833-30121-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1474380833-30121-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Poking the CCI ports from non-secure is likely to end up in fireworks,
so let's not try our luck here, and skip the driver initialization
if booted from HYP (which is always non-secure).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/bus/arm-cci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index ffa7c9d..70f51a9 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -28,6 +28,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
+#include <asm/virt.h>
 
 static void __iomem *cci_ctrl_base;
 static unsigned long cci_ctrl_phys;
@@ -2184,6 +2185,16 @@ static int cci_probe_ports(struct device_node *np)
 	const char *match_str;
 	bool is_ace;
 
+	/*
+	 * If we booted in HYP mode, then we're running non-secure,
+	 * and there is zero chance that we'll be able to configure
+	 * anything on the CCI. Gracefully leave the room...
+	 */
+	if (is_hyp_mode_available()) {
+		pr_info("%s: skipping probe (running non-secure)\n",
+			np->full_name);
+		return -ENODEV;
+	}
 
 	cci_config = of_match_node(arm_cci_matches, np)->data;
 	if (!cci_config)
-- 
2.1.4
