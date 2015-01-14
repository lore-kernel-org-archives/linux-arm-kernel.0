From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 14 Jan 2015 23:04:55 +0800
Subject: [PATCH v7 07/17] ARM64 / ACPI: Disable ACPI if FADT revision is less
 than 5.1
In-Reply-To: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FADT Major.Minor version was introduced in ACPI 5.1, it is the same
as ACPI version.

In ACPI 5.1, some major gaps are fixed for ARM, such as updates in
MADT table for GIC and SMP init, without those updates, we can not
get the MPIDR for SMP init, and GICv2/3 related init information, so
we can't boot arm64 ACPI properly with table versions predating 5.1.

If firmware provides ACPI tables with ACPI version less than 5.1,
OS will be messed up with those information and have no way to init
smp and GIC, so disable ACPI if we get an FADT table with version
less that 5.1.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 39a1655..4177758 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -13,6 +13,8 @@
  *  published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/cpumask.h>
@@ -49,10 +51,32 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
 	early_memunmap(map, size);
 }
 
+static int __init acpi_parse_fadt(struct acpi_table_header *table)
+{
+	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
+
+	/*
+	 * Revision in table header is the FADT Major revision,
+	 * and there is a minor revision of FADT which was introduced
+	 * by ACPI 5.1, we only deal with ACPI 5.1 or newer revision
+	 * to get arm boot flags, or we will disable ACPI.
+	 */
+	if (table->revision > 5 ||
+	    (table->revision == 5 && fadt->minor_revision >= 1))
+		return 0;
+
+	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
+		table->revision, fadt->minor_revision);
+	disable_acpi();
+
+	return -EINVAL;
+}
+
 /*
  * acpi_boot_table_init() called from setup_arch(), always.
  *	1. find RSDP and get its address, and then find XSDT
  *	2. extract all tables and checksums them all
+ *	3. check ACPI FADT revision
  *
  * We can parse ACPI boot-time tables such as MADT after
  * this function is called.
@@ -64,8 +88,13 @@ void __init acpi_boot_table_init(void)
 		return;
 
 	/* Initialize the ACPI boot-time table parser. */
-	if (acpi_table_init())
+	if (acpi_table_init()) {
 		disable_acpi();
+		return;
+	}
+
+	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt))
+		pr_err("Can't find FADT or error happened during parsing FADT\n");
 }
 
 static int __init parse_acpi(char *arg)
-- 
1.9.1
