From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 12 Aug 2015 16:51:28 -0500
Subject: [PATCH 1/3] Honor ACPI _CCA attribute setting
In-Reply-To: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1439416290-21228-2-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI configurations can now mark devices as noncoherent,
support that choice.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/acpi/acpi_bus.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 83061ca..7ecb8e4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -399,7 +399,7 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
 	 * case 1. Do not support and disable DMA.
 	 * case 2. Support but rely on arch-specific cache maintenance for
 	 *         non-coherence DMA operations.
-	 * Currently, we implement case 1 above.
+	 * Currently, we implement case 2 above.
 	 *
 	 * For the case when _CCA is missing (i.e. cca_seen=0) and
 	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
@@ -407,7 +407,8 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
 	 *
 	 * See acpi_init_coherency() for more info.
 	 */
-	if (adev->flags.coherent_dma) {
+	if (adev->flags.coherent_dma ||
+	    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
 		ret = true;
 		if (coherent)
 			*coherent = adev->flags.coherent_dma;
-- 
2.4.3
