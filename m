From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Feb 2016 09:32:58 +0100
Subject: [PATCH] staging: rtl8712: reduce stack usage
Message-ID: <1455698012-814399-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "translate_scan" function in rtl8712 uses a lot of stack, and
gets inlined into its single caller, r8711_wx_get_scan, which
in some configurations now blows the 1024 byte stack warning
limit:

drivers/staging/rtl8712/rtl871x_ioctl_linux.c: In function 'r8711_wx_get_scan':
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1227:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

This somewhat reduces the stack usage by moving the translate_scan
function out of line with the noinline_for_stack annotation.
It might be possible to modify translate_scan() a little further
to reduce the stack usage, but with this patch, we can build without
the warning, the the call chain to get here is rather predictable
(sys_ioctl->vfs_ioctl->sock_ioctl->dev_ioctl->wext_ioctl->
r8711_wx_get_scan).

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index db2e31bcdd77..a15f3ce70223 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -137,7 +137,7 @@ static inline void handle_group_key(struct ieee_param *param,
 	}
 }
 
-static inline char *translate_scan(struct _adapter *padapter,
+static noinline_for_stack char *translate_scan(struct _adapter *padapter,
 				   struct iw_request_info *info,
 				   struct wlan_network *pnetwork,
 				   char *start, char *stop)
-- 
2.7.0
