From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 25 Nov 2015 13:58:09 +0100
Subject: [PATCH 1/2] drivers: amba: properly handle devices with power domains
In-Reply-To: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
References: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1448456289-31960-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To read pid/cid registers, the probed device need to be properly turned on.
When it is inside a power domain, the bus code should ensure that the
given power domain is enabled before trying to access device's registers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/amba/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f009936..25715cb 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -373,6 +373,12 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 		goto err_release;
 	}
 
+	ret = dev_pm_domain_attach(&dev->dev, true);
+	if (ret) {
+		iounmap(tmp);
+		goto err_release;
+	}
+
 	ret = amba_get_enable_pclk(dev);
 	if (ret == 0) {
 		u32 pid, cid;
@@ -398,6 +404,7 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 	}
 
 	iounmap(tmp);
+	dev_pm_domain_detach(&dev->dev, true);
 
 	if (ret)
 		goto err_release;
-- 
1.9.2
