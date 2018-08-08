From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  8 Aug 2018 17:31:36 +0200
Subject: [PATCH 14/28] net: split eth_platform_get_mac_address() into
 subroutines
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Message-ID: <20180808153150.23444-15-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want do add more sources from which to read the MAC address. In
order to avoid bloating this function too much, start by splitting it
into subroutines, each of which takes care of reading the MAC from
one source.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 48 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..cf54cdf042b7 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -525,26 +525,52 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 	return NULL;
 }
 
-int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
+static int mac_address_from_of(struct device *dev, u8 *mac_addr)
 {
 	const unsigned char *addr;
-	struct device_node *dp;
+	struct device_node *np;
 
-	if (dev_is_pci(dev))
-		dp = pci_device_to_OF_node(to_pci_dev(dev));
-	else
-		dp = dev->of_node;
+	np = dev_is_pci(dev) ? pci_device_to_OF_node(to_pci_dev(dev))
+			     : dev->of_node;
 
-	addr = NULL;
-	if (dp)
-		addr = of_get_mac_address(dp);
-	if (!addr)
-		addr = arch_get_platform_mac_address();
+	if (!np)
+		return -ENODEV;
 
+	addr = of_get_mac_address(np);
 	if (!addr)
 		return -ENODEV;
 
+	if (!addr || !is_valid_ether_addr(addr))
+		return -ENODEV;
+
+	ether_addr_copy(mac_addr, addr);
+	return 0;
+}
+
+static int mac_address_from_arch(u8 *mac_addr)
+{
+	const unsigned char *addr;
+
+	addr = arch_get_platform_mac_address();
+	if (!addr || !is_valid_ether_addr(addr))
+		return -ENODEV;
+
 	ether_addr_copy(mac_addr, addr);
 	return 0;
 }
+
+int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
+{
+	int rv;
+
+	rv = mac_address_from_of(dev, mac_addr);
+	if (!rv)
+		return 0;
+
+	rv = mac_address_from_arch(mac_addr);
+	if (!rv)
+		return 0;
+
+	return -ENODEV;
+}
 EXPORT_SYMBOL(eth_platform_get_mac_address);
-- 
2.18.0
