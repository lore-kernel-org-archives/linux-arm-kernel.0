From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 11 Mar 2011 12:23:40 +0200
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1299839023-16601-5-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index aec87f7..f1bb98a 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -42,6 +42,7 @@
 #include <plat/pxa27x_keypad.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/ohci.h>
+#include <mach/pm.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -705,6 +706,16 @@ static struct pxaohci_platform_data z2_ohci_platform_data = {
 	.power_budget	= 500,
 };
 
+#ifdef CONFIG_PM
+static void z2_power_off(void)
+{
+	local_irq_disable();
+	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP);
+}
+#else
+#define z2_power_off   NULL
+#endif
+
 /******************************************************************************
  * Machine init
  ******************************************************************************/
@@ -727,6 +738,8 @@ static void __init z2_init(void)
 	z2_leds_init();
 	z2_keys_init();
 	z2_pmic_init();
+
+	pm_power_off = z2_power_off;
 }
 
 MACHINE_START(ZIPIT2, "Zipit Z2")
-- 
1.7.4.1
