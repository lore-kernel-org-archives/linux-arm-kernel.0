From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:35:52 +0900
Subject: [PATCH 13/14] ARM: shmobile: Extend APMU code to allow single cluster
 only
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
Message-ID: <ee490bcc4f2d456c40df93236cf6a1bce2d5ddd0.1380532277.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Extend the APMU code with a check to only allow boot
of CPU cores that sit in the same cluster as CPU0.

This makes it possible for people to use the r8a790
CA7 boot mode with CA7-cores only. The default CA15
boot mode will enable CA15 cores only. This is an
intentional software limitation to cope with lacking
scheduler support.

By removing this patch it is possible to run all 8 cores
in parallel, but this is not recommended without out of tree
scheduler modfications or custom user space code to control
the CPU affinitiy.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 34dc40d..caaaa35 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -94,8 +94,21 @@ static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit))
 	u32 id;
 	int k;
 	int bit, index;
+	bool is_allowed;
 
 	for (k = 0; k < ARRAY_SIZE(apmu_config); k++) {
+		/* only enable the cluster that includes the boot CPU */
+		is_allowed = false;
+		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
+			id = apmu_config[k].cpus[bit];
+			if (id >= 0) {
+				if (id == cpu_logical_map(0))
+					is_allowed = true;
+			}
+		}
+		if (!is_allowed)
+			continue;
+
 		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
 			id = apmu_config[k].cpus[bit];
 			if (id >= 0) {
-- 
1.8.4
