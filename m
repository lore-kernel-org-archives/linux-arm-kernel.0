From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Oct 2015 15:23:55 +0200
Subject: [PATCH 5/5] irqchip: armada-370-xp: document the overall driver logic
In-Reply-To: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1445347435-2333-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the overall logic of the driver to handle the global and per-CPU
masking of the interrupts is far from trivial, this commit adds a long
comment detailing how the hardware operates and what strategy the
driver implements on top of that.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 888add6..f14cc2d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -34,6 +34,86 @@
 #include <asm/smp_plat.h>
 #include <asm/mach/irq.h>
 
+/*
+ * Overall diagram of the Armada XP interrupt controller:
+ *
+ *    To CPU 0                 To CPU 1
+ *
+ *       /\                       /\
+ *       ||                       ||
+ * +---------------+        +---------------+
+ * |               |	 |               |
+ * |    per-CPU    |	 |    per-CPU    |
+ * |  mask/unmask  |	 |  mask/unmask  |
+ * |     CPU0      |	 |     CPU1      |
+ * |               |	 |               |
+ * +---------------+	 +---------------+
+ *        /\                       /\
+ *        ||                       ||
+ *        \\_______________________//
+ *                     ||
+ *            +-------------------+
+ *            |                   |
+ *            | Global interrupt  |
+ *            |    mask/unmask    |
+ *            |                   |
+ *            +-------------------+
+ *                     /\
+ *                     ||
+ *               interrupt from
+ *                   device
+ *
+ * The "global interrupt mask/unmask" is modified using the
+ * ARMADA_370_XP_INT_SET_ENABLE_OFFS and
+ * ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS registers, which are relative
+ * to "main_int_base".
+ *
+ * The "per-CPU mask/unmask" is modified using the
+ * ARMADA_370_XP_INT_SET_MASK_OFFS and
+ * ARMADA_370_XP_INT_CLEAR_MASK_OFFS registers, which are relative to
+ * "per_cpu_int_base". This base address points to a special address,
+ * which automatically accesses the registers of the current CPU.
+ *
+ * The per-CPU mask/unmask can also be adjusted using the global
+ * per-interrupt ARMADA_370_XP_INT_SOURCE_CTL register, which we use
+ * to configure interrupt affinity.
+ *
+ * Due to this model, all interrupts need to be mask/unmasked at two
+ * different levels: at the global level and at the per-CPU level.
+ *
+ * This driver takes the following approach to deal with this:
+ *
+ *  - For global interrupts:
+ *
+ *    At ->map() time, a global interrupt is unmasked at the per-CPU
+ *    mask/unmask level. It is therefore unmasked at this level for
+ *    the current CPU, running the ->map() code. This allows to have
+ *    the interrupt unmasked at this level in non-SMP
+ *    configurations. In SMP configurations, the ->set_affinity()
+ *    callback is called, which using the
+ *    ARMADA_370_XP_INT_SOURCE_CTL() readjusts the per-CPU mask/unmask
+ *    for the interrupt.
+ *
+ *    The ->mask() and ->unmask() operations only mask/unmask the
+ *    interrupt at the "global" level.
+ *
+ *    So, a global interrupt is enabled at the per-CPU level as soon
+ *    as it is mapped. At run time, the masking/unmasking takes place
+ *    at the global level.
+ *
+ *  - For per-CPU interrupts
+ *
+ *    At ->map() time, a per-CPU interrupt is unmasked at the global
+ *    mask/unmask level.
+ *
+ *    The ->mask() and ->unmask() operations mask/unmask the interrupt
+ *    at the per-CPU level.
+ *
+ *    So, a per-CPU interrupt is enabled at the global level as soon
+ *    as it is mapped. At run time, the masking/unmasking takes place
+ *    at the per-CPU level.
+ */
+
 /* Registers relative to main_int_base */
 #define ARMADA_370_XP_INT_CONTROL		(0x00)
 #define ARMADA_370_XP_SW_TRIG_INT_OFFS		(0x04)
-- 
2.6.2
