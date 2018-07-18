From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 18 Jul 2018 18:10:31 +0200
Subject: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Message-ID: <20180718161035.7005-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Initialize the variables with proper values so that we save a few
lines of code before we extend this function in the follow-up patches.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..da8530879e1e 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
-	const unsigned char *addr;
-	struct device_node *dp;
+	struct device_node *dp = dev_is_pci(dev) ?
+			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
+	const unsigned char *addr = NULL;
 
-	if (dev_is_pci(dev))
-		dp = pci_device_to_OF_node(to_pci_dev(dev));
-	else
-		dp = dev->of_node;
-
-	addr = NULL;
 	if (dp)
 		addr = of_get_mac_address(dp);
 	if (!addr)
-- 
2.17.1
