From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 30 Sep 2013 11:49:37 +0200
Subject: [PATCH 3/3] [RFC] ARM: prepare ARMv7-M for MULTIPLATFORM use
In-Reply-To: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1380534577-15076-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v7-M is a third group that is incompatible with both v4/v5 and v6/v7.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
This behaves strange but I think is robust not to allow broken configs:

When v4/v5 is selected, v6/v7 and v7m are available for enabling, too.
When v6/v7 is selected the other choices are disabled
When v7m is selected only v6/v7 are available for enabling.
---
 arch/arm/Kconfig            | 11 ++++++++---
 arch/arm/kernel/entry-v7m.S |  6 ++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d873a34..4d749fa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -881,7 +881,7 @@ comment "CPU Core family selection"
 
 config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
-	depends on !ARCH_MULTI_V6_V7
+	depends on !ARCH_MULTI_V6_V7 && !ARCH_MULTI_V7M
 	select ARCH_MULTI_V4_V5
 	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
 		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
@@ -889,7 +889,7 @@ config ARCH_MULTI_V4T
 
 config ARCH_MULTI_V5
 	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
-	depends on !ARCH_MULTI_V6_V7
+	depends on !ARCH_MULTI_V6_V7 && !ARCH_MULTI_V7M
 	select ARCH_MULTI_V4_V5
 	select CPU_ARM926T if (!CPU_ARM946E || CPU_ARM1020 || \
 		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
@@ -912,8 +912,13 @@ config ARCH_MULTI_V7
 config ARCH_MULTI_V6_V7
 	bool
 
+config ARCH_MULTI_V7M
+	bool "ARMv7-M based platforms (Cortex-M)"
+	depends on !ARCH_MULTI_V6_V7 && !MMU
+	select CPU_V7M
+
 config ARCH_MULTI_CPU_AUTO
-	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
+	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7 || ARCH_MULTI_V7M)
 	select ARCH_MULTI_V5
 
 endmenu
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 52b2643..f72ced6 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -14,8 +14,6 @@
 #include <asm/thread_notify.h>
 #include <asm/v7m.h>
 
-#include <mach/entry-macro.S>
-
 #include "entry-header.S"
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -141,3 +139,7 @@ ENTRY(vector_table)
 	.rept	64 - 16
 	.long	__irq_entry		@ 16..64 - External Interrupts
 	.endr
+
+	.globl  handle_arch_irq
+handle_arch_irq:
+	.long	0
-- 
1.8.4.rc3
