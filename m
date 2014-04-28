From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:30:42 +0100
Subject: [PATCH 53/97] ARM: l2c: provide common PL310 early resume code
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerGE-0001XH-PW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Makefile          |  2 +-
 arch/arm/mm/l2c-l2x0-resume.S | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mm/l2c-l2x0-resume.S

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index de5a6a27081b..91da64de440f 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -97,6 +97,6 @@ AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
 
 obj-$(CONFIG_OUTER_CACHE)	+= l2c-common.o
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
-obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
+obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o l2c-l2x0-resume.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
 obj-$(CONFIG_CACHE_TAUROS2)	+= cache-tauros2.o
diff --git a/arch/arm/mm/l2c-l2x0-resume.S b/arch/arm/mm/l2c-l2x0-resume.S
new file mode 100644
index 000000000000..99b05f21a59a
--- /dev/null
+++ b/arch/arm/mm/l2c-l2x0-resume.S
@@ -0,0 +1,58 @@
+/*
+ * L2C-310 early resume code.  This can be used by platforms to restore
+ * the settings of their L2 cache controller before restoring the
+ * processor state.
+ *
+ * This code can only be used to if you are running in the secure world.
+ */
+#include <linux/linkage.h>
+#include <asm/hardware/cache-l2x0.h>
+
+	.text
+
+ENTRY(l2c310_early_resume)
+	adr	r0, 1f
+	ldr	r2, [r0]
+	add	r0, r2, r0
+
+	ldmia	r0, {r1, r2, r3, r4, r5, r6, r7, r8}
+	@ r1 = phys address of L2C-310 controller
+	@ r2 = aux_ctrl
+	@ r3 = tag_latency
+	@ r4 = data_latency
+	@ r5 = filter_start
+	@ r6 = filter_end
+	@ r7 = prefetch_ctrl
+	@ r8 = pwr_ctrl
+
+	@ Check that the address has been initialised
+	teq	r1, #0
+	moveq	pc, lr
+
+	@ The prefetch and power control registers are revision dependent
+	@ and can be written whether or not the L2 cache is enabled
+	ldr	r0, [r1, #L2X0_CACHE_ID]
+	and	r0, r0, #L2X0_CACHE_ID_RTL_MASK
+	cmp	r0, #L310_CACHE_ID_RTL_R2P0
+	strcs	r7, [r1, #L310_PREFETCH_CTRL]
+	cmp	r0, #L310_CACHE_ID_RTL_R3P0
+	strcs	r8, [r1, #L310_POWER_CTRL]
+
+	@ Don't setup the L2 cache if it is already enabled
+	ldr	r0, [r1, #L2X0_CTRL]
+	tst	r0, #L2X0_CTRL_EN
+	movne	pc, lr
+
+	str	r3, [r1, #L310_TAG_LATENCY_CTRL]
+	str	r4, [r1, #L310_DATA_LATENCY_CTRL]
+	str	r6, [r1, #L310_ADDR_FILTER_END]
+	str	r5, [r1, #L310_ADDR_FILTER_START]
+
+	str	r2, [r1, #L2X0_AUX_CTRL]
+	mov	r9, #L2X0_CTRL_EN
+	str	r9, [r1, #L2X0_CTRL]
+	mov	pc, lr
+ENDPROC(l2c310_early_resume)
+
+	.align
+1:	.long	l2x0_saved_regs - .
-- 
1.8.3.1
