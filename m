From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Apr 2013 13:24:28 +0100
Subject: [PATCH 1/9 v2] crypto: ux500/hash - Prepare clock before enabling it
In-Reply-To: <1366280825-31136-2-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20130419122428.GC3432@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Slight change of plan for v2.

Now we're doing a seperate clk_prepare(), as the clk_enable() in the
previous patch turned out to be called inside a spin_lock().

Arnd, can you confirm your Ack please?

---

crypto: ux500/hash - Prepare clock before enabling it

If we fail to prepare the ux500-hash clock before enabling it the
platform will fail to boot. Here we insure this happens.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andreas Westin <andreas.westin@stericsson.com>
Cc: linux-crypto at vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 632c333..1e8b2f3 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -1727,11 +1727,17 @@ static int ux500_hash_probe(struct platform_device *pdev)
 		goto out_regulator;
 	}
 
+	ret = clk_prepare(device_data->clk);
+	if (ret) {
+		dev_err(dev, "[%s] clk_prepare() failed!", __func__);
+		goto out_clk;
+	}
+
 	/* Enable device power (and clock) */
 	ret = hash_enable_power(device_data, false);
 	if (ret) {
 		dev_err(dev, "[%s]: hash_enable_power() failed!", __func__);
-		goto out_clk;
+		goto out_clk_unprepare;
 	}
 
 	ret = hash_check_hw(device_data);
@@ -1763,6 +1769,9 @@ static int ux500_hash_probe(struct platform_device *pdev)
 out_power:
 	hash_disable_power(device_data, false);
 
+out_clk_unprepare:
+	clk_unprepare(device_data->clk);
+
 out_clk:
 	clk_put(device_data->clk);
 
@@ -1827,6 +1836,7 @@ static int ux500_hash_remove(struct platform_device *pdev)
 		dev_err(dev, "[%s]: hash_disable_power() failed",
 			__func__);
 
+	clk_unprepare(device_data->clk);
 	clk_put(device_data->clk);
 	regulator_put(device_data->regulator);
