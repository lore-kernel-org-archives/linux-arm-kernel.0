From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 11 May 2016 17:33:11 +0100
Subject: [PATCH] usb: dwc3: st: Fix USB_DR_MODE_PERIPHERAL configuration.
Message-ID: <1462984391-605-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set USB3_FORCE_VBUSVALID when configured for USB_DR_MODE_PERIPHERAL
mode, as it is required to have a working setup.

This worked on the internal driver by relying on the reset
value of the syscfg register as the bits aren't explicity cleared
and set like the upstream driver.

Also add a comment about what setting this bit means.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/usb/dwc3/dwc3-st.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 5c0adb9..50d6ae6 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -129,12 +129,18 @@ static int st_dwc3_drd_init(struct st_dwc3 *dwc3_data)
 	switch (dwc3_data->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
 
-		val &= ~(USB3_FORCE_VBUSVALID | USB3_DELAY_VBUSVALID
+		val &= ~(USB3_DELAY_VBUSVALID
 			| USB3_SEL_FORCE_OPMODE | USB3_FORCE_OPMODE(0x3)
 			| USB3_SEL_FORCE_DPPULLDOWN2 | USB3_FORCE_DPPULLDOWN2
 			| USB3_SEL_FORCE_DMPULLDOWN2 | USB3_FORCE_DMPULLDOWN2);
 
-		val |= USB3_DEVICE_NOT_HOST;
+		/*
+		 * USB3_PORT2_FORCE_VBUSVALID When '1' and when
+		 * USB3_PORT2_DEVICE_NOT_HOST = 1, forces VBUSVLDEXT2 input
+		 * of the pico PHY to 1.
+		 */
+
+		val |= USB3_DEVICE_NOT_HOST | USB3_FORCE_VBUSVALID;
 		break;
 
 	case USB_DR_MODE_HOST:
-- 
1.9.1
