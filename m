From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jun 2014 21:56:19 +0200
Subject: [PATCH RESEND 1/2] ARM: topology: Use a clock if possible to get the
 CPU frequency
In-Reply-To: <1403034980-19112-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1403034980-19112-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1403034980-19112-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A7 and Cortex-A15 based SoCs need a clock-frequency property in the
topology code.

Allow to use a clock to provide the same information.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/kernel/topology.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 9d853189028b..0bd044cbbcb2 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
@@ -100,8 +101,8 @@ static void __init parse_dt_topology(void)
 				 GFP_NOWAIT);
 
 	for_each_possible_cpu(cpu) {
-		const u32 *rate;
-		int len;
+		struct clk *clk;
+		u32 rate = 0;
 
 		/* too early to use cpu->of_node */
 		cn = of_get_cpu_node(cpu, NULL);
@@ -117,14 +118,23 @@ static void __init parse_dt_topology(void)
 		if (cpu_eff->compatible == NULL)
 			continue;
 
-		rate = of_get_property(cn, "clock-frequency", &len);
-		if (!rate || len != 4) {
-			pr_err("%s missing clock-frequency property\n",
-				cn->full_name);
+		clk = of_clk_get(cn, 0);
+		if (!IS_ERR(clk)) {
+			rate = clk_get_rate(clk);
+		} else {
+			if (of_property_read_u32(cn, "clock-frequency", &rate)) {
+				pr_err("%s missing clocks or clock-frequency properties\n",
+				       cn->full_name);
+				continue;
+			}
+		}
+
+		if (!rate) {
+			pr_err("%s invalid CPU frequency", cn->full_name);
 			continue;
 		}
 
-		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
+		capacity = ((rate) >> 20) * cpu_eff->efficiency;
 
 		/* Save min capacity of the system */
 		if (capacity < min_capacity)
-- 
2.0.0
