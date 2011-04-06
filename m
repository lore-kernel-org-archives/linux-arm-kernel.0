From: john.linn@xilinx.com (John Linn)
Date: Wed, 6 Apr 2011 11:15:08 -0600
Subject: [PATCH V2 2/4] ARM: Xilinx: Adding local timer to support SMP
In-Reply-To: <1302110110-32208-2-git-send-email-john.linn@xilinx.com>
References: <1302110110-32208-1-git-send-email-john.linn@xilinx.com>
	<1302110110-32208-2-git-send-email-john.linn@xilinx.com>
Message-ID: <41780974-b89d-4d22-869b-92076ebd44b0@VA3EHSMHS026.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each Cortex A9 CPU has a local timer in it and it can
be used during SMP mode.

Signed-off-by: John Linn <john.linn@xilinx.com>
---

V2 Changes

These changes were broken out seperately in V2 at the request of Michal Simek.

Minor cleanup for the change from mach-xilinx to mach-zynq. The non-local 
timer change is no longer in the SMP patch as it was integrated into the 
non-SMP patches. 

 arch/arm/mach-zynq/Makefile                |    1 +
 arch/arm/mach-zynq/include/mach/irqs.h     |    1 +
 arch/arm/mach-zynq/include/mach/zynq_soc.h |    1 +
 arch/arm/mach-zynq/localtimer.c            |   39 ++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-zynq/localtimer.c

diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index 62787ff..9983a3f 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -5,3 +5,4 @@
 # Common support
 obj-y 				:= common.o timer.o
 obj-$(CONFIG_MACH_XILINX_EP107)	+= board_ep107.o
+obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
diff --git a/arch/arm/mach-zynq/include/mach/irqs.h b/arch/arm/mach-zynq/include/mach/irqs.h
index e7f414a..1f44780 100644
--- a/arch/arm/mach-zynq/include/mach/irqs.h
+++ b/arch/arm/mach-zynq/include/mach/irqs.h
@@ -22,6 +22,7 @@
  * GIC Interrupts
  */
 
+#define IRQ_SCU_CPU_TIMER	29
 #define IRQ_GIC_SPI_START	32
 #define IRQ_TIMERCOUNTER0	42
 #define IRQ_UART0		59
diff --git a/arch/arm/mach-zynq/include/mach/zynq_soc.h b/arch/arm/mach-zynq/include/mach/zynq_soc.h
index ff5349c..8768e57 100644
--- a/arch/arm/mach-zynq/include/mach/zynq_soc.h
+++ b/arch/arm/mach-zynq/include/mach/zynq_soc.h
@@ -42,6 +42,7 @@
 #define TTC0_BASE			IOMEM(TTC0_VIRT)
 #define SCU_PERIPH_BASE			IOMEM(SCU_PERIPH_VIRT)
 #define SCU_GIC_CPU_BASE		(SCU_PERIPH_BASE + 0x100)
+#define SCU_CPU_TIMER_BASE		(SCU_PERIPH_BASE + 0x600)
 #define SCU_GIC_DIST_BASE		(SCU_PERIPH_BASE + 0x1000)
 #define PL310_L2CC_BASE			IOMEM(PL310_L2CC_VIRT)
 #define OCM_LOW_BASE			IOMEM(OCM_LOW_VIRT)
diff --git a/arch/arm/mach-zynq/localtimer.c b/arch/arm/mach-zynq/localtimer.c
new file mode 100644
index 0000000..d627b06
--- /dev/null
+++ b/arch/arm/mach-zynq/localtimer.c
@@ -0,0 +1,39 @@
+/*
+ * arch/arm/mach-xilinx/localtimer.c
+ *
+ * Both cortex-a9 cores have their own timer in it's CPU domain.
+ *
+ * Copyright (C) 2011 Xilinx, Inc.
+ *
+ * This file is based on arch/arm/plat-versatile/localtimer.c
+ *
+ * Copyright (C) 2002 ARM Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/init.h>
+#include <linux/clockchips.h>
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+#include <mach/zynq_soc.h>
+#include <mach/irqs.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	twd_base = SCU_CPU_TIMER_BASE;
+
+	evt->irq = IRQ_SCU_CPU_TIMER;
+	twd_timer_setup(evt);
+	return 0;
+}
+
-- 
1.5.4.7



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
