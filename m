From: ayaka@soulik.info (Randy Li)
Date: Sun,  7 May 2017 22:46:32 +0800
Subject: [PATCH 1/2] ARM: dts: rockchip: add eDP panel support for Firefly
In-Reply-To: <20170507144633.11714-1-ayaka@soulik.info>
References: <20170507144633.11714-1-ayaka@soulik.info>
Message-ID: <20170507144633.11714-2-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the supporting to the eDP panel sold by
the T-CHIP for the Firefly RK3288.

The InvenSense MPU6050 sensor at the botton of the panel
is also enabled.

The Firefly RK3288 Reload use a different GPIO pin to enable
the power of the eDP panel.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 92 +++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 436878b..786cfb7 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -62,6 +62,62 @@
 		};
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <
+			  3   4   5   6   7
+			  8   9  10  11  12  13  14  15
+			 16  17  18  19  20  21  22  23
+			 24  25  26  27  28  29  30  31
+			 32  33  34  35  36  37  38  39
+			 40  41  42  43  44  45  46  47
+			 48  49  50  51  52  53  54  55
+			 56  57  58  59  60  61  62  63
+			 64  65  66  67  68  69  70  71
+			 72  73  74  75  76  77  78  79
+			 80  81  82  83  84  85  86  87
+			 88  89  90  91  92  93  94  95
+			 96  97  98  99 100 101 102 103
+			104 105 106 107 108 109 110 111
+			112 113 114 115 116 117 118 119
+			120 121 122 123 124 125 126 127
+			128 129 130 131 132 133 134 135
+			136 137 138 139 140 141 142 143
+			144 145 146 147 148 149 150 151
+			152 153 154 155 156 157 158 159
+			160 161 162 163 164 165 166 167
+			168 169 170 171 172 173 174 175
+			176 177 178 179 180 181 182 183
+			184 185 186 187 188 189 190 191
+			192 193 194 195 196 197 198 199
+			200 201 202 203 204 205 206 207
+			208 209 210 211 212 213 214 215
+			216 217 218 219 220 221 222 223
+			224 225 226 227 228 229 230 231
+			232 233 234 235 236 237 238 239
+			240 241 242 243 244 245 246 247
+			248 249 250 251 252 253 254 255>;
+		default-brightness-level = <180>;
+		pwms = <&pwm1 0 25000 0>;
+		pwm-names = "backlight";
+		power-supply = <&vcc_sys>;
+	};
+
+	panel: panel {
+		compatible ="lg,lp079qx1-sp0v";
+		power-supply = <&vcc_sys>;
+		backlight = <&backlight>;
+		enable-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
+
+		ports {
+			panel_in: port {
+				panel_in_edp: endpoint {
+					remote-endpoint = <&edp_out_panel>;
+				};
+			};
+		};
+	};
+
 	dovdd_1v8: dovdd-1v8-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "dovdd_1v8";
@@ -203,6 +259,26 @@
 	cpu0-supply = <&vdd_cpu>;
 };
 
+&edp {
+	vcc-supply = <&vdd10_lcd>;
+	vccio-supply = <&vcca_18>;
+	ports {
+		edp_out: port at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			edp_out_panel: endpoint {
+				reg = <0>;
+				remote-endpoint = <&panel_in_edp>;
+			};
+		};
+	};
+};
+
+&edp_phy {
+	status = "okay";
+};
+
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
@@ -385,6 +461,22 @@
 
 &i2c1 {
 	status = "okay";
+
+	mpu6050 at 68 {
+		compatible = "invensense,mpu6050";
+		reg = <0x68>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
+		mount-matrix = "0",
+			       "1",
+			       "0",
+			       "-1",
+			       "0",
+			       "0",
+			       "0",
+			       "0",
+			       "-1";
+	};
 };
 
 &i2c2 {
-- 
2.9.3
