From: vkuzmichev@mvista.com (vkuzmichev at mvista.com)
Date: Mon,  4 Oct 2010 13:45:39 +0400
Subject: [PATCH 3/4] ARM: mpcore_wdt: Fix WDIOC_SETOPTIONS handling
In-Reply-To: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
Message-ID: <1286185540-19569-4-git-send-email-vkuzmichev@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Kuzmichev <vkuzmichev@mvista.com>

According to the include/linux/watchdog.h WDIOC_SETOPTIONS is
classified as 'read from device' ioctl call:
  #define WDIOC_SETOPTIONS        _IOR(WATCHDOG_IOCTL_BASE, 4, int)

However, the driver 'mpcore_wdt' performs 'copy_from_user' only if
_IOC_WRITE is set, thus the local variable 'uarg' which is used in
WDIOC_SETOPTIONS handling remains uninitialized.

The proper way to fix this is to bind WDIOC_SETOPTIONS to _IOW,
but this will break compatibility.
So adding additional condition for performing 'copy_from_user'.

Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>
---
 drivers/watchdog/mpcore_wdt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 1bd3529..6d3ac06 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -238,7 +238,8 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
 	if (_IOC_DIR(cmd) && _IOC_SIZE(cmd) > sizeof(uarg))
 		return -ENOTTY;
 
-	if (_IOC_DIR(cmd) & _IOC_WRITE) {
+	if (_IOC_DIR(cmd) & _IOC_WRITE
+			|| cmd == WDIOC_SETOPTIONS) {
 		ret = copy_from_user(&uarg, (void __user *)arg, _IOC_SIZE(cmd));
 		if (ret)
 			return -EFAULT;
-- 
1.7.2.2
