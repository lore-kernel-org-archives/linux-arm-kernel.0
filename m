From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 27 Feb 2013 14:33:19 +0800
Subject: [PATCH v10 8/8] usb: chipidea: imx: fix the error that using
 uninitialized pointer
In-Reply-To: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1361946799-29471-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the core's probe fails, the platform layer may not get core's
private data, if the platform tries to use struct ci13xxx, it will
use uninitialized pointer. Besides, if the core's probe fails,
the platform layer should know it, and let its probe fail too.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci13xxx_imx.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 5499cf8..720ea92 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -239,6 +239,13 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	ci = platform_get_drvdata(plat_ci);
+
+	if (!ci) {
+		ret = -ENODEV;
+		dev_err(&pdev->dev, 
+			"some wrong at ci core's initialization\n");
+		goto err_clk;
+	}
 	/*
 	 * Internal vbus on/off policy
 	 * - Always on for host only function
-- 
1.7.0.4
