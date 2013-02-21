From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 20 Feb 2013 23:07:21 -0500
Subject: [V8 PATCH 11/16] usb: phy: mv_usb2_phy: add externel chip support
In-Reply-To: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361419646-9052-12-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the vbus and idpin detection. It may be completed by some
external chip, for example the pmic chip 88pm860x in driver/mfd
can do it.
Although the usb controller can detect the vbus and id pin, but
it need clock on and PHY enabled to detect the
vbus/idpin. It will increase the power.
Using the external chip to detect vbus/idpin can save the power.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/phy/mv_usb2_phy.c        |   49 +++++++++++++++++++
 include/linux/platform_data/mv_usb.h |   15 ++----
 include/linux/usb/mv_usb2.h          |   89 ++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/phy/mv_usb2_phy.c b/drivers/usb/phy/mv_usb2_phy.c
index a81e5e4..cbf207c 100644
--- a/drivers/usb/phy/mv_usb2_phy.c
+++ b/drivers/usb/phy/mv_usb2_phy.c
@@ -129,6 +129,53 @@ enum mv_usb2_phy_type {
 	MMP2_USB,
 };
 
+int mv_usb2_register_notifier(struct mv_usb2_phy *phy,
+		struct notifier_block *nb)
+{
+	int ret;
+
+	if (!phy)
+		return -ENODEV;
+
+	ret = atomic_notifier_chain_register(&phy->extern_chip.head, nb);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(mv_usb2_register_notifier);
+
+int mv_usb2_unregister_notifier(struct mv_usb2_phy *phy,
+		struct notifier_block *nb)
+{
+	int ret;
+
+	if (!phy)
+		return -ENODEV;
+
+	ret = atomic_notifier_chain_unregister(&phy->extern_chip.head, nb);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(mv_usb2_unregister_notifier);
+
+int mv_usb2_notify(struct mv_usb2_phy *phy, unsigned long val, void *v)
+{
+	int ret;
+
+	if (!phy)
+		return -ENODEV;
+
+	ret = atomic_notifier_call_chain(&phy->extern_chip.head, val, v);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(mv_usb2_notify);
+
 static unsigned int u2o_get(void __iomem *base, unsigned int offset)
 {
 	return readl(base + offset);
@@ -363,6 +410,8 @@ static int mv_usb2_phy_probe(struct platform_device *pdev)
 
 	usb_add_phy_dev(&mv_phy->phy);
 
+	ATOMIC_INIT_NOTIFIER_HEAD(&mv_phy->extern_chip.head);
+
 	platform_set_drvdata(pdev, mv_phy);
 
 	return 0;
diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platform_data/mv_usb.h
index fd3d1b4..dc25d60 100644
--- a/include/linux/platform_data/mv_usb.h
+++ b/include/linux/platform_data/mv_usb.h
@@ -28,16 +28,13 @@ enum {
 	VBUS_HIGH	= 1 << 0,
 };
 
-struct mv_usb_addon_irq {
-	unsigned int	irq;
-	int		(*poll)(void);
-};
-
+#define MV_USB_HAS_VBUS_DETECTION	(1 << 0)
+#define MV_USB_HAS_IDPIN_DETECTION	(1 << 1)
 struct mv_usb_platform_data {
 	unsigned int		clknum;
 	char			**clkname;
-	struct mv_usb_addon_irq	*id;	/* Only valid for OTG. ID pin change*/
-	struct mv_usb_addon_irq	*vbus;	/* valid for OTG/UDC. VBUS change*/
+
+	unsigned int		extern_attr;
 
 	/* only valid for HCD. OTG or Host only*/
 	unsigned int		mode;
@@ -45,9 +42,7 @@ struct mv_usb_platform_data {
 	/* This flag is used for that needs id pin checked by otg */
 	unsigned int    disable_otg_clock_gating:1;
 	/* Force a_bus_req to be asserted */
-	 unsigned int    otg_force_a_bus_req:1;
-
-	int	(*set_vbus)(unsigned int vbus);
+	unsigned int    otg_force_a_bus_req:1;
 };
 
 struct mv_usb_phy_platform_data {
diff --git a/include/linux/usb/mv_usb2.h b/include/linux/usb/mv_usb2.h
index 77250f5..f0bfacb 100644
--- a/include/linux/usb/mv_usb2.h
+++ b/include/linux/usb/mv_usb2.h
@@ -18,6 +18,33 @@
 #define MV_USB2_PHY_INDEX	0
 #define MV_USB2_OTG_PHY_INDEX	1
 
+enum {
+	EVENT_VBUS,
+	EVENT_ID,
+};
+
+struct pxa_usb_vbus_ops {
+	int (*get_vbus)(unsigned int *level);
+	int (*set_vbus)(unsigned int level);
+	int (*init)(void);
+};
+
+struct pxa_usb_idpin_ops {
+	int (*get_idpin)(unsigned int *level);
+	int (*init)(void);
+};
+
+struct pxa_usb_extern_ops {
+	struct pxa_usb_vbus_ops		vbus;
+	struct pxa_usb_idpin_ops	idpin;
+};
+
+struct mv_usb2_extern_chip {
+	unsigned int id;
+	struct pxa_usb_extern_ops ops;
+	struct atomic_notifier_head head;
+};
+
 struct mv_usb2_phy {
 	struct usb_phy		phy;
 	struct platform_device	*pdev;
@@ -27,6 +54,68 @@ struct mv_usb2_phy {
 	void __iomem		*base;
 	struct clk		**clks;
 	unsigned int		clks_num;
+	struct mv_usb2_extern_chip extern_chip;
 };
 
+#if defined(CONFIG_MV_USB2_PHY) || defined(CONFIG_MV_USB2_PHY_MODULE)
+#define mv_usb2_has_extern_call(phy, o, f, arg...)( \
+{ \
+	int ret;					\
+	ret = (!phy ? 0 : ((phy->extern_chip.ops.o.f) ?	\
+		1 : 0));				\
+	ret;						\
+} \
+)
+
+#define mv_usb2_extern_call(phy, o, f, args...)( \
+{ \
+	int ret;						\
+	ret = (!phy ? -ENODEV : ((phy->extern_chip.ops.o.f) ?	\
+		phy->extern_chip.ops.o.f(args) : -ENOIOCTLCMD));\
+	ret;							\
+} \
+)
+
+#define mv_usb2_set_extern_call(phy, o, f, p)( \
+{ \
+	int ret;							\
+	ret = !phy ? -ENODEV : ((phy->extern_chip.ops.o.f) ?		\
+		-EINVAL : ({phy->extern_chip.ops.o.f = p; 0; }));	\
+	ret;								\
+} \
+)
+
+extern int mv_usb2_register_notifier(struct mv_usb2_phy *phy,
+					struct notifier_block *nb);
+extern int mv_usb2_unregister_notifier(struct mv_usb2_phy *phy,
+					struct notifier_block *nb);
+extern int mv_usb2_notify(struct mv_usb2_phy *phy, unsigned long val, void *v);
+
+#else
+
+#define mv_usb2_has_extern_call(phy, o, f, arg...)(0)
+
+#define mv_usb2_extern_call(phy, o, f, args...)(0)
+
+#define mv_usb2_set_extern_call(phy, o, f, p)(0)
+
+int mv_usb2_register_notifier(struct mv_usb2_phy *phy,
+					struct notifier_block *nb)
+{
+	return -EINVAL;
+}
+
+int mv_usb2_unregister_notifier(struct mv_usb2_phy *phy,
+					struct notifier_block *nb)
+{
+	return -EINVAL;
+}
+
+int mv_usb2_notify(struct mv_usb2_phy *phy, unsigned long val, void *v)
+{
+	return 0;
+}
+
+#endif
+
 #endif
-- 
1.7.4.1
