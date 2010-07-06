From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue,  6 Jul 2010 03:37:40 +0300
Subject: [PATCH 09/15] wireless: wl12xx: support pdata SDIO handlers
In-Reply-To: <1278376666-3509-1-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
Message-ID: <1278376666-3509-10-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ohad Ben-Cohen <ohadb@ti.com>

Make it possible for board code to send SDIO handlers to
the wl12xx driver.

These SDIO handlers are needed to allow software to trigger
card detect events for hard-wired SDIO devices such as the
wl1271 device.

Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
---
 drivers/net/wireless/wl12xx/wl1271.h |    4 ++++
 include/linux/wl12xx.h               |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271.h b/drivers/net/wireless/wl12xx/wl1271.h
index 6f1b6b5..fc4d122 100644
--- a/drivers/net/wireless/wl12xx/wl1271.h
+++ b/drivers/net/wireless/wl12xx/wl1271.h
@@ -356,6 +356,10 @@ struct wl1271 {
 	struct wl1271_if_operations *if_ops;
 
 	void (*set_power)(bool enable);
+	/* SDIO card detect emulation */
+	void (*set_carddetect)(bool card_present);
+	void (*set_embedded_data)(void *priv);
+
 	int irq;
 
 	spinlock_t wl_lock;
diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
index 137ac89..4106184 100644
--- a/include/linux/wl12xx.h
+++ b/include/linux/wl12xx.h
@@ -26,6 +26,8 @@
 
 struct wl12xx_platform_data {
 	void (*set_power)(bool enable);
+	void (*set_carddetect)(bool card_present);
+	void (*set_embedded_data)(void *priv);
 	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
 	int irq;
 	bool use_eeprom;
-- 
1.7.0.4
