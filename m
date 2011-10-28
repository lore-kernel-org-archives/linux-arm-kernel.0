From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:56 +0100
Subject: [PATCH 28/51] ARM: mach-netx: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-29-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-netx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-netx/generic.c             |    7 +++++++
 arch/arm/mach-netx/include/mach/system.h |    6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index 00023b5..13ed7a3 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -180,8 +180,15 @@ void __init netx_init_irq(void)
 	irq_set_chained_handler(NETX_IRQ_HIF, netx_hif_demux_handler);
 }
 
+static void netx_arch_reset(char mode, const char *cmd)
+{
+	writel(NETX_SYSTEM_RES_CR_FIRMW_RES_EN | NETX_SYSTEM_RES_CR_FIRMW_RES,
+	       NETX_SYSTEM_RES_CR);
+}
+
 static int __init netx_init(void)
 {
+	arm_arch_reset = netx_arch_reset;
 	return platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-netx/include/mach/system.h b/arch/arm/mach-netx/include/mach/system.h
index dc7b4bc..83ae2b1 100644
--- a/arch/arm/mach-netx/include/mach/system.h
+++ b/arch/arm/mach-netx/include/mach/system.h
@@ -19,10 +19,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include "netx-regs.h"
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -30,8 +26,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	writel(NETX_SYSTEM_RES_CR_FIRMW_RES_EN | NETX_SYSTEM_RES_CR_FIRMW_RES,
-	       NETX_SYSTEM_RES_CR);
 }
 
 #endif
-- 
1.7.4.1
