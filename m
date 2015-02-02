From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  2 Feb 2015 20:45:37 +0800
Subject: [PATCH v8 09/21] ARM64 / ACPI: Disable ACPI if FADT revision is less
 than 5.1
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1422881149-8177-10-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FADT Major.Minor version was introduced in ACPI 5.1, it is the same
as ACPI version.

In ACPI 5.1, some major gaps are fixed for ARM, such as updates in
MADT table for GIC and SMP init, without those updates, we can not
get the MPIDR for SMP init, and GICv2/3 related init information, so
we can't boot arm64 ACPI properly with table versions predating 5.1.

If firmware provides ACPI tables with ACPI version less than 5.1,
OS has no way to retrieve the configuration data that is necessary
to init SMP boot protocol and the GIC properly, so disable ACPI if
we get an FADT table with version less that 5.1.

CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index afe10b4..b9f64ec 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -13,6 +13,8 @@
  *  published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/cpumask.h>
@@ -49,10 +51,32 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
 	early_memunmap(map, size);
 }
 
+static int __init acpi_parse_fadt(struct acpi_table_header *table)
+{
+	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
+
+	/*
+	 * Revision in table header is the FADT Major revision, and there
+	 * is a minor revision of FADT which was introduced by ACPI 5.1,
+	 * we only deal with ACPI 5.1 or newer revision to get GIC and SMP
+	 * boot protocol configuration data, or we will disable ACPI.
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
@@ -64,8 +88,16 @@ void __init acpi_boot_table_init(void)
 		return;
 
 	/* Initialize the ACPI boot-time table parser. */
-	if (acpi_table_init())
+	if (acpi_table_init()) {
+		disable_acpi();
+		return;
+	}
+
+	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt)) {
+		/* disable ACPI if no FADT is found */
 		disable_acpi();
+		pr_err("Can't find FADT\n");
+	}
 }
 
 static int __init parse_acpi(char *arg)
-- 
1.9.1
