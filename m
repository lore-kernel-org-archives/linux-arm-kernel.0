From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue,  7 Jul 2015 00:54:55 +0530
Subject: [PATCH-v3 11/11] Documentation: binding: add sclk adjustment
 properties to i2c-pxa
In-Reply-To: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436210695-19159-12-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With addition of PXA910 family of devices, the TWSI module supports
new feature which allows us to adjust SCLK. i2c-pxa driver takes input
configuration in nsec and converts it to respective bit-fields,

 - i2c-sclk-low-time-ns : SCLK low time (tlow)
   This property is used along with mode selection.
 - i2c-sclk-high-time-ns : SCLK high time (thigh)
 - i2c-start-hold-time-ns : Used in case of high speed mode for start bit
   hold/setup wait counter.
 - i2c-stop-hold-time-ns : Used in case of high speed mode for stop bit
   hold/setup wait counter.
 - i2c-sda-hold-time-ns : Used to calculate hold/setup wait counter for
   standard and fast mode.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
index 9657db5..bb4df60 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
@@ -23,12 +23,25 @@ Optional properties :
  - i2c-disable-after-xfer : If set, driver will disable I2C module
    after msg xfer and enable it again before xfer.
 
+   (Applicable to PXA910 family):
+
+ - i2c-sclk-low-time-ns : SCLK low time (tlow), for standard/fast/high
+   speed mode.
+   This property is used along with mode selection. Driver uses this property
+   to set low/high time for standard and fast speed mode, as HW counter
+   bit-field is same for both.
+ - i2c-sclk-high-time-ns : SCLK high time (thigh), Used in case of high speed
+   mode only.
+
 Examples:
 	twsi1: i2c at d4011000 {
 		compatible = "mrvl,mmp-twsi";
 		reg = <0xd4011000 0x1000>;
 		interrupts = <7>;
 		mrvl,i2c-fast-mode;
+
+		i2c-sclk-low-time-ns = <988>;
+		i2c-sclk-high-time-ns = <988>;
 	};
 	
 	twsi2: i2c at d4025000 {
-- 
1.9.1
