From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Mon, 27 Jun 2016 19:53:10 +0530
Subject: [PATCH] pinctrl: stm32: Modify error handling for pinctrl_register
Message-ID: <20160627142310.GA26798@amitoj-Inspiron-3542>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl_register returns an ERR_PTR on error.

The Coccinelle semantic patch used to make this change is as follows:

@@
expression e,e1,e2;
@@

e = pinctrl_register(...)
... when != e = e1
if (
-   e == NULL
+   IS_ERR(e)
   ) {
     ...
     return
-      e2
+      PTR_ERR(e)
     ;
     }

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 8deb566..857bb3d 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -814,9 +814,9 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	pctl->dev = &pdev->dev;
 
 	pctl->pctl_dev = pinctrl_register(&pctl->pctl_desc, &pdev->dev, pctl);
-	if (!pctl->pctl_dev) {
+	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "Failed pinctrl registration\n");
-		return -EINVAL;
+		return PTR_ERR(pctl->pctl_dev);
 	}
 
 	for (i = 0; i < pctl->nbanks; i++)
-- 
1.9.1
