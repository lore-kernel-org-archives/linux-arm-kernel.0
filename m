From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 10:47:54 +0800
Subject: [PATCH 3/3] pinctrl: sirf: add DT-binding pinmux mapping support
In-Reply-To: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
References: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345690074-31327-4-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This makes us possible to define pinmux mapping in board-specific DTS.
prima2.dtsi provides all possible (groups,functions) configuration, and
device in .dts select configurations from dtsi files.

Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 arch/arm/boot/dts/prima2-evb.dts   |   37 ++++++
 arch/arm/boot/dts/prima2.dtsi      |  221 +++++++++++++++++++++++++++++++++++-
 arch/arm/mach-prima2/Makefile.boot |    2 +
 drivers/pinctrl/pinctrl-sirf.c     |   58 +++++++++-
 4 files changed, 315 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/prima2-evb.dts

diff --git a/arch/arm/boot/dts/prima2-evb.dts b/arch/arm/boot/dts/prima2-evb.dts
new file mode 100644
index 0000000..57286b4
--- /dev/null
+++ b/arch/arm/boot/dts/prima2-evb.dts
@@ -0,0 +1,37 @@
+/*
+ * DTS file for CSR SiRFprimaII Evaluation Board
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/dts-v1/;
+
+/include/ "prima2.dtsi"
+
+/ {
+	model = "CSR SiRFprimaII Evaluation Board";
+	compatible = "sirf,prima2", "sirf,prima2-cb";
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	axi {
+		peri-iobg {
+			uart at b0060000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart1_pins_a>;
+			};
+			spi at b00d0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi0_pins_a>;
+			};
+			spi at b0170000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi1_pins_a>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 1b716aa..055fca5 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -277,14 +277,231 @@
 				interrupts = <33>;
 			};
 
-			gpio: gpio-controller at b0120000 {
+			gpio: pinctrl at b0120000 {
 				#gpio-cells = <2>;
 				#interrupt-cells = <2>;
-				compatible = "sirf,prima2-gpio-pinmux";
+				compatible = "sirf,prima2-pinctrl";
 				reg = <0xb0120000 0x10000>;
 				interrupts = <43 44 45 46 47>;
 				gpio-controller;
 				interrupt-controller;
+
+				lcd_16pins_a: lcd0 at 0 {
+					lcd {
+						sirf,pins = "lcd_16bitsgrp";
+						sirf,function = "lcd_16bits";
+					};
+				};
+				lcd_18pins_a: lcd0 at 1 {
+					lcd {
+						sirf,pins = "lcd_18bitsgrp";
+						sirf,function = "lcd_18bits";
+					};
+				};
+				lcd_24pins_a: lcd0 at 2 {
+					lcd {
+						sirf,pins = "lcd_24bitsgrp";
+						sirf,function = "lcd_24bits";
+					};
+				};
+				lcdrom_pins_a: lcdrom0 at 0 {
+					lcd {
+						sirf,pins = "lcdromgrp";
+						sirf,function = "lcdrom";
+					};
+				};
+				uart0_pins_a: uart0 at 0 {
+					uart {
+						sirf,pins = "uart0grp";
+						sirf,function = "uart0";
+					};
+				};
+				uart1_pins_a: uart1 at 0 {
+					uart {
+						sirf,pins = "uart1grp";
+						sirf,function = "uart1";
+					};
+				};
+				uart2_pins_a: uart2 at 0 {
+					uart {
+						sirf,pins = "uart2grp";
+						sirf,function = "uart2";
+					};
+				};
+				uart2_noflow_pins_a: uart2 at 1 {
+					uart {
+						sirf,pins = "uart2_nostreamctrlgrp";
+						sirf,function = "uart2_nostreamctrl";
+					};
+				};
+				spi0_pins_a: spi0 at 0 {
+					spi {
+						sirf,pins = "spi0grp";
+						sirf,function = "spi0";
+					};
+				};
+				spi1_pins_a: spi1 at 0 {
+					spi {
+						sirf,pins = "spi1grp";
+						sirf,function = "spi1";
+					};
+				};
+				i2c0_pins_a: i2c0 at 0 {
+					i2c {
+						sirf,pins = "i2c0grp";
+						sirf,function = "i2c0";
+					};
+				};
+				i2c1_pins_a: i2c1 at 0 {
+					i2c {
+						sirf,pins = "i2c1grp";
+						sirf,function = "i2c1";
+					};
+				};
+                                pwm0_pins_a: pwm0 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm0grp";
+                                                sirf,function = "pwm0";
+                                        };
+                                };
+                                pwm1_pins_a: pwm1 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm1grp";
+                                                sirf,function = "pwm1";
+                                        };
+                                };
+                                pwm2_pins_a: pwm2 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm2grp";
+                                                sirf,function = "pwm2";
+                                        };
+                                };
+                                pwm3_pins_a: pwm3 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm3grp";
+                                                sirf,function = "pwm3";
+                                        };
+                                };
+                                gps_pins_a: gps at 0 {
+                                        gps {
+                                                sirf,pins = "gpsgrp";
+                                                sirf,function = "gps";
+                                        };
+                                };
+                                vip_pins_a: vip at 0 {
+                                        vip {
+                                                sirf,pins = "vipgrp";
+                                                sirf,function = "vip";
+                                        };
+                                };
+                                sdmmc0_pins_a: sdmmc0 at 0 {
+                                        sdmmc0 {
+                                                sirf,pins = "sdmmc0grp";
+                                                sirf,function = "sdmmc0";
+                                        };
+                                };
+                                sdmmc1_pins_a: sdmmc1 at 0 {
+                                        sdmmc1 {
+                                                sirf,pins = "sdmmc1grp";
+                                                sirf,function = "sdmmc1";
+                                        };
+                                };
+                                sdmmc2_pins_a: sdmmc2 at 0 {
+                                        sdmmc2 {
+                                                sirf,pins = "sdmmc2grp";
+                                                sirf,function = "sdmmc2";
+                                        };
+                                };
+                                sdmmc3_pins_a: sdmmc3 at 0 {
+                                        sdmmc3 {
+                                                sirf,pins = "sdmmc3grp";
+                                                sirf,function = "sdmmc3";
+                                        };
+                                };
+                                sdmmc4_pins_a: sdmmc4 at 0 {
+                                        sdmmc4 {
+                                                sirf,pins = "sdmmc4grp";
+                                                sirf,function = "sdmmc4";
+                                        };
+                                };
+                                sdmmc5_pins_a: sdmmc5 at 0 {
+                                        sdmmc5 {
+                                                sirf,pins = "sdmmc5grp";
+                                                sirf,function = "sdmmc5";
+                                        };
+                                };
+                                i2s_pins_a: i2s at 0 {
+                                        i2s {
+                                                sirf,pins = "i2sgrp";
+                                                sirf,function = "i2s";
+                                        };
+                                };
+                                ac97_pins_a: ac97 at 0 {
+                                        ac97 {
+                                                sirf,pins = "ac97grp";
+                                                sirf,function = "ac97";
+                                        };
+                                };
+                                nand_pins_a: nand at 0 {
+                                        nand {
+                                                sirf,pins = "nandgrp";
+                                                sirf,function = "nand";
+                                        };
+                                };
+                                usp0_pins_a: usp0 at 0 {
+                                        usp0 {
+                                                sirf,pins = "usp0grp";
+                                                sirf,function = "usp0";
+                                        };
+                                };
+                                usp1_pins_a: usp1 at 0 {
+                                        usp1 {
+                                                sirf,pins = "usp1grp";
+                                                sirf,function = "usp1";
+                                        };
+                                };
+                                usp2_pins_a: usp2 at 0 {
+                                        usp2 {
+                                                sirf,pins = "usp2grp";
+                                                sirf,function = "usp2";
+                                        };
+                                };
+                                usb0_utmi_drvbus_pins_a: usb0_utmi_drvbus at 0 {
+                                        usb0_utmi_drvbus {
+                                                sirf,pins = "usb0_utmi_drvbusgrp";
+                                                sirf,function = "usb0_utmi_drvbus";
+                                        };
+                                };
+                                usb1_utmi_drvbus_pins_a: usb1_utmi_drvbus at 0 {
+                                        usb1_utmi_drvbus {
+                                                sirf,pins = "usb1_utmi_drvbusgrp";
+                                                sirf,function = "usb1_utmi_drvbus";
+                                        };
+                                };
+                                warm_rst_pins_a: warm_rst at 0 {
+                                        warm_rst {
+                                                sirf,pins = "warm_rstgrp";
+                                                sirf,function = "warm_rst";
+                                        };
+                                };
+                                pulse_count_pins_a: pulse_count at 0 {
+                                        pulse_count {
+                                                sirf,pins = "pulse_countgrp";
+                                                sirf,function = "pulse_count";
+                                        };
+                                };
+                                cko0_rst_pins_a: cko0_rst at 0 {
+                                        cko0_rst {
+                                                sirf,pins = "cko0_rstgrp";
+                                                sirf,function = "cko0_rst";
+                                        };
+                                };
+                                cko1_rst_pins_a: cko1_rst at 0 {
+                                        cko1_rst {
+                                                sirf,pins = "cko1_rstgrp";
+                                                sirf,function = "cko1_rst";
+                                        };
+                                };
 			};
 
 			pwm at b0130000 {
diff --git a/arch/arm/mach-prima2/Makefile.boot b/arch/arm/mach-prima2/Makefile.boot
index c77a488..98167da 100644
--- a/arch/arm/mach-prima2/Makefile.boot
+++ b/arch/arm/mach-prima2/Makefile.boot
@@ -1,3 +1,5 @@
 zreladdr-y		+= 0x00008000
 params_phys-y		:= 0x00000100
 initrd_phys-y		:= 0x00800000
+
+dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 7fca6ce..304360c 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -17,6 +17,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -916,11 +917,66 @@ static void sirfsoc_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s
 	seq_printf(s, " " DRIVER_NAME);
 }
 
+static int sirfsoc_dt_node_to_map(struct pinctrl_dev *pctldev,
+				 struct device_node *np_config,
+				 struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct sirfsoc_pmx *spmx = pinctrl_dev_get_drvdata(pctldev);
+	struct device_node *np;
+	struct property *prop;
+	const char *function, *group;
+	int ret, index = 0, count = 0;
+
+	/* calculate number of maps required */
+	for_each_child_of_node(np_config, np) {
+		ret = of_property_read_string(np, "sirf,function", &function);
+		if (ret < 0)
+			return ret;
+
+		ret = of_property_count_strings(np, "sirf,pins");
+		if (ret < 0)
+			return ret;
+
+		count += ret;
+	}
+
+	if (!count) {
+		dev_err(spmx->dev, "No child nodes passed via DT\n");
+		return -ENODEV;
+	}
+
+	*map = kzalloc(sizeof(**map) * count, GFP_KERNEL);
+	if (!*map)
+		return -ENOMEM;
+
+	for_each_child_of_node(np_config, np) {
+		of_property_read_string(np, "sirf,function", &function);
+		of_property_for_each_string(np, "sirf,pins", prop, group) {
+			(*map)[index].type = PIN_MAP_TYPE_MUX_GROUP;
+			(*map)[index].data.mux.group = group;
+			(*map)[index].data.mux.function = function;
+			index++;
+		}
+	}
+
+	*num_maps = count;
+
+	return 0;
+}
+
+static void sirfsoc_dt_free_map(struct pinctrl_dev *pctldev,
+		struct pinctrl_map *map, unsigned num_maps)
+{
+	kfree(map);
+}
+
 static struct pinctrl_ops sirfsoc_pctrl_ops = {
 	.get_groups_count = sirfsoc_get_groups_count,
 	.get_group_name = sirfsoc_get_group_name,
 	.get_group_pins = sirfsoc_get_group_pins,
 	.pin_dbg_show = sirfsoc_pin_dbg_show,
+	.dt_node_to_map = sirfsoc_dt_node_to_map,
+	.dt_free_map = sirfsoc_dt_free_map,
 };
 
 struct sirfsoc_pmx_func {
@@ -1221,7 +1277,7 @@ out_no_gpio_remap:
 }
 
 static const struct of_device_id pinmux_ids[] __devinitconst = {
-	{ .compatible = "sirf,prima2-gpio-pinmux" },
+	{ .compatible = "sirf,prima2-pinctrl" },
 	{}
 };
 
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
