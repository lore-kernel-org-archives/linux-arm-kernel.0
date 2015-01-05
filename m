From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  5 Jan 2015 13:06:41 +0100
Subject: [PATCH 4/8] ARM: at91: time: move the system timer driver to
 drivers/clocksource
In-Reply-To: <1420459605-24561-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1420459605-24561-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1420459605-24561-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Import at91rm9200_time.c from mach-at91 as timer-atmel-st.c. Further cleanup is
required to get rid of the mach-at91 headers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Makefile                                           | 2 +-
 drivers/clocksource/Kconfig                                           | 4 ++++
 drivers/clocksource/Makefile                                          | 1 +
 .../at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c         | 0
 4 files changed, 6 insertions(+), 1 deletion(-)
 rename arch/arm/mach-at91/at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c (100%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 7b6424d40764..5d1ee3a6f115 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -7,7 +7,7 @@ obj-y		:= setup.o sysirq_mask.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= sam9_smc.o
 
 # CPU-specific support
-obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o
+obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9260)	+= at91sam9260.o
 obj-$(CONFIG_SOC_AT91SAM9261)	+= at91sam9261.o
 obj-$(CONFIG_SOC_AT91SAM9263)	+= at91sam9263.o
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index fc01ec27d3c8..ebc6dd77136e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -128,6 +128,10 @@ config ATMEL_PIT
 	select CLKSRC_OF if OF
 	def_bool SOC_AT91SAM9 || SOC_SAMA5
 
+config ATMEL_ST
+	select CLKSRC_OF if OF
+	def_bool SOC_AT91RM9200
+
 config CLKSRC_METAG_GENERIC
 	def_bool y if METAG
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 94d90b24b56b..b7380ded4e4c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_CLKSRC_OF)	+= clksrc-of.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
+obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/drivers/clocksource/timer-atmel-st.c
similarity index 100%
rename from arch/arm/mach-at91/at91rm9200_time.c
rename to drivers/clocksource/timer-atmel-st.c
-- 
2.1.0
