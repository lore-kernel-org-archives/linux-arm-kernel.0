From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 19 Jul 2018 10:20:26 +0200
Subject: [PATCH v2 1/3] net: fortify eth_platform_get_mac_address()
In-Reply-To: <20180719082028.26116-1-brgl@bgdev.pl>
References: <20180719082028.26116-1-brgl@bgdev.pl>
Message-ID: <20180719082028.26116-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We'll soon have more sources from which to read the MAC address in this
routine. Make sure the address is correct before returning it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 net/ethernet/eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..39af03894598 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -541,7 +541,7 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!addr)
 		addr = arch_get_platform_mac_address();
 
-	if (!addr)
+	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
 	ether_addr_copy(mac_addr, addr);
-- 
2.17.1
