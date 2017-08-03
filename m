From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  3 Aug 2017 13:32:35 +0100
Subject: [PATCH v3 1/5] ACPICA: resource_mgr: Allow _DMA method in walk
 resources
In-Reply-To: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
References: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170803123239.11359-2-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPICA commit 7636d2fb683d5699a5c14e949fba9ac52e91d4c1

The _DMA object contains a resource template, this change adds support
for the walk resources function so that ACPI devices containing a _DMA
object can actually parse it to detect DMA ranges for the respective
bus.

Link: https://github.com/acpica/acpica/commit/7636d2fb
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/acpica/rsxface.c | 7 ++++---
 include/acpi/acnames.h        | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 59a4f9e..be65e65 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -615,7 +615,7 @@ ACPI_EXPORT_SYMBOL(acpi_walk_resource_buffer)
  *                                device we are querying
  *              name            - Method name of the resources we want.
  *                                (METHOD_NAME__CRS, METHOD_NAME__PRS, or
- *                                METHOD_NAME__AEI)
+ *                                METHOD_NAME__AEI or METHOD_NAME__DMA)
  *              user_function   - Called for each resource
  *              context         - Passed to user_function
  *
@@ -641,11 +641,12 @@ acpi_walk_resources(acpi_handle device_handle,
 	if (!device_handle || !user_function || !name ||
 	    (!ACPI_COMPARE_NAME(name, METHOD_NAME__CRS) &&
 	     !ACPI_COMPARE_NAME(name, METHOD_NAME__PRS) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI))) {
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI) &&
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__DMA))) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Get the _CRS/_PRS/_AEI resource list */
+	/* Get the _CRS/_PRS/_AEI/_DMA resource list */
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
 	status = acpi_rs_get_method_data(device_handle, name, &buffer);
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index b421584..d8dd3bf 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -54,6 +54,7 @@
 #define METHOD_NAME__CLS        "_CLS"
 #define METHOD_NAME__CRS        "_CRS"
 #define METHOD_NAME__DDN        "_DDN"
+#define METHOD_NAME__DMA        "_DMA"
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__INI        "_INI"
 #define METHOD_NAME__PLD        "_PLD"
-- 
2.10.0
