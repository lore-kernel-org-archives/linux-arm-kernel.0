From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 20 Feb 2018 13:58:12 +0100
Subject: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
Message-ID: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some boards, especially when vbus supply requires large current,
and the charge pump on the PHY isn't enough, an external vbus power switch
may be used.
Add support for this optional external vbus supply in ehci-platform.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

---
Changes in v2:
 * Address Roger Quadros comments: move regulator_enable/disable from
ehci_platform_power_on/off to ehci_platform_port_power.
---
 Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
 drivers/usb/host/ehci-platform.c                   | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 3efde12..fc480cd 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -19,6 +19,7 @@ Optional properties:
  - phys : phandle + phy specifier pair
  - phy-names : "usb"
  - resets : phandle + reset specifier pair
+ - vbus-supply : phandle of regulator supplying vbus
 
 Example (Sequoia 440EPx):
     ehci at e0000300 {
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index b065a96..05be100 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -46,6 +47,7 @@ struct ehci_platform_priv {
 	struct reset_control *rsts;
 	struct phy **phys;
 	int num_phys;
+	struct regulator *vbus_supply;
 	bool reset_on_resume;
 };
 
@@ -76,6 +78,25 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	return 0;
 }
 
+static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
+				    bool enable)
+{
+	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
+	int ret = 0;
+
+	if (priv->vbus_supply) {
+		if (enable)
+			ret = regulator_enable(priv->vbus_supply);
+		else
+			ret = regulator_disable(priv->vbus_supply);
+		if (ret)
+			dev_err(hcd->self.controller,
+				"failed to %s vbus supply: %d\n",
+				enable ? "enable" : "disable", ret);
+	}
+	return ret;
+}
+
 static int ehci_platform_power_on(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
@@ -134,6 +155,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
 static const struct ehci_driver_overrides platform_overrides __initconst = {
 	.reset =		ehci_platform_reset,
 	.extra_priv_size =	sizeof(struct ehci_platform_priv),
+	.port_power =		ehci_platform_port_power,
 };
 
 static struct usb_ehci_pdata ehci_platform_defaults = {
@@ -247,6 +269,15 @@ static int ehci_platform_probe(struct platform_device *dev)
 	if (err)
 		goto err_put_clks;
 
+	priv->vbus_supply = devm_regulator_get_optional(&dev->dev, "vbus");
+	if (IS_ERR(priv->vbus_supply)) {
+		err = PTR_ERR(priv->vbus_supply);
+		if (err == -ENODEV)
+			priv->vbus_supply = NULL;
+		else
+			goto err_reset;
+	}
+
 	if (pdata->big_endian_desc)
 		ehci->big_endian_desc = 1;
 	if (pdata->big_endian_mmio)
-- 
2.7.4
