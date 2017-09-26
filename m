From: ahs3@redhat.com (Al Stone)
Date: Tue, 26 Sep 2017 16:23:24 -0600
Subject: [PATCH 3/3] arm64: cpuinfo: display product info in /proc/cpuinfo
In-Reply-To: <20170926222324.17409-1-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
Message-ID: <20170926222324.17409-4-ahs3@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While it is very useful to know what CPU is being used, it is also
useful to know who made the platform being used.  On servers, this
can point to the right person to contact when a server is having
trouble.

Go get the product info -- manufacturer, product name and version --
from DMI (aka SMBIOS) and display it in /proc/cpuinfo.  To look more
like other server platforms, include the CPU type and frequency when
displaying the product info, too.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/cpuinfo.c | 135 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 0b4261884862..6a9dbad5ee3f 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -19,10 +19,12 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/unaligned.h>
 
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/compat.h>
+#include <linux/dmi.h>
 #include <linux/elf.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -31,6 +33,7 @@
 #include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/cpuinfo.h>
@@ -167,6 +170,111 @@ static const char *const compat_hwcap2_str[] = {
 };
 #endif /* CONFIG_COMPAT */
 
+/* Details needed when extracting fields from DMI info */
+#define DMI_ENTRY_BASEBOARD_MIN_LENGTH	8
+#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
+
+#define DMI_BASEBOARD_MANUFACTURER	0x04
+#define DMI_BASEBOARD_PRODUCT		0x05
+#define DMI_BASEBOARD_VERSION		0x06
+#define DMI_PROCESSOR_MAX_SPEED		0x14
+
+#define DMI_MAX_STRLEN			80
+
+/* Values captured from DMI info */
+static u64 dmi_max_mhz;
+static char *dmi_product_info;
+
+/* Callback function used to retrieve the max frequency from DMI */
+static void find_dmi_mhz(const struct dmi_header *dm, void *private)
+{
+	const u8 *dmi_data = (const u8 *)dm;
+	u16 *mhz = (u16 *)private;
+
+	if (dm->type == DMI_ENTRY_PROCESSOR &&
+	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
+		u16 val = (u16)get_unaligned((const u16 *)
+				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
+		*mhz = val > *mhz ? val : *mhz;
+	}
+}
+
+/* Look up the max frequency in DMI */
+static u64 get_dmi_max_mhz(void)
+{
+	u16 mhz = 0;
+
+	dmi_walk(find_dmi_mhz, &mhz);
+
+	/*
+	 * Real stupid fallback value, just in case there is no
+	 * actual value set.
+	 */
+	mhz = mhz ? mhz : 1;
+
+	return (u64)mhz;
+}
+
+/* Helper function for the product info callback */
+static char *copy_string_n(char *dst, char *table, int idx)
+{
+	char *d = dst;
+	char *ptr = table;
+	int ii;
+
+	/* skip the first idx-1 strings */
+	for (ii = 1; ii < idx; ii++) {
+		while (*ptr)
+			ptr++;
+		ptr++;
+	}
+
+	/* copy in the string we need */
+	while (*ptr && (d - dst) < (DMI_MAX_STRLEN - 2))
+		*d++ = *ptr++;
+
+	return d;
+}
+
+/* Callback function used to retrieve the product info DMI */
+static void find_dmi_product_info(const struct dmi_header *dm, void *private)
+{
+	const u8 *dmi_data = (const u8 *)dm;
+	char *ptr = (char *)private;
+
+	if (dm->type == DMI_ENTRY_BASEBOARD &&
+	    dm->length >= DMI_ENTRY_BASEBOARD_MIN_LENGTH) {
+		int idx;
+
+		idx = (int)get_unaligned((const u8 *)
+				(dmi_data + DMI_BASEBOARD_MANUFACTURER));
+		ptr = copy_string_n(ptr, (char *)(dmi_data + dm->length), idx);
+		*ptr++ = ' ';
+
+		idx = (int)get_unaligned((const u8 *)
+				(dmi_data + DMI_BASEBOARD_PRODUCT));
+		ptr = copy_string_n(ptr, (char *)(dmi_data + dm->length), idx);
+		*ptr++ = ' ';
+
+		idx = (int)get_unaligned((const u8 *)
+				(dmi_data + DMI_BASEBOARD_VERSION));
+		ptr = copy_string_n(ptr, (char *)(dmi_data + dm->length), idx);
+	}
+}
+
+/* Look up the baseboard info in DMI */
+static void get_dmi_product_info(void)
+{
+	if (!dmi_product_info) {
+		dmi_product_info = kcalloc(DMI_MAX_STRLEN,
+					   sizeof(char), GFP_KERNEL);
+		if (!dmi_product_info)
+			return;
+	}
+
+	dmi_walk(find_dmi_product_info, dmi_product_info);
+}
+
 static int c_show(struct seq_file *m, void *v)
 {
 	int i, j;
@@ -190,6 +298,31 @@ static int c_show(struct seq_file *m, void *v)
 			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
 				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
 
+		if (IS_ENABLED(CONFIG_DMI)) {
+			seq_puts(m, "product name\t: ");
+
+			if (!dmi_product_info)
+				get_dmi_product_info();
+			if (dmi_product_info)
+				seq_printf(m, "%s", dmi_product_info);
+			else
+				seq_puts(m, "<unknown>");
+
+			seq_printf(m, ", ARM 8.%d (r%dp%d) CPU",
+				   MIDR_VARIANT(midr),
+				   MIDR_VARIANT(midr),
+				   MIDR_REVISION(midr));
+
+			if (!dmi_max_mhz)
+				dmi_max_mhz = get_dmi_max_mhz();
+			if (dmi_max_mhz)
+				seq_printf(m, " @ %d.%02dGHz\n",
+					   (int)(dmi_max_mhz / 1000),
+					   (int)(dmi_max_mhz % 1000));
+			else
+				seq_puts(m, " @ <unknown>GHz\n");
+		}
+
 		impl = (u8) MIDR_IMPLEMENTOR(midr);
 		for (j = 0; hw_implementer[j].id != 0; j++) {
 			if (hw_implementer[j].id == impl) {
@@ -208,7 +341,7 @@ static int c_show(struct seq_file *m, void *v)
 		part = (u16) MIDR_PARTNUM(midr);
 		for (j = 0; parts[j].id != (-1); j++) {
 			if (parts[j].id == part) {
-				seq_printf(m, "%s\n", parts[j].name);
+				seq_printf(m, "%s ", parts[j].name);
 				break;
 			}
 		}
-- 
2.13.5
