From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:05 +0100
Subject: [PATCH 03/14] [media] coda: simplify optional reset handling
In-Reply-To: <20170130114116.22089-1-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
Message-ID: <20170130114116.22089-3-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to
describe optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional
without special cases and to call reset_control_reset unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/platform/coda/coda-common.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 9e6bdafa16f58..a8482c44b82d2 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1840,8 +1840,7 @@ static int coda_hw_init(struct coda_dev *dev)
 	if (ret)
 		goto err_clk_ahb;
 
-	if (dev->rstc)
-		reset_control_reset(dev->rstc);
+	reset_control_reset(dev->rstc);
 
 	/*
 	 * Copy the first CODA_ISRAM_SIZE in the internal SRAM.
@@ -2216,13 +2215,8 @@ static int coda_probe(struct platform_device *pdev)
 	dev->rstc = devm_reset_control_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(dev->rstc)) {
 		ret = PTR_ERR(dev->rstc);
-		if (ret == -ENOENT || ret == -ENOTSUPP) {
-			dev->rstc = NULL;
-		} else {
-			dev_err(&pdev->dev, "failed get reset control: %d\n",
-				ret);
-			return ret;
-		}
+		dev_err(&pdev->dev, "failed get reset control: %d\n", ret);
+		return ret;
 	}
 
 	/* Get IRAM pool from device tree or platform data */
-- 
2.11.0
