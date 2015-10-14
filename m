From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 14 Oct 2015 17:04:55 +0100
Subject: [PATCH] hwrng: stm32 - Fix build with CONFIG_PM
In-Reply-To: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1444838695-7182-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c6a97c42e399 ("hwrng: stm32 - add support for STM32 HW RNG")
was inadequately tested (actually it was tested quite hard so
incompetent would be a better description that inadequate) and does
not compile on platforms with CONFIG_PM set.

Fix this.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Herbert: This is the diff between v2 and v3 of my STM32 HW RNG
             patch. This is partly reassurance of what has changed
             and also "just in case" you prefer to simply fix the
    	 problem.

 drivers/char/hw_random/stm32-rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 7fa3656a5fc5..92a810648bd0 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -160,7 +160,7 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 #ifdef CONFIG_PM
 static int stm32_rng_runtime_suspend(struct device *dev)
 {
-	struct stm32_rng_private *priv = dev_get_drvdata(pdev);
+	struct stm32_rng_private *priv = dev_get_drvdata(dev);

 	stm32_rng_cleanup(&priv->rng);

@@ -169,7 +169,7 @@ static int stm32_rng_runtime_suspend(struct device *dev)

 static int stm32_rng_runtime_resume(struct device *dev)
 {
-	struct stm32_rng_private *priv = dev_get_drvdata(pdev);
+	struct stm32_rng_private *priv = dev_get_drvdata(dev);

 	return stm32_rng_init(&priv->rng);
 }
--
2.4.3
