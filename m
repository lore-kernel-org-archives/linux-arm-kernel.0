From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 23 Dec 2015 11:59:24 +0100
Subject: [PATCH v5 1/5] drivers: nvdimm: ensure no negative value gets returned
 on positive match
In-Reply-To: <1450868368-5650-1-git-send-email-m.szyprowski@samsung.com>
References: <1450868368-5650-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1450868368-5650-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dan Williams <dan.j.williams@intel.com>

This patch ensures that existing bus match callbacks don't return
negative values (which might be interpreted as potential errors in the
future) in case of positive match.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/nvdimm/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 7e2c43f..2b2181c 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -62,7 +62,7 @@ static int nvdimm_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct nd_device_driver *nd_drv = to_nd_device_driver(drv);
 
-	return test_bit(to_nd_device_type(dev), &nd_drv->type);
+	return !!test_bit(to_nd_device_type(dev), &nd_drv->type);
 }
 
 static struct module *to_bus_provider(struct device *dev)
-- 
1.9.2
