From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 13 Jun 2014 12:23:48 +0200
Subject: [PATCH v2] i2c: sun6-p2wi: fix call to snprintf
Message-ID: <1402655028-6214-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes possible issue in case pdev name contains formatting characters.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Reported-by: Kees Cook <keescook@google.com>
---
Changes since v1:
- use strlcpy instead of snprintf

 drivers/i2c/busses/i2c-sun6i-p2wi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 5d2d678..09de4fd 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -237,7 +237,7 @@ static int p2wi_probe(struct platform_device *pdev)
 	if (IS_ERR(p2wi->regs))
 		return PTR_ERR(p2wi->regs);
 
-	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
+	strlcpy(p2wi->adapter.name, pdev->name, sizeof(p2wi->adapter.name));
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "failed to retrieve irq: %d\n", irq);
-- 
1.8.3.2
