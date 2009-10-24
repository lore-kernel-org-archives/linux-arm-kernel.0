From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:14:02 +0400
Subject: [PATCH 10/20] SA1100: h3100/h3600: remove now unused
	assign_h3600_egpio handlers
In-Reply-To: <1256415129-22701-1-git-send-email-mad_soft@inbox.ru>
References: <1256415129-22701-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256415251-22735-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all users of assign_h3600_egpio now converted to gpiolib, we
can safely remove all assign_h3600_egpio handling code and
definitions.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c                   |  139 ------------------------
 arch/arm/mach-sa1100/include/mach/h3600.h      |   23 ----
 arch/arm/mach-sa1100/include/mach/h3600_gpio.h |   22 ----
 3 files changed, 0 insertions(+), 184 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 5e6011c..6792dd1 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -49,9 +49,6 @@
 
 #include "generic.h"
 
-void (*assign_h3600_egpio)(enum ipaq_egpio_type x, int level);
-EXPORT_SYMBOL(assign_h3600_egpio);
-
 struct gpio_default_state {
 	int gpio;
 	int mode;
@@ -306,72 +303,6 @@ static void __init h3xxx_map_io(void)
 
 #ifdef CONFIG_SA1100_H3100
 
-#define H3100_EGPIO	(*(volatile unsigned int *)H3600_EGPIO_VIRT)
-static unsigned int h3100_egpio = 0;
-
-static void h3100_control_egpio(enum ipaq_egpio_type x, int setp)
-{
-	unsigned int egpio = 0;
-	long	     gpio = 0;
-	unsigned long flags;
-
-	switch (x) {
-	case IPAQ_EGPIO_LCD_POWER:
-		egpio |= EGPIO_H3600_LCD_ON;
-		gpio  |= GPIO_H3100_LCD_3V_ON;
-		break;
-	case IPAQ_EGPIO_LCD_ENABLE:
-		break;
-	case IPAQ_EGPIO_CODEC_NRESET:
-		egpio |= EGPIO_H3600_CODEC_NRESET;
-		break;
-	case IPAQ_EGPIO_AUDIO_ON:
-		gpio |= GPIO_H3100_AUD_PWR_ON
-			| GPIO_H3100_AUD_ON;
-		break;
-	case IPAQ_EGPIO_QMUTE:
-		gpio |= GPIO_H3100_QMUTE;
-		break;
-	case IPAQ_EGPIO_OPT_NVRAM_ON:
-		egpio |= EGPIO_H3600_OPT_NVRAM_ON;
-		break;
-	case IPAQ_EGPIO_OPT_ON:
-		egpio |= EGPIO_H3600_OPT_ON;
-		break;
-	case IPAQ_EGPIO_CARD_RESET:
-		egpio |= EGPIO_H3600_CARD_RESET;
-		break;
-	case IPAQ_EGPIO_OPT_RESET:
-		egpio |= EGPIO_H3600_OPT_RESET;
-		break;
-	case IPAQ_EGPIO_IR_ON:
-		gpio |= GPIO_H3100_IR_ON;
-		break;
-	case IPAQ_EGPIO_IR_FSEL:
-		gpio |= GPIO_H3100_IR_FSEL;
-		break;
-	case IPAQ_EGPIO_RS232_ON:
-		egpio |= EGPIO_H3600_RS232_ON;
-		break;
-	case IPAQ_EGPIO_VPP_ON:
-		egpio |= EGPIO_H3600_VPP_ON;
-		break;
-	}
-
-	if (egpio || gpio) {
-		local_irq_save(flags);
-		if (setp) {
-			h3100_egpio |= egpio;
-			GPSR = gpio;
-		} else {
-			h3100_egpio &= ~egpio;
-			GPCR = gpio;
-		}
-		H3100_EGPIO = h3100_egpio;
-		local_irq_restore(flags);
-	}
-}
-
 #define H3100_DIRECT_EGPIO (GPIO_H3100_BT_ON	  \
 			  | GPIO_H3100_GPIO3	  \
 			  | GPIO_H3100_QMUTE	  \
@@ -409,9 +340,6 @@ static void __init h3100_map_io(void)
 	/* Older bootldrs put GPIO2-9 in alternate mode on the
 	   assumption that they are used for video */
 	GAFR &= ~H3100_DIRECT_EGPIO;
-
-	H3100_EGPIO = h3100_egpio;
-	assign_h3600_egpio = h3100_control_egpio;
 }
 
 /*
@@ -465,70 +393,6 @@ MACHINE_END
 
 #ifdef CONFIG_SA1100_H3600
 
-#define H3600_EGPIO	(*(volatile unsigned int *)H3600_EGPIO_VIRT)
-static unsigned int h3600_egpio = EGPIO_H3600_RS232_ON;
-
-static void h3600_control_egpio(enum ipaq_egpio_type x, int setp)
-{
-	unsigned int egpio = 0;
-	unsigned long flags;
-
-	switch (x) {
-	case IPAQ_EGPIO_LCD_POWER:
-		egpio |= EGPIO_H3600_LCD_ON |
-			 EGPIO_H3600_LCD_PCI |
-			 EGPIO_H3600_LCD_5V_ON |
-			 EGPIO_H3600_LVDD_ON;
-		break;
-	case IPAQ_EGPIO_LCD_ENABLE:
-		break;
-	case IPAQ_EGPIO_CODEC_NRESET:
-		egpio |= EGPIO_H3600_CODEC_NRESET;
-		break;
-	case IPAQ_EGPIO_AUDIO_ON:
-		egpio |= EGPIO_H3600_AUD_AMP_ON |
-			 EGPIO_H3600_AUD_PWR_ON;
-		break;
-	case IPAQ_EGPIO_QMUTE:
-		egpio |= EGPIO_H3600_QMUTE;
-		break;
-	case IPAQ_EGPIO_OPT_NVRAM_ON:
-		egpio |= EGPIO_H3600_OPT_NVRAM_ON;
-		break;
-	case IPAQ_EGPIO_OPT_ON:
-		egpio |= EGPIO_H3600_OPT_ON;
-		break;
-	case IPAQ_EGPIO_CARD_RESET:
-		egpio |= EGPIO_H3600_CARD_RESET;
-		break;
-	case IPAQ_EGPIO_OPT_RESET:
-		egpio |= EGPIO_H3600_OPT_RESET;
-		break;
-	case IPAQ_EGPIO_IR_ON:
-		egpio |= EGPIO_H3600_IR_ON;
-		break;
-	case IPAQ_EGPIO_IR_FSEL:
-		egpio |= EGPIO_H3600_IR_FSEL;
-		break;
-	case IPAQ_EGPIO_RS232_ON:
-		egpio |= EGPIO_H3600_RS232_ON;
-		break;
-	case IPAQ_EGPIO_VPP_ON:
-		egpio |= EGPIO_H3600_VPP_ON;
-		break;
-	}
-
-	if (egpio) {
-		local_irq_save(flags);
-		if (setp)
-			h3600_egpio |= egpio;
-		else
-			h3600_egpio &= ~egpio;
-		H3600_EGPIO = h3600_egpio;
-		local_irq_restore(flags);
-	}
-}
-
 /*
  * helper for sa1100fb
  */
@@ -567,9 +431,6 @@ static void __init h3600_map_io(void)
 	GPDR = GPIO_H3600_L3_CLOCK |
 	       GPIO_H3600_L3_MODE  | GPIO_H3600_L3_DATA  |
 	       GPIO_H3600_CLK_SET1 | GPIO_H3600_CLK_SET0;
-
-	H3600_EGPIO = h3600_egpio;	   /* Maintains across sleep? */
-	assign_h3600_egpio = h3600_control_egpio;
 }
 
 /*
diff --git a/arch/arm/mach-sa1100/include/mach/h3600.h b/arch/arm/mach-sa1100/include/mach/h3600.h
index 69f138c..19d7fe1 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600.h
+++ b/arch/arm/mach-sa1100/include/mach/h3600.h
@@ -66,27 +66,4 @@
 #define IRQ_GPIO_H3600_OPT_IRQ		IRQ_GPIO24
 #define IRQ_GPIO_H3600_COM_CTS		IRQ_GPIO25
 
-
-#ifndef __ASSEMBLY__
-
-enum ipaq_egpio_type {
-	IPAQ_EGPIO_LCD_POWER,	  /* Power to the LCD panel */
-	IPAQ_EGPIO_CODEC_NRESET,  /* Clear to reset the audio codec (remember to return high) */
-	IPAQ_EGPIO_AUDIO_ON,	  /* Audio power */
-	IPAQ_EGPIO_QMUTE,	  /* Audio muting */
-	IPAQ_EGPIO_OPT_NVRAM_ON,  /* Non-volatile RAM on extension sleeves (SPI interface) */
-	IPAQ_EGPIO_OPT_ON,	  /* Power to extension sleeves */
-	IPAQ_EGPIO_CARD_RESET,	  /* Reset PCMCIA cards on extension sleeve (???) */
-	IPAQ_EGPIO_OPT_RESET,	  /* Reset option pack (???) */
-	IPAQ_EGPIO_IR_ON,	  /* IR sensor/emitter power */
-	IPAQ_EGPIO_IR_FSEL,	  /* IR speed selection 1->fast, 0->slow */
-	IPAQ_EGPIO_RS232_ON,	  /* Maxim RS232 chip power */
-	IPAQ_EGPIO_VPP_ON,	  /* Turn on power to flash programming */
-	IPAQ_EGPIO_LCD_ENABLE,	  /* Enable/disable LCD controller */
-};
-
-extern void (*assign_h3600_egpio)(enum ipaq_egpio_type x, int level);
-
-#endif /* ASSEMBLY */
-
 #endif /* _INCLUDE_H3600_H_ */
diff --git a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h b/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
index ce80f1a..6cfbc64 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
@@ -76,28 +76,6 @@
 #define IRQ_GPIO_H3600_ACTION_BUTTON    IRQ_GPIO18
 #define IRQ_GPIO_H3600_OPT_DET		IRQ_GPIO27
 
-/* H3100 / 3600 EGPIO pins */
-#define EGPIO_H3600_VPP_ON		(1 << 0)
-#define EGPIO_H3600_CARD_RESET		(1 << 1)   /* reset the attached pcmcia/compactflash card.  active high. */
-#define EGPIO_H3600_OPT_RESET		(1 << 2)   /* reset the attached option pack.  active high. */
-#define EGPIO_H3600_CODEC_NRESET	(1 << 3)   /* reset the onboard UDA1341.  active low. */
-#define EGPIO_H3600_OPT_NVRAM_ON	(1 << 4)   /* apply power to optionpack nvram, active high. */
-#define EGPIO_H3600_OPT_ON		(1 << 5)   /* full power to option pack.  active high. */
-#define EGPIO_H3600_LCD_ON		(1 << 6)   /* enable 3.3V to LCD.  active high. */
-#define EGPIO_H3600_RS232_ON		(1 << 7)   /* UART3 transceiver force on.  Active high. */
-
-/* H3600 only EGPIO pins */
-#define EGPIO_H3600_LCD_PCI		(1 << 8)   /* LCD control IC enable.  active high. */
-#define EGPIO_H3600_IR_ON		(1 << 9)   /* apply power to IR module.  active high. */
-#define EGPIO_H3600_AUD_AMP_ON		(1 << 10)  /* apply power to audio power amp.  active high. */
-#define EGPIO_H3600_AUD_PWR_ON		(1 << 11)  /* apply power to reset of audio circuit.  active high. */
-#define EGPIO_H3600_QMUTE		(1 << 12)  /* mute control for onboard UDA1341.  active high. */
-#define EGPIO_H3600_IR_FSEL		(1 << 13)  /* IR speed select: 1->fast, 0->slow */
-#define EGPIO_H3600_LCD_5V_ON		(1 << 14)  /* enable 5V to LCD. active high. */
-#define EGPIO_H3600_LVDD_ON		(1 << 15)  /* enable 9V and -6.5V to LCD. */
-
-
-/* gpiolib versions of EGPIOs */
 
 /* H3100 / 3600 EGPIO pins */
 #define H3XXX_EGPIO_BASE		(GPIO_MAX + 1)
-- 
1.6.5.1.63.ga9d7.dirty
