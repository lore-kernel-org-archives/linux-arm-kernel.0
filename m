From: agross@codeaurora.org (Andy Gross)
Date: Thu, 12 Jun 2014 14:34:11 -0500
Subject: [Patch v2 2/3] spi: qup: Fix order of spi_register_master
In-Reply-To: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
Message-ID: <1402601652-24641-3-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the devm_spi_register_master below the initialization of the
runtime_pm.  If done in the wrong order, the spi_register_master fails if any
probed slave devices issue SPI transactions.

Signed-off-by: Andy Gross <agross@codeaurora.org>
Acked-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/spi/spi-qup.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 3938c62..c08da38 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -619,16 +619,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	ret = devm_spi_register_master(dev, master);
-	if (ret)
-		goto error;
-
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret)
+		goto disable_pm;
+
 	return 0;
 
+disable_pm:
+	pm_runtime_disable(&pdev->dev);
 error:
 	clk_disable_unprepare(cclk);
 	clk_disable_unprepare(iclk);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
