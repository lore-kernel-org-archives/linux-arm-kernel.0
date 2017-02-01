From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 1 Feb 2017 15:01:05 -0800
Subject: [PATCH] arm64: make use of for_each_node_by_type()
Message-ID: <20170201230105.GA32086@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of open-coding the loop, let's use canned macro.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This will also be needed if I manage to make of_find_node_by_type() stop
dropping reference to starting node as it is quite unexpected thing to
do.

 arch/arm64/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index cb87234cfcf2..a8ec5da530af 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -603,9 +603,9 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
  */
 static void __init of_parse_and_init_cpus(void)
 {
-	struct device_node *dn = NULL;
+	struct device_node *dn;
 
-	while ((dn = of_find_node_by_type(dn, "cpu"))) {
+	for_each_node_by_type(dn, "cpu") {
 		u64 hwid = of_get_cpu_mpidr(dn);
 
 		if (hwid == INVALID_HWID)
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
