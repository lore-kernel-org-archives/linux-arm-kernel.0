From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 28 Nov 2012 21:31:14 -0500
Subject: [PATCH -next] mmc: wmt-sdmmc: fix potential NULL pointer dereference
 in wmt_mci_probe()
Message-ID: <CAPgLHd9bKK54pR591ytB1_S3EOw4F177=Ofqf_h_n9_+SFyi2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The dereference to 'of_id' should be moved below the NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/wmt-sdmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 5ba4605..f737b0c 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -773,7 +773,7 @@ static int __devinit wmt_mci_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 		of_match_device(wmt_mci_dt_ids, &pdev->dev);
-	const struct wmt_mci_caps *wmt_caps = of_id->data;
+	const struct wmt_mci_caps *wmt_caps;
 	int ret;
 	int regular_irq, dma_irq;
 
@@ -787,6 +787,7 @@ static int __devinit wmt_mci_probe(struct platform_device *pdev)
 		return -EFAULT;
 	}
 
+	wmt_caps = of_id->data;
 	regular_irq = irq_of_parse_and_map(np, 0);
 	dma_irq = irq_of_parse_and_map(np, 1);
 
