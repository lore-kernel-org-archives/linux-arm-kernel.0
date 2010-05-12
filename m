From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:33 -0700
Subject: [PATCH 04/25] msm: add sirc interrupt controller driver.
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-5-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory Bean <gbean@codeaurora.org>

Scorpion-based SOCs from Qualcomm use a different interrupt
controller 'sirc'.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/sirc.h |  115 +++++++++++++++++++++
 arch/arm/mach-msm/sirc.c              |  177 +++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/include/mach/sirc.h
 create mode 100644 arch/arm/mach-msm/sirc.c

diff --git a/arch/arm/mach-msm/include/mach/sirc.h b/arch/arm/mach-msm/include/mach/sirc.h
new file mode 100644
index 0000000..7281337
--- /dev/null
+++ b/arch/arm/mach-msm/include/mach/sirc.h
@@ -0,0 +1,115 @@
+/* Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above
+ *       copyright notice, this list of conditions and the following
+ *       disclaimer in the documentation and/or other materials provided
+ *       with the distribution.
+ *     * Neither the name of Code Aurora Forum, Inc. nor the names of its
+ *       contributors may be used to endorse or promote products derived
+ *       from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
+ * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#ifndef __ASM_ARCH_MSM_SIRC_H
+#define __ASM_ARCH_MSM_SIRC_H
+
+struct sirc_regs_t {
+	void    *int_enable;
+	void    *int_enable_clear;
+	void    *int_enable_set;
+	void    *int_type;
+	void    *int_polarity;
+	void    *int_clear;
+};
+
+struct sirc_cascade_regs {
+	void    *int_status;
+	unsigned int    cascade_irq;
+};
+
+void msm_init_sirc(void);
+void msm_sirc_enter_sleep(void);
+void msm_sirc_exit_sleep(void);
+
+#if defined(CONFIG_ARCH_MSM_SCORPION)
+
+#include <mach/msm_iomap.h>
+
+/*
+ * Secondary interrupt controller interrupts
+ */
+
+#define FIRST_SIRC_IRQ (NR_MSM_IRQS + NR_GPIO_IRQS)
+
+#define INT_UART1                     (FIRST_SIRC_IRQ + 0)
+#define INT_UART2                     (FIRST_SIRC_IRQ + 1)
+#define INT_UART3                     (FIRST_SIRC_IRQ + 2)
+#define INT_UART1_RX                  (FIRST_SIRC_IRQ + 3)
+#define INT_UART2_RX                  (FIRST_SIRC_IRQ + 4)
+#define INT_UART3_RX                  (FIRST_SIRC_IRQ + 5)
+#define INT_SPI_INPUT                 (FIRST_SIRC_IRQ + 6)
+#define INT_SPI_OUTPUT                (FIRST_SIRC_IRQ + 7)
+#define INT_SPI_ERROR                 (FIRST_SIRC_IRQ + 8)
+#define INT_GPIO_GROUP1               (FIRST_SIRC_IRQ + 9)
+#define INT_GPIO_GROUP2               (FIRST_SIRC_IRQ + 10)
+#define INT_GPIO_GROUP1_SECURE        (FIRST_SIRC_IRQ + 11)
+#define INT_GPIO_GROUP2_SECURE        (FIRST_SIRC_IRQ + 12)
+#define INT_AVS_SVIC                  (FIRST_SIRC_IRQ + 13)
+#define INT_AVS_REQ_UP                (FIRST_SIRC_IRQ + 14)
+#define INT_AVS_REQ_DOWN              (FIRST_SIRC_IRQ + 15)
+#define INT_PBUS_ERR                  (FIRST_SIRC_IRQ + 16)
+#define INT_AXI_ERR                   (FIRST_SIRC_IRQ + 17)
+#define INT_SMI_ERR                   (FIRST_SIRC_IRQ + 18)
+#define INT_EBI1_ERR                  (FIRST_SIRC_IRQ + 19)
+#define INT_IMEM_ERR                  (FIRST_SIRC_IRQ + 20)
+#define INT_TEMP_SENSOR               (FIRST_SIRC_IRQ + 21)
+#define INT_TV_ENC                    (FIRST_SIRC_IRQ + 22)
+#define INT_GRP2D                     (FIRST_SIRC_IRQ + 23)
+#define INT_GSBI_QUP                  (FIRST_SIRC_IRQ + 24)
+#define INT_SC_ACG                    (FIRST_SIRC_IRQ + 25)
+#define INT_WDT0                      (FIRST_SIRC_IRQ + 26)
+#define INT_WDT1                      (FIRST_SIRC_IRQ + 27)
+
+#if defined(CONFIG_MSM_SOC_REV_A)
+#define NR_SIRC_IRQS                  28
+#define SIRC_MASK                     0x0FFFFFFF
+#else
+#define NR_SIRC_IRQS                  23
+#define SIRC_MASK                     0x007FFFFF
+#endif
+
+#define LAST_SIRC_IRQ                 (FIRST_SIRC_IRQ + NR_SIRC_IRQS - 1)
+
+#define SPSS_SIRC_INT_SELECT          (MSM_SIRC_BASE + 0x00)
+#define SPSS_SIRC_INT_ENABLE          (MSM_SIRC_BASE + 0x04)
+#define SPSS_SIRC_INT_ENABLE_CLEAR    (MSM_SIRC_BASE + 0x08)
+#define SPSS_SIRC_INT_ENABLE_SET      (MSM_SIRC_BASE + 0x0C)
+#define SPSS_SIRC_INT_TYPE            (MSM_SIRC_BASE + 0x10)
+#define SPSS_SIRC_INT_POLARITY        (MSM_SIRC_BASE + 0x14)
+#define SPSS_SIRC_SECURITY            (MSM_SIRC_BASE + 0x18)
+#define SPSS_SIRC_IRQ_STATUS          (MSM_SIRC_BASE + 0x1C)
+#define SPSS_SIRC_IRQ1_STATUS         (MSM_SIRC_BASE + 0x20)
+#define SPSS_SIRC_RAW_STATUS          (MSM_SIRC_BASE + 0x24)
+#define SPSS_SIRC_INT_CLEAR           (MSM_SIRC_BASE + 0x28)
+#define SPSS_SIRC_SOFT_INT            (MSM_SIRC_BASE + 0x2C)
+
+#endif
+
+#endif
diff --git a/arch/arm/mach-msm/sirc.c b/arch/arm/mach-msm/sirc.c
new file mode 100644
index 0000000..b079452
--- /dev/null
+++ b/arch/arm/mach-msm/sirc.c
@@ -0,0 +1,177 @@
+/* Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+
+static unsigned int int_enable;
+static unsigned int wake_enable;
+
+static struct sirc_regs_t sirc_regs = {
+	.int_enable       = SPSS_SIRC_INT_ENABLE,
+	.int_enable_clear = SPSS_SIRC_INT_ENABLE_CLEAR,
+	.int_enable_set   = SPSS_SIRC_INT_ENABLE_SET,
+	.int_type         = SPSS_SIRC_INT_TYPE,
+	.int_polarity     = SPSS_SIRC_INT_POLARITY,
+	.int_clear        = SPSS_SIRC_INT_CLEAR,
+};
+
+static struct sirc_cascade_regs sirc_reg_table[] = {
+	{
+		.int_status  = SPSS_SIRC_IRQ_STATUS,
+		.cascade_irq = INT_SIRC_0,
+	}
+};
+
+static unsigned int save_type;
+static unsigned int save_polarity;
+
+/* Mask off the given interrupt. Keep the int_enable mask in sync with
+   the enable reg, so it can be restored after power collapse. */
+static void sirc_irq_mask(unsigned int irq)
+{
+	unsigned int mask;
+
+
+	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	writel(mask, sirc_regs.int_enable_clear);
+	int_enable &= ~mask;
+	return;
+}
+
+/* Unmask the given interrupt. Keep the int_enable mask in sync with
+   the enable reg, so it can be restored after power collapse. */
+static void sirc_irq_unmask(unsigned int irq)
+{
+	unsigned int mask;
+
+	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	writel(mask, sirc_regs.int_enable_set);
+	int_enable |= mask;
+	return;
+}
+
+static void sirc_irq_ack(unsigned int irq)
+{
+	unsigned int mask;
+
+	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	writel(mask, sirc_regs.int_clear);
+	return;
+}
+
+static int sirc_irq_set_wake(unsigned int irq, unsigned int on)
+{
+	unsigned int mask;
+
+	/* Used to set the interrupt enable mask during power collapse. */
+	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	if (on)
+		wake_enable |= mask;
+	else
+		wake_enable &= ~mask;
+
+	return 0;
+}
+
+static int sirc_irq_set_type(unsigned int irq, unsigned int flow_type)
+{
+	unsigned int mask;
+	unsigned int val;
+
+	mask = 1 << (irq - FIRST_SIRC_IRQ);
+	val = readl(sirc_regs.int_polarity);
+
+	if (flow_type & (IRQF_TRIGGER_LOW | IRQF_TRIGGER_FALLING))
+		val |= mask;
+	else
+		val &= ~mask;
+
+	writel(val, sirc_regs.int_polarity);
+
+	val = readl(sirc_regs.int_type);
+	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
+		val |= mask;
+		irq_desc[irq].handle_irq = handle_edge_irq;
+	} else {
+		val &= ~mask;
+		irq_desc[irq].handle_irq = handle_level_irq;
+	}
+
+	writel(val, sirc_regs.int_type);
+
+	return 0;
+}
+
+/* Finds the pending interrupt on the passed cascade irq and redrives it */
+static void sirc_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int reg = 0;
+	unsigned int sirq;
+	unsigned int status;
+
+	while ((reg < ARRAY_SIZE(sirc_reg_table)) &&
+		(sirc_reg_table[reg].cascade_irq != irq))
+		reg++;
+
+	status = readl(sirc_reg_table[reg].int_status);
+	status &= SIRC_MASK;
+	if (status == 0)
+		return;
+
+	for (sirq = 0;
+	     (sirq < NR_SIRC_IRQS) && ((status & (1U << sirq)) == 0);
+	     sirq++)
+		;
+	generic_handle_irq(sirq+FIRST_SIRC_IRQ);
+
+	desc->chip->ack(irq);
+}
+
+static struct irq_chip sirc_irq_chip = {
+	.name      = "sirc",
+	.ack       = sirc_irq_ack,
+	.mask      = sirc_irq_mask,
+	.unmask    = sirc_irq_unmask,
+	.set_wake  = sirc_irq_set_wake,
+	.set_type  = sirc_irq_set_type,
+};
+
+void __init msm_init_sirc(void)
+{
+	int i;
+
+	int_enable = 0;
+	wake_enable = 0;
+
+	for (i = FIRST_SIRC_IRQ; i < LAST_SIRC_IRQ; i++) {
+		set_irq_chip(i, &sirc_irq_chip);
+		set_irq_handler(i, handle_edge_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sirc_reg_table); i++) {
+		set_irq_chained_handler(sirc_reg_table[i].cascade_irq,
+					sirc_irq_handler);
+		set_irq_wake(sirc_reg_table[i].cascade_irq, 1);
+	}
+	return;
+}
+
-- 
1.6.2.3
