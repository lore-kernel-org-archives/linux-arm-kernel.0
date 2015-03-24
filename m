From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 24 Mar 2015 17:58:52 +0000
Subject: [PATCH 2/5] ARM64: kernel: psci: factor out probe function
In-Reply-To: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1427219940-27201-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSCI v0.2+ versions provide a specific PSCI call (PSCI_VERSION) to
detect the PSCI version at run-time. Current PSCI v0.2 init code
carries out the version probing in the PSCI 0.2 DT init function,
but the version probing does not depend on DT so it can be factored out
in order to make it available to other boot mechanisms (ie ACPI) to
reuse. The psci_probe() probing function can be easily extended
to add detection and initialization of PSCI functions defined in
PSCI versions >0.2.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/psci.c | 50 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index d3c52ce..2caac44 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -303,25 +303,19 @@ static void __init psci_0_2_set_functions(void)
 }
 
 /*
- * PSCI Function IDs for v0.2+ are well defined so use
- * standard values.
+ * Probe function for PSCI firmware versions >= 0.2
  */
-static int __init psci_0_2_init(struct device_node *np)
+static int __init psci_probe(void)
 {
-	int err, ver;
-
-	err = get_set_conduit_method(np);
-
-	if (err)
-		goto out_put_node;
-
-	ver = psci_get_version();
+	int ver = psci_get_version();
 
 	if (ver == PSCI_RET_NOT_SUPPORTED) {
-		/* PSCI v0.2 mandates implementation of PSCI_ID_VERSION. */
+		/*
+		 * PSCI versions >=0.2 mandates implementation of
+		 * PSCI_VERSION.
+		 */
 		pr_err("PSCI firmware does not comply with the v0.2 spec.\n");
-		err = -EOPNOTSUPP;
-		goto out_put_node;
+		return -EOPNOTSUPP;
 	} else {
 		pr_info("PSCIv%d.%d detected in firmware.\n",
 				PSCI_VERSION_MAJOR(ver),
@@ -329,14 +323,38 @@ static int __init psci_0_2_init(struct device_node *np)
 
 		if (PSCI_VERSION_MAJOR(ver) == 0 &&
 				PSCI_VERSION_MINOR(ver) < 2) {
-			err = -EINVAL;
 			pr_err("Conflicting PSCI version detected.\n");
-			goto out_put_node;
+			return -EINVAL;
 		}
 	}
 
 	psci_0_2_set_functions();
 
+	return 0;
+}
+
+/*
+ * PSCI init function for PSCI versions >=0.2
+ *
+ * Probe based on PSCI PSCI_VERSION function
+ */
+static int __init psci_0_2_init(struct device_node *np)
+{
+	int err;
+
+	err = get_set_conduit_method(np);
+
+	if (err)
+		goto out_put_node;
+	/*
+	 * Starting with v0.2, the PSCI specification introduced a call
+	 * (PSCI_VERSION) that allows probing the firmware version, so
+	 * that PSCI function IDs and version specific initialization
+	 * can be carried out according to the specific version reported
+	 * by firmware
+	 */
+	err = psci_probe();
+
 out_put_node:
 	of_node_put(np);
 	return err;
-- 
2.2.1
