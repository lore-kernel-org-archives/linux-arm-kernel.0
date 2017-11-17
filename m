From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:50:03 +0530
Subject: [PATCH 8/10 v2] Input: twl4030-pwrbutton: Handle return value of
 platform_get_irq
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510949239.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510949239.git.arvind.yadav.cs@gmail.com>
Message-ID: <5a63dbd55d3d61de6b0a5c530172ea6ff6f85462.1510949239.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              return error insted of -ENOMEM.

 drivers/input/misc/twl4030-pwrbutton.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index b307cca..64e7d4b 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -58,6 +58,9 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 	int err;
 
+	if (irq < 0)
+		return irq;
+
 	pwr = devm_input_allocate_device(&pdev->dev);
 	if (!pwr) {
 		dev_err(&pdev->dev, "Can't allocate power button\n");
-- 
2.7.4
