From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 27 Jun 2014 11:49:29 +0800
Subject: [PATCH v4 06/13] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1403840976-7456-7-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

Introduce two early parameters for "acpi", one is the parameter
to disable ACPI on ARM64 and another one is acpi=strict to disable
out-of-spec workarounds.

Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 Documentation/kernel-parameters.txt |    3 ++-
 drivers/acpi/plat/arm-core.c        |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 8849049..b7e9fc0 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -165,7 +165,7 @@ multipliers 'Kilo', 'Mega', and 'Giga', equalling 2^10, 2^20, and 2^30
 bytes respectively. Such letter suffixes can also be entirely omitted.
 
 
-	acpi=		[HW,ACPI,X86]
+	acpi=		[HW,ACPI,X86,ARM]
 			Advanced Configuration and Power Interface
 			Format: { force | off | strict | noirq | rsdt }
 			force -- enable ACPI if default was off
@@ -175,6 +175,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
 			copy_dsdt -- copy DSDT to memory
+			For ARM64, ONLY "off" and "strict" are available.
 
 			See also Documentation/power/runtime_pm.txt, pci=noacpi
 
diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
index c6c7e03..cf46c25 100644
--- a/drivers/acpi/plat/arm-core.c
+++ b/drivers/acpi/plat/arm-core.c
@@ -108,3 +108,24 @@ void __init acpi_boot_table_init(void)
 		return;
 	}
 }
+
+static int __init parse_acpi(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	/* "acpi=off" disables both ACPI table parsing and interpreter */
+	if (strcmp(arg, "off") == 0) {
+		disable_acpi();
+	}
+	/* acpi=strict disables out-of-spec workarounds */
+	else if (strcmp(arg, "strict") == 0) {
+		acpi_strict = 1;
+	} else {
+		/* Core will printk when we return error */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("acpi", parse_acpi);
-- 
1.7.9.5
