From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  1 Feb 2018 18:34:59 +0900
Subject: [PATCH 2/2] lkdtm: fix irq handler entry for arm64
In-Reply-To: <20180201093459.20477-1-takahiro.akashi@linaro.org>
References: <20180201093459.20477-1-takahiro.akashi@linaro.org>
Message-ID: <20180201093459.20477-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm64 doesn't have "do_IRQ" function, instead *handle_arch_irq, which is
initialized by irq chip (gic), is called from exception entry.
This patch fixes this problem.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/misc/lkdtm_core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index ba92291508dc..e20343543053 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -249,13 +249,29 @@ static int lkdtm_register_cpoint(struct crashpoint *crashpoint,
 	if (lkdtm_kprobe != NULL)
 		unregister_kprobe(lkdtm_kprobe);
 
+	if (IS_ENABLED(CONFIG_ARM64) &&
+			!strcmp(crashpoint->name, "INT_HARDWARE_ENTRY")) {
+		extern void (*handle_arch_irq)(struct pt_regs *regs);
+
+		crashpoint->kprobe.addr = (kprobe_opcode_t *)*handle_arch_irq;
+		/*
+		 * Instantiating kprobe.symbol_name here, say
+		 * with lookup_symbol_name(*handle_arch_irq),
+		 * would cause register_kprobe() to fail.
+		 */
+		crashpoint->kprobe.symbol_name = NULL;
+	}
 	lkdtm_crashpoint = crashpoint;
 	lkdtm_crashtype = crashtype;
 	lkdtm_kprobe = &crashpoint->kprobe;
 	ret = register_kprobe(lkdtm_kprobe);
 	if (ret < 0) {
-		pr_info("Couldn't register kprobe %s\n",
-			crashpoint->kprobe.symbol_name);
+		if (IS_ENABLED(CONFIG_ARM64))
+			pr_info("Couldn't register kprobe 0x%lx\n",
+				(unsigned long)crashpoint->kprobe.addr);
+		else
+			pr_info("Couldn't register kprobe %s\n",
+				crashpoint->kprobe.symbol_name);
 		lkdtm_kprobe = NULL;
 		lkdtm_crashpoint = NULL;
 		lkdtm_crashtype = NULL;
-- 
2.15.1
