From: maxime.coquelin-nonst@stericsson.com (Maxime Coquelin)
Date: Wed, 9 Mar 2011 17:59:21 +0100
Subject: [RFC PATCHv1 2/2] ux500: Export U8500 SoC info through sysfs
In-Reply-To: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
Message-ID: <1299689961-5028-3-git-send-email-maxime.coquelin-nonst@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST-Ericsson's U8500 implementation.
Register sysfs SoC interface, and export SoC ID, process and silicon revision
number.

Signed-off-by: Maxime COQUELIN <maxime.coquelin-nonst@stericsson.com>
---
 arch/arm/mach-ux500/id.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index d35122e..0d41c77 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -8,6 +8,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/sys_soc.h>
+#include <linux/slab.h>
 
 #include <asm/cputype.h>
 #include <asm/tlbflush.h>
@@ -105,3 +107,97 @@ void __init ux500_map_io(void)
 
 	ux500_print_soc_info(asicid);
 }
+
+
+#ifdef CONFIG_SYS_SOC
+#define U8500_BB_UID_BASE (U8500_BACKUPRAM1_BASE + 0xFC0)
+#define U8500_BB_UID_LENGTH 5
+
+#define UX500_SOC_INFO_SZ 64
+
+static char soc_id[UX500_SOC_INFO_SZ];
+static char revision[UX500_SOC_INFO_SZ];
+static char process[UX500_SOC_INFO_SZ];
+
+static char *ux500_get_soc_id(struct sys_soc_info *si)
+{
+	void __iomem *uid_base = __io_address(U8500_BB_UID_BASE);
+	int i, sz = 0;
+
+	if (dbx500_partnumber() == 0x8500) {
+		for (i = 0; i < U8500_BB_UID_LENGTH; i++)
+			sz += snprintf(soc_id + sz, UX500_SOC_INFO_SZ - sz, "%08x",
+					readl(uid_base + i * sizeof(u32)));
+	}
+	else {
+		/* Don't know where it is located for U5500 */
+		sprintf(soc_id, "N/A");
+	}
+
+	/*
+	 * As this key will never change, no need to read it anymore.
+	 */
+	si->info = soc_id;
+	return soc_id;
+}
+
+static char *ux500_get_revision(struct sys_soc_info *si)
+{
+	unsigned int rev = dbx500_revision();
+
+	if (rev == 0x01)
+		sprintf(revision, "%s", "ED");
+	else if (rev >= 0xA0)
+		sprintf(revision, "%d.%d" , (rev >> 4) - 0xA + 1, rev & 0xf);
+	else
+		sprintf(revision, "%s", "Unknown");
+
+	/*
+	 * As this key will never change, no need to read it anymore.
+	 */
+	si->info = revision;
+	return revision;
+}
+
+static char *ux500_get_process(struct sys_soc_info *si)
+{
+	if (dbx500_id.process == 0x00)
+		sprintf(process, "Standard");
+	else
+		sprintf(process, "%02xnm", dbx500_id.process);
+
+	/*
+	 * As this key will never change, no need to read it anymore.
+	 */
+	si->info = process;
+	return process;
+}
+
+static struct sys_soc_info soc_info[] = {
+	[0] = {
+		.name = "soc_id",
+		.get_info = ux500_get_soc_id,
+	},
+	[1] = {
+		.name = "revision",
+		.get_info = ux500_get_revision,
+	},
+	[2] = {
+		.name = "process",
+		.get_info = ux500_get_process,
+	},
+};
+
+static int __init ux500_sys_soc_init(void)
+{
+	char part_number[8];
+
+	sprintf(part_number, "DB%4x", dbx500_partnumber());
+	register_sys_soc(part_number, soc_info, ARRAY_SIZE(soc_info));
+
+	return 0;
+}
+
+module_init(ux500_sys_soc_init);
+#endif
+
-- 
1.7.1
