From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 02 Dec 2015 08:21:43 +0100
Subject: [PATCH v4 3/3] ARM: amba: Properly handle devices with power domains
In-Reply-To: <1449040903-26674-1-git-send-email-m.szyprowski@samsung.com>
References: <1449040903-26674-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1449040903-26674-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To read pid/cid registers, the probed device need to be properly turned on.
When it is inside a power domain, the bus code should ensure that the
given power domain is enabled before trying to access device's registers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 643127f..570033b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -60,6 +60,10 @@ static int amba_read_periphid(struct amba_device *dev)
 	if (!tmp)
 		return -ENOMEM;
 
+	ret = dev_pm_domain_attach(&dev->dev, true);
+	if (ret == -EPROBE_DEFER)
+		goto err_unmap;
+
 	ret = amba_get_enable_pclk(dev);
 	if (ret == 0) {
 		u32 pid, cid;
@@ -84,6 +88,8 @@ static int amba_read_periphid(struct amba_device *dev)
 			ret = -ENODEV;
 	}
 
+	dev_pm_domain_detach(&dev->dev, true);
+err_unmap:
 	iounmap(tmp);
 
 	return ret;
-- 
1.9.2
