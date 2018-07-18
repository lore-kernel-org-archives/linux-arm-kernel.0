From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 18 Jul 2018 18:10:35 +0200
Subject: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Message-ID: <20180718161035.7005-6-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
address from SPI flash. If we want this function to generalize reading
the MAC address, we need to separately try to use MTD.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index adf5bd03851f..f7dbd2cff7f9 100644
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
@@ -573,6 +574,25 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 		}
 	}
 
+#ifdef CONFIG_MTD
+	/* NOTE: this should go away as soon as MTD gets nvmem support. */
+	if (!addr) {
+		struct mtd_info *mtd;
+		int rv;
+
+		mtd = get_mtd_device_nm("MAC-Address");
+		if (!IS_ERR(mtd)) {
+			rv = mtd_read(mtd, 0, ETH_ALEN, &alen, addrbuf);
+			if (rv == 0) {
+				from = "MTD";
+				addr = addrbuf;
+			}
+
+			put_mtd_device(mtd);
+		}
+	}
+#endif /* CONFIG_MTD */
+
 	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
-- 
2.17.1
