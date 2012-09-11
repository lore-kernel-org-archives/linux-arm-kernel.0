From: niej0001@gmail.com (Jun Nie)
Date: Tue, 11 Sep 2012 10:43:40 +0800
Subject: [PATCH v2 1/1] ARM: mmp: enable pxa910 gpio wake up
Message-ID: <CAGA24MLRJRZp1h4p-WVoPcRDJSe0fkbu5NRRR+Q_XsghnB9O8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable pxa910 gpio wake up setting via feeding pm
subsystem set_wake hook in plat info

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/mach-mmp/pxa910.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 6da52e9..7fb6543 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -9,6 +9,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/gpio-pxa.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
@@ -23,6 +24,7 @@
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
+#include <mach/pm-pxa910.h>

 #include "common.h"
 #include "clock.h"
@@ -180,11 +182,18 @@ struct resource pxa910_resource_gpio[] = {
 	},
 };

+static struct pxa_gpio_platform_data pxa910_gpio_info __initdata = {
+	.gpio_set_wake = pxa910_set_wake,
+};
+
 struct platform_device pxa910_device_gpio = {
 	.name		= "pxa-gpio",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pxa910_resource_gpio),
 	.resource	= pxa910_resource_gpio,
+	.dev            = {
+		.platform_data  = &pxa910_gpio_info,
+	},
 };

 static struct resource pxa910_resource_rtc[] = {
-- 
1.7.0.4
