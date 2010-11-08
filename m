From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon,  8 Nov 2010 20:37:43 +0800
Subject: [PATCH 2/9] ARM: pxa: redefine irqs.h
In-Reply-To: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of componets of PXA93x are shared with PXA3xx. From CPUID, they belong
to same family. But it's confustion that code of PXA93x is depend on PXA3xx
by default.

Now clean the scope of both PXA3xx and PXA93X. Only PXA300/PXA310/PXA320 is
family member of PXA3xx. Only PXA930/PXA935 is family member of PXA93x. Remove
the code dependany on IRQ definition.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/irqs.h |   47 ++++++++++-----------------------
 arch/arm/mach-pxa/irq.c               |    6 ++--
 2 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index d372caa..cb7ee26 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -21,16 +21,14 @@
 
 #define PXA_IRQ(x)	(PXA_ISA_IRQ_NUM + (x))
 
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 #define IRQ_SSP3	PXA_IRQ(0)	/* SSP3 service request */
 #define IRQ_MSL		PXA_IRQ(1)	/* MSL Interface interrupt */
-#define IRQ_USBH2	PXA_IRQ(2)	/* USB Host interrupt 1 (OHCI) */
-#define IRQ_USBH1	PXA_IRQ(3)	/* USB Host interrupt 2 (non-OHCI) */
+#define IRQ_USBH2	PXA_IRQ(2)	/* USB Host interrupt 1 (OHCI,PXA27x) */
+#define IRQ_USBH1	PXA_IRQ(3)	/* USB Host interrupt 2 (non-OHCI,PXA27x) */
 #define IRQ_KEYPAD	PXA_IRQ(4)	/* Key pad controller */
-#define IRQ_MEMSTK	PXA_IRQ(5)	/* Memory Stick interrupt */
+#define IRQ_MEMSTK	PXA_IRQ(5)	/* Memory Stick interrupt (PXA27x) */
+#define IRQ_ACIPC0	PXA_IRQ(5)	/* AP-CP Communication (PXA930) */
 #define IRQ_PWRI2C	PXA_IRQ(6)	/* Power I2C interrupt */
-#endif
-
 #define IRQ_HWUART	PXA_IRQ(7)	/* HWUART Transmit/Receive/Error (PXA26x) */
 #define IRQ_OST_4_11	PXA_IRQ(7)	/* OS timer 4-11 matches (PXA27x) */
 #define	IRQ_GPIO0	PXA_IRQ(8)	/* GPIO0 Edge Detect */
@@ -38,7 +36,8 @@
 #define	IRQ_GPIO_2_x	PXA_IRQ(10)	/* GPIO[2-x] Edge Detect */
 #define	IRQ_USB		PXA_IRQ(11)	/* USB Service */
 #define	IRQ_PMU		PXA_IRQ(12)	/* Performance Monitoring Unit */
-#define	IRQ_I2S		PXA_IRQ(13)	/* I2S Interrupt */
+#define	IRQ_I2S		PXA_IRQ(13)	/* I2S Interrupt (PXA27x) */
+#define IRQ_SSP4	PXA_IRQ(13)	/* SSP4 service request (PXA3xx) */
 #define	IRQ_AC97	PXA_IRQ(14)	/* AC97 Interrupt */
 #define IRQ_ASSP	PXA_IRQ(15)	/* Audio SSP Service Request (PXA25x) */
 #define IRQ_USIM	PXA_IRQ(15)     /* Smart Card interface interrupt (PXA27x) */
@@ -47,6 +46,7 @@
 #define	IRQ_LCD		PXA_IRQ(17)	/* LCD Controller Service Request */
 #define	IRQ_I2C		PXA_IRQ(18)	/* I2C Service Request */
 #define	IRQ_ICP		PXA_IRQ(19)	/* ICP Transmit/Receive/Error */
+#define IRQ_ACIPC2	PXA_IRQ(19)	/* AP-CP Communication (PXA930) */
 #define	IRQ_STUART	PXA_IRQ(20)	/* STUART Transmit/Receive/Error */
 #define	IRQ_BTUART	PXA_IRQ(21)	/* BTUART Transmit/Receive/Error */
 #define	IRQ_FFUART	PXA_IRQ(22)	/* FFUART Transmit/Receive/Error*/
@@ -60,19 +60,17 @@
 #define	IRQ_RTC1Hz	PXA_IRQ(30)	/* RTC HZ Clock Tick */
 #define	IRQ_RTCAlrm	PXA_IRQ(31)	/* RTC Alarm */
 
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 #define IRQ_TPM		PXA_IRQ(32)	/* TPM interrupt */
 #define IRQ_CAMERA	PXA_IRQ(33)	/* Camera Interface */
-#endif
-
-#ifdef CONFIG_PXA3xx
-#define IRQ_SSP4	PXA_IRQ(13)	/* SSP4 service request */
 #define IRQ_CIR		PXA_IRQ(34)	/* Consumer IR */
 #define IRQ_COMM_WDT	PXA_IRQ(35) 	/* Comm WDT interrupt */
 #define IRQ_TSI		PXA_IRQ(36)	/* Touch Screen Interface (PXA320) */
+#define IRQ_ENHROT	PXA_IRQ(37)	/* Enhanced Rotary (PXA930) */
 #define IRQ_USIM2	PXA_IRQ(38)	/* USIM2 Controller */
-#define IRQ_GCU		PXA_IRQ(39)	/* Graphics Controller */
+#define IRQ_GCU		PXA_IRQ(39)	/* Graphics Controller (PXA3xx) */
+#define IRQ_ACIPC1	PXA_IRQ(40)	/* AP-CP Communication (PXA930) */
 #define IRQ_MMC2	PXA_IRQ(41)	/* MMC2 Controller */
+#define IRQ_TRKBALL	PXA_IRQ(43)	/* Track Ball (PXA930) */
 #define IRQ_1WIRE	PXA_IRQ(44)	/* 1-Wire Controller */
 #define IRQ_NAND	PXA_IRQ(45)	/* NAND Controller */
 #define IRQ_USB2	PXA_IRQ(46)	/* USB 2.0 Device Controller */
@@ -80,30 +78,13 @@
 #define IRQ_WAKEUP1	PXA_IRQ(50)	/* EXT_WAKEUP1 */
 #define IRQ_DMEMC	PXA_IRQ(51)	/* Dynamic Memory Controller */
 #define IRQ_MMC3	PXA_IRQ(55)	/* MMC3 Controller (PXA310) */
-#endif
 
-#ifdef CONFIG_CPU_PXA935
 #define IRQ_U2O		PXA_IRQ(64)	/* USB OTG 2.0 Controller (PXA935) */
 #define IRQ_U2H		PXA_IRQ(65)	/* USB Host 2.0 Controller (PXA935) */
-
-#define IRQ_MMC3_PXA935	PXA_IRQ(72)	/* MMC3 Controller (PXA935) */
-#define IRQ_MMC4_PXA935	PXA_IRQ(73)	/* MMC4 Controller (PXA935) */
-#define IRQ_MMC5_PXA935	PXA_IRQ(74)	/* MMC5 Controller (PXA935) */
-
+#define IRQ_PXA935_MMC0	PXA_IRQ(72)	/* MMC0 Controller (PXA935) */
+#define IRQ_PXA935_MMC1	PXA_IRQ(73)	/* MMC1 Controller (PXA935) */
+#define IRQ_PXA935_MMC2	PXA_IRQ(74)	/* MMC2 Controller (PXA935) */
 #define IRQ_U2P		PXA_IRQ(93)	/* USB PHY D+/D- Lines (PXA935) */
-#endif
-
-#ifdef CONFIG_CPU_PXA930
-#define IRQ_ENHROT	PXA_IRQ(37)	/* Enhanced Rotary (PXA930) */
-#define IRQ_ACIPC0	PXA_IRQ(5)
-#define IRQ_ACIPC1	PXA_IRQ(40)
-#define IRQ_ACIPC2	PXA_IRQ(19)
-#define IRQ_TRKBALL	PXA_IRQ(43)	/* Track Ball */
-#endif
-
-#ifdef CONFIG_CPU_PXA950
-#define IRQ_GC500	PXA_IRQ(70)	/* Graphics Controller (PXA950) */
-#endif
 
 #define PXA_GPIO_IRQ_BASE	PXA_IRQ(96)
 #define PXA_GPIO_IRQ_NUM	(192)
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 1beb40f..05df84d 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -134,7 +134,7 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 	}
 
 	/* initialize interrupt priority */
-	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
+	if (cpu_is_pxa27x() || cpu_is_pxa3xx() || cpu_is_pxa93x()) {
 		for (i = 0; i < irq_nr; i++)
 			IPR(i) = i | (1 << 31);
 	}
@@ -165,7 +165,7 @@ static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
 		_ICMR(irq) = 0;
 	}
 
-	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
+	if (cpu_is_pxa27x() || cpu_is_pxa3xx() || cpu_is_pxa93x()) {
 		for (i = 0; i < pxa_internal_irq_nr; i++)
 			saved_ipr[i] = IPR(i);
 	}
@@ -177,7 +177,7 @@ static int pxa_irq_resume(struct sys_device *dev)
 {
 	int i, irq = PXA_IRQ(0);
 
-	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
+	if (cpu_is_pxa27x() || cpu_is_pxa3xx() || cpu_is_pxa93x()) {
 		for (i = 0; i < pxa_internal_irq_nr; i++)
 			IPR(i) = saved_ipr[i];
 	}
-- 
1.5.6.5
