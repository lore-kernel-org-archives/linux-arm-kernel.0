From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Sep 2013 17:41:19 +0200
Subject: [PATCH 8/8] ARM: plat-iop: pass physical base for GPIO
Message-ID: <1378741279-13143-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This alters the IOP platforms to pass a physical base for their
GPIO blocks and alters the driver to remap it when probing
instead of relying on the virtual addresses to be used.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-iop32x/iq31244.c | 2 +-
 arch/arm/mach-iop32x/iq80321.c | 2 +-
 arch/arm/mach-iop33x/iq80331.c | 2 +-
 arch/arm/mach-iop33x/iq80332.c | 2 +-
 drivers/gpio/gpio-iop.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index 4441a87..cbe6df4 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -282,7 +282,7 @@ void ep80219_power_off(void)
 }
 
 static struct resource iq31244_gpio_res[] = {
-	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_VIRT_BASE + 0x07c4), 0x10),
+	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_PHYS_BASE + 0x07c4), 0x10),
 };
 
 static void __init iq31244_init_machine(void)
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index b41cd49..82a1998 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -169,7 +169,7 @@ static struct platform_device iq80321_serial_device = {
 };
 
 static struct resource iq80321_gpio_res[] = {
-	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_VIRT_BASE + 0x07c4), 0x10),
+	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_PHYS_BASE + 0x07c4), 0x10),
 };
 
 static void __init iq80321_init_machine(void)
diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index 25741c4..e2cb65c 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -123,7 +123,7 @@ static struct platform_device iq80331_flash_device = {
 };
 
 static struct resource iq80331_gpio_res[] = {
-	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_VIRT_BASE + 0x1780), 0x10),
+	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_PHYS_BASE + 0x1780), 0x10),
 };
 
 static void __init iq80331_init_machine(void)
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index a3b56e1..0b6269d 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -123,7 +123,7 @@ static struct platform_device iq80332_flash_device = {
 };
 
 static struct resource iq80332_gpio_res[] = {
-	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_VIRT_BASE + 0x1780), 0x10),
+	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_PHYS_BASE + 0x1780), 0x10),
 };
 
 static void __init iq80332_init_machine(void)
diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
index 0d991d7..c22a61b 100644
--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -110,7 +110,7 @@ static int iop3xx_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = (void *) res->start;
+	base = devm_ioremap_resource(&pdev->dev, res);
 
 	return gpiochip_add(&iop3xx_chip);
 }
-- 
1.8.3.1
