From: singhalsimran0@gmail.com (simran singhal)
Date: Sat,  4 Mar 2017 22:16:53 +0530
Subject: [PATCH 1/3] staging: rtl8192u: Clean up tests if NULL returned on
 failure
In-Reply-To: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
References: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
Message-ID: <1488646015-7059-2-git-send-email-singhalsimran0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some functions like kmalloc/kzalloc return NULL on failure.
When NULL represents failure, !x is commonly used.

This was done using Coccinelle:
@@
expression *e;
identifier l1;
@@

e = \(kmalloc\|kzalloc\|kcalloc\|devm_kzalloc\)(...);
...
- e == NULL
+ !e

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c  | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c    | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c         | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index 713f1d6..df94021 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -67,7 +67,7 @@ static void *ieee80211_tkip_init(int key_idx)
 	struct ieee80211_tkip_data *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
-	if (priv == NULL)
+	if (!priv)
 		goto fail;
 	priv->key_idx = key_idx;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
index 0e8c876..7ba4b07 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
@@ -42,7 +42,7 @@ static void *prism2_wep_init(int keyidx)
 	struct prism2_wep_data *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
-	if (priv == NULL)
+	if (!priv)
 		return NULL;
 	priv->key_idx = keyidx;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 1bff0e9..4adab30 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -3025,7 +3025,7 @@ static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
 		ieee80211_crypt_delayed_deinit(ieee, crypt);
 
 		new_crypt = kzalloc(sizeof(*new_crypt), GFP_KERNEL);
-		if (new_crypt == NULL) {
+		if (!new_crypt) {
 			ret = -ENOMEM;
 			goto done;
 		}
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index 2481c21..c925e53 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -362,7 +362,7 @@ int ieee80211_wx_set_encode(struct ieee80211_device *ieee,
 		/* take WEP into use */
 		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data),
 				    GFP_KERNEL);
-		if (new_crypt == NULL)
+		if (!new_crypt)
 			return -ENOMEM;
 		new_crypt->ops = ieee80211_get_crypto_ops("WEP");
 		if (!new_crypt->ops) {
@@ -610,7 +610,7 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_device *ieee,
 		ieee80211_crypt_delayed_deinit(ieee, crypt);
 
 		new_crypt = kzalloc(sizeof(*new_crypt), GFP_KERNEL);
-		if (new_crypt == NULL) {
+		if (!new_crypt) {
 			ret = -ENOMEM;
 			goto done;
 		}
-- 
2.7.4
