From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 28 Feb 2018 13:57:43 +0900
Subject: [PATCH v2 2/3] lkdtm: handle unresolved name for probing
In-Reply-To: <20180228045744.12914-1-takahiro.akashi@linaro.org>
References: <20180228045744.12914-1-takahiro.akashi@linaro.org>
Message-ID: <20180228045744.12914-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since arm64 doesn't have "do_IRQ" function, INT_HARDWARE_ENTRY just doesn't
work.

This patch provides a generalized approach for handling such an unresolved
name for probing. Currently we handle only INT_HARDWARE_ENTRY, but may
extend this workaround for others, if applicable, in the future.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/misc/lkdtm_core.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index 2154d1bfd18b..737e7e0f50f4 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -39,6 +39,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/hrtimer.h>
+#include <linux/kallsyms.h>
 #include <linux/slab.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/debugfs.h>
@@ -235,6 +236,9 @@ static noinline void lkdtm_do_action(const struct crashtype *crashtype)
 	crashtype->func();
 }
 
+/* Architecture may overwrite this. */
+unsigned long __weak get_handle_irq(void) { return 0; }
+
 static int lkdtm_register_cpoint(struct crashpoint *crashpoint,
 				 const struct crashtype *crashtype)
 {
@@ -249,13 +253,38 @@ static int lkdtm_register_cpoint(struct crashpoint *crashpoint,
 	if (lkdtm_kprobe != NULL)
 		unregister_kprobe(lkdtm_kprobe);
 
+	if (!kallsyms_lookup_name(crashpoint->kprobe.symbol_name)) {
+		/* This symbol is not arhcitecture agnostic. */
+		if (!strcmp(crashpoint->name, "INT_HARDWARE_ENTRY")) {
+			unsigned long func;
+
+			func = get_handle_irq();
+			if (func) {
+				crashpoint->kprobe.addr =
+						(kprobe_opcode_t *)func;
+				/*
+				 * Instantiating kprobe.symbol_name here, say
+				 * with lookup_symbol_name(*handle_arch_irq),
+				 * would cause register_kprobe() to fail.
+				 */
+				crashpoint->kprobe.symbol_name = NULL;
+			} else {
+				pr_info("Couldn't find a function for INT_HARDWARE_ENTRY\n");
+				return -EINVAL;
+			}
+		}
+	}
 	lkdtm_crashpoint = crashpoint;
 	lkdtm_crashtype = crashtype;
 	lkdtm_kprobe = &crashpoint->kprobe;
 	ret = register_kprobe(lkdtm_kprobe);
 	if (ret < 0) {
-		pr_info("Couldn't register kprobe %s\n",
-			crashpoint->kprobe.symbol_name);
+		if (crashpoint->kprobe.symbol_name)
+			pr_info("Couldn't register kprobe %s\n",
+				crashpoint->kprobe.symbol_name);
+		else
+			pr_info("Couldn't register kprobe 0x%lx\n",
+				(unsigned long)crashpoint->kprobe.addr);
 		lkdtm_kprobe = NULL;
 		lkdtm_crashpoint = NULL;
 		lkdtm_crashtype = NULL;
-- 
2.16.2
