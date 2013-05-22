From: avinashphilip@ti.com (Philip Avinash)
Date: Wed, 22 May 2013 12:40:28 +0530
Subject: [PATCH 05/11] ARM: davinci: creation of gpio platform device for dm
 platforms
In-Reply-To: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1369206634-6778-6-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio controller resource information being associated with
davinci_soc_info structure and not created any device. Hence davinci
gpio didn't fall under proper device model. This patch creates gpio
davinci as a platform device for dm platforms.
Also add daivinci_register_gpio API to create platform device for dm*
platforms.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 arch/arm/mach-davinci/devices.c             |   13 +++++++++++++
 arch/arm/mach-davinci/include/mach/common.h |    2 ++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index a7068a3..b4f345b 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -313,6 +313,19 @@ static void davinci_init_wdt(void)
 	platform_device_register(&davinci_wdt_device);
 }
 
+static struct platform_device davinci_gpio_device = {
+	.name		= "davinci_gpio",
+	.id		= -1,
+};
+
+int davinci_gpio_register(struct resource *res, int size, void *pdata)
+{
+	davinci_gpio_device.resource = res;
+	davinci_gpio_device.num_resources = size;
+	davinci_gpio_device.dev.platform_data = pdata;
+	return platform_device_register(&davinci_gpio_device);
+}
+
 /*-------------------------------------------------------------------------*/
 
 /*-------------------------------------------------------------------------*/
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index b124b77..bd389ba 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -14,6 +14,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/ioport.h>
 
 extern void davinci_timer_init(void);
 
@@ -83,6 +84,7 @@ extern void davinci_common_init(struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
 void davinci_restart(char mode, const char *cmd);
 void davinci_init_late(void);
+int davinci_gpio_register(struct resource *res, int size, void *pdata);
 
 #ifdef CONFIG_DAVINCI_RESET_CLOCKS
 int davinci_clk_disable_unused(void);
-- 
1.7.9.5
