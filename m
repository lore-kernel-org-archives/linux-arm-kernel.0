From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 22:48:14 +0200
Subject: [PATCH 4/5] staging: wlags49_h2: avoid PROFILE_ALL_BRANCHES warnings
In-Reply-To: <1402001295-1980118-1-git-send-email-arnd@arndb.de>
References: <1402001295-1980118-1-git-send-email-arnd@arndb.de>
Message-ID: <1402001295-1980118-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using an 'if()' inside of an 'extern inline' function causes
a gcc warning when CONFIG_PROFILE_ALL_BRANCHES is set every
time the function is called, which gets very noisy:

In file included from /git/arm-soc/drivers/staging/wlags49_h2/wl_wext.c:73:0:
drivers/staging/wlags49_h2/wl_internal.h:1035:216: warning: '______f' is static but declared in inline function 'wl_act_int_off' which is not static [enabled by default]
  if(lp->is_handling_int == WL_HANDLING_INT) {

Fortunately there is a trivial workaround, so we can avoid
the problem by making the functions in question 'static inline'
rather than 'extern inline'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Henk de Groot <pe1dnn@amsat.org>
---
 drivers/staging/wlags49_h2/wl_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlags49_h2/wl_internal.h b/drivers/staging/wlags49_h2/wl_internal.h
index 78129e9..1ecb5cb 100644
--- a/drivers/staging/wlags49_h2/wl_internal.h
+++ b/drivers/staging/wlags49_h2/wl_internal.h
@@ -1013,7 +1013,7 @@ static inline void wl_unlock(struct wl_private *lp,
 /* Interrupt enable disable functions                               */
 /********************************************************************/
 
-extern inline void wl_act_int_on(struct wl_private *lp)
+static inline void wl_act_int_on(struct wl_private *lp)
 {
 	/*
 	 * Only do something when the driver is handling
@@ -1025,7 +1025,7 @@ extern inline void wl_act_int_on(struct wl_private *lp)
 	}
 }
 
-extern inline void wl_act_int_off(struct wl_private *lp)
+static inline void wl_act_int_off(struct wl_private *lp)
 {
 	/*
 	 * Only do something when the driver is handling
-- 
1.8.3.2
