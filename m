From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Feb 2012 09:01:40 +0100
Subject: [PATCH] regulator mc13783: bail out without platform data
Message-ID: <1330502500-30567-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the platform data pointer is used without checking it. Bail out
in the driver instead of crashing the kernel.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/mc13783-regulator.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index 8e9b90a..6c0face 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -344,6 +344,9 @@ static int __devinit mc13783_regulator_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s id %d\n", __func__, pdev->id);
 
+	if (!pdata)
+		return -EINVAL;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv) +
 			pdata->num_regulators * sizeof(priv->regulators[0]),
 			GFP_KERNEL);
-- 
1.7.9.1
