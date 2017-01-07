From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  7 Jan 2017 10:41:41 +0200
Subject: [PATCH 2/2] usb: host: ohci-exynos: Decrese node refcount on
 exynos_ehci_get_phy() error paths
In-Reply-To: <20170107084141.3731-1-krzk@kernel.org>
References: <20170107084141.3731-1-krzk@kernel.org>
Message-ID: <20170107084141.3731-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Returning from for_each_available_child_of_node() loop requires cleaning
up node refcount.  Error paths lacked it so for example in case of
deferred probe, the refcount of phy node was left increased.

Fixes: 6d40500ac9b6 ("usb: ehci/ohci-exynos: Fix of_node_put() for child when getting PHYs")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/host/ohci-exynos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 2cd105be7319..6865b919403f 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -66,10 +66,12 @@ static int exynos_ohci_get_phy(struct device *dev,
 		if (IS_ERR(phy)) {
 			ret = PTR_ERR(phy);
 			if (ret == -EPROBE_DEFER) {
+				of_node_put(child);
 				return ret;
 			} else if (ret != -ENOSYS && ret != -ENODEV) {
 				dev_err(dev,
 					"Error retrieving usb2 phy: %d\n", ret);
+				of_node_put(child);
 				return ret;
 			}
 		}
-- 
2.9.3
