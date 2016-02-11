From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 11 Feb 2016 22:23:17 +0100
Subject: [PATCH 3/4] ARM: pxa: add the number of DMA requestor lines
In-Reply-To: <1455225798-9510-1-git-send-email-robert.jarzmik@free.fr>
References: <1455225798-9510-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1455225798-9510-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare the number of DMA requestor lines per platform :
 - for pxa25x: 40 requestor lines
 - for pxa27x: 75 requestor lines
 - for pxa3xx: 100 requestor lines

This information will be used to activate the DMA flow control or not.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi        | 1 +
 arch/arm/boot/dts/pxa3xx.dtsi        | 1 +
 arch/arm/mach-pxa/devices.c          | 3 ++-
 arch/arm/mach-pxa/pxa25x.c           | 2 +-
 arch/arm/mach-pxa/pxa27x.c           | 2 +-
 arch/arm/mach-pxa/pxa3xx.c           | 2 +-
 arch/arm/plat-pxa/include/plat/dma.h | 2 +-
 7 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index ef366b204c89..1f5bdfd8f9e0 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -13,6 +13,7 @@
 			interrupts = <25>;
 			#dma-channels = <32>;
 			#dma-cells = <2>;
+			#requestors = <75>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index cf6998a0804d..d10d932d1d2b 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -12,6 +12,7 @@
 			interrupts = <25>;
 			#dma-channels = <32>;
 			#dma-cells = <2>;
+			#requestors = <100>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 6e12c162506f..d9ff6e4dd854 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1233,6 +1233,7 @@ void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info)
 
 static struct mmp_dma_platdata pxa_dma_pdata = {
 	.dma_channels	= 0,
+	.nb_requestors	= 0,
 };
 
 static struct resource pxa_dma_resource[] = {
@@ -1261,7 +1262,7 @@ static struct platform_device pxa2xx_pxa_dma = {
 	.resource	= pxa_dma_resource,
 };
 
-void __init pxa2xx_set_dmac_info(int nb_channels)
+void __init pxa2xx_set_dmac_info(int nb_channels, int nb_requestors)
 {
 	pxa_dma_pdata.dma_channels = nb_channels;
 	pxa_register_device(&pxa2xx_pxa_dma, &pxa_dma_pdata);
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index a177bf45feef..823504f48f80 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -206,7 +206,7 @@ static int __init pxa25x_init(void)
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 
-		pxa2xx_set_dmac_info(16);
+		pxa2xx_set_dmac_info(16, 40);
 		pxa_register_device(&pxa25x_device_gpio, &pxa25x_gpio_info);
 		ret = platform_add_devices(pxa25x_devices,
 					   ARRAY_SIZE(pxa25x_devices));
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 73e96270dc53..d84239c89639 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -310,7 +310,7 @@ static int __init pxa27x_init(void)
 		if (!of_have_populated_dt()) {
 			pxa_register_device(&pxa27x_device_gpio,
 					    &pxa27x_gpio_info);
-			pxa2xx_set_dmac_info(32);
+			pxa2xx_set_dmac_info(32, 75);
 			ret = platform_add_devices(devices,
 						   ARRAY_SIZE(devices));
 		}
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index a1c4c888f246..fb0adb669124 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -450,7 +450,7 @@ static int __init pxa3xx_init(void)
 		if (of_have_populated_dt())
 			return 0;
 
-		pxa2xx_set_dmac_info(32);
+		pxa2xx_set_dmac_info(32, 100);
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 		if (ret)
 			return ret;
diff --git a/arch/arm/plat-pxa/include/plat/dma.h b/arch/arm/plat-pxa/include/plat/dma.h
index 28848b344e2d..ceba3e4184fc 100644
--- a/arch/arm/plat-pxa/include/plat/dma.h
+++ b/arch/arm/plat-pxa/include/plat/dma.h
@@ -95,6 +95,6 @@ static inline int pxad_toggle_reserved_channel(int legacy_channel)
 }
 #endif
 
-extern void __init pxa2xx_set_dmac_info(int nb_channels);
+extern void __init pxa2xx_set_dmac_info(int nb_channels, int nb_requestors);
 
 #endif /* __PLAT_DMA_H */
-- 
2.1.4
