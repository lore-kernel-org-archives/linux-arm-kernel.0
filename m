From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 10 Mar 2015 15:18:53 +0000
Subject: [PATCH 3/5] arm-cci: Get rid of secure transactions for PMU driver
In-Reply-To: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1426000735-14375-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Avoid secure transactions while probing the CCI PMU. The
existing code makes use of the Peripheral ID2 (PID2) register
to determine the revision of the CCI400, which requires a
secure transaction. This puts a limitation on the usage of the
driver on systems running non-secure Linux(e.g, ARM64).

Updated the device-tree binding for cci pmu node to add the explicit
revision number for the compatible field.

The supported strings are :
	arm,cci-400-pmu,r0
	arm,cci-400-pmu,r1
	arm,cci-400-pmu - DEPRECATED. See NOTE below

NOTE: If the revision is not mentioned, we need to probe the cci revision,
which could be fatal on a platform running non-secure. We need a reliable way
to know if we can poke the CCI registers at runtime on ARM32. We depend on
'mcpm_is_available()' when it is available. mcpm_is_available() returns true
only when there is a registered driver for mcpm. Otherwise, we assume that we
don't have secure access, and skips probing the revision number(ARM64 case).

The MCPM should figure out if it is safe to access the CCI. Unfortunately
there isn't a reliable way to indicate the same via dtb. This patch doesn't
address/change the current situation. It only deals with the CCI-PMU, leaving
the assumptions about the secure access as it has been, prior to this patch.

Changes since V2:
 - Use 'bool' instead of 'int' for platform_has_secure_cci_access().
   (Suggested-by: Sudeep Holla)

Cc: devicetree at vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 Documentation/devicetree/bindings/arm/cci.txt |    7 +++--
 arch/arm/include/asm/arm-cci.h                |   42 +++++++++++++++++++++++++
 arch/arm64/include/asm/arm-cci.h              |   27 ++++++++++++++++
 drivers/bus/arm-cci.c                         |   17 +++++++++-
 include/linux/arm-cci.h                       |    2 ++
 5 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/arm-cci.h
 create mode 100644 arch/arm64/include/asm/arm-cci.h

diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
index f28d82b..0e4b6a7 100644
--- a/Documentation/devicetree/bindings/arm/cci.txt
+++ b/Documentation/devicetree/bindings/arm/cci.txt
@@ -94,8 +94,11 @@ specific to ARM.
 		- compatible
 			Usage: required
 			Value type: <string>
-			Definition: must be "arm,cci-400-pmu"
-
+			Definition: Supported strings are :
+				 "arm,cci-400-pmu,r0"
+				 "arm,cci-400-pmu,r1"
+				 "arm,cci-400-pmu"  - DEPRECATED, permitted only where OS has
+						      secure acces to CCI registers
 		- reg:
 			Usage: required
 			Value type: Integer cells. A register entry, expressed
diff --git a/arch/arm/include/asm/arm-cci.h b/arch/arm/include/asm/arm-cci.h
new file mode 100644
index 0000000..fe77f7a
--- /dev/null
+++ b/arch/arm/include/asm/arm-cci.h
@@ -0,0 +1,42 @@
+/*
+ * arch/arm/include/asm/arm-cci.h
+ *
+ * Copyright (C) 2015 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_ARM_CCI_H
+#define __ASM_ARM_CCI_H
+
+#ifdef CONFIG_MCPM
+#include <asm/mcpm.h>
+
+/*
+ * We don't have a reliable way of detecting whether,
+ * if we have access to secure-only registers, unless
+ * mcpm is registered.
+ */
+static inline bool platform_has_secure_cci_access(void)
+{
+	return mcpm_is_available();
+}
+
+#else
+static inline bool platform_has_secure_cci_access(void)
+{
+	return false;
+}
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/arm-cci.h b/arch/arm64/include/asm/arm-cci.h
new file mode 100644
index 0000000..f0b6371
--- /dev/null
+++ b/arch/arm64/include/asm/arm-cci.h
@@ -0,0 +1,27 @@
+/*
+ * arch/arm64/include/asm/arm-cci.h
+ *
+ * Copyright (C) 2015 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_ARM_CCI_H
+#define __ASM_ARM_CCI_H
+
+static inline bool platform_has_secure_cci_access(void)
+{
+	return false;
+}
+
+#endif
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index f88383e..70dff09 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -217,7 +217,9 @@ static int probe_cci_revision(void)
 
 static const struct cci_pmu_model *probe_cci_model(struct platform_device *pdev)
 {
-	return &cci_pmu_models[probe_cci_revision()];
+	if (platform_has_secure_cci_access())
+		return &cci_pmu_models[probe_cci_revision()];
+	return NULL;
 }
 
 static int pmu_is_valid_counter(struct cci_pmu *cci_pmu, int idx)
@@ -873,6 +875,15 @@ static struct cci_pmu_model cci_pmu_models[] = {
 static const struct of_device_id arm_cci_pmu_matches[] = {
 	{
 		.compatible = "arm,cci-400-pmu",
+		.data	= NULL,
+	},
+	{
+		.compatible = "arm,cci-400-pmu,r0",
+		.data	= &cci_pmu_models[CCI_REV_R0],
+	},
+	{
+		.compatible = "arm,cci-400-pmu,r1",
+		.data	= &cci_pmu_models[CCI_REV_R1],
 	},
 	{},
 };
@@ -883,7 +894,11 @@ static inline const struct cci_pmu_model *get_cci_model(struct platform_device *
 							pdev->dev.of_node);
 	if (!match)
 		return NULL;
+	if (match->data)
+		return match->data;
 
+	dev_warn(&pdev->dev, "DEPERCATED compatible property,"
+			 "requires secure access to CCI registers");
 	return probe_cci_model(pdev);
 }
 
diff --git a/include/linux/arm-cci.h b/include/linux/arm-cci.h
index 79d6edf..aede5c7 100644
--- a/include/linux/arm-cci.h
+++ b/include/linux/arm-cci.h
@@ -24,6 +24,8 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
+#include <asm/arm-cci.h>
+
 struct device_node;
 
 #ifdef CONFIG_ARM_CCI
-- 
1.7.9.5
