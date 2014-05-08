From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 15:52:17 +0200
Subject: [PATCH 4/8] usb: phy: fix isp1301-omap dependency on tps65010
In-Reply-To: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
Message-ID: <1399557141-1346645-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The isp1301-omap driver cannot be built-in if the tps65010 driver
is a module, otherwise we get a link error from the reference to
the tps65010_set_vbus_draw function.

There is already a hack in the driver to work around the problem
of tps65010 being not available at all. This patch extends that
hack to ensure that the real tps65010_set_vbus_draw() function
is only called when it's avaiable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap at vger.kernel.org
---
 drivers/usb/phy/phy-isp1301-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 6e146d7..35a0dd2 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -94,7 +94,7 @@ struct isp1301 {
 
 #if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3)
 
-#if	defined(CONFIG_TPS65010) || defined(CONFIG_TPS65010_MODULE)
+#if	defined(CONFIG_TPS65010) || (defined(CONFIG_TPS65010_MODULE) && defined(MODULE))
 
 #include <linux/i2c/tps65010.h>
 
-- 
1.8.3.2
