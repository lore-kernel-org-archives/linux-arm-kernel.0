From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 16 May 2015 17:17:40 +0200
Subject: [PATCH] USB: ehci-platform: support EHCIs with transaction translator
Message-ID: <1431789460-26831-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some EHCI controllers have a Transaction Translator built into
the root hub. Support this feature in device tree when using
the ehci-platform driver by adding a feature flag for it.

This is needed to get USB working on NXP LPC18xx/43xx platforms.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

 Documentation/devicetree/bindings/usb/usb-ehci.txt | 2 ++
 drivers/usb/host/ehci-platform.c                   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 0b04fdff9d5a..a12d6012a40f 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -13,6 +13,8 @@ Optional properties:
  - big-endian-desc : boolean, set this for hcds with big-endian descriptors
  - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
  - needs-reset-on-resume : boolean, set this to force EHCI reset after resume
+ - has-transaction-translator : boolean, set this if EHCI have a Transaction
+				Translator built into the root hub.
  - clocks : a list of phandle + clock specifier pairs
  - phys : phandle + phy specifier pair
  - phy-names : "usb"
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index d8a75a51d6d4..ba07f16b13e0 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -202,6 +202,10 @@ static int ehci_platform_probe(struct platform_device *dev)
 					  "needs-reset-on-resume"))
 			pdata->reset_on_resume = 1;
 
+		if (of_property_read_bool(dev->dev.of_node,
+					  "has-transaction-translator"))
+			pdata->has_tt = 1;
+
 		priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
 				"phys", "#phy-cells");
 		priv->num_phys = priv->num_phys > 0 ? priv->num_phys : 1;
-- 
1.8.0
