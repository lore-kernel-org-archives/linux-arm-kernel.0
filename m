From: tklauser@distanz.ch (Tobias Klauser)
Date: Wed, 16 Sep 2015 17:18:56 +0200
Subject: [PATCH] ARM: topology: Use of_property_read_u32 instead of
 open-coding it
Message-ID: <1442416736-10185-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_property_read_u32 to read the "clock-frequency" property instead
of using of_get_property with return value checks and endianness
conversion.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm/kernel/topology.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 08b7847..615a13c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -100,8 +100,7 @@ static void __init parse_dt_topology(void)
 				 GFP_NOWAIT);
 
 	for_each_possible_cpu(cpu) {
-		const u32 *rate;
-		int len;
+		u32 rate;
 
 		/* too early to use cpu->of_node */
 		cn = of_get_cpu_node(cpu, NULL);
@@ -117,14 +116,13 @@ static void __init parse_dt_topology(void)
 		if (cpu_eff->compatible == NULL)
 			continue;
 
-		rate = of_get_property(cn, "clock-frequency", &len);
-		if (!rate || len != 4) {
+		if (of_property_read_u32(cn, "clock-frequency", &rate)) {
 			pr_err("%s missing clock-frequency property\n",
 				cn->full_name);
 			continue;
 		}
 
-		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
+		capacity = (rate >> 20) * cpu_eff->efficiency;
 
 		/* Save min capacity of the system */
 		if (capacity < min_capacity)
-- 
2.5.0
