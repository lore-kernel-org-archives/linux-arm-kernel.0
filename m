From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Jul 2018 12:23:31 +0100
Subject: [PATCH] drivers/perf: arm-ccn: Use devm_ioremap_resource() to map
 memory
Message-ID: <1532604211-28609-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of checking the return value of platform_get_resource(), we can
use devm_ioremap_resource() which has the NULL pointer check and the
memory region requesting. devm_ioremap_resource is designed to replace
calls to devm_request_mem_region followed by devm_ioremap, so let's use
the same.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/perf/arm-ccn.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

Hi Will,

Just came across this when I was trying to use devm_ioremap_resource
for vexpress-syscfg instead of adding a patch that adds more unnecessary
NULL ptr checks based on coccinelle warnings. All other perf drivers
seem to do the same except this one. I changed this too along
with vexpress-syscfg, but forgot to send.

Regards,
Sudeep


diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index b416ee18e6bb..4b15c36f4631 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1485,17 +1485,9 @@ static int arm_ccn_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ccn);

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
-	if (!devm_request_mem_region(ccn->dev, res->start,
-			resource_size(res), pdev->name))
-		return -EBUSY;
-
-	ccn->base = devm_ioremap(ccn->dev, res->start,
-				resource_size(res));
-	if (!ccn->base)
-		return -EFAULT;
+	ccn->base = devm_ioremap_resource(ccn->dev, res);
+	if (IS_ERR(ccn->base))
+		return PTR_ERR(ccn->base);

 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res)
--
2.7.4
