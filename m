From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 02 Jun 2013 22:14:43 +0200
Subject: [PATCHv3 3/3] Add DT bindings documentation for g762 driver
In-Reply-To: <cover.1370202835.git.arno@natisbad.org>
References: <cover.1370202835.git.arno@natisbad.org>
Message-ID: <4ba30c5af4e25c5d7d263b0f927aa9373a300bfa.1370202835.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 Documentation/devicetree/bindings/hwmon/g762.txt |   58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt

diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
new file mode 100644
index 0000000..3f7ccbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/g762.txt
@@ -0,0 +1,58 @@
+GMT G762/G763 PWM Fan controller
+
+Required node properties:
+
+ - "compatible": must be either "gmt,g762" or "gmt,g763"
+ - "reg": I2C bus address of the device
+
+Optional properties:
+
+ - "pwm_mode": fan driving mode. 1 for PWM mode, 0 for DC mode.
+
+ - "pwm_enable": fan speed control. 1 for open-loop, 2 for closed-loop.
+
+ - "pwm_freq": reference clock frequency for PWM mode in Hz. If not set,
+               default value is 32768.
+
+ - "fan_pulses": number of pulses per fan revolution. Supported values
+               are 2 and 4.
+
+ - "fan_div": fan clock frequency divisor value. Supported values are 1,
+               2, 4 and 8. Default is 1.
+
+ - "fan_target": initial target fan speed in RPM. Only works in closed-loop
+               fan speed control, i.e. when pwm_enable has already been set
+               to 2.
+
+ - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
+               The higher the more.
+
+ - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
+               and 1 (negative duty).
+
+ - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
+
+If an optional property is not set in .dts file, then current value is kept
+unmodified (e.g. u-boot installed value).
+
+
+Additional information on operational parameters for the device is available
+in Documentation/hwmon/g762. A detailed datasheet for the device is available
+at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
+
+Example g762 node:
+
+   g762: g762 at 3e {
+	compatible = "gmt,g762";
+	reg = <0x3e>;
+	pwm_mode = <1>;      /* closed-loop control */
+	pwm_enable = <2>;    /* PWM mode */
+	pwm_freq = <8192>;   /* PWM reference clock freq */
+	fan_pulses = <2>;    /* 2 pulses per rev */
+	fan_div = <2>;       /* fan clock divisor */
+	fan_target = <2000>; /* target fan speed at 2000 RPM */
+	fan_gear_mode = <0>; /* chip default */
+	fan_startv = <1>;    /* chip default */
+	pwm_polarity = <0>;  /* chip default */
+   };
+
-- 
1.7.10.4
