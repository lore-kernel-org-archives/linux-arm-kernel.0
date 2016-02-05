From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Feb 2016 16:21:50 +0100
Subject: [PATCH] staging: wilc1000: fix compilation without CONFIG_PM
Message-ID: <1454685729-3663377-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the addition of the wakeup code in wilc1000, it no longer
builds when CONFIG_PM is disabled:

drivers/staging/wilc1000/wilc_wfi_cfgoperations.c: In function 'wilc_create_wiphy':
drivers/staging/wilc1000/wilc_wfi_cfgoperations.c:2632:13: error: 'struct wiphy' has no member named 'wowlan'
  wdev->wiphy->wowlan = &wowlan_support;

This marks the wowlan_support variable as __maybe_unused and hides
the reference when CONFIG_PM is disabled to avoid the build error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 73584a40d748 ("staging: wilc1000: add ops resuem/suspend/wakeup in cfg80211")
---
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 4eede2b4e661..7e6262026070 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -74,7 +74,7 @@ static const struct ieee80211_txrx_stypes
 	}
 };
 
-static const struct wiphy_wowlan_support wowlan_support = {
+static const struct wiphy_wowlan_support wowlan_support __maybe_unused = {
 	.flags = WIPHY_WOWLAN_ANY
 };
 
@@ -2629,7 +2629,9 @@ struct wireless_dev *wilc_create_wiphy(struct net_device *net, struct device *de
 	sema_init(&(priv->SemHandleUpdateStats), 1);
 	priv->wdev = wdev;
 	wdev->wiphy->max_scan_ssids = MAX_NUM_PROBED_SSID;
+#ifdef CONFIG_PM
 	wdev->wiphy->wowlan = &wowlan_support;
+#endif
 	wdev->wiphy->max_num_pmkids = WILC_MAX_NUM_PMKIDS;
 	PRINT_INFO(CFG80211_DBG, "Max number of PMKIDs = %d\n", wdev->wiphy->max_num_pmkids);
 
-- 
2.7.0
