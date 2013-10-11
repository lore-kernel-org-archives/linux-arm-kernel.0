From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Oct 2013 13:15:53 +0200
Subject: [PATCH 2/2] at91: add rtc irq fixup
In-Reply-To: <1381490153-9706-1-git-send-email-plagnioj@jcrosoft.com>
References: <1381490153-9706-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1381490153-9706-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the irq can still be on after a reset or power on as the IP are
powered by the backup power. This could lead to an interrupt dead lock
when the kernel boot. So disable them before booting.

Handle it in C as the DT may not provide or enable the RTC node but we still
need the fixup.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-at91/at91sam9g45.c              |  1 +
 arch/arm/mach-at91/at91sam9n12.c              |  6 ++++++
 arch/arm/mach-at91/at91sam9rl.c               |  1 +
 arch/arm/mach-at91/at91sam9x5.c               |  6 ++++++
 arch/arm/mach-at91/generic.h                  |  1 +
 arch/arm/mach-at91/include/mach/at91sam9n12.h |  2 ++
 arch/arm/mach-at91/include/mach/at91sam9x5.h  |  2 ++
 arch/arm/mach-at91/include/mach/sama5d3.h     |  2 ++
 arch/arm/mach-at91/irq_fixup.c                | 25 +++++++++++++++++++++++++
 arch/arm/mach-at91/sama5d3.c                  |  6 ++++++
 10 files changed, 52 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index b3e2693..654f9ab 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -375,6 +375,7 @@ static void __init at91sam9g45_ioremap_registers(void)
 static void __init at91sam9g45_initialize(void)
 {
 	at91_rtt_irq_fixup(AT91SAM9G45_BASE_RTT);
+	at91_rtc_irq_fixup(AT91SAM9G45_BASE_RTC);
 	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9g45_restart;
 
diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index c7d670d1..98a1739 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
@@ -223,7 +223,13 @@ static void __init at91sam9n12_map_io(void)
 	at91_init_sram(0, AT91SAM9N12_SRAM_BASE, AT91SAM9N12_SRAM_SIZE);
 }
 
+static void __init at91sam9n12_initialize(void)
+{
+	at91_rtc_irq_fixup(AT91SAM9N12_BASE_RTC);
+}
+
 AT91_SOC_START(at91sam9n12)
 	.map_io = at91sam9n12_map_io,
 	.register_clocks = at91sam9n12_register_clocks,
+	.init = at91sam9n12_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 01feae9..6acd6a4 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -292,6 +292,7 @@ static void __init at91sam9rl_ioremap_registers(void)
 static void __init at91sam9rl_initialize(void)
 {
 	at91_rtt_irq_fixup(AT91SAM9RL_BASE_RTT);
+	at91_rtc_irq_fixup(AT91SAM9RL_BASE_RTC);
 	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 916e5a1..26ef20a 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -322,6 +322,11 @@ static void __init at91sam9x5_map_io(void)
 	at91_init_sram(0, AT91SAM9X5_SRAM_BASE, AT91SAM9X5_SRAM_SIZE);
 }
 
+static void __init at91sam9x5_initialize(void)
+{
+	at91_rtc_irq_fixup(AT91SAM9X5_BASE_RTC);
+}
+
 /* --------------------------------------------------------------------
  *  Interrupt initialization
  * -------------------------------------------------------------------- */
@@ -329,4 +334,5 @@ static void __init at91sam9x5_map_io(void)
 AT91_SOC_START(at91sam9x5)
 	.map_io = at91sam9x5_map_io,
 	.register_clocks = at91sam9x5_register_clocks,
+	.init = at91sam9x5_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index c7ad514..7d377f3 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -36,6 +36,7 @@ extern int  __init at91_aic5_of_init(struct device_node *node,
 				    struct device_node *parent);
 
 void at91_rtt_irq_fixup(uint32_t addr);
+void at91_rtc_irq_fixup(uint32_t addr);
 
  /* Timer */
 extern void at91rm9200_ioremap_st(u32 addr);
diff --git a/arch/arm/mach-at91/include/mach/at91sam9n12.h b/arch/arm/mach-at91/include/mach/at91sam9n12.h
index d374b87..6a1d457 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9n12.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9n12.h
@@ -48,6 +48,8 @@
 #define AT91SAM9N12_BASE_USART2	0xf8024000
 #define AT91SAM9N12_BASE_USART3	0xf8028000
 
+#define AT91SAM9N12_BASE_RTC	0xfffffeb0
+
 /*
  * Internal Memory.
  */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9x5.h b/arch/arm/mach-at91/include/mach/at91sam9x5.h
index c75ee19..24e281c 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9x5.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9x5.h
@@ -54,6 +54,8 @@
 #define AT91SAM9X5_BASE_USART1	0xf8020000
 #define AT91SAM9X5_BASE_USART2	0xf8024000
 
+#define AT91SAM9X5_BASE_RTC	0xfffffeb0
+
 /*
  * Internal Memory.
  */
diff --git a/arch/arm/mach-at91/include/mach/sama5d3.h b/arch/arm/mach-at91/include/mach/sama5d3.h
index 31096a8..b5d045e 100644
--- a/arch/arm/mach-at91/include/mach/sama5d3.h
+++ b/arch/arm/mach-at91/include/mach/sama5d3.h
@@ -72,6 +72,8 @@
 #define SAMA5D3_BASE_USART2	0xf8020000
 #define SAMA5D3_BASE_USART3	0xf8024000
 
+#define SAMA5D3_BASE_RTC	0xfffffeb0
+
 /*
  * Internal Memory
  */
diff --git a/arch/arm/mach-at91/irq_fixup.c b/arch/arm/mach-at91/irq_fixup.c
index a93588f..38bdfec 100644
--- a/arch/arm/mach-at91/irq_fixup.c
+++ b/arch/arm/mach-at91/irq_fixup.c
@@ -31,3 +31,28 @@ void at91_rtt_irq_fixup(uint32_t addr)
 	writel(mr &~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN), reg);
 	iounmap(base);
 }
+
+
+#define	AT91_RTC_IDR		0x24			/* Interrupt Disable Register */
+
+/*
+ * As the RTC is powered by the backup power so if the interrupt
+ * is still on when the kernel start, the kernel will end up with
+ * dead lock interrupt that it can not clear. Because the interrupt line is
+ * shared with the basic timer (PIT) on AT91_ID_SYS.
+ */
+void at91_rtc_irq_fixup(uint32_t addr)
+{
+	void __iomem *reg;
+	void __iomem *base;
+
+	base = ioremap(addr, 256);
+	if (!base)
+		return;
+
+	reg = base + AT91_RTC_IDR;
+
+	writel(0x5, reg);
+
+	iounmap(base);
+}
diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
index 4012797..548b37d 100644
--- a/arch/arm/mach-at91/sama5d3.c
+++ b/arch/arm/mach-at91/sama5d3.c
@@ -371,7 +371,13 @@ static void __init sama5d3_map_io(void)
 	at91_init_sram(0, SAMA5D3_SRAM_BASE, SAMA5D3_SRAM_SIZE);
 }
 
+static void __init sama5d3_initialize(void)
+{
+	at91_rtc_irq_fixup(SAMA5D3_BASE_RTC);
+}
+
 AT91_SOC_START(sama5d3)
 	.map_io = sama5d3_map_io,
 	.register_clocks = sama5d3_register_clocks,
+	.init = sama5d3_initialize,
 AT91_SOC_END
-- 
1.8.4.rc3
