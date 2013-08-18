From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Sun, 18 Aug 2013 10:49:00 +0530
Subject: [PATCH v3 4/7] ARM: davinci: devices.c: support gpio platform device
In-Reply-To: <1376803143-13738-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1376803143-13738-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <1376803143-13738-5-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philip Avinash <avinashphilip@ti.com>

DaVinci GPIO driver now uses platform device model.
Add a GPIO platform register API to convert the
traditional DaVinci  SoCs to use the new model.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
[nsekhar at ti.com: move function declaration to local header,
simplify commit message]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/mach-davinci/davinci.h |    2 ++
 arch/arm/mach-davinci/devices.c |   13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 2ab5d57..6dfc038 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -53,6 +53,8 @@ extern void __iomem *davinci_sysmod_base;
 #define DAVINCI_SYSMOD_VIRT(x)	(davinci_sysmod_base + (x))
 void davinci_map_sysmod(void);
 
+int davinci_gpio_register(struct resource *res, int size, void *pdata);
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 111573c..b0fac4e 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -318,6 +318,19 @@ static void davinci_init_wdt(void)
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
-- 
1.7.9.5
