From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  1 Sep 2014 22:57:42 +0800
Subject: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

Introduce one early parameters "off" for "acpi" to disable ACPI on
ARM64.

Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 Documentation/kernel-parameters.txt |    3 ++-
 arch/arm64/kernel/acpi.c            |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5ae8608..9dfb1d8 100644
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
+			For ARM64, ONLY "acpi=off" is available.
 
 			See also Documentation/power/runtime_pm.txt, pci=noacpi
 
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index b6940a0..9547275 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -74,3 +74,18 @@ void __init acpi_boot_table_init(void)
  * TBD when ARM/ARM64 starts to support suspend...
  */
 int (*acpi_suspend_lowlevel)(void) = NULL;
+
+static int __init parse_acpi(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	/* "acpi=off" disables both ACPI table parsing and interpreter */
+	if (strcmp(arg, "off") == 0)
+		disable_acpi();
+	else
+		return -EINVAL;	/* Core will print when we return error */
+
+	return 0;
+}
+early_param("acpi", parse_acpi);
-- 
1.7.9.5
