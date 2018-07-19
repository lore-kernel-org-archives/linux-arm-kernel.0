From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 19 Jul 2018 10:20:28 +0200
Subject: [PATCH v2 3/3] net: add MTD support to eth_platform_get_mac_address()
In-Reply-To: <20180719082028.26116-1-brgl@bgdev.pl>
References: <20180719082028.26116-1-brgl@bgdev.pl>
Message-ID: <20180719082028.26116-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
address from SPI flash. If we want this function to generalize reading
the MAC address, we need to separately try to use MTD.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index af3b4b1b77eb..addbb3375e3b 100644
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
@@ -568,6 +569,23 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
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
+			if (rv == 0)
+				addr = addrbuf;
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
