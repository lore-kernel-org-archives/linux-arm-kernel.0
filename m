From: lionel.Debieve@st.com (Lionel Debieve)
Date: Mon, 29 Jan 2018 15:28:09 +0100
Subject: [PATCH 1/3] crypto: stm32/hash: avoid error if maxburst not defined
In-Reply-To: <20180129142811.13273-1-lionel.Debieve@st.com>
References: <20180129142811.13273-1-lionel.Debieve@st.com>
Message-ID: <20180129142811.13273-2-lionel.Debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lionel Debieve <lionel.debieve@st.com>

dma-maxburst is an optional value and must not return
error in case of dma not used (or max-burst not defined).

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/crypto/stm32/stm32-hash.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 4ca4a264a833..73cdc3b4dca8 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -1404,18 +1404,19 @@ MODULE_DEVICE_TABLE(of, stm32_hash_of_match);
 static int stm32_hash_get_of_match(struct stm32_hash_dev *hdev,
 				   struct device *dev)
 {
-	int err;
-
 	hdev->pdata = of_device_get_match_data(dev);
 	if (!hdev->pdata) {
 		dev_err(dev, "no compatible OF match\n");
 		return -EINVAL;
 	}
 
-	err = of_property_read_u32(dev->of_node, "dma-maxburst",
-				   &hdev->dma_maxburst);
+	if (of_property_read_u32(dev->of_node, "dma-maxburst",
+				 &hdev->dma_maxburst)) {
+		dev_info(dev, "dma-maxburst not specified, using 0\n");
+		hdev->dma_maxburst = 0;
+	}
 
-	return err;
+	return 0;
 }
 
 static int stm32_hash_probe(struct platform_device *pdev)
-- 
2.15.1
