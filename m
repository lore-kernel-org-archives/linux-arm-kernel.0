From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 15:03:48 +0530
Subject: [PATCH 6/6 v2] mmc: sunxi-mmc: Handle return value of platform_get_irq
In-Reply-To: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
References: <130df0c2c60ed6a0f460b68c586cc0a4167aed0b.1510997223.git.arvind.yadav.cs@gmail.com>
Message-ID: <27a6d3a22516b3711b48bfbf305b6d8f3960eeac.1510997223.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/mmc/host/sunxi-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index cc98355d..ec2a16b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1255,6 +1255,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		goto error_assert_reset;
 
 	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
+		ret = host->irq;
+		goto error_assert_reset;
+	}
+
 	return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
 			sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
 
-- 
2.7.4
