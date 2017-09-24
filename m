From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Sun, 24 Sep 2017 12:04:54 +0300
Subject: [PATCH 2/2] of: configure DMA for host1x devices
In-Reply-To: <20170924090454.28116-1-mperttunen@nvidia.com>
References: <20170924090454.28116-1-mperttunen@nvidia.com>
Message-ID: <20170924090454.28116-2-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devices in the host1x bus rely on the old behavior of of_dma_configure
to set up DMA ops. Add a check for them into of_dma_configure.

We must do the check using a string comparison instead of using
pointers since the host1x bus can be compiled into a module.

Fixes: 723288836628 ("of: restrict DMA configuration")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/of/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 64b710265d39..12368418cd33 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -104,6 +104,9 @@ int of_dma_configure(struct device *dev, struct device_node *np)
 		if (!dev_is_pci(dev) &&
 #ifdef CONFIG_ARM_AMBA
 		    dev->bus != &amba_bustype &&
+#endif
+#if IS_ENABLED(CONFIG_TEGRA_HOST1X)
+		    !(dev->bus && !strcmp("host1x", dev->bus->name)) &&
 #endif
 		    dev->bus != &platform_bus_type)
 			return ret == -ENODEV ? 0 : ret;
-- 
2.14.1
