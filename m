From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  4 Dec 2017 23:18:23 +0530
Subject: [PATCH 7/7 v2] net: fjes: Fix platform_get_irq's error checking
In-Reply-To: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512409703-20881-8-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             commit message was not correct.

 drivers/net/fjes/fjes_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 750954b..af7204b 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1268,6 +1268,11 @@ static int fjes_probe(struct platform_device *plat_dev)
 	hw->hw_res.start = res->start;
 	hw->hw_res.size = resource_size(res);
 	hw->hw_res.irq = platform_get_irq(plat_dev, 0);
+	if (hw->hw_res.irq <= 0) {
+		err = hw->hw_res.irq ? hw->hw_res.irq : -ENODEV;
+		goto err_free_netdev;
+	}
+
 	err = fjes_hw_init(&adapter->hw);
 	if (err)
 		goto err_free_netdev;
-- 
2.7.4
