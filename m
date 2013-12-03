From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed,  4 Dec 2013 00:39:09 +0800
Subject: [RFC part2 PATCH 5/9] ACPI: Define ACPI_IRQ_MODEL_GIC needed for arm
In-Reply-To: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1386088753-2850-6-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Needed because arm uses GIC which is defined in ACPI 5.0 spec.

Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/bus.c           |    3 +++
 drivers/acpi/plat/arm-core.c |    6 +++++-
 include/linux/acpi.h         |    1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a79273a..b1fed60 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -410,6 +410,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_IOSAPIC:
 		message = "IOSAPIC";
 		break;
+	case ACPI_IRQ_MODEL_GIC:
+		message = "GIC";
+		break;
 	case ACPI_IRQ_MODEL_PLATFORM:
 		message = "platform specific model";
 		break;
diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
index c4c8c68..9cc0208 100644
--- a/drivers/acpi/plat/arm-core.c
+++ b/drivers/acpi/plat/arm-core.c
@@ -82,7 +82,11 @@ EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
  * Boot-time Configuration
  */
 
-enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
+/*
+ * Since we're on ARM, the default interrupt routing model
+ * clearly has to be GIC.
+ */
+enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 
 static unsigned int gsi_to_irq(unsigned int gsi)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 115c610..1e6a0ac 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -69,6 +69,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_IOAPIC,
 	ACPI_IRQ_MODEL_IOSAPIC,
 	ACPI_IRQ_MODEL_PLATFORM,
+	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
1.7.9.5
