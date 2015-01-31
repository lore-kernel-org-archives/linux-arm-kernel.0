From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Jan 2015 23:36:23 +0100
Subject: [PATCH] ARM: pxa: pxa27x skip default device initialization with DT
Message-ID: <1422743783-32511-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting via DT, the default PXA devices must not have been probed
before, otherwise the augmented information from the device tree is
ignored.

This is the twin commit of commit 82ce44d104dc ("ARM: pxa3xx: skip
default device initialization when booting via DT").

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa27x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 0485248..b5abdeb 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -307,8 +307,12 @@ static int __init pxa27x_init(void)
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 
-		pxa_register_device(&pxa27x_device_gpio, &pxa27x_gpio_info);
-		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		if (!of_have_populated_dt()) {
+			pxa_register_device(&pxa27x_device_gpio,
+					    &pxa27x_gpio_info);
+			ret = platform_add_devices(devices,
+						   ARRAY_SIZE(devices));
+		}
 	}
 
 	return ret;
-- 
2.1.0
