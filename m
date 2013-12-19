From: levex@linux.com (Levente Kurusa)
Date: Thu, 19 Dec 2013 16:03:22 +0100
Subject: [PATCH 11/38] arm: mach-integrator: add missing put_device call
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Message-ID: <1387465429-3568-12-git-send-email-levex@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required so that we give up the last reference to the device.
Calling put_device on the failed device will allow lm_device_release to be
called which will kfree() the struct lm_device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/arm/mach-integrator/lm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/lm.c b/arch/arm/mach-integrator/lm.c
index f52c7af..1199f38 100644
--- a/arch/arm/mach-integrator/lm.c
+++ b/arch/arm/mach-integrator/lm.c
@@ -89,8 +89,10 @@ int lm_device_register(struct lm_device *dev)
 	ret = request_resource(&iomem_resource, &dev->resource);
 	if (ret == 0) {
 		ret = device_register(&dev->dev);
-		if (ret)
+		if (ret) {
 			release_resource(&dev->resource);
+			put_device(&dev->dev);
+		}
 	}
 	return ret;
 }
-- 
1.8.3.1
