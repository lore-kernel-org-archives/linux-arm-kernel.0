From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 18 Jul 2018 18:10:33 +0200
Subject: [PATCH 3/5] net: fortify eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Message-ID: <20180718161035.7005-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We'll soon have more sources from which to read the MAC address in this
routine. Make sure the address is correct before returning it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 2a2173324d9e..6b64586fd2af 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -544,7 +544,7 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 			from = "arch callback";
 	}
 
-	if (!addr)
+	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
 	dev_info(dev, "read MAC address from %s\n", from);
-- 
2.17.1
