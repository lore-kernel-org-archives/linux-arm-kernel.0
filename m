From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 29 Jan 2018 18:05:17 +0100
Subject: [PATCH 1/5] hwrng: stm32 - add reset during probe
In-Reply-To: <20180129170521.1862-1-lionel.debieve@st.com>
References: <20180129170521.1862-1-lionel.debieve@st.com>
Message-ID: <20180129170521.1862-2-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid issue when probing the RNG without
reset if bad status has been detected previously

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/char/hw_random/stm32-rng.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 63d84e6f1891..83c695938a2d 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #define RNG_CR 0x00
@@ -46,6 +47,7 @@ struct stm32_rng_private {
 	struct hwrng rng;
 	void __iomem *base;
 	struct clk *clk;
+	struct reset_control *rst;
 };
 
 static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
@@ -140,6 +142,13 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	priv->rst = devm_reset_control_get(&ofdev->dev, NULL);
+	if (!IS_ERR(priv->rst)) {
+		reset_control_assert(priv->rst);
+		udelay(2);
+		reset_control_deassert(priv->rst);
+	}
+
 	dev_set_drvdata(dev, priv);
 
 	priv->rng.name = dev_driver_string(dev),
-- 
2.15.1
