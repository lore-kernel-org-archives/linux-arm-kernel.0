From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 22:48:15 +0200
Subject: [PATCH 5/5] staging: rtl8712, rtl8712: avoid lots of build warnings
In-Reply-To: <1402001295-1980118-1-git-send-email-arnd@arndb.de>
References: <1402001295-1980118-1-git-send-email-arnd@arndb.de>
Message-ID: <1402001295-1980118-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rtl8712 driver has an 'extern inline' function that contains an
'if', which causes lots of warnings with CONFIG_PROFILE_ALL_BRANCHES
overriding the definition of 'if':

drivers/staging/rtl8712/ieee80211.h:759:229: warning: '______f' is static but declared in inline function 'ieee80211_get_hdrlen' which is not static [enabled by default]

This changes the driver to use 'static inline' instead, which happens
to be the correct annotation anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 10 +++++-----
 drivers/staging/rtl8712/ieee80211.h            |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index e0aa069..1040bab 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2238,7 +2238,7 @@ static inline void *ieee80211_priv(struct net_device *dev)
 	return ((struct ieee80211_device *)netdev_priv(dev))->priv;
 }
 
-extern inline int ieee80211_is_empty_essid(const char *essid, int essid_len)
+static inline int ieee80211_is_empty_essid(const char *essid, int essid_len)
 {
 	/* Single white space is for Linksys APs */
 	if (essid_len == 1 && essid[0] == ' ')
@@ -2254,7 +2254,7 @@ extern inline int ieee80211_is_empty_essid(const char *essid, int essid_len)
 	return 1;
 }
 
-extern inline int ieee80211_is_valid_mode(struct ieee80211_device *ieee, int mode)
+static inline int ieee80211_is_valid_mode(struct ieee80211_device *ieee, int mode)
 {
 	/*
 	 * It is possible for both access points and our device to support
@@ -2280,7 +2280,7 @@ extern inline int ieee80211_is_valid_mode(struct ieee80211_device *ieee, int mod
 	return 0;
 }
 
-extern inline int ieee80211_get_hdrlen(u16 fc)
+static inline int ieee80211_get_hdrlen(u16 fc)
 {
 	int hdrlen = IEEE80211_3ADDR_LEN;
 
@@ -2564,12 +2564,12 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee);
 
 extern const long ieee80211_wlan_frequencies[];
 
-extern inline void ieee80211_increment_scans(struct ieee80211_device *ieee)
+static inline void ieee80211_increment_scans(struct ieee80211_device *ieee)
 {
 	ieee->scans++;
 }
 
-extern inline int ieee80211_get_scans(struct ieee80211_device *ieee)
+static inline int ieee80211_get_scans(struct ieee80211_device *ieee)
 {
 	return ieee->scans;
 }
diff --git a/drivers/staging/rtl8712/ieee80211.h b/drivers/staging/rtl8712/ieee80211.h
index da4000e..8269be8 100644
--- a/drivers/staging/rtl8712/ieee80211.h
+++ b/drivers/staging/rtl8712/ieee80211.h
@@ -734,7 +734,7 @@ enum ieee80211_state {
 #define IEEE_G            (1<<2)
 #define IEEE_MODE_MASK    (IEEE_A|IEEE_B|IEEE_G)
 
-extern inline int ieee80211_is_empty_essid(const char *essid, int essid_len)
+static inline int ieee80211_is_empty_essid(const char *essid, int essid_len)
 {
 	/* Single white space is for Linksys APs */
 	if (essid_len == 1 && essid[0] == ' ')
@@ -748,7 +748,7 @@ extern inline int ieee80211_is_empty_essid(const char *essid, int essid_len)
 	return 1;
 }
 
-extern inline int ieee80211_get_hdrlen(u16 fc)
+static inline int ieee80211_get_hdrlen(u16 fc)
 {
 	int hdrlen = 24;
 
-- 
1.8.3.2
