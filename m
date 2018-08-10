From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 10 Aug 2018 14:51:50 -0700
Subject: [PATCH 3/3] arm64: dts: qcom: sdm845-mtp: Add nodes for USB
In-Reply-To: <20180810215150.82490-1-dianders@chromium.org>
References: <20180810215150.82490-1-dianders@chromium.org>
Message-ID: <20180810215150.82490-4-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the various nodes to "okay" and hook up the regulators.

NOTE: For now the main USB port (the one that goes out the Type C
connector) is forced to host.  Eventually someone will need to get the
Type C detection hooked up and get this all integrated with the
PMI8998 PMIC.  The reason for forcing to "host" in the meantime is
that this will leave us with one "host" and one "peripheral" port.

In order for host mode this to work, we assume that the bootloader
left things configured enough for us.  Apparently the magic for that
is is to do these writes on pmi8998:
- pm_comm_write_byte(2, 0x1153, 0x2C, 0);
- pm_comm_write_byte(2, 0x1152, 0x07, 0);
- pm_comm_write_byte(2, 0x1140, 0x00, 0);
- pm_comm_write_byte(2, 0x1140, 0x01, 0);

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 839ef9125bf4..eb9400bf2cbf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -480,6 +480,67 @@
 	status = "okay";
 };
 
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	/* Until we have Type C hooked up we'll force this as host. */
+	dr_mode = "host";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vdda_usb1_ss_core>;
+	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
+	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
+	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
+	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_usb1_ss_1p2>;
+	vdda-pll-supply = <&vdda_usb1_ss_core>;
+};
+
+&usb_2 {
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	/*
+	 * Though the USB block on SDM845 can support host, there's no vbus
+	 * signal for this port on MTP.  Thus (unless you have a non-compliant
+	 * hub that works without vbus) the only sensible thing is to force
+	 * peripheral mode.
+	 */
+	dr_mode = "peripheral";
+};
+
+&usb_2_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vdda_usb2_ss_core>;
+	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
+	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_22_8_MA>;
+};
+
+&usb_2_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_usb2_ss_1p2>;
+	vdda-pll-supply = <&vdda_usb2_ss_core>;
+};
+
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 
 &qup_i2c10_default {
-- 
2.18.0.597.ga71716f1ad-goog
