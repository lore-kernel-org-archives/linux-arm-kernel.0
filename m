From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 12 Mar 2015 22:55:48 +0100
Subject: [PATCH v3 02/15] ARM: ARMv7-M: Enlarge vector table up to 256 entries
In-Reply-To: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1426197361-19290-3-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Coquelin <mcoquelin.stm32@gmail.com>

>From Cortex-M reference manuals, the nvic supports up to 240 interrupts.
So the number of entries in vectors table is up to 256.

This patch adds a new config flag to specify the number of external interrupts.
Some ifdeferies are added in order to respect the natural alignment without
wasting too much space on smaller systems.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/kernel/entry-v7m.S | 13 +++++++++----
 arch/arm/mm/Kconfig         | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 8944f49..b6c8bb9 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -117,9 +117,14 @@ ENTRY(__switch_to)
 ENDPROC(__switch_to)
 
 	.data
-	.align	8
+#if CONFIG_CPU_V7M_NUM_IRQ <= 112
+	.align	9
+#else
+	.align	10
+#endif
+
 /*
- * Vector table (64 words => 256 bytes natural alignment)
+ * Vector table (Natural alignment need to be ensured)
  */
 ENTRY(vector_table)
 	.long	0			@ 0 - Reset stack pointer
@@ -138,6 +143,6 @@ ENTRY(vector_table)
 	.long	__invalid_entry		@ 13 - Reserved
 	.long	__pendsv_entry		@ 14 - PendSV
 	.long	__invalid_entry		@ 15 - SysTick
-	.rept	64 - 16
-	.long	__irq_entry		@ 16..64 - External Interrupts
+	.rept	CONFIG_CPU_V7M_NUM_IRQ
+	.long	__irq_entry		@ External Interrupts
 	.endr
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9b4f29e..aec53b4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -604,6 +604,21 @@ config CPU_USE_DOMAINS
 	  This option enables or disables the use of domain switching
 	  via the set_fs() function.
 
+config CPU_V7M_NUM_IRQ
+	int "Number of external interrupts connected to the NVIC"
+	depends on CPU_V7M
+	default 90 if ARCH_STM32
+	default 38 if ARCH_EFM32
+	default 240
+	help
+	  This option indicates the number of interrupts connected to the NVIC.
+	  The value can be larger than the real number of interrupts supported
+	  by the system, but must not be lower.
+	  The default value is 240, corresponding to the maximum number of
+	  interrupts supported by the NVIC on Cortex-M family.
+
+	  If unsure, keep default value.
+
 #
 # CPU supports 36-bit I/O
 #
-- 
1.9.1
