From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 16:25:12 +0530
Subject: [PATCH 05/10 v3] Input: cpcap-pwrbutton: Handle return value of
 platform_get_irq
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Message-ID: <ae8e2bcc48ceeb7cf04f4ec19e7cc76d51fcf58f.1510999558.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              return irq instead of -ENODEV.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/misc/cpcap-pwrbutton.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap-pwrbutton.c
index 0abef63..3a0626b 100644
--- a/drivers/input/misc/cpcap-pwrbutton.c
+++ b/drivers/input/misc/cpcap-pwrbutton.c
@@ -57,6 +57,9 @@ static int cpcap_power_button_probe(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 	int err;
 
+	if (irq <= 0)
+		return irq;
+
 	button = devm_kmalloc(&pdev->dev, sizeof(*button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-- 
2.7.4
