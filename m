From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 13:53:02 +0200
Subject: [PATCH] driver core: firmware loader: fix build error
Message-ID: <1563703.RysIHVehbx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch af5bc11e9 "driver core: firmware loader: kill FW_ACTION_NOHOTPLUG
requests before suspend" caused a regression for the case where
CONFIG_FW_LOADER_USER_HELPER is not enabled, because it adds
references to code that is not available in that configuration:

drivers/base/firmware_class.c: In function 'kill_requests_without_uevent':
drivers/base/firmware_class.c:1424:49: error: 'struct firmware_buf' has no member named 'pending_list'
  list_for_each_entry_safe(buf, next, &pending_fw_head, pending_list) {
drivers/base/firmware_class.c:1426:5: error: implicit declaration of function 'fw_load_abort' [-Werror=implicit-function-declaration]

This fixes the build error by making the new code conditional
as well. Found using ARM ape6evm_defconfig on today's linux-next.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index c415043..6cca468 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -1417,6 +1417,7 @@ static void __device_uncache_fw_images(void)
 /* kill pending requests without uevent to avoid blocking suspend */
 static void kill_requests_without_uevent(void)
 {
+#ifdef CONFIG_FW_LOADER_USER_HELPER
 	struct firmware_buf *buf;
 	struct firmware_buf *next;
 
@@ -1426,6 +1427,7 @@ static void kill_requests_without_uevent(void)
 			 fw_load_abort(buf);
 	}
 	mutex_unlock(&fw_lock);
+#endif
 }
 
 /**
