From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 19 Jul 2018 17:32:43 +0200
Subject: [PATCH v3 3/3] net: add MTD support to eth_platform_get_mac_address()
In-Reply-To: <20180719153243.20944-1-brgl@bgdev.pl>
References: <20180719153243.20944-1-brgl@bgdev.pl>
Message-ID: <20180719153243.20944-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
address from SPI flash. If we want this function to generalize reading
the MAC address, we need to separately try to use MTD.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 98bc280b8a62..a0d5e4477afc 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -55,6 +55,7 @@
 #include <linux/of_net.h>
 #include <linux/pci.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/mtd/mtd.h>
 #include <net/dst.h>
 #include <net/arp.h>
 #include <net/sock.h>
@@ -593,6 +594,36 @@ static int mac_address_from_nvmem(struct device *dev, u8 *mac_addr)
 	return rv;
 }
 
+#ifdef CONFIG_MTD
+static int mac_address_from_mtd(u8 *mac_addr)
+{
+	struct mtd_info *mtd;
+	size_t alen;
+	int rv = 0;
+
+	mtd = get_mtd_device_nm("MAC-Address");
+	if (IS_ERR(mtd))
+		return PTR_ERR(mtd);
+
+	rv = mtd_read(mtd, 0, ETH_ALEN, &alen, mac_addr);
+	if (rv)
+		goto put_mtd;
+
+	if (alen != ETH_ALEN || !is_valid_ether_addr(mac_addr))
+		rv = -ENODEV;
+
+put_mtd:
+	put_mtd_device(mtd);
+
+	return rv;
+}
+#else /* CONFIG_MTD */
+static int mac_address_from_mtd(u8 *mac_addr)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_MTD */
+
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
 	int rv;
@@ -609,6 +640,6 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!rv)
 		return 0;
 
-	return -ENODEV;
+	return mac_address_from_mtd(mac_addr);
 }
 EXPORT_SYMBOL(eth_platform_get_mac_address);
-- 
2.17.1
