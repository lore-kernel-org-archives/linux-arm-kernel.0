From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:04:56 +0100
Subject: [PATCH 2/2] pinctrl: mvebu: add pin-muxing driver for the Marvell
 Armada 380/385
In-Reply-To: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392051896-19178-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 380/385 are new ARM SoCs from Marvell, part of the
mvebu family, but using a Cortex-A9 CPU core. In terms of pin-muxing,
it is similar to Armada 370 and XP for the register layout, only
different in the number of available pins and their
functions. Therefore, we simply use the existing
drivers/pinctrl/mvebu/ infrastructure, with no other changes that the
list of pins and corresponding functions.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../pinctrl/marvell,armada-38x-pinctrl.txt         |  79 ++++
 drivers/pinctrl/mvebu/Kconfig                      |   4 +
 drivers/pinctrl/mvebu/Makefile                     |   1 +
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c         | 445 +++++++++++++++++++++
 4 files changed, 529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-38x.c

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
new file mode 100644
index 0000000..1d45f9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -0,0 +1,79 @@
+* Marvell Armada 380/385 SoC pinctrl driver for mpp
+
+Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
+part and usage.
+
+Required properties:
+- compatible: "marvell,88f6810-pinctrl", "marvell,88f6820-pinctrl" or
+  "marvell,88f6828-pinctrl" depending on the specific variant of the
+  SoC being used.
+
+Available mpp pins/groups and functions:
+Note: brackets (x) are not part of the mpp name for marvell,function and given
+only for more detailed description in this document.
+
+name          pins     functions
+================================================================================
+mpp0          0        gpio, ua0(rxd)
+mpp1          1        gpio, ua0(txd)
+mpp2          2        gpio, i2c0(sck)
+mpp3          3        gpio, i2c0(sda)
+mpp4          4        gpio, ge(mdc), ua1(txd), ua0(rts)
+mpp5          5        gpio, ge(mdio), ua1(rxd), ua0(cts)
+mpp6          6        gpio, ge0(txclkout), ge0(crs), dev(cs3)
+mpp7          7        gpio, ge0(txd0), dev(ad9)
+mpp8          8        gpio, ge0(txd1), dev(ad10)
+mpp9          9        gpio, ge0(txd2), dev(ad11)
+mpp10         10       gpio, ge0(txd3), dev(ad12)
+mpp11         11       gpio, ge0(txctl), dev(ad13)
+mpp12         12       gpio, ge0(rxd0), pcie0(rstout), pcie1(rstout) [1], spi0(cs1), dev(ad14)
+mpp13         13       gpio, ge0(rxd1), pcie0(clkreq), pcie1(clkreq) [1], spi0(cs2), dev(ad15)
+mpp14         14       gpio, ge0(rxd2), ptp(clk), m(vtt_ctrl), spi0(cs3), dev(wen1)
+mpp15         15       gpio, ge0(rxd3), ge(mdc slave), pcie0(rstout), spi0(mosi), pcie1(rstout) [1]
+mpp16         16       gpio, ge0(rxctl), ge(mdio slave), m(decc_err), spi0(miso), pcie0(clkreq)
+mpp17         17       gpio, ge0(rxclk), ptp(clk), ua1(rxd), spi0(sck), sata1(prsnt)
+mpp18         18       gpio, ge0(rxerr), ptp(trig_gen), ua1(txd), spi0(cs0), pcie1(rstout) [1]
+mpp19         19       gpio, ge0(col), ptp(event_req), pcie0(clkreq), sata1(prsnt), ua0(cts)
+mpp20         20       gpio, ge0(txclk), ptp(clk), pcie1(rstout) [1], sata0(prsnt), ua0(rts)
+mpp21         21       gpio, spi0(cs1), ge1(rxd0), sata0(prsnt), sd0(cmd), dev(bootcs)
+mpp22         22       gpio, spi0(mosi), dev(ad0)
+mpp23         23       gpio, spi0(sck), dev(ad2)
+mpp24         24       gpio, spi0(miso), ua0(cts), ua1(rxd), sd0(d4), dev(ready)
+mpp25         25       gpio, spi0(cs0), ua0(rts), ua1(txd), sd0(d5), dev(cs0)
+mpp26         26       gpio, spi0(cs2), i2c1(sck), sd0(d6), dev(cs1)
+mpp27         27       gpio, spi0(cs3), ge1(txclkout), i2c1(sda), sd0(d7), dev(cs2)
+mpp28         28       gpio, ge1(txd0), sd0(clk), dev(ad5)
+mpp29         29       gpio, ge1(txd1), dev(ale0)
+mpp30         30       gpio, ge1(txd2), dev(oen)
+mpp31         31       gpio, ge1(txd3), dev(ale1)
+mpp32         32       gpio, ge1(txctl), dev(wen0)
+mpp33         33       gpio, m(decc_err), dev(ad3)
+mpp34         34       gpio, dev(ad1)
+mpp35         35       gpio, ref(clk_out1), dev(a1)
+mpp36         36       gpio, ptp(trig_gen), dev(a0)
+mpp37         37       gpio, ptp(clk), ge1(rxclk), sd0(d3), dev(ad8)
+mpp38         38       gpio, ptp(event_req), ge1(rxd1), ref(clk_out0), sd0(d0), dev(ad4)
+mpp39         39       gpio, i2c1(sck), ge1(rxd2), ua0(cts), sd0(d1), dev(a2)
+mpp40         40       gpio, i2c1(sda), ge1(rxd3), ua0(rts), sd0(d2), dev(ad6)
+mpp41         41       gpio, ua1(rxd), ge1(rxctl), ua0(cts), spi1(cs3), dev(burst/last)
+mpp42         42       gpio, ua1(txd), ua0(rts), dev(ad7)
+mpp43         43       gpio, pcie0(clkreq), m(vtt_ctrl), m(decc_err), pcie0(rstout), dev(clkout)
+mpp44         44       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3(prsnt) [3], pcie0(rstout)
+mpp45         45       gpio, ref(clk_out0), pcie0(rstout), pcie1(rstout) [1], pcie2(rstout), pcie3(rstout)
+mpp46         46       gpio, ref(clk_out1), pcie0(rstout), pcie1(rstout) [1], pcie2(rstout), pcie3(rstout)
+mpp47         47       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], spi1(cs2), sata3(prsnt) [2]
+mpp48         48       gpio, sata0(prsnt), m(vtt_ctrl), tdm2c(pclk), audio(mclk), sd0(d4)
+mpp49         49       gpio, sata2(prsnt) [2], sata3(prsnt) [2], tdm2c(fsync), audio(lrclk), sd0(d5)
+mpp50         50       gpio, pcie0(rstout), pcie1(rstout) [1], tdm2c(drx), audio(extclk), sd0(cmd)
+mpp51         51       gpio, tdm2c(dtx), audio(sdo), m(decc_err)
+mpp52         52       gpio, pcie0(rstout), pcie1(rstout) [1], tdm2c(intn), audio(sdi), sd0(d6)
+mpp53         53       gpio, sata1(prsnt), sata0(prsnt), tdm2c(rstn), audio(bclk), sd0(d7)
+mpp54         54       gpio, sata0(prsnt), sata1(prsnt), pcie0(rstout), pcie1(rstout) [1], sd0(d3)
+mpp55         55       gpio, ua1(cts), ge(mdio), pcie1(clkreq) [1], spi1(cs1), sd0(d0)
+mpp56         56       gpio, ua1(rts), ge(mdc), m(decc_err), spi1(mosi)
+mpp57         57       gpio, spi1(sck), sd0(clk)
+mpp58         58       gpio, pcie1(clkreq) [1], i2c1(sck), pcie2(clkreq), spi1(miso), sd0(d1)
+mpp59         59       gpio, pcie0(rstout), i2c1(sda), pcie1(rstout) [1], spi1(cs0), sd0(d2)
+
+[1]: only available on 88F6820 and 88F6828
+[2]: only available on 88F6828
diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
index 30c4570..a22b030 100644
--- a/drivers/pinctrl/mvebu/Kconfig
+++ b/drivers/pinctrl/mvebu/Kconfig
@@ -21,6 +21,10 @@ config PINCTRL_ARMADA_375
 	bool
 	select PINCTRL_MVEBU
 
+config PINCTRL_ARMADA_38X
+	bool
+	select PINCTRL_MVEBU
+
 config PINCTRL_ARMADA_XP
 	bool
 	select PINCTRL_MVEBU
diff --git a/drivers/pinctrl/mvebu/Makefile b/drivers/pinctrl/mvebu/Makefile
index e306c64..bc1b9f1 100644
--- a/drivers/pinctrl/mvebu/Makefile
+++ b/drivers/pinctrl/mvebu/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_PINCTRL_DOVE)	+= pinctrl-dove.o
 obj-$(CONFIG_PINCTRL_KIRKWOOD)	+= pinctrl-kirkwood.o
 obj-$(CONFIG_PINCTRL_ARMADA_370) += pinctrl-armada-370.o
 obj-$(CONFIG_PINCTRL_ARMADA_375) += pinctrl-armada-375.o
+obj-$(CONFIG_PINCTRL_ARMADA_38X) += pinctrl-armada-38x.o
 obj-$(CONFIG_PINCTRL_ARMADA_XP)  += pinctrl-armada-xp.o
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
new file mode 100644
index 0000000..b3aa85e
--- /dev/null
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -0,0 +1,445 @@
+/*
+ * Marvell Armada 380/385 pinctrl driver based on mvebu pinctrl core
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-mvebu.h"
+
+enum {
+	V_88F6810 = BIT(0),
+	V_88F6820 = BIT(1),
+	V_88F6828 = BIT(2),
+	V_88F6810_PLUS = (V_88F6810 | V_88F6820 | V_88F6828),
+	V_88F6820_PLUS = (V_88F6820 | V_88F6828),
+};
+
+static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
+	MPP_MODE(0,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ua0",   "rxd",        V_88F6810_PLUS)),
+	MPP_MODE(1,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ua0",   "txd",        V_88F6810_PLUS)),
+	MPP_MODE(2,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "i2c0",  "sck",        V_88F6810_PLUS)),
+	MPP_MODE(3,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "i2c0",  "sda",        V_88F6810_PLUS)),
+	MPP_MODE(4,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge",    "mdc",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ua1",   "txd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua0",   "rts",        V_88F6810_PLUS)),
+	MPP_MODE(5,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge",    "mdio",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ua1",   "rxd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua0",   "cts",        V_88F6810_PLUS)),
+	MPP_MODE(6,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "txclkout",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge0",   "crs",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "cs3",        V_88F6810_PLUS)),
+	MPP_MODE(7,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "txd0",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad9",        V_88F6810_PLUS)),
+	MPP_MODE(8,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "txd1",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad10",       V_88F6810_PLUS)),
+	MPP_MODE(9,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "txd2",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad11",       V_88F6810_PLUS)),
+	MPP_MODE(10,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "txd3",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad12",       V_88F6810_PLUS)),
+	MPP_MODE(11,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "txctl",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad13",       V_88F6810_PLUS)),
+	MPP_MODE(12,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "rxd0",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi0",  "cs1",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad14",       V_88F6810_PLUS)),
+	MPP_MODE(13,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "rxd1",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "pcie0", "clkreq",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie1", "clkreq",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi0",  "cs2",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad15",       V_88F6810_PLUS)),
+	MPP_MODE(14,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "rxd2",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ptp",   "clk",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "m",     "vtt_ctrl",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi0",  "cs3",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "wen1",       V_88F6810_PLUS)),
+	MPP_MODE(15,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "rxd3",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge",    "mdc slave",  V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi0",  "mosi",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "pcie1", "rstout",     V_88F6820_PLUS)),
+	MPP_MODE(16,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "rxctl",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge",    "mdio slave", V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "m",     "decc_err",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi0",  "miso",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "pcie0", "clkreq",     V_88F6810_PLUS)),
+	MPP_MODE(17,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "rxclk",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ptp",   "clk",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua1",   "rxd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi0",  "sck",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sata1", "prsnt",      V_88F6810_PLUS)),
+	MPP_MODE(18,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "rxerr",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ptp",   "trig_gen",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua1",   "txd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi0",  "cs0",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "pcie1", "rstout",     V_88F6820_PLUS)),
+	MPP_MODE(19,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "col",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ptp",   "event_req",  V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie0", "clkreq",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sata1", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "ua0",   "cts",        V_88F6810_PLUS)),
+	MPP_MODE(20,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ge0",   "txclk",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ptp",   "clk",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(4, "sata0", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "ua0",   "rts",        V_88F6810_PLUS)),
+	MPP_MODE(21,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "spi0",  "cs1",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "rxd0",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "sata0", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "cmd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "bootcs",     V_88F6810_PLUS)),
+	MPP_MODE(22,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "spi0",  "mosi",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad0",        V_88F6810_PLUS)),
+	MPP_MODE(23,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "spi0",  "sck",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad2",        V_88F6810_PLUS)),
+	MPP_MODE(24,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "spi0",  "miso",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ua0",   "cts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua1",   "rxd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "d4",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ready",      V_88F6810_PLUS)),
+	MPP_MODE(25,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "spi0",  "cs0",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ua0",   "rts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua1",   "txd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "d5",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "cs0",        V_88F6810_PLUS)),
+	MPP_MODE(26,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "spi0",  "cs2",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "i2c1",  "sck",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "d6",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "cs1",        V_88F6810_PLUS)),
+	MPP_MODE(27,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "spi0",  "cs3",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "txclkout",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "i2c1",  "sda",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "d7",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "cs2",        V_88F6810_PLUS)),
+	MPP_MODE(28,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "txd0",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "clk",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad5",        V_88F6810_PLUS)),
+	MPP_MODE(29,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "txd1",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ale0",       V_88F6810_PLUS)),
+	MPP_MODE(30,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "txd2",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "oen",        V_88F6810_PLUS)),
+	MPP_MODE(31,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "txd3",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ale1",       V_88F6810_PLUS)),
+	MPP_MODE(32,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "txctl",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "wen0",       V_88F6810_PLUS)),
+	MPP_MODE(33,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "m",     "decc_err",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad3",        V_88F6810_PLUS)),
+	MPP_MODE(34,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad1",        V_88F6810_PLUS)),
+	MPP_MODE(35,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ref",   "clk_out1",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "a1",         V_88F6810_PLUS)),
+	MPP_MODE(36,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ptp",   "trig_gen",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "a0",         V_88F6810_PLUS)),
+	MPP_MODE(37,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ptp",   "clk",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "rxclk",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "d3",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad8",        V_88F6810_PLUS)),
+	MPP_MODE(38,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ptp",   "event_req",  V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "rxd1",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ref",   "clk_out0",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "d0",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad4",        V_88F6810_PLUS)),
+	MPP_MODE(39,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "i2c1",  "sck",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "rxd2",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua0",   "cts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "d1",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "a2",         V_88F6810_PLUS)),
+	MPP_MODE(40,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "i2c1",  "sda",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "rxd3",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua0",   "rts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",   "d2",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad6",        V_88F6810_PLUS)),
+	MPP_MODE(41,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ua1",   "rxd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge1",   "rxctl",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua0",   "cts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi1",  "cs3",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "burst/last", V_88F6810_PLUS)),
+	MPP_MODE(42,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ua1",   "txd",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "ua0",   "rts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "ad7",        V_88F6810_PLUS)),
+	MPP_MODE(43,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "pcie0", "clkreq",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "m",     "vtt_ctrl",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "m",     "decc_err",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "clkout",     V_88F6810_PLUS)),
+	MPP_MODE(44,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "sata1", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "sata2", "prsnt",      V_88F6828),
+		 MPP_VAR_FUNCTION(4, "sata3", "prsnt",      V_88F6828),
+		 MPP_VAR_FUNCTION(5, "pcie0", "rstout",     V_88F6810_PLUS)),
+	MPP_MODE(45,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ref",   "clk_out0",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(4, "pcie2", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "pcie3", "rstout",     V_88F6810_PLUS)),
+	MPP_MODE(46,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ref",   "clk_out1",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(4, "pcie2", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "pcie3", "rstout",     V_88F6810_PLUS)),
+	MPP_MODE(47,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "sata1", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "sata2", "prsnt",      V_88F6828),
+		 MPP_VAR_FUNCTION(4, "spi1",  "cs2",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sata3", "prsnt",      V_88F6828)),
+	MPP_MODE(48,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "m",     "vtt_ctrl",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm2c", "pclk",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "audio", "mclk",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d4",         V_88F6810_PLUS)),
+	MPP_MODE(49,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "sata2", "prsnt",      V_88F6828),
+		 MPP_VAR_FUNCTION(2, "sata3", "prsnt",      V_88F6828),
+		 MPP_VAR_FUNCTION(3, "tdm2c", "fsync",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "audio", "lrclk",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d5",         V_88F6810_PLUS)),
+	MPP_MODE(50,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm2c", "drx",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "audio", "extclk",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "cmd",        V_88F6810_PLUS)),
+	MPP_MODE(51,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm2c", "dtx",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "audio", "sdo",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "m",     "decc_err",   V_88F6810_PLUS)),
+	MPP_MODE(52,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm2c", "intn",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "audio", "sdi",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d6",         V_88F6810_PLUS)),
+	MPP_MODE(53,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "sata1", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "sata0", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm2c", "rstn",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "audio", "bclk",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d7",         V_88F6810_PLUS)),
+	MPP_MODE(54,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "sata1", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d3",         V_88F6810_PLUS)),
+	MPP_MODE(55,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ua1",   "cts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge",    "mdio",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie1", "clkreq",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi1",  "cs1",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d0",         V_88F6810_PLUS)),
+	MPP_MODE(56,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ua1",   "rts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ge",    "mdc",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "m",     "decc_err",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi1",  "mosi",       V_88F6810_PLUS)),
+	MPP_MODE(57,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi1",  "sck",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "clk",        V_88F6810_PLUS)),
+	MPP_MODE(58,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "pcie1", "clkreq",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(2, "i2c1",  "sck",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie2", "clkreq",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi1",  "miso",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d1",         V_88F6810_PLUS)),
+	MPP_MODE(59,
+		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "i2c1",  "sda",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(4, "spi1",  "cs0",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d2",         V_88F6810_PLUS)),
+};
+
+static struct mvebu_pinctrl_soc_info armada_38x_pinctrl_info;
+
+static struct of_device_id armada_38x_pinctrl_of_match[] = {
+	{
+		.compatible = "marvell,mv88f6810-pinctrl",
+		.data       = (void *) V_88F6810,
+	},
+	{
+		.compatible = "marvell,mv88f6820-pinctrl",
+		.data       = (void *) V_88F6820,
+	},
+	{
+		.compatible = "marvell,mv88f6828-pinctrl",
+		.data       = (void *) V_88F6828,
+	},
+	{ },
+};
+
+static struct mvebu_mpp_ctrl armada_38x_mpp_controls[] = {
+	MPP_REG_CTRL(0, 59),
+};
+
+static struct pinctrl_gpio_range armada_38x_mpp_gpio_ranges[] = {
+	MPP_GPIO_RANGE(0,   0,  0, 32),
+	MPP_GPIO_RANGE(1,  32, 32, 27),
+};
+
+static int armada_38x_pinctrl_probe(struct platform_device *pdev)
+{
+	struct mvebu_pinctrl_soc_info *soc = &armada_38x_pinctrl_info;
+	const struct of_device_id *match =
+		of_match_device(armada_38x_pinctrl_of_match, &pdev->dev);
+
+	if (!match)
+		return -ENODEV;
+
+	soc->variant = (unsigned) match->data & 0xff;
+
+	soc->controls = armada_38x_mpp_controls;
+	soc->ncontrols = ARRAY_SIZE(armada_38x_mpp_controls);
+	soc->gpioranges = armada_38x_mpp_gpio_ranges;
+	soc->ngpioranges = ARRAY_SIZE(armada_38x_mpp_gpio_ranges);
+	soc->modes = armada_38x_mpp_modes;
+	soc->nmodes = armada_38x_mpp_controls[0].npins;
+
+	pdev->dev.platform_data = soc;
+
+	return mvebu_pinctrl_probe(pdev);
+}
+
+static int armada_38x_pinctrl_remove(struct platform_device *pdev)
+{
+	return mvebu_pinctrl_remove(pdev);
+}
+
+static struct platform_driver armada_38x_pinctrl_driver = {
+	.driver = {
+		.name = "armada-38x-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(armada_38x_pinctrl_of_match),
+	},
+	.probe = armada_38x_pinctrl_probe,
+	.remove = armada_38x_pinctrl_remove,
+};
+
+module_platform_driver(armada_38x_pinctrl_driver);
+
+MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell Armada 38x pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.2
