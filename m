From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 20:25:07 +0800
Subject: [PATCH 13/20] ARM64 / ACPI: Define ACPI_IRQ_MODEL_GIC needed for arm
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1389961514-13562-14-git-send-email-hanjun.guo@linaro.org>
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
index 0710004..246b40c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -487,6 +487,9 @@ static int __init acpi_bus_init_irq(void)
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
index 7f1d709..2ff00b0 100644
--- a/drivers/acpi/plat/arm-core.c
+++ b/drivers/acpi/plat/arm-core.c
@@ -76,7 +76,11 @@ void arch_fix_phys_package_id(int num, u32 slot)
 }
 EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
 
-enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
+/*
+ * Since we're on ARM, the default interrupt routing model
+ * clearly has to be GIC.
+ */
+enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 
 static unsigned int gsi_to_irq(unsigned int gsi)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d9099b1..da55da2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -63,6 +63,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_IOAPIC,
 	ACPI_IRQ_MODEL_IOSAPIC,
 	ACPI_IRQ_MODEL_PLATFORM,
+	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
1.7.9.5
