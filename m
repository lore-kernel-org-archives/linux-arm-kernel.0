From: charu@ti.com (Charulatha V)
Date: Fri, 22 Apr 2011 16:38:15 +0530
Subject: [RFC PATCH 01/18] OMAP1: GPIO: Fix mpuio_init() call
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Message-ID: <1303470512-19671-2-git-send-email-charu@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In OMAP1 GPIO, MPUIO bank's initialization is called as part of
omap_gpio_sysinit() which is an "arch_initcall". mpuio_init()
relies on the gpio_bank pointer of MPUIO bank whose memory is
allocated only during omap_gpio_probe(). Hence move mpuio_init()
call as part of probe after the gpio_bank pointer is initialized.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d2adcdd..9164bd4 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1697,6 +1697,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		ret = init_gpio_info(pdev);
 		if (ret)
 			return ret;
+		if (cpu_class_is_omap1())
+			mpuio_init();
 	}
 
 	id = pdev->id;
@@ -2110,8 +2112,6 @@ static int __init omap_gpio_sysinit(void)
 {
 	int ret = 0;
 
-	mpuio_init();
-
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret == 0) {
-- 
1.7.1
