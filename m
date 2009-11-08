From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sun, 08 Nov 2009 19:52:31 +0100
Subject: [REPOST PATCH 3/3] MXC: add platform resources for i.MX21 USB host
	controller.
In-Reply-To: <20091108185217.14742.32892.stgit@srv002.fuzzey.net>
References: <20091108185217.14742.32892.stgit@srv002.fuzzey.net>
Message-ID: <20091108185231.14742.23365.stgit@srv002.fuzzey.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 arch/arm/mach-mx2/devices.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-mx2/devices.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index 3522397..4e6f5a0 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -565,3 +565,30 @@ int __init mxc_register_gpios(void)
 {
 	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
 }
+
+#ifdef CONFIG_MACH_MX21
+static struct resource mx21_usbhc_resources[] = {
+	[0] = {
+		.start	= USBOTG_BASE_ADDR,
+		.end	= USBOTG_BASE_ADDR + 0x1FFF,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= MXC_INT_USBHOST,
+		.end		= MXC_INT_USBHOST,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mx21_usbhc_device = {
+	.name		= "imx21-hcd",
+	.id		= 0,
+	.dev		= {
+		.dma_mask = &mx21_usbhc_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(mx21_usbhc_resources),
+	.resource	= mx21_usbhc_resources,
+};
+#endif
+
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index d315406..f3b4d8b 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -26,4 +26,5 @@ extern struct platform_device mxc_usbh2;
 extern struct platform_device mxc_spi_device0;
 extern struct platform_device mxc_spi_device1;
 extern struct platform_device mxc_spi_device2;
+extern struct platform_device mx21_usbhc_device;
 
