From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 22 Dec 2011 09:33:22 -0200
Subject: [PATCH v2] usb: gadget: Fix build error due to selection of
 USB_FSL_MPH_DR_OF by ARCH_MXC
In-Reply-To: <1324492640-25481-1-git-send-email-fabio.estevam@freescale.com>
References: <1324492640-25481-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1324553602-3411-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB_FSL_MPH_DR_OF is a PowerPC driver and should not be selected by ARCH_MXC.

Doing a 'make mx3_defconfig' and selecting i.MX6 we get:

CC [M]  drivers/usb/host/fsl-mph-dr-of.o
drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'

Fix this error by not allowing USB_FSL_MPH_DR_OF to be selected by ARCH_MXC.

Cc: stable at kernel.org
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Changed the selection logic to depend on FSL_SOC
- Cc stable at kernel.org

 drivers/usb/gadget/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 23a4473..0148676 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -159,7 +159,7 @@ config USB_FSL_USB2
 	tristate "Freescale Highspeed USB DR Peripheral Controller"
 	depends on FSL_SOC || ARCH_MXC
 	select USB_GADGET_DUALSPEED
-	select USB_FSL_MPH_DR_OF if OF
+	select USB_FSL_MPH_DR_OF if OF && FSL_SOC
 	help
 	   Some of Freescale PowerPC processors have a High Speed
 	   Dual-Role(DR) USB controller, which supports device mode.
-- 
1.7.1
