From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 18 Jul 2018 18:10:32 +0200
Subject: [PATCH 2/5] net: add an info message to eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Message-ID: <20180718161035.7005-3-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Many drivers that read the MAC address from EEPROM or MTD emit a log
message when they succeed. Since this function is meant to be reused
in those drivers instead of reimplementing the same operation
everywhere, add an info message when we successfully read the MAC
address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index da8530879e1e..2a2173324d9e 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -530,15 +530,24 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	struct device_node *dp = dev_is_pci(dev) ?
 			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
 	const unsigned char *addr = NULL;
+	const char *from = NULL;
 
-	if (dp)
+	if (dp) {
 		addr = of_get_mac_address(dp);
-	if (!addr)
+		if (addr)
+			from = "device tree";
+	}
+
+	if (!addr) {
 		addr = arch_get_platform_mac_address();
+		if (addr)
+			from = "arch callback";
+	}
 
 	if (!addr)
 		return -ENODEV;
 
+	dev_info(dev, "read MAC address from %s\n", from);
 	ether_addr_copy(mac_addr, addr);
 	return 0;
 }
-- 
2.17.1
