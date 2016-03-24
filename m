From: david@lechnology.com (David Lechner)
Date: Thu, 24 Mar 2016 18:51:35 -0500
Subject: [PATCH v3 10/16] ARM: davinci: da8xx: Add CFGCHIPn syscon platform
 declaration.
In-Reply-To: <1458863503-31121-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
Message-ID: <1458863503-31121-11-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CFGCHIPn registers are used by a number of devices, so using a syscon
device to share them. The first consumer of this will by the phy-da8xx-usb
driver.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes: This is a new patch. There is one syscon device for all CFGCHIP
registers.


 arch/arm/mach-davinci/board-da830-evm.c     |  4 ++++
 arch/arm/mach-davinci/board-da850-evm.c     |  4 ++++
 arch/arm/mach-davinci/board-mityomapl138.c  |  4 ++++
 arch/arm/mach-davinci/board-omapl138-hawk.c |  4 ++++
 arch/arm/mach-davinci/devices-da8xx.c       | 28 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h  |  2 ++
 6 files changed, 46 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 605d444..3051cb6 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -586,6 +586,10 @@ static __init void da830_evm_init(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	int ret;
 
+	ret = da8xx_register_cfgchip();
+	if (ret)
+		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
+
 	ret = da830_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 8e4539f..ec5cb10 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1345,6 +1345,10 @@ static __init void da850_evm_init(void)
 {
 	int ret;
 
+	ret = da8xx_register_cfgchip();
+	if (ret)
+		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
+
 	ret = da850_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index d97c588..c04b45d 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -509,6 +509,10 @@ static void __init mityomapl138_init(void)
 {
 	int ret;
 
+	ret = da8xx_register_cfgchip();
+	if (ret)
+		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
+
 	/* for now, no special EDMA channels are reserved */
 	ret = da850_register_edma(NULL);
 	if (ret)
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index d4930b6..8691a25 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -294,6 +294,10 @@ static __init void omapl138_hawk_init(void)
 {
 	int ret;
 
+	ret = da8xx_register_cfgchip();
+	if (ret)
+		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
+
 	ret = da850_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 725e693..69d11a1 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -11,6 +11,7 @@
  * (at your option) any later version.
  */
 #include <linux/init.h>
+#include <linux/platform_data/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/dma-contiguous.h>
 #include <linux/serial_8250.h>
@@ -1109,3 +1110,30 @@ int __init da850_register_sata(unsigned long refclkpn)
 	return platform_device_register(&da850_sata_device);
 }
 #endif
+
+static struct syscon_platform_data da8xx_cfgchip_platform_data = {
+	.label	= "cfgchip",
+};
+
+static struct resource da8xx_cfgchip_resources[] = {
+	{
+		.start	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP0_REG,
+		.end	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP4_REG + 3,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device da8xx_cfgchip_device = {
+	.name	= "syscon",
+	.id	= 0,
+	.dev	= {
+		.platform_data	= &da8xx_cfgchip_platform_data,
+	},
+	.num_resources	= ARRAY_SIZE(da8xx_cfgchip_resources),
+	.resource	= da8xx_cfgchip_resources,
+};
+
+int __init da8xx_register_cfgchip(void)
+{
+	return platform_device_register(&da8xx_cfgchip_device);
+}
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index c367530..c32444b 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -61,6 +61,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_CFGCHIP1_REG	0x180
 #define DA8XX_CFGCHIP2_REG	0x184
 #define DA8XX_CFGCHIP3_REG	0x188
+#define DA8XX_CFGCHIP4_REG	0x18c
 
 #define DA8XX_SYSCFG1_BASE	(IO_PHYS + 0x22C000)
 #define DA8XX_SYSCFG1_VIRT(x)	(da8xx_syscfg1_base + (x))
@@ -116,6 +117,7 @@ void da8xx_rproc_reserve_cma(void);
 int da8xx_register_rproc(void);
 int da850_register_gpio(void);
 int da830_register_gpio(void);
+int da8xx_register_cfgchip(void);
 
 extern struct platform_device da8xx_serial_device[];
 extern struct emac_platform_data da8xx_emac_pdata;
-- 
1.9.1
