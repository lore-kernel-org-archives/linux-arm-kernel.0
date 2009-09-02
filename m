From: daniel@caiaq.de (Daniel Mack)
Date: Wed,  2 Sep 2009 22:47:54 +0200
Subject: [PATCH 1/5] USB OTG: add support for ulpi connected external
	transceivers
In-Reply-To: <1251924478-30651-1-git-send-email-daniel@caiaq.de>
References: <1251924478-30651-1-git-send-email-daniel@caiaq.de>
Message-ID: <1251924478-30651-2-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for OTG transceivers directly connected to the ULPI
interface. In particular, the following details are added

- a struct for low level io functions (read/write)
- a priv field to be used as 'viewport' by low level access functions
- an (*init) and (*shutdown) callbacks, along with static inline helpers
- a (*set_vbus) callback to switch the port power on and off
- a flags field for per-transceiver settings
- some defines for the flags bitmask to configure platform specific
  details

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-usb at vger.kernel.org
---
 include/linux/usb/otg.h |   68 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 2443c0e..52bb917 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -33,6 +33,23 @@ enum usb_otg_state {
 	OTG_STATE_A_VBUS_ERR,
 };
 
+#define USB_OTG_PULLUP_ID		(1 << 0)
+#define USB_OTG_PULLDOWN_DP		(1 << 1)
+#define USB_OTG_PULLDOWN_DM		(1 << 2)
+#define USB_OTG_EXT_VBUS_INDICATOR	(1 << 3)
+#define USB_OTG_DRV_VBUS		(1 << 4)
+#define USB_OTG_DRV_VBUS_EXT		(1 << 5)
+
+struct otg_transceiver;
+
+/* for transceivers connected thru an ULPI interface, the user must
+ * provide access ops
+ */
+struct otg_io_access_ops {
+	int (*read)(struct otg_transceiver *otg, u32 reg);
+	int (*write)(struct otg_transceiver *otg, u32 val, u32 reg);
+};
+
 /*
  * the otg driver needs to interact with both device side and host side
  * usb controllers.  it decides which controller is active@a given
@@ -42,6 +59,7 @@ enum usb_otg_state {
 struct otg_transceiver {
 	struct device		*dev;
 	const char		*label;
+	unsigned int		 flags;
 
 	u8			default_a;
 	enum usb_otg_state	state;
@@ -49,10 +67,17 @@ struct otg_transceiver {
 	struct usb_bus		*host;
 	struct usb_gadget	*gadget;
 
+	struct otg_io_access_ops	*io_ops;
+	void __iomem			*io_priv;
+
 	/* to pass extra port status to the root hub */
 	u16			port_status;
 	u16			port_change;
 
+	/* initialize/shutdown the OTG controller */
+	int	(*init)(struct otg_transceiver *otg);
+	void	(*shutdown)(struct otg_transceiver *otg);
+
 	/* bind/unbind the host controller */
 	int	(*set_host)(struct otg_transceiver *otg,
 				struct usb_bus *host);
@@ -65,6 +90,10 @@ struct otg_transceiver {
 	int	(*set_power)(struct otg_transceiver *otg,
 				unsigned mA);
 
+	/* effective for A-peripheral, ignored for B devices */
+	int	(*set_vbus)(struct otg_transceiver *otg,
+				bool enabled);
+
 	/* for non-OTG B devices: set transceiver into suspend mode */
 	int	(*set_suspend)(struct otg_transceiver *otg,
 				int suspend);
@@ -85,6 +114,38 @@ extern int otg_set_transceiver(struct otg_transceiver *);
 extern void usb_nop_xceiv_register(void);
 extern void usb_nop_xceiv_unregister(void);
 
+/* helpers for direct access thru low-level io interface */
+static inline int otg_io_read(struct otg_transceiver *otg, u32 reg)
+{
+	if (otg->io_ops && otg->io_ops->read)
+		return otg->io_ops->read(otg, reg);
+
+	return -EINVAL;
+}
+
+static inline int otg_io_write(struct otg_transceiver *otg, u32 reg, u32 val)
+{
+	if (otg->io_ops && otg->io_ops->write)
+		return otg->io_ops->write(otg, reg, val);
+
+	return -EINVAL;
+}
+
+static inline int
+otg_init(struct otg_transceiver *otg)
+{
+	if (otg->init)
+		return otg->init(otg);
+
+	return 0;
+}
+
+static inline void
+otg_shutdown(struct otg_transceiver *otg)
+{
+	if (otg->shutdown)
+		otg->shutdown(otg);
+}
 
 /* for usb host and peripheral controller drivers */
 extern struct otg_transceiver *otg_get_transceiver(void);
@@ -97,6 +158,12 @@ otg_start_hnp(struct otg_transceiver *otg)
 	return otg->start_hnp(otg);
 }
 
+/* Context: can sleep */
+static inline int
+otg_set_vbus(struct otg_transceiver *otg, bool enabled)
+{
+	return otg->set_vbus(otg, enabled);
+}
 
 /* for HCDs */
 static inline int
@@ -105,7 +172,6 @@ otg_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 	return otg->set_host(otg, host);
 }
 
-
 /* for usb peripheral controller drivers */
 
 /* Context: can sleep */
-- 
1.6.3.3
