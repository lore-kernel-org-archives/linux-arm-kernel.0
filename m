From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 10 Oct 2011 18:37:52 +0200
Subject: [PATCH 4/4] ARM: at91/dma: DMA controller registering with DT support
In-Reply-To: <9723283e7097730f568bf7c2f3a93ae42c6bc5ca.1318264339.git.nicolas.ferre@atmel.com>
References: <1314075338.22120.3.camel@vkoul-udesk3>
	<9723283e7097730f568bf7c2f3a93ae42c6bc5ca.1318264339.git.nicolas.ferre@atmel.com>
Message-ID: <e292fbb24a98b7cfda8ea83364956a50e1cb120f.1318264339.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree support on at91sam9g45 family SoC. Only call
platform_device_register() if no dma-controller node is
found in device tree.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index c9b897f..cee7287 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -64,7 +64,14 @@ static struct platform_device at_hdmac_device = {
 
 void __init at91_add_device_hdmac(void)
 {
-	platform_device_register(&at_hdmac_device);
+	struct device_node *of_node =
+		of_find_node_by_name(NULL, "dma-controller");
+
+	if (of_node) {
+		of_node_put(of_node);
+	} else {
+		platform_device_register(&at_hdmac_device);
+	}
 }
 #else
 void __init at91_add_device_hdmac(void) {}
-- 
1.7.5.4
