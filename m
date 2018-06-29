From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 Jun 2018 17:17:57 +0100
Subject: [PATCH] ACPI/PPTT: use ACPI ID whenever
 ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
Message-ID: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we use the ACPI processor ID only for the leaf/processor nodes
as the specification states it must match the value of ACPI processor ID
field in the processor?s entry in the MADT.

However, if a PPTT structure represents processors group, it match a
processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
flag describe whether the ACPI processor ID is valid.

Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
consistent instead of using table offset as it's currently done for non
leaf nodes.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/pptt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Hi,

There's ongoing discussion on assigning ID based in OS using simple
counters. It can never be consistent with firmware's view. So if the
firmware provides valid UID for non-processors node, we must use it.

Regards,
Sudeep

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index e5ea1974d1e3..d1e26cb599bf 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -481,8 +481,14 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 	if (cpu_node) {
 		cpu_node = acpi_find_processor_package_id(table, cpu_node,
 							  level, flag);
-		/* Only the first level has a guaranteed id */
-		if (level == 0)
+		/*
+		 * As per specification if the processor structure represents
+		 * an actual processor, then ACPI processor ID must be valid.
+		 * For processor containers ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
+		 * should be set if the UID is valid
+		 */
+		if (level == 0 ||
+		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
 			return cpu_node->acpi_processor_id;
 		return ACPI_PTR_DIFF(cpu_node, table);
 	}
-- 
2.7.4
