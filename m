From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Dec 2009 13:18:08 +0800
Subject: [PATCH 7/7] [ARM] pxa: move board board IRQ definitions out of irqs.h
In-Reply-To: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1261977488-18271-8-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/include/asm/hardware/it8152.h     |   12 +++++
 arch/arm/mach-pxa/include/mach/balloon3.h  |   10 ++++
 arch/arm/mach-pxa/include/mach/irqs.h      |   67 +---------------------------
 arch/arm/mach-pxa/include/mach/lpd270.h    |    4 ++
 arch/arm/mach-pxa/include/mach/lubbock.h   |   11 +++++
 arch/arm/mach-pxa/include/mach/mainstone.h |   17 +++++++
 arch/arm/mach-pxa/include/mach/pcm027.h    |    7 +++
 drivers/usb/gadget/pxa25x_udc.c            |    4 ++
 8 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/include/asm/hardware/it8152.h
index 74b5fff..6700c7f 100644
--- a/arch/arm/include/asm/hardware/it8152.h
+++ b/arch/arm/include/asm/hardware/it8152.h
@@ -75,6 +75,18 @@ extern unsigned long it8152_base_address;
   IT8152_PD_IRQ(1)  USB (USBR)
   IT8152_PD_IRQ(0)  Audio controller (ACR)
  */
+#define IT8152_IRQ(x)   (IRQ_BOARD_END + (x))
+
+/* IRQ-sources in 3 groups - local devices, LPC (serial), and external PCI */
+#define IT8152_LD_IRQ_COUNT     9
+#define IT8152_LP_IRQ_COUNT     16
+#define IT8152_PD_IRQ_COUNT     15
+
+/* Priorities: */
+#define IT8152_PD_IRQ(i)        IT8152_IRQ(i)
+#define IT8152_LP_IRQ(i)        (IT8152_IRQ(i) + IT8152_PD_IRQ_COUNT)
+#define IT8152_LD_IRQ(i)        (IT8152_IRQ(i) + IT8152_PD_IRQ_COUNT + IT8152_LP_IRQ_COUNT)
+
 /* frequently used interrupts */
 #define IT8152_PCISERR		IT8152_PD_IRQ(14)
 #define IT8152_H2PTADR		IT8152_PD_IRQ(13)
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index bfec09b..1a74106 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -129,6 +129,16 @@ enum balloon3_features {
 #define CPLD_AROUTING_LOONR2INT_BIT    6
 #define CPLD_AROUTING_LOONR2EXT_BIT    7
 
+/* Balloon3 Interrupts */
+#define BALLOON3_IRQ(x)		(IRQ_BOARD_START + (x))
+
+#define BALLOON3_BP_CF_NRDY_IRQ	BALLOON3_IRQ(0)
+#define BALLOON3_BP_NSTSCHG_IRQ	BALLOON3_IRQ(1)
+
+#define BALLOON3_AUX_NIRQ	IRQ_GPIO(BALLOON3_GPIO_AUX_NIRQ)
+#define BALLOON3_CODEC_IRQ	IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ)
+#define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)
+
 extern int balloon3_has(enum balloon3_features feature);
 
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index b35b3ac..ffc8314 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -150,74 +150,9 @@
 #define NR_IRQS			(IRQ_BOARD_START)
 #endif
 
-/*
- * Board specific IRQs.  Define them here.
- * Do not surround them with ifdefs.
- */
-#define LUBBOCK_IRQ(x)		(IRQ_BOARD_START + (x))
-#define LUBBOCK_SD_IRQ		LUBBOCK_IRQ(0)
-#define LUBBOCK_SA1111_IRQ	LUBBOCK_IRQ(1)
-#define LUBBOCK_USB_IRQ		LUBBOCK_IRQ(2)  /* usb connect */
-#define LUBBOCK_ETH_IRQ		LUBBOCK_IRQ(3)
-#define LUBBOCK_UCB1400_IRQ	LUBBOCK_IRQ(4)
-#define LUBBOCK_BB_IRQ		LUBBOCK_IRQ(5)
-#define LUBBOCK_USB_DISC_IRQ	LUBBOCK_IRQ(6)  /* usb disconnect */
-#define LUBBOCK_LAST_IRQ	LUBBOCK_IRQ(6)
-
-#define LPD270_IRQ(x)		(IRQ_BOARD_START + (x))
-#define LPD270_USBC_IRQ		LPD270_IRQ(2)
-#define LPD270_ETHERNET_IRQ	LPD270_IRQ(3)
-#define LPD270_AC97_IRQ		LPD270_IRQ(4)
-
-#define MAINSTONE_IRQ(x)	(IRQ_BOARD_START + (x))
-#define MAINSTONE_MMC_IRQ	MAINSTONE_IRQ(0)
-#define MAINSTONE_USIM_IRQ	MAINSTONE_IRQ(1)
-#define MAINSTONE_USBC_IRQ	MAINSTONE_IRQ(2)
-#define MAINSTONE_ETHERNET_IRQ	MAINSTONE_IRQ(3)
-#define MAINSTONE_AC97_IRQ	MAINSTONE_IRQ(4)
-#define MAINSTONE_PEN_IRQ	MAINSTONE_IRQ(5)
-#define MAINSTONE_MSINS_IRQ	MAINSTONE_IRQ(6)
-#define MAINSTONE_EXBRD_IRQ	MAINSTONE_IRQ(7)
-#define MAINSTONE_S0_CD_IRQ	MAINSTONE_IRQ(9)
-#define MAINSTONE_S0_STSCHG_IRQ	MAINSTONE_IRQ(10)
-#define MAINSTONE_S0_IRQ	MAINSTONE_IRQ(11)
-#define MAINSTONE_S1_CD_IRQ	MAINSTONE_IRQ(13)
-#define MAINSTONE_S1_STSCHG_IRQ	MAINSTONE_IRQ(14)
-#define MAINSTONE_S1_IRQ	MAINSTONE_IRQ(15)
-
-/* Balloon3 Interrupts */
-#define BALLOON3_IRQ(x)		(IRQ_BOARD_START + (x))
-
-#define BALLOON3_BP_CF_NRDY_IRQ	BALLOON3_IRQ(0)
-#define BALLOON3_BP_NSTSCHG_IRQ	BALLOON3_IRQ(1)
-
-#define BALLOON3_AUX_NIRQ	IRQ_GPIO(BALLOON3_GPIO_AUX_NIRQ)
-#define BALLOON3_CODEC_IRQ	IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ)
-#define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)
-
-/* phyCORE-PXA270 (PCM027) Interrupts */
-#define PCM027_IRQ(x)          (IRQ_BOARD_START + (x))
-#define PCM027_BTDET_IRQ       PCM027_IRQ(0)
-#define PCM027_FF_RI_IRQ       PCM027_IRQ(1)
-#define PCM027_MMCDET_IRQ      PCM027_IRQ(2)
-#define PCM027_PM_5V_IRQ       PCM027_IRQ(3)
-
-/* ITE8152 irqs */
 /* add IT8152 IRQs beyond BOARD_END */
 #ifdef CONFIG_PCI_HOST_ITE8152
-#define IT8152_IRQ(x)   (IRQ_BOARD_END + (x))
-
-/* IRQ-sources in 3 groups - local devices, LPC (serial), and external PCI */
-#define IT8152_LD_IRQ_COUNT     9
-#define IT8152_LP_IRQ_COUNT     16
-#define IT8152_PD_IRQ_COUNT     15
-
-/* Priorities: */
-#define IT8152_PD_IRQ(i)        IT8152_IRQ(i)
-#define IT8152_LP_IRQ(i)        (IT8152_IRQ(i) + IT8152_PD_IRQ_COUNT)
-#define IT8152_LD_IRQ(i)        (IT8152_IRQ(i) + IT8152_PD_IRQ_COUNT + IT8152_LP_IRQ_COUNT)
-
-#define IT8152_LAST_IRQ         IT8152_LD_IRQ(IT8152_LD_IRQ_COUNT - 1)
+#define IT8152_LAST_IRQ         (IRQ_BOARD_END + 40)
 
 #if NR_IRQS < (IT8152_LAST_IRQ+1)
 #undef NR_IRQS
diff --git a/arch/arm/mach-pxa/include/mach/lpd270.h b/arch/arm/mach-pxa/include/mach/lpd270.h
index f89fb71..0e6440c 100644
--- a/arch/arm/mach-pxa/include/mach/lpd270.h
+++ b/arch/arm/mach-pxa/include/mach/lpd270.h
@@ -34,5 +34,9 @@
 #define LPD270_INT_ETHERNET	(1 << 3)  /* Ethernet controller IRQ */
 #define LPD270_INT_USBC		(1 << 2)  /* USB client cable detection IRQ */
 
+#define LPD270_IRQ(x)		(IRQ_BOARD_START + (x))
+#define LPD270_USBC_IRQ		LPD270_IRQ(2)
+#define LPD270_ETHERNET_IRQ	LPD270_IRQ(3)
+#define LPD270_AC97_IRQ		LPD270_IRQ(4)
 
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/lubbock.h b/arch/arm/mach-pxa/include/mach/lubbock.h
index 751b748..a0d4247 100644
--- a/arch/arm/mach-pxa/include/mach/lubbock.h
+++ b/arch/arm/mach-pxa/include/mach/lubbock.h
@@ -34,6 +34,17 @@
 #define LUB_IRQ_SET_CLR		__LUB_REG(LUBBOCK_FPGA_PHYS + 0x0d0)
 #define LUB_GP			__LUB_REG(LUBBOCK_FPGA_PHYS + 0x100)
 
+/* Board specific IRQs */
+#define LUBBOCK_IRQ(x)		(IRQ_BOARD_START + (x))
+#define LUBBOCK_SD_IRQ		LUBBOCK_IRQ(0)
+#define LUBBOCK_SA1111_IRQ	LUBBOCK_IRQ(1)
+#define LUBBOCK_USB_IRQ		LUBBOCK_IRQ(2)  /* usb connect */
+#define LUBBOCK_ETH_IRQ		LUBBOCK_IRQ(3)
+#define LUBBOCK_UCB1400_IRQ	LUBBOCK_IRQ(4)
+#define LUBBOCK_BB_IRQ		LUBBOCK_IRQ(5)
+#define LUBBOCK_USB_DISC_IRQ	LUBBOCK_IRQ(6)  /* usb disconnect */
+#define LUBBOCK_LAST_IRQ	LUBBOCK_IRQ(6)
+
 #ifndef __ASSEMBLY__
 extern void lubbock_set_misc_wr(unsigned int mask, unsigned int set);
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/mainstone.h b/arch/arm/mach-pxa/include/mach/mainstone.h
index 3461c43..86e623a 100644
--- a/arch/arm/mach-pxa/include/mach/mainstone.h
+++ b/arch/arm/mach-pxa/include/mach/mainstone.h
@@ -117,4 +117,21 @@
 #define MST_PCMCIA_PWR_VCC_33   0x8	   /* voltage VCC = 3.3V */
 #define MST_PCMCIA_PWR_VCC_50   0x4	   /* voltage VCC = 5.0V */
 
+/* board specific IRQs */
+#define MAINSTONE_IRQ(x)	(IRQ_BOARD_START + (x))
+#define MAINSTONE_MMC_IRQ	MAINSTONE_IRQ(0)
+#define MAINSTONE_USIM_IRQ	MAINSTONE_IRQ(1)
+#define MAINSTONE_USBC_IRQ	MAINSTONE_IRQ(2)
+#define MAINSTONE_ETHERNET_IRQ	MAINSTONE_IRQ(3)
+#define MAINSTONE_AC97_IRQ	MAINSTONE_IRQ(4)
+#define MAINSTONE_PEN_IRQ	MAINSTONE_IRQ(5)
+#define MAINSTONE_MSINS_IRQ	MAINSTONE_IRQ(6)
+#define MAINSTONE_EXBRD_IRQ	MAINSTONE_IRQ(7)
+#define MAINSTONE_S0_CD_IRQ	MAINSTONE_IRQ(9)
+#define MAINSTONE_S0_STSCHG_IRQ	MAINSTONE_IRQ(10)
+#define MAINSTONE_S0_IRQ	MAINSTONE_IRQ(11)
+#define MAINSTONE_S1_CD_IRQ	MAINSTONE_IRQ(13)
+#define MAINSTONE_S1_STSCHG_IRQ	MAINSTONE_IRQ(14)
+#define MAINSTONE_S1_IRQ	MAINSTONE_IRQ(15)
+
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/pcm027.h b/arch/arm/mach-pxa/include/mach/pcm027.h
index 4dcd2e8..0408326 100644
--- a/arch/arm/mach-pxa/include/mach/pcm027.h
+++ b/arch/arm/mach-pxa/include/mach/pcm027.h
@@ -23,6 +23,13 @@
  * Definitions of CPU card resources only
  */
 
+/* phyCORE-PXA270 (PCM027) Interrupts */
+#define PCM027_IRQ(x)          (IRQ_BOARD_START + (x))
+#define PCM027_BTDET_IRQ       PCM027_IRQ(0)
+#define PCM027_FF_RI_IRQ       PCM027_IRQ(1)
+#define PCM027_MMCDET_IRQ      PCM027_IRQ(2)
+#define PCM027_PM_5V_IRQ       PCM027_IRQ(3)
+
 /* I2C RTC */
 #define PCM027_RTC_IRQ_GPIO	0
 #define PCM027_RTC_IRQ		IRQ_GPIO(PCM027_RTC_IRQ_GPIO)
diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index e6fedbd..be5fb34 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -65,6 +65,10 @@
 #include <mach/pxa25x-udc.h>
 #endif
 
+#ifdef CONFIG_ARCH_LUBBOCK
+#include <mach/lubbock.h>
+#endif
+
 #include <asm/mach/udc_pxa2xx.h>
 
 
-- 
1.6.3.3
