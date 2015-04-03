From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 3 Apr 2015 17:25:42 +0800
Subject: [PATCH v9 08/30] PCI: Update pci_host_bridge bus resource
In-Reply-To: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
References: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1428053164-28277-10-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yijing Wang <wangyijing0307@gmail.com>

Sometimes, the bus resource start number is not equal to
root bus number. For example, in pci_scan_bus(), we always
add the default bus resource which start bus number is 0,
but the root bus number callers given may != 0, so
we need to update pci_host_bridge bus resource, because we
would check whether host bridge bus resoruce is confict
in later patch.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host-bridge.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index ecc1a7c..1a9834b 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -26,8 +26,11 @@ static void pci_host_update_busn_res(
 	struct resource_entry *window;
 
 	resource_list_for_each_entry(window, resources)
-		if (window->res->flags & IORESOURCE_BUS)
+		if (window->res->flags & IORESOURCE_BUS) {
+			if (bus > window->res->start)
+				window->res->start = bus;
 			return;
+		}
 
 	pr_info(
 	 "No busn resource found for pci%04x:%02x, will use [bus %02x-ff]\n",
-- 
1.7.1
