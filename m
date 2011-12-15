From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 Dec 2011 14:02:35 +0000
Subject: [PATCH v6 3/9] ARM: versatile: Map local timers using Device Tree
 when possible
In-Reply-To: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1323957761-13553-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to map TWD registers basing on a "arm,smp-twd" Device Tree
node (compatible value as used in Highbank's DT). This overrides
existing twd_base value.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/plat-versatile/localtimer.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-versatile/localtimer.c b/arch/arm/plat-versatile/localtimer.c
index 0fb3961..8f0dc10 100644
--- a/arch/arm/plat-versatile/localtimer.c
+++ b/arch/arm/plat-versatile/localtimer.c
@@ -11,6 +11,8 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/clockchips.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
@@ -21,6 +23,16 @@
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
+#if defined(CONFIG_OF)
+	struct device_node *node = of_find_compatible_node(NULL,
+			NULL, "arm,smp-twd");
+
+	if (node)
+		twd_base = of_iomap(node, 0);
+#endif
+	if (!twd_base)
+		return -ENXIO;
+
 	evt->irq = IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
 	return 0;
-- 
1.7.5.4
