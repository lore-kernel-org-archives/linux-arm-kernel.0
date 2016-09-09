From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  9 Sep 2016 11:58:18 +0800
Subject: [PATCH v2] phy: sun4i-usb: Use spinlock to guard phyctl register
 access
Message-ID: <20160909035818.16273-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The musb driver calls into this phy driver to disable/enable squelch
detection. This function was introduced in 24fe86a617c5 ("phy: sun4i-usb:
Add a sunxi specific function for setting squelch-detect"). This
function in turn calls sun4i_usb_phy_write, which uses a mutex to
guard the common access register. Unfortunately musb does this
in atomic context, which results in the following warning with lock
debugging enabled:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
in_atomic(): 1, irqs_disabled(): 128, pid: 96, name: kworker/0:2
CPU: 0 PID: 96 Comm: kworker/0:2 Not tainted 4.8.0-rc4-00181-gd502f8ad1c3e #13
Hardware name: Allwinner sun8i Family
Workqueue: events musb_deassert_reset
[<c010bc01>] (unwind_backtrace) from [<c0109237>] (show_stack+0xb/0xc)
[<c0109237>] (show_stack) from [<c02a669b>] (dump_stack+0x67/0x74)
[<c02a669b>] (dump_stack) from [<c05d68c9>] (mutex_lock+0x15/0x2c)
[<c05d68c9>] (mutex_lock) from [<c02c3589>] (sun4i_usb_phy_write+0x39/0xec)
[<c02c3589>] (sun4i_usb_phy_write) from [<c03e6327>] (musb_port_reset+0xfb/0x184)
[<c03e6327>] (musb_port_reset) from [<c03e4917>] (musb_deassert_reset+0x1f/0x2c)
[<c03e4917>] (musb_deassert_reset) from [<c012ecb5>] (process_one_work+0x129/0x2b8)
[<c012ecb5>] (process_one_work) from [<c012f5e3>] (worker_thread+0xf3/0x424)
[<c012f5e3>] (worker_thread) from [<c0132dbd>] (kthread+0xa1/0xb8)
[<c0132dbd>] (kthread) from [<c0105f31>] (ret_from_fork+0x11/0x20)

Since the register access is mmio, we can use a spinlock to guard this
specific access, rather than the mutex that guards the entire phy.

Fixes: ba4bdc9e1dc0 ("PHY: sunxi: Add driver for sunxi usb phy")
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: stable at vger.kernel.org
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:

  - Remove the old mutex, since it is no longer used
  - Use irqsave/irqrestore variant of spinlock ops

---
 drivers/phy/phy-sun4i-usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index fcf4d95ecc6d..34b7f0c2e019 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -40,6 +40,7 @@
 #include <linux/power_supply.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/spinlock.h>
 #include <linux/usb/of.h>
 #include <linux/workqueue.h>
 
@@ -114,7 +115,7 @@ struct sun4i_usb_phy_data {
 	void __iomem *base;
 	const struct sun4i_usb_phy_cfg *cfg;
 	enum usb_dr_mode dr_mode;
-	struct mutex mutex;
+	spinlock_t reg_lock; /* guard access to phyctl reg */
 	struct sun4i_usb_phy {
 		struct phy *phy;
 		void __iomem *pmu;
@@ -181,9 +182,10 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 	struct sun4i_usb_phy_data *phy_data = to_sun4i_usb_phy_data(phy);
 	u32 temp, usbc_bit = BIT(phy->index * 2);
 	void __iomem *phyctl = phy_data->base + phy_data->cfg->phyctl_offset;
+	unsigned long flags;
 	int i;
 
-	mutex_lock(&phy_data->mutex);
+	spin_lock_irqsave(&phy_data->reg_lock, flags);
 
 	if (phy_data->cfg->type == sun8i_a33_phy ||
 	    phy_data->cfg->type == sun50i_a64_phy) {
@@ -221,7 +223,8 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 
 		data >>= 1;
 	}
-	mutex_unlock(&phy_data->mutex);
+
+	spin_unlock_irqrestore(&phy_data->reg_lock, flags);
 }
 
 static void sun4i_usb_phy_passby(struct sun4i_usb_phy *phy, int enable)
@@ -582,7 +585,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	mutex_init(&data->mutex);
+	spin_lock_init(&data->reg_lock);
 	INIT_DELAYED_WORK(&data->detect, sun4i_usb_phy0_id_vbus_det_scan);
 	dev_set_drvdata(dev, data);
 	data->cfg = of_device_get_match_data(dev);
-- 
2.9.3
