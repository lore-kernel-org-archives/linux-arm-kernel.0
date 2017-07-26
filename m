From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Wed, 26 Jul 2017 11:34:43 +0200
Subject: [PATCH 1/6] nvmem: lpc18xx-eeprom: explicitly request exclusive reset
 control
In-Reply-To: <20170726093448.2564-1-srinivas.kandagatla@linaro.org>
References: <20170726093448.2564-1-srinivas.kandagatla@linaro.org>
Message-ID: <20170726093448.2564-2-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/lpc18xx_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index c81ae4c..6c7e2c4 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -197,7 +197,7 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rst = devm_reset_control_get(dev, NULL);
+	rst = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rst)) {
 		dev_err(dev, "failed to get reset: %ld\n", PTR_ERR(rst));
 		ret = PTR_ERR(rst);
-- 
2.9.3
