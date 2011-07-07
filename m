From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:20 +0100
Subject: [RFC PATCH 07/17] ARM: kernel: save/restore v7 assembly helpers
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-8-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides v7 assembly functions to disable-clean-invalidate
D$ and programme the SCU CPU power status register.

The function to disable/clean/invalidate D$ is just a shim that
clears the C bit and jump to the respective function defined in proc
info.

SCU CPU power mode is there to programme the register from an MMU off
path where the C environment is not up and running.

Using scu_power_mode(...) is not possible, or at least hairy,
since it relies on the smp_processor_id() (so the kernel stack) to be up
and running, and it might not access any static data (since gcc inserts
virtual addresses constants into the code, making it impossible to call
when MMU is off and virtual translation is still not up and running).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/sr_v7_helpers.S |   47 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/sr_v7_helpers.S

diff --git a/arch/arm/kernel/sr_v7_helpers.S b/arch/arm/kernel/sr_v7_helpers.S
new file mode 100644
index 0000000..6443918
--- /dev/null
+++ b/arch/arm/kernel/sr_v7_helpers.S
@@ -0,0 +1,47 @@
+/*
+ * Copyright (c) 2008-2011 ARM Ltd
+ *
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+	.text
+	@ this function disables data caching, then cleans and invalidates
+	@ the whole data cache. Apart from the preamble to clear the C bit it
+	@ uses kernel flushing function provided for v7
+
+ENTRY(disable_clean_inv_dcache_v7_all)
+ ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
+
+	dsb
+	mrc	p15, 0, r3, c1, c0, 0
+	bic	r3, #4			   @ clear C bit
+	mcr	p15, 0, r3, c1, c0, 0
+	dsb
+
+	bl	v7_flush_dcache_all
+ ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
+	mov	pc, lr
+ENDPROC(disable_clean_inv_dcache_v7_all)
+
+	@ Resetting the SCU CPU power register when the MMU is off
+	@ must be done in assembly since the C environment is not
+	@ set-up yet
+ENTRY(scu_cpu_mode)
+	ALT_SMP(mrc p15, 0, r2, c0, c0, 5)
+	ALT_UP(mov r2, #0)
+	and	r2, r2, #15
+	strb	r1, [r0, r2]
+	mov	pc, lr
+ENDPROC(scu_cpu_mode)
+	.end
+
-- 
1.7.4.4
