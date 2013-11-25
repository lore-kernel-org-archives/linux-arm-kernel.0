From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Mon, 25 Nov 2013 16:27:07 +0100
Subject: [PATCH v2 5/6] net: MOXA ART: generate random address
In-Reply-To: <1385393228-22416-1-git-send-email-jonas.jensen@gmail.com>
References: <1385393228-22416-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <1385393228-22416-5-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address register is zero:ed on boot, fill it with a randomly generated
address on probe.

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Applies to next-20131125

 drivers/net/ethernet/moxa/moxart_ether.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index d1c4a83..ef7a347 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -734,6 +734,12 @@ static int moxart_mac_probe(struct platform_device *pdev)
 		goto init_fail;
 	}
 
+	if (!is_valid_ether_addr(ndev->dev_addr)) {
+		eth_hw_addr_random(ndev);
+		netdev_info(ndev, "generated random MAC address %pM\n",
+			    ndev->dev_addr);
+	}
+
 	netdev_dbg(ndev, "%s: IRQ=%d address=%pM\n",
 		   __func__, ndev->irq, ndev->dev_addr);
 
-- 
1.8.2.1
