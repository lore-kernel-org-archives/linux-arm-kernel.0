From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Fri, 13 Oct 2017 09:29:25 +0000
Subject: [PATCH -next] ARM: OMAP2+: omap_device: fix error return code in
 omap_device_copy_resources()
Message-ID: <1507886965-156349-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix to return error code -EINVAL from the irq_of_parse_and_map() error
handling case instead of 0, as done elsewhere in this function.

Fixes: d85a2d61432a ("ARM: OMAP2+: Populate legacy resources for dma
and smartreflex")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/arm/mach-omap2/omap_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 713fc6b..d45cbfd 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -433,8 +433,10 @@ void omap_device_delete(struct omap_device *od)
 		irq = irq_of_parse_and_map(child, 0);
 	if (!irq)
 		irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
+	if (!irq) {
+		error = -EINVAL;
 		goto free;
+	}
 
 	/* Legacy DMA code needs interrupt name to be "0" */
 	res[1].start = irq;
