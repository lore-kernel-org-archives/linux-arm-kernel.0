From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 19 Feb 2016 07:50:12 +0100
Subject: [PATCH v2] ARM: imx: Do L2 errata only if the L2 cache isn't enabled
Message-ID: <1455864612-12089-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the generic L2 cache handling code is encapsulated by a
check if the L2 cache is enabled. If it's enabled already, the code
is skipped. The write to the L2-Cache controller from non-secure
world causes an imprecise external abort. This is needed in
scenarios where one of the cores runs an other OS, e.g. an RTOS.

For the i.MX6 specific L2 cache handling we missed this check.
Add it.

Signed-off-by: Marcel Grosshans <MarcelViktor.Grosshans@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
Changes in v2: Update the commit message regarding the non-secure use case.

 arch/arm/mach-imx/system.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 51c3501..a600bd7 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -106,6 +106,9 @@ void __init imx_init_l2cache(void)
 		goto out;
 	}
 
+	if (readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)
+		goto skip_if_enabled;
+
 	/* Configure the L2 PREFETCH and POWER registers */
 	val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
 	val |= 0x70800000;
@@ -122,6 +125,7 @@ void __init imx_init_l2cache(void)
 		val &= ~(1 << 30 | 1 << 23);
 	writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
 
+skip_if_enabled:
 	iounmap(l2x0_base);
 	of_node_put(np);
 
-- 
2.5.0
