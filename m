From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 30 Jul 2017 20:46:23 +0300
Subject: [PATCH] phy: rockchip-inno-usb2: fix of_irq_get_byname() error checks
Message-ID: <20170730174630.481994041@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_get_byname() may  return 0 as well as negative error number on
failure,  while the driver only checks for the negative values. The driver
would then call devm_request_threaded_irq() for IRQ0 and thus never get
the valid interrupts.

Check for IRQ <= 0 instead and return -ENXIO iff  it's 0 from
rockchip_usb2phy_{host|otg}_port_init(), and thus fail the driver's probe.

Fixes: 0e08d2a727e6 ("phy: rockchip-inno-usb2: add a new driver for Rockchip usb2phy")
Fixes: 98898f3bc83c ("phy: rockchip-inno-usb2: support otg-port for rk3399")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'fixes' branch of Kishon's 'linux-phy.git' repo.

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-phy/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
===================================================================
--- linux-phy.orig/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ linux-phy/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -925,9 +925,9 @@ static int rockchip_usb2phy_host_port_in
 	INIT_DELAYED_WORK(&rport->sm_work, rockchip_usb2phy_sm_work);
 
 	rport->ls_irq = of_irq_get_byname(child_np, "linestate");
-	if (rport->ls_irq < 0) {
+	if (rport->ls_irq <= 0) {
 		dev_err(rphy->dev, "no linestate irq provided\n");
-		return rport->ls_irq;
+		return rport->ls_irq ?: -ENXIO;
 	}
 
 	ret = devm_request_threaded_irq(rphy->dev, rport->ls_irq, NULL,
@@ -988,9 +988,9 @@ static int rockchip_usb2phy_otg_port_ini
 		of_property_read_bool(child_np, "rockchip,utmi-avalid");
 
 	rport->bvalid_irq = of_irq_get_byname(child_np, "otg-bvalid");
-	if (rport->bvalid_irq < 0) {
+	if (rport->bvalid_irq <= 0) {
 		dev_err(rphy->dev, "no vbus valid irq provided\n");
-		ret = rport->bvalid_irq;
+		ret = rport->bvalid_irq ?: -ENXIO;
 		goto out;
 	}
 
