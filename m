From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon,  3 May 2010 13:52:34 +0530
Subject: [PATCH V3 resend] ST SPEAr: Adding support for shared irq layer
Message-ID: <1272874954-3459-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multiple peripherals in SPEAr share common hardware interrupt lines.
This patch adds support for a shared irq layer, which registers hardware
irqs by itself and exposes virtual irq numbers to peripherals.

Modifications in V3 resend:
- Instead of dummy ack, using shirq_irq_mask as ack routine

Modifications in V3:
- Adding dummy ack routine in irq_chip

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/irqs.h     |  101 +++++++++++++++-
 arch/arm/mach-spear3xx/include/mach/spear300.h |   16 +++
 arch/arm/mach-spear3xx/include/mach/spear310.h |   24 ++++
 arch/arm/mach-spear3xx/include/mach/spear320.h |   26 ++++
 arch/arm/mach-spear3xx/spear300.c              |   67 +++++++++++-
 arch/arm/mach-spear3xx/spear310.c              |  148 +++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear320.c              |  150 ++++++++++++++++++++++++
 arch/arm/mach-spear6xx/include/mach/irqs.h     |    1 +
 arch/arm/plat-spear/Makefile                   |    2 +
 arch/arm/plat-spear/include/plat/shirq.h       |   73 ++++++++++++
 arch/arm/plat-spear/shirq.c                    |  118 +++++++++++++++++++
 11 files changed, 718 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/shirq.h
 create mode 100644 arch/arm/plat-spear/shirq.c

diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index fe980e0..7f940b8 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -14,7 +14,7 @@
 #ifndef __MACH_IRQS_H
 #define __MACH_IRQS_H
 
-/* IRQ definitions */
+/* SPEAr3xx IRQ definitions */
 #define IRQ_HW_ACCEL_MOD_0			0
 #define IRQ_INTRCOMM_RAS_ARM			1
 #define IRQ_CPU_GPT1_1				2
@@ -50,16 +50,103 @@
 #define IRQ_HW_ACCEL_MOD_1			31
 #define IRQ_VIC_END				32
 
-#define SPEAR_GPIO_INT_BASE	IRQ_VIC_END
+#define VIRQ_START				IRQ_VIC_END
 
+/* SPEAr300 Virtual irq definitions */
 #ifdef CONFIG_MACH_SPEAR300
-#define SPEAR_GPIO1_INT_BASE	(SPEAR_GPIO_INT_BASE + 8)
-#define SPEAR_GPIO_INT_END	(SPEAR_GPIO1_INT_BASE + 8)
+/* IRQs sharing IRQ_GEN_RAS_1 */
+#define VIRQ_IT_PERS_S				(VIRQ_START + 0)
+#define VIRQ_IT_CHANGE_S			(VIRQ_START + 1)
+#define VIRQ_I2S				(VIRQ_START + 2)
+#define VIRQ_TDM				(VIRQ_START + 3)
+#define VIRQ_CAMERA_L				(VIRQ_START + 4)
+#define VIRQ_CAMERA_F				(VIRQ_START + 5)
+#define VIRQ_CAMERA_V				(VIRQ_START + 6)
+#define VIRQ_KEYBOARD				(VIRQ_START + 7)
+#define VIRQ_GPIO1				(VIRQ_START + 8)
+
+/* IRQs sharing IRQ_GEN_RAS_3 */
+#define IRQ_CLCD				IRQ_GEN_RAS_3
+
+/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
+#define IRQ_SDIO				IRQ_INTRCOMM_RAS_ARM
+
+/* GPIO pins virtual irqs */
+#define SPEAR_GPIO_INT_BASE			(VIRQ_START + 9)
+#define SPEAR_GPIO1_INT_BASE			(SPEAR_GPIO_INT_BASE + 8)
+#define SPEAR_GPIO_INT_END			(SPEAR_GPIO1_INT_BASE + 8)
+
+/* SPEAr310 Virtual irq definitions */
+#elif defined(CONFIG_MACH_SPEAR310)
+/* IRQs sharing IRQ_GEN_RAS_1 */
+#define VIRQ_SMII0				(VIRQ_START + 0)
+#define VIRQ_SMII1				(VIRQ_START + 1)
+#define VIRQ_SMII2				(VIRQ_START + 2)
+#define VIRQ_SMII3				(VIRQ_START + 3)
+#define VIRQ_WAKEUP_SMII0			(VIRQ_START + 4)
+#define VIRQ_WAKEUP_SMII1			(VIRQ_START + 5)
+#define VIRQ_WAKEUP_SMII2			(VIRQ_START + 6)
+#define VIRQ_WAKEUP_SMII3			(VIRQ_START + 7)
+
+/* IRQs sharing IRQ_GEN_RAS_2 */
+#define VIRQ_UART1				(VIRQ_START + 8)
+#define VIRQ_UART2				(VIRQ_START + 9)
+#define VIRQ_UART3				(VIRQ_START + 10)
+#define VIRQ_UART4				(VIRQ_START + 11)
+#define VIRQ_UART5				(VIRQ_START + 12)
+
+/* IRQs sharing IRQ_GEN_RAS_3 */
+#define VIRQ_EMI				(VIRQ_START + 13)
+#define VIRQ_PLGPIO				(VIRQ_START + 14)
+
+/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
+#define VIRQ_TDM_HDLC				(VIRQ_START + 15)
+#define VIRQ_RS485_0				(VIRQ_START + 16)
+#define VIRQ_RS485_1				(VIRQ_START + 17)
+
+/* GPIO pins virtual irqs */
+#define SPEAR_GPIO_INT_BASE			(VIRQ_START + 18)
+
+/* SPEAr320 Virtual irq definitions */
 #else
-#define SPEAR_GPIO_INT_END	(SPEAR_GPIO_INT_BASE + 8)
+/* IRQs sharing IRQ_GEN_RAS_1 */
+#define VIRQ_EMI				(VIRQ_START + 0)
+#define VIRQ_CLCD				(VIRQ_START + 1)
+#define VIRQ_SPP				(VIRQ_START + 2)
+
+/* IRQs sharing IRQ_GEN_RAS_2 */
+#define IRQ_SDIO				IRQ_GEN_RAS_2
+
+/* IRQs sharing IRQ_GEN_RAS_3 */
+#define VIRQ_PLGPIO				(VIRQ_START + 3)
+#define VIRQ_I2S_PLAY				(VIRQ_START + 4)
+#define VIRQ_I2S_REC				(VIRQ_START + 5)
+
+/* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
+#define VIRQ_CANU				(VIRQ_START + 6)
+#define VIRQ_CANL				(VIRQ_START + 7)
+#define VIRQ_UART1				(VIRQ_START + 8)
+#define VIRQ_UART2				(VIRQ_START + 9)
+#define VIRQ_SSP1				(VIRQ_START + 10)
+#define VIRQ_SSP2				(VIRQ_START + 11)
+#define VIRQ_SMII0				(VIRQ_START + 12)
+#define VIRQ_MII1_SMII1				(VIRQ_START + 13)
+#define VIRQ_WAKEUP_SMII0			(VIRQ_START + 14)
+#define VIRQ_WAKEUP_MII1_SMII1			(VIRQ_START + 15)
+#define VIRQ_I2C				(VIRQ_START + 16)
+
+/* GPIO pins virtual irqs */
+#define SPEAR_GPIO_INT_BASE			(VIRQ_START + 17)
+
+#endif
+
+/* PLGPIO Virtual IRQs */
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+#define SPEAR_PLGPIO_INT_BASE			(SPEAR_GPIO_INT_BASE + 8)
+#define SPEAR_GPIO_INT_END			(SPEAR_PLGPIO_INT_BASE + 102)
 #endif
 
-#define VIRTUAL_IRQS		(SPEAR_GPIO_INT_END - IRQ_VIC_END)
-#define NR_IRQS			(IRQ_VIC_END + VIRTUAL_IRQS)
+#define VIRQ_END				SPEAR_GPIO_INT_END
+#define NR_IRQS					VIRQ_END
 
 #endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear300.h b/arch/arm/mach-spear3xx/include/mach/spear300.h
index 40c16f3..ccaa765 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear300.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear300.h
@@ -20,6 +20,22 @@
 #define SPEAR300_TELECOM_BASE		0x50000000
 #define SPEAR300_TELECOM_SIZE		0x10000000
 
+/* Interrupt registers offsets and masks */
+#define SPEAR300_TELECOM_REG_SIZE	0x00010000
+#define INT_ENB_MASK_REG		0x54
+#define INT_STS_MASK_REG		0x58
+#define IT_PERS_S_IRQ_MASK		(1 << 0)
+#define IT_CHANGE_S_IRQ_MASK		(1 << 1)
+#define I2S_IRQ_MASK			(1 << 2)
+#define TDM_IRQ_MASK			(1 << 3)
+#define CAMERA_L_IRQ_MASK		(1 << 4)
+#define CAMERA_F_IRQ_MASK		(1 << 5)
+#define CAMERA_V_IRQ_MASK		(1 << 6)
+#define KEYBOARD_IRQ_MASK		(1 << 7)
+#define GPIO1_IRQ_MASK			(1 << 8)
+
+#define SHIRQ_RAS1_MASK			0x1FF
+
 #define SPEAR300_CLCD_BASE		0x60000000
 #define SPEAR300_CLCD_SIZE		0x10000000
 
diff --git a/arch/arm/mach-spear3xx/include/mach/spear310.h b/arch/arm/mach-spear3xx/include/mach/spear310.h
index d4f58d6..b27bb8a 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear310.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear310.h
@@ -40,6 +40,30 @@
 
 #define SPEAR310_SOC_CONFIG_BASE	0xB4000000
 #define SPEAR310_SOC_CONFIG_SIZE	0x00000070
+/* Interrupt registers offsets and masks */
+#define INT_STS_MASK_REG		0x04
+#define SMII0_IRQ_MASK			(1 << 0)
+#define SMII1_IRQ_MASK			(1 << 1)
+#define SMII2_IRQ_MASK			(1 << 2)
+#define SMII3_IRQ_MASK			(1 << 3)
+#define WAKEUP_SMII0_IRQ_MASK		(1 << 4)
+#define WAKEUP_SMII1_IRQ_MASK		(1 << 5)
+#define WAKEUP_SMII2_IRQ_MASK		(1 << 6)
+#define WAKEUP_SMII3_IRQ_MASK		(1 << 7)
+#define UART1_IRQ_MASK			(1 << 8)
+#define UART2_IRQ_MASK			(1 << 9)
+#define UART3_IRQ_MASK			(1 << 10)
+#define UART4_IRQ_MASK			(1 << 11)
+#define UART5_IRQ_MASK			(1 << 12)
+#define EMI_IRQ_MASK			(1 << 13)
+#define TDM_HDLC_IRQ_MASK		(1 << 14)
+#define RS485_0_IRQ_MASK		(1 << 15)
+#define RS485_1_IRQ_MASK		(1 << 16)
+
+#define SHIRQ_RAS1_MASK			0x000FF
+#define SHIRQ_RAS2_MASK			0x01F00
+#define SHIRQ_RAS3_MASK			0x02000
+#define SHIRQ_INTRCOMM_RAS_MASK		0x1C000
 
 #endif /* __MACH_SPEAR310_H */
 
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index e8ad2ed..cacf17a 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -64,6 +64,32 @@
 
 #define SPEAR320_SOC_CONFIG_BASE	0xB4000000
 #define SPEAR320_SOC_CONFIG_SIZE	0x00000070
+/* Interrupt registers offsets and masks */
+#define INT_STS_MASK_REG		0x04
+#define INT_CLR_MASK_REG		0x04
+#define INT_ENB_MASK_REG		0x08
+#define GPIO_IRQ_MASK			(1 << 0)
+#define I2S_PLAY_IRQ_MASK		(1 << 1)
+#define I2S_REC_IRQ_MASK		(1 << 2)
+#define EMI_IRQ_MASK			(1 << 7)
+#define CLCD_IRQ_MASK			(1 << 8)
+#define SPP_IRQ_MASK			(1 << 9)
+#define SDIO_IRQ_MASK			(1 << 10)
+#define CAN_U_IRQ_MASK			(1 << 11)
+#define CAN_L_IRQ_MASK			(1 << 12)
+#define UART1_IRQ_MASK			(1 << 13)
+#define UART2_IRQ_MASK			(1 << 14)
+#define SSP1_IRQ_MASK			(1 << 15)
+#define SSP2_IRQ_MASK			(1 << 16)
+#define SMII0_IRQ_MASK			(1 << 17)
+#define MII1_SMII1_IRQ_MASK		(1 << 18)
+#define WAKEUP_SMII0_IRQ_MASK		(1 << 19)
+#define WAKEUP_MII1_SMII1_IRQ_MASK	(1 << 20)
+#define I2C1_IRQ_MASK			(1 << 21)
+
+#define SHIRQ_RAS1_MASK			0x000380
+#define SHIRQ_RAS3_MASK			0x000007
+#define SHIRQ_INTRCOMM_RAS_MASK		0x3FF800
 
 #endif /* __MACH_SPEAR320_H */
 
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 66e7fcd..3560f8c 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -17,6 +17,7 @@
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/shirq.h>
 
 /* pad multiplexing support */
 /* muxing registers */
@@ -386,14 +387,78 @@ struct amba_device gpio1_device = {
 		.end = SPEAR300_GPIO_BASE + SPEAR300_GPIO_SIZE - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_GEN_RAS_1, NO_IRQ},
+	.irq = {VIRQ_GPIO1, NO_IRQ},
+};
+
+/* spear3xx shared irq */
+struct shirq_dev_config shirq_ras1_config[] = {
+	{
+		.virq = VIRQ_IT_PERS_S,
+		.enb_mask = IT_PERS_S_IRQ_MASK,
+		.status_mask = IT_PERS_S_IRQ_MASK,
+	}, {
+		.virq = VIRQ_IT_CHANGE_S,
+		.enb_mask = IT_CHANGE_S_IRQ_MASK,
+		.status_mask = IT_CHANGE_S_IRQ_MASK,
+	}, {
+		.virq = VIRQ_I2S,
+		.enb_mask = I2S_IRQ_MASK,
+		.status_mask = I2S_IRQ_MASK,
+	}, {
+		.virq = VIRQ_TDM,
+		.enb_mask = TDM_IRQ_MASK,
+		.status_mask = TDM_IRQ_MASK,
+	}, {
+		.virq = VIRQ_CAMERA_L,
+		.enb_mask = CAMERA_L_IRQ_MASK,
+		.status_mask = CAMERA_L_IRQ_MASK,
+	}, {
+		.virq = VIRQ_CAMERA_F,
+		.enb_mask = CAMERA_F_IRQ_MASK,
+		.status_mask = CAMERA_F_IRQ_MASK,
+	}, {
+		.virq = VIRQ_CAMERA_V,
+		.enb_mask = CAMERA_V_IRQ_MASK,
+		.status_mask = CAMERA_V_IRQ_MASK,
+	}, {
+		.virq = VIRQ_KEYBOARD,
+		.enb_mask = KEYBOARD_IRQ_MASK,
+		.status_mask = KEYBOARD_IRQ_MASK,
+	}, {
+		.virq = VIRQ_GPIO1,
+		.enb_mask = GPIO1_IRQ_MASK,
+		.status_mask = GPIO1_IRQ_MASK,
+	},
+};
+
+struct spear_shirq shirq_ras1 = {
+	.irq = IRQ_GEN_RAS_1,
+	.dev_config = shirq_ras1_config,
+	.dev_count = ARRAY_SIZE(shirq_ras1_config),
+	.regs = {
+		.enb_reg = INT_ENB_MASK_REG,
+		.status_reg = INT_STS_MASK_REG,
+		.status_reg_mask = SHIRQ_RAS1_MASK,
+		.clear_reg = -1,
+	},
 };
 
 /* spear300 routines */
 void __init spear300_init(void)
 {
+	int ret = 0;
+
 	/* call spear3xx family common init function */
 	spear3xx_init();
+
+	/* shared irq registeration */
+	shirq_ras1.regs.base =
+		ioremap(SPEAR300_TELECOM_BASE, SPEAR300_TELECOM_REG_SIZE);
+	if (shirq_ras1.regs.base) {
+		ret = spear_shirq_register(&shirq_ras1);
+		if (ret)
+			printk(KERN_ERR "Error registering Shared IRQ\n");
+	}
 }
 
 void spear300_pmx_init(void)
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index dd5a572..96a1ab8 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/shirq.h>
 
 /* pad multiplexing support */
 /* muxing registers */
@@ -140,11 +141,158 @@ struct pmx_driver pmx_driver = {
 
 /* Add spear310 specific devices here */
 
+/* spear3xx shared irq */
+struct shirq_dev_config shirq_ras1_config[] = {
+	{
+		.virq = VIRQ_SMII0,
+		.status_mask = SMII0_IRQ_MASK,
+	}, {
+		.virq = VIRQ_SMII1,
+		.status_mask = SMII1_IRQ_MASK,
+	}, {
+		.virq = VIRQ_SMII2,
+		.status_mask = SMII2_IRQ_MASK,
+	}, {
+		.virq = VIRQ_SMII3,
+		.status_mask = SMII3_IRQ_MASK,
+	}, {
+		.virq = VIRQ_WAKEUP_SMII0,
+		.status_mask = WAKEUP_SMII0_IRQ_MASK,
+	}, {
+		.virq = VIRQ_WAKEUP_SMII1,
+		.status_mask = WAKEUP_SMII1_IRQ_MASK,
+	}, {
+		.virq = VIRQ_WAKEUP_SMII2,
+		.status_mask = WAKEUP_SMII2_IRQ_MASK,
+	}, {
+		.virq = VIRQ_WAKEUP_SMII3,
+		.status_mask = WAKEUP_SMII3_IRQ_MASK,
+	},
+};
+
+struct spear_shirq shirq_ras1 = {
+	.irq = IRQ_GEN_RAS_1,
+	.dev_config = shirq_ras1_config,
+	.dev_count = ARRAY_SIZE(shirq_ras1_config),
+	.regs = {
+		.enb_reg = -1,
+		.status_reg = INT_STS_MASK_REG,
+		.status_reg_mask = SHIRQ_RAS1_MASK,
+		.clear_reg = -1,
+	},
+};
+
+struct shirq_dev_config shirq_ras2_config[] = {
+	{
+		.virq = VIRQ_UART1,
+		.status_mask = UART1_IRQ_MASK,
+	}, {
+		.virq = VIRQ_UART2,
+		.status_mask = UART2_IRQ_MASK,
+	}, {
+		.virq = VIRQ_UART3,
+		.status_mask = UART3_IRQ_MASK,
+	}, {
+		.virq = VIRQ_UART4,
+		.status_mask = UART4_IRQ_MASK,
+	}, {
+		.virq = VIRQ_UART5,
+		.status_mask = UART5_IRQ_MASK,
+	},
+};
+
+struct spear_shirq shirq_ras2 = {
+	.irq = IRQ_GEN_RAS_2,
+	.dev_config = shirq_ras2_config,
+	.dev_count = ARRAY_SIZE(shirq_ras2_config),
+	.regs = {
+		.enb_reg = -1,
+		.status_reg = INT_STS_MASK_REG,
+		.status_reg_mask = SHIRQ_RAS2_MASK,
+		.clear_reg = -1,
+	},
+};
+
+struct shirq_dev_config shirq_ras3_config[] = {
+	{
+		.virq = VIRQ_EMI,
+		.status_mask = EMI_IRQ_MASK,
+	},
+};
+
+struct spear_shirq shirq_ras3 = {
+	.irq = IRQ_GEN_RAS_3,
+	.dev_config = shirq_ras3_config,
+	.dev_count = ARRAY_SIZE(shirq_ras3_config),
+	.regs = {
+		.enb_reg = -1,
+		.status_reg = INT_STS_MASK_REG,
+		.status_reg_mask = SHIRQ_RAS3_MASK,
+		.clear_reg = -1,
+	},
+};
+
+struct shirq_dev_config shirq_intrcomm_ras_config[] = {
+	{
+		.virq = VIRQ_TDM_HDLC,
+		.status_mask = TDM_HDLC_IRQ_MASK,
+	}, {
+		.virq = VIRQ_RS485_0,
+		.status_mask = RS485_0_IRQ_MASK,
+	}, {
+		.virq = VIRQ_RS485_1,
+		.status_mask = RS485_1_IRQ_MASK,
+	},
+};
+
+struct spear_shirq shirq_intrcomm_ras = {
+	.irq = IRQ_INTRCOMM_RAS_ARM,
+	.dev_config = shirq_intrcomm_ras_config,
+	.dev_count = ARRAY_SIZE(shirq_intrcomm_ras_config),
+	.regs = {
+		.enb_reg = -1,
+		.status_reg = INT_STS_MASK_REG,
+		.status_reg_mask = SHIRQ_INTRCOMM_RAS_MASK,
+		.clear_reg = -1,
+	},
+};
+
 /* spear310 routines */
 void __init spear310_init(void)
 {
+	void __iomem *base;
+	int ret = 0;
+
 	/* call spear3xx family common init function */
 	spear3xx_init();
+
+	/* shared irq registeration */
+	base = ioremap(SPEAR310_SOC_CONFIG_BASE, SPEAR310_SOC_CONFIG_SIZE);
+	if (base) {
+		/* shirq 1 */
+		shirq_ras1.regs.base = base;
+		ret = spear_shirq_register(&shirq_ras1);
+		if (ret)
+			printk(KERN_ERR "Error registering Shared IRQ 1\n");
+
+		/* shirq 2 */
+		shirq_ras2.regs.base = base;
+		ret = spear_shirq_register(&shirq_ras2);
+		if (ret)
+			printk(KERN_ERR "Error registering Shared IRQ 2\n");
+
+		/* shirq 3 */
+		shirq_ras3.regs.base = base;
+		ret = spear_shirq_register(&shirq_ras3);
+		if (ret)
+			printk(KERN_ERR "Error registering Shared IRQ 3\n");
+
+		/* shirq 4 */
+		shirq_intrcomm_ras.regs.base = base;
+		ret = spear_shirq_register(&shirq_intrcomm_ras);
+		if (ret)
+			printk(KERN_ERR "Error registering Shared IRQ 4\n");
+	}
 }
 
 void spear310_pmx_init(void)
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 2cedf5e..6a12195 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/shirq.h>
 
 /* pad multiplexing support */
 /* muxing registers */
@@ -385,11 +386,160 @@ struct pmx_driver pmx_driver = {
 
 /* Add spear320 specific devices here */
 
+/* spear3xx shared irq */
+struct shirq_dev_config shirq_ras1_config[] = {
+	{
+		.virq = VIRQ_EMI,
+		.status_mask = EMI_IRQ_MASK,
+		.clear_mask = EMI_IRQ_MASK,
+	}, {
+		.virq = VIRQ_CLCD,
+		.status_mask = CLCD_IRQ_MASK,
+		.clear_mask = CLCD_IRQ_MASK,
+	}, {
+		.virq = VIRQ_SPP,
+		.status_mask = SPP_IRQ_MASK,
+		.clear_mask = SPP_IRQ_MASK,
+	},
+};
+
+struct spear_shirq shirq_ras1 = {
+	.irq = IRQ_GEN_RAS_1,
+	.dev_config = shirq_ras1_config,
+	.dev_count = ARRAY_SIZE(shirq_ras1_config),
+	.regs = {
+		.enb_reg = -1,
+		.status_reg = INT_STS_MASK_REG,
+		.status_reg_mask = SHIRQ_RAS1_MASK,
+		.clear_reg = INT_CLR_MASK_REG,
+		.reset_to_clear = 1,
+	},
+};
+
+struct shirq_dev_config shirq_ras3_config[] = {
+	{
+		.virq = VIRQ_PLGPIO,
+		.enb_mask = GPIO_IRQ_MASK,
+		.status_mask = GPIO_IRQ_MASK,
+		.clear_mask = GPIO_IRQ_MASK,
+	}, {
+		.virq = VIRQ_I2S_PLAY,
+		.enb_mask = I2S_PLAY_IRQ_MASK,
+		.status_mask = I2S_PLAY_IRQ_MASK,
+		.clear_mask = I2S_PLAY_IRQ_MASK,
+	}, {
+		.virq = VIRQ_I2S_REC,
+		.enb_mask = I2S_REC_IRQ_MASK,
+		.status_mask = I2S_REC_IRQ_MASK,
+		.clear_mask = I2S_REC_IRQ_MASK,
+	},
+};
+
+struct spear_shirq shirq_ras3 = {
+	.irq = IRQ_GEN_RAS_3,
+	.dev_config = shirq_ras3_config,
+	.dev_count = ARRAY_SIZE(shirq_ras3_config),
+	.regs = {
+		.enb_reg = INT_ENB_MASK_REG,
+		.reset_to_enb = 1,
+		.status_reg = INT_STS_MASK_REG,
+		.status_reg_mask = SHIRQ_RAS3_MASK,
+		.clear_reg = INT_CLR_MASK_REG,
+		.reset_to_clear = 1,
+	},
+};
+
+struct shirq_dev_config shirq_intrcomm_ras_config[] = {
+	{
+		.virq = VIRQ_CANU,
+		.status_mask = CAN_U_IRQ_MASK,
+		.clear_mask = CAN_U_IRQ_MASK,
+	}, {
+		.virq = VIRQ_CANL,
+		.status_mask = CAN_L_IRQ_MASK,
+		.clear_mask = CAN_L_IRQ_MASK,
+	}, {
+		.virq = VIRQ_UART1,
+		.status_mask = UART1_IRQ_MASK,
+		.clear_mask = UART1_IRQ_MASK,
+	}, {
+		.virq = VIRQ_UART2,
+		.status_mask = UART2_IRQ_MASK,
+		.clear_mask = UART2_IRQ_MASK,
+	}, {
+		.virq = VIRQ_SSP1,
+		.status_mask = SSP1_IRQ_MASK,
+		.clear_mask = SSP1_IRQ_MASK,
+	}, {
+		.virq = VIRQ_SSP2,
+		.status_mask = SSP2_IRQ_MASK,
+		.clear_mask = SSP2_IRQ_MASK,
+	}, {
+		.virq = VIRQ_SMII0,
+		.status_mask = SMII0_IRQ_MASK,
+		.clear_mask = SMII0_IRQ_MASK,
+	}, {
+		.virq = VIRQ_MII1_SMII1,
+		.status_mask = MII1_SMII1_IRQ_MASK,
+		.clear_mask = MII1_SMII1_IRQ_MASK,
+	}, {
+		.virq = VIRQ_WAKEUP_SMII0,
+		.status_mask = WAKEUP_SMII0_IRQ_MASK,
+		.clear_mask = WAKEUP_SMII0_IRQ_MASK,
+	}, {
+		.virq = VIRQ_WAKEUP_MII1_SMII1,
+		.status_mask = WAKEUP_MII1_SMII1_IRQ_MASK,
+		.clear_mask = WAKEUP_MII1_SMII1_IRQ_MASK,
+	}, {
+		.virq = VIRQ_I2C,
+		.status_mask = I2C1_IRQ_MASK,
+		.clear_mask = I2C1_IRQ_MASK,
+	},
+};
+
+struct spear_shirq shirq_intrcomm_ras = {
+	.irq = IRQ_INTRCOMM_RAS_ARM,
+	.dev_config = shirq_intrcomm_ras_config,
+	.dev_count = ARRAY_SIZE(shirq_intrcomm_ras_config),
+	.regs = {
+		.enb_reg = -1,
+		.status_reg = INT_STS_MASK_REG,
+		.status_reg_mask = SHIRQ_INTRCOMM_RAS_MASK,
+		.clear_reg = INT_CLR_MASK_REG,
+		.reset_to_clear = 1,
+	},
+};
+
 /* spear320 routines */
 void __init spear320_init(void)
 {
+	void __iomem *base;
+	int ret = 0;
+
 	/* call spear3xx family common init function */
 	spear3xx_init();
+
+	/* shared irq registeration */
+	base = ioremap(SPEAR320_SOC_CONFIG_BASE, SPEAR320_SOC_CONFIG_SIZE);
+	if (base) {
+		/* shirq 1 */
+		shirq_ras1.regs.base = base;
+		ret = spear_shirq_register(&shirq_ras1);
+		if (ret)
+			printk(KERN_ERR "Error registering Shared IRQ 1\n");
+
+		/* shirq 3 */
+		shirq_ras3.regs.base = base;
+		ret = spear_shirq_register(&shirq_ras3);
+		if (ret)
+			printk(KERN_ERR "Error registering Shared IRQ 3\n");
+
+		/* shirq 4 */
+		shirq_intrcomm_ras.regs.base = base;
+		ret = spear_shirq_register(&shirq_intrcomm_ras);
+		if (ret)
+			printk(KERN_ERR "Error registering Shared IRQ 4\n");
+	}
 }
 
 void spear320_pmx_init(void)
diff --git a/arch/arm/mach-spear6xx/include/mach/irqs.h b/arch/arm/mach-spear6xx/include/mach/irqs.h
index 08a3abc..8f214b0 100755
--- a/arch/arm/mach-spear6xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear6xx/include/mach/irqs.h
@@ -85,6 +85,7 @@
 
 #define IRQ_VIC_END				64
 
+/* GPIO pins virtual irqs */
 #define SPEAR_GPIO_INT_BASE	IRQ_VIC_END
 #define SPEAR_GPIO0_INT_BASE	SPEAR_GPIO_INT_BASE
 #define SPEAR_GPIO1_INT_BASE	(SPEAR_GPIO0_INT_BASE + 8)
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 6f4ad5e..eb89540 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -4,3 +4,5 @@
 
 # Common support
 obj-y	:= clock.o padmux.o time.o
+
+obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o
diff --git a/arch/arm/plat-spear/include/plat/shirq.h b/arch/arm/plat-spear/include/plat/shirq.h
new file mode 100644
index 0000000..03ed8b5
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/shirq.h
@@ -0,0 +1,73 @@
+/*
+ * arch/arm/plat-spear/include/plat/shirq.h
+ *
+ * SPEAr platform shared irq layer header file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_SHIRQ_H
+#define __PLAT_SHIRQ_H
+
+#include <linux/irq.h>
+#include <linux/types.h>
+
+/*
+ * struct shirq_dev_config: shared irq device configuration
+ *
+ * virq: virtual irq number of device
+ * enb_mask: enable mask of device
+ * status_mask: status mask of device
+ * clear_mask: clear mask of device
+ */
+struct shirq_dev_config {
+	u32 virq;
+	u32 enb_mask;
+	u32 status_mask;
+	u32 clear_mask;
+};
+
+/*
+ * struct shirq_regs: shared irq register configuration
+ *
+ * base: base address of shared irq register
+ * enb_reg: enable register offset
+ * reset_to_enb: val 1 indicates, we need to clear bit for enabling interrupt
+ * status_reg: status register offset
+ * status_reg_mask: status register valid mask
+ * clear_reg: clear register offset
+ * reset_to_clear: val 1 indicates, we need to clear bit for clearing interrupt
+ */
+struct shirq_regs {
+	void __iomem *base;
+	u32 enb_reg;
+	u32 reset_to_enb;
+	u32 status_reg;
+	u32 status_reg_mask;
+	u32 clear_reg;
+	u32 reset_to_clear;
+};
+
+/*
+ * struct spear_shirq: shared irq structure
+ *
+ * irq: hardware irq number
+ * dev_config: array of device config structures which are using "irq" line
+ * dev_count: size of dev_config array
+ * regs: register configuration for shared irq block
+ */
+struct spear_shirq {
+	u32 irq;
+	struct shirq_dev_config *dev_config;
+	u32 dev_count;
+	struct shirq_regs regs;
+};
+
+int spear_shirq_register(struct spear_shirq *shirq);
+
+#endif /* __PLAT_SHIRQ_H */
diff --git a/arch/arm/plat-spear/shirq.c b/arch/arm/plat-spear/shirq.c
new file mode 100644
index 0000000..2172d69
--- /dev/null
+++ b/arch/arm/plat-spear/shirq.c
@@ -0,0 +1,118 @@
+/*
+ * arch/arm/plat-spear/shirq.c
+ *
+ * SPEAr platform shared irq layer source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/spinlock.h>
+#include <plat/shirq.h>
+
+struct spear_shirq *shirq;
+static DEFINE_SPINLOCK(lock);
+
+static void shirq_irq_mask(unsigned irq)
+{
+	struct spear_shirq *shirq = get_irq_chip_data(irq);
+	u32 val, id = irq - shirq->dev_config[0].virq;
+	unsigned long flags;
+
+	if ((shirq->regs.enb_reg == -1) || shirq->dev_config[id].enb_mask == -1)
+		return;
+
+	spin_lock_irqsave(&lock, flags);
+	val = readl(shirq->regs.base + shirq->regs.enb_reg);
+	if (shirq->regs.reset_to_enb)
+		val |= shirq->dev_config[id].enb_mask;
+	else
+		val &= ~(shirq->dev_config[id].enb_mask);
+	writel(val, shirq->regs.base + shirq->regs.enb_reg);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+static void shirq_irq_unmask(unsigned irq)
+{
+	struct spear_shirq *shirq = get_irq_chip_data(irq);
+	u32 val, id = irq - shirq->dev_config[0].virq;
+	unsigned long flags;
+
+	if ((shirq->regs.enb_reg == -1) || shirq->dev_config[id].enb_mask == -1)
+		return;
+
+	spin_lock_irqsave(&lock, flags);
+	val = readl(shirq->regs.base + shirq->regs.enb_reg);
+	if (shirq->regs.reset_to_enb)
+		val &= ~(shirq->dev_config[id].enb_mask);
+	else
+		val |= shirq->dev_config[id].enb_mask;
+	writel(val, shirq->regs.base + shirq->regs.enb_reg);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+static struct irq_chip shirq_chip = {
+	.name		= "spear_shirq",
+	.ack		= shirq_irq_mask,
+	.mask		= shirq_irq_mask,
+	.unmask		= shirq_irq_unmask,
+};
+
+static void shirq_handler(unsigned irq, struct irq_desc *desc)
+{
+	u32 i, val, mask;
+	struct spear_shirq *shirq = get_irq_data(irq);
+
+	desc->chip->ack(irq);
+	while ((val = readl(shirq->regs.base + shirq->regs.status_reg) &
+				shirq->regs.status_reg_mask)) {
+		for (i = 0; (i < shirq->dev_count) && val; i++) {
+			if (!(shirq->dev_config[i].status_mask & val))
+				continue;
+
+			generic_handle_irq(shirq->dev_config[i].virq);
+
+			/* clear interrupt */
+			val &= ~shirq->dev_config[i].status_mask;
+			if ((shirq->regs.clear_reg == -1) ||
+					shirq->dev_config[i].clear_mask == -1)
+				continue;
+			mask = readl(shirq->regs.base + shirq->regs.clear_reg);
+			if (shirq->regs.reset_to_clear)
+				mask &= ~shirq->dev_config[i].clear_mask;
+			else
+				mask |= shirq->dev_config[i].clear_mask;
+			writel(mask, shirq->regs.base + shirq->regs.clear_reg);
+		}
+	}
+	desc->chip->unmask(irq);
+}
+
+int spear_shirq_register(struct spear_shirq *shirq)
+{
+	int i;
+
+	if (!shirq || !shirq->dev_config || !shirq->regs.base)
+		return -EFAULT;
+
+	if (!shirq->dev_count)
+		return -EINVAL;
+
+	set_irq_chained_handler(shirq->irq, shirq_handler);
+	for (i = 0; i < shirq->dev_count; i++) {
+		set_irq_chip(shirq->dev_config[i].virq, &shirq_chip);
+		set_irq_handler(shirq->dev_config[i].virq, handle_simple_irq);
+		set_irq_flags(shirq->dev_config[i].virq, IRQF_VALID);
+		set_irq_chip_data(shirq->dev_config[i].virq, shirq);
+	}
+
+	set_irq_data(shirq->irq, shirq);
+	return 0;
+}
-- 
1.6.0.2
