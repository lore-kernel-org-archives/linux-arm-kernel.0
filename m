From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 29 Nov 2016 12:43:34 -0600
Subject: [PATCH 2/2] ACPI: Ignore Consumer/Producer for QWord/DWord/Word
 Address Space
In-Reply-To: <20161129182415.7618.99129.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129182415.7618.99129.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20161129184334.7618.5495.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per ACPI spec r6.0, sec 6.4.3.5.1, 2, 3, Bit [0] of General Flags (the
Consumer/Producer bit) should be ignored for QWord/DWord/Word Address Space
descriptors.  The Consumer/Producer bit is defined only for the Extended
Address Space descriptor.

Ignore Consumer/Producer except for Extended Address Space descriptors.

Note that for QWord/DWord/Word descriptors, we previously applied the
translation offset (_TRA) only when the Consumer/Producer bit was set.
This patch changes that: for those descriptors, we ignore Consumer/Producer
and always apply the translation offset.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/resource.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 2732d39e..b45cd8f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -261,11 +261,16 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 	 * primary side. Non-bridge devices must list 0 for all Address
 	 * Translation offset bits.
 	 */
-	if (addr->producer_consumer == ACPI_PRODUCER)
+	if (ares->type == ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64) {
+		if (addr->producer_consumer == ACPI_PRODUCER)
+			offset = attr->translation_offset;
+		else if (attr->translation_offset)
+			pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
+				 attr->translation_offset);
+	} else {
 		offset = attr->translation_offset;
-	else if (attr->translation_offset)
-		pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
-			 attr->translation_offset);
+	}
+
 	start = attr->minimum + offset;
 	end = attr->maximum + offset;
 
@@ -294,7 +299,8 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 		return false;
 	}
 
-	if (addr->producer_consumer == ACPI_PRODUCER)
+	if (ares->type == ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64 &&
+	    addr->producer_consumer == ACPI_PRODUCER)
 		res->flags |= IORESOURCE_WINDOW;
 
 	if (addr->info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
