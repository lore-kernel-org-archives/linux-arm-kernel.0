From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Nov 2015 13:49:50 +0100
Subject: [PATCH v2 4/4] ARM: amba: Properly handle devices with power domains
In-Reply-To: <1448542190-19498-1-git-send-email-m.szyprowski@samsung.com>
References: <1448542190-19498-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1448542190-19498-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To read pid/cid registers, the probed device need to be properly turned on.
When it is inside a power domain, the bus code should ensure that the
given power domain is enabled before trying to access device's registers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/amba/bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 72ebf9b..4fc1976 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -364,6 +364,10 @@ static int read_periphid(struct amba_device *d, unsigned int *periphid)
 	if (!tmp)
 		return -ENOMEM;
 
+	ret = dev_pm_domain_attach(&d->dev, true);
+	if (ret == -EPROBE_DEFER)
+		goto err_unmap;
+
 	ret = amba_get_enable_pclk(d);
 	if (ret == 0) {
 		u32 pid, cid;
@@ -388,6 +392,8 @@ static int read_periphid(struct amba_device *d, unsigned int *periphid)
 			ret = -ENODEV;
 	}
 
+	dev_pm_domain_detach(&d->dev, true);
+err_unmap:
 	iounmap(tmp);
 
 	return ret;
-- 
1.9.2
