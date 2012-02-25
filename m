From: stigge@antcom.de (Roland Stigge)
Date: Sat, 25 Feb 2012 16:35:13 +0100
Subject: [PATCH v2 1/6] ARM: LPC32xx: Fix irq on GPI_28
In-Reply-To: <1330184118-10270-1-git-send-email-stigge@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
Message-ID: <1330184118-10270-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPI_28 IRQ was not registered properly. The registration of
IRQ_LPC32XX_GPI_28 was added and the (wrong) IRQ_LPC32XX_GPI_11 at
LPC32XX_SIC1_IRQ(4) was replaced by IRQ_LPC32XX_GPI_28 (see manual of
LPC32xx / interrupt controller).

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-lpc32xx/include/mach/irqs.h |    2 +-
 arch/arm/mach-lpc32xx/irq.c               |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/include/mach/irqs.h
+++ linux-2.6/arch/arm/mach-lpc32xx/include/mach/irqs.h
@@ -61,7 +61,7 @@
  */
 #define IRQ_LPC32XX_JTAG_COMM_TX	LPC32XX_SIC1_IRQ(1)
 #define IRQ_LPC32XX_JTAG_COMM_RX	LPC32XX_SIC1_IRQ(2)
-#define IRQ_LPC32XX_GPI_11		LPC32XX_SIC1_IRQ(4)
+#define IRQ_LPC32XX_GPI_28		LPC32XX_SIC1_IRQ(4)
 #define IRQ_LPC32XX_TS_P		LPC32XX_SIC1_IRQ(6)
 #define IRQ_LPC32XX_TS_IRQ		LPC32XX_SIC1_IRQ(7)
 #define IRQ_LPC32XX_TS_AUX		LPC32XX_SIC1_IRQ(8)
--- linux-2.6.orig/arch/arm/mach-lpc32xx/irq.c
+++ linux-2.6/arch/arm/mach-lpc32xx/irq.c
@@ -118,6 +118,10 @@ static const struct lpc32xx_event_info l
 		.event_group = &lpc32xx_event_pin_regs,
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_06_BIT,
 	},
+	[IRQ_LPC32XX_GPI_28] = {
+		.event_group = &lpc32xx_event_pin_regs,
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_28_BIT,
+	},
 	[IRQ_LPC32XX_GPIO_00] = {
 		.event_group = &lpc32xx_event_int_regs,
 		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_00_BIT,
