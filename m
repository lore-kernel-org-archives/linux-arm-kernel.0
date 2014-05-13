From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 May 2014 21:46:52 +0200
Subject: [PATCH v2] usb: phy: msm: reset controller is mandatory now
Message-ID: <4319810.IibMxJ0Qvk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a27345434134 "usb: phy: msm: Use reset framework for LINK
and PHY resets" introduced a mandatory call to reset_control_get
into the msm usb phy driver, which means we have to add a Kconfig
dependency on the API to avoid this build error:

phy/phy-msm-usb.c: In function 'msm_otg_read_dt':
phy/phy-msm-usb.c:1461:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]
  motg->link_rst = devm_reset_control_get(&pdev->dev, "link");
  ^

Since the usb-ehci-msm driver currently selects the OTG driver,
we could still get a broken dependency here. To solve that,
this patch also removes the 'select', which turns out to be
unnecessary.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3d9e540..7a39ae8 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -170,7 +170,6 @@ config USB_EHCI_MSM
 	tristate "Support for Qualcomm QSD/MSM on-chip EHCI USB controller"
 	depends on ARCH_MSM
 	select USB_EHCI_ROOT_HUB_TT
-	select USB_MSM_OTG
 	---help---
 	  Enables support for the USB Host controller present on the
 	  Qualcomm chipsets. Root Hub has inbuilt TT.
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 359a6c1..65bec8f 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -165,6 +165,7 @@ config USB_ISP1301
 config USB_MSM_OTG
 	tristate "Qualcomm on-chip USB OTG controller support"
 	depends on (USB || USB_GADGET) && (ARCH_MSM || ARCH_QCOM)
+	depends on RESET_CONTROLLER
 	select USB_PHY
 	help
 	  Enable this to support the USB OTG transceiver on Qualcomm chips. It
