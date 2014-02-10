From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:04:55 +0100
Subject: [PATCH 1/2] pinctrl: mvebu: add pin-muxing driver for the Marvell
 Armada 375
In-Reply-To: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392051896-19178-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 375 is a new ARM SoC from Marvell, part of the
mvebu family, but using a Cortex-A9 CPU core. In terms of pin-muxing,
it is similar to Armada 370 and XP for the register layout, only
different in the number of available pins and their
functions. Therefore, we simply use the existing
drivers/pinctrl/mvebu/ infrastructure, with no other changes that the
list of pins and corresponding functions.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../pinctrl/marvell,armada-375-pinctrl.txt         |  81 ++++
 drivers/pinctrl/mvebu/Kconfig                      |   4 +
 drivers/pinctrl/mvebu/Makefile                     |   1 +
 drivers/pinctrl/mvebu/pinctrl-armada-375.c         | 441 +++++++++++++++++++++
 4 files changed, 527 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-375.c

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
new file mode 100644
index 0000000..2ede59d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
@@ -0,0 +1,81 @@
+* Marvell Armada 375 SoC pinctrl driver for mpp
+
+Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
+part and usage.
+
+Required properties:
+- compatible: "marvell,88f6720-pinctrl"
+
+Available mpp pins/groups and functions:
+Note: brackets (x) are not part of the mpp name for marvell,function and given
+only for more detailed description in this document.
+
+name          pins     functions
+================================================================================
+mpp0          0        gpio, dev(ad2), spi0(cs1), spi1(cs1)
+mpp1          1        gpio, dev(ad3), spi0(mosi), spi1(mosi)
+mpp2          2        gpio, dev(ad4), ptp(eventreq), led(c0), audio(sdi)
+mpp3          3        gpio, dev(ad5), ptp(triggen), led(p3), audio(mclk)
+mpp4          4        gpio, dev(ad6), spi0(miso), spi1(miso)
+mpp5          5        gpio, dev(ad7), spi0(cs2), spi1(cs2)
+mpp6          6        gpio, dev(ad0), led(p1), audio(rclk)
+mpp7          7        gpio, dev(ad1), ptp(clk), led(p2), audio(extclk)
+mpp8          8        gpio, dev (bootcs), spi0(cs0), spi1(cs0)
+mpp9          9        gpio, nf(wen), spi0(sck), spi1(sck)
+mpp10        10        gpio, nf(ren), dram(vttctrl), led(c1)
+mpp11        11        gpio, dev(a0), led(c2), audio(sdo)
+mpp12        12        gpio, dev(a1), audio(bclk)
+mpp13        13        gpio, dev(readyn), pcie0(rstoutn), pcie1(rstoutn)
+mpp14        14        gpio, i2c0(sda), uart1(txd)
+mpp15        15        gpio, i2c0(sck), uart1(rxd)
+mpp16        16        gpio, uart0(txd)
+mpp17        17        gpio, uart0(rxd)
+mpp18        18        gpio, tdm(intn)
+mpp19        19        gpio, tdm(rstn)
+mpp20        20        gpio, tdm(pclk)
+mpp21        21        gpio, tdm(fsync)
+mpp22        22        gpio, tdm(drx)
+mpp23        23        gpio, tdm(dtx)
+mpp24        24        gpio, led(p0), ge1(rxd0), sd(cmd), uart0(rts)
+mpp25        25        gpio, led(p2), ge1(rxd1), sd(d0), uart0(cts)
+mpp26        26        gpio, pcie0(clkreq), ge1(rxd2), sd(d2), uart1(rts)
+mpp27        27        gpio, pcie1(clkreq), ge1(rxd3), sd(d1), uart1(cts)
+mpp28        28        gpio, led(p3), ge1(txctl), sd(clk)
+mpp29        29        gpio, pcie1(clkreq), ge1(rxclk), sd(d3)
+mpp30        30        gpio, ge1(txd0), spi1(cs0)
+mpp31        31        gpio, ge1(txd1), spi1(mosi)
+mpp32        32        gpio, ge1(txd2), spi1(sck), ptp(triggen)
+mpp33        33        gpio, ge1(txd3), spi1(miso)
+mpp34        34        gpio, ge1(txclkout), spi1(sck)
+mpp35        35        gpio, ge1(rxctl), spi1(cs1), spi0(cs2)
+mpp36        36        gpio, pcie0(clkreq)
+mpp37        37        gpio, pcie0(clkreq), tdm(intn), ge(mdc)
+mpp38        38        gpio, pcie1(clkreq), ge(mdio)
+mpp39        39        gpio, ref(clkout)
+mpp40        40        gpio, uart1(txd)
+mpp41        41        gpio, uart1(rxd)
+mpp42        42        gpio, spi1(cs2), led(c0)
+mpp43        43        gpio, sata0(prsnt), dram(vttctrl)
+mpp44        44        gpio, sata0(prsnt)
+mpp45        45        gpio, spi0(cs2), pcie0(rstoutn)
+mpp46        46        gpio, led(p0), ge0(txd0), ge1(txd0)
+mpp47        47        gpio, led(p1), ge0(txd1), ge1(txd1)
+mpp48        48        gpio, led(p2), ge0(txd2), ge1(txd2)
+mpp49        49        gpio, led(p3), ge0(txd3), ge1(txd3)
+mpp50        50        gpio, led(c0), ge0(rxd0), ge1(rxd0)
+mpp51        51        gpio, led(c1), ge0(rxd1), ge1(rxd1)
+mpp52        52        gpio, led(c2), ge0(rxd2), ge1(rxd2)
+mpp53        53        gpio, pcie1(rstoutn), ge0(rxd3), ge1(rxd3)
+mpp54        54        gpio, pcie0(rstoutn), ge0(rxctl), ge1(rxctl)
+mpp55        55        gpio, ge0(rxclk), ge1(rxclk)
+mpp56        56        gpio, ge0(txclkout), ge1(txclkout)
+mpp57        57        gpio, ge0(txctl), ge1(txctl)
+mpp58        58        gpio, led(c0)
+mpp59        59        gpio, led(c1)
+mpp60        60        gpio, uart1(txd), led(c2)
+mpp61        61        gpio, i2c1(sda), uart1(rxd), spi1(cs2), led(p0)
+mpp62        62        gpio, i2c1(sck), led(p1)
+mpp63        63        gpio, ptp(triggen), led(p2)
+mpp64        64        gpio, dram(vttctrl), led(p3)
+mpp65        65        gpio, sata1(prsnt)
+mpp66        66        gpio, ptp(eventreq), spi1(cs3)
diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
index 366fa54..30c4570 100644
--- a/drivers/pinctrl/mvebu/Kconfig
+++ b/drivers/pinctrl/mvebu/Kconfig
@@ -17,6 +17,10 @@ config PINCTRL_ARMADA_370
 	bool
 	select PINCTRL_MVEBU
 
+config PINCTRL_ARMADA_375
+	bool
+	select PINCTRL_MVEBU
+
 config PINCTRL_ARMADA_XP
 	bool
 	select PINCTRL_MVEBU
diff --git a/drivers/pinctrl/mvebu/Makefile b/drivers/pinctrl/mvebu/Makefile
index 37c2532..e306c64 100644
--- a/drivers/pinctrl/mvebu/Makefile
+++ b/drivers/pinctrl/mvebu/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_PINCTRL_MVEBU)	+= pinctrl-mvebu.o
 obj-$(CONFIG_PINCTRL_DOVE)	+= pinctrl-dove.o
 obj-$(CONFIG_PINCTRL_KIRKWOOD)	+= pinctrl-kirkwood.o
 obj-$(CONFIG_PINCTRL_ARMADA_370) += pinctrl-armada-370.o
+obj-$(CONFIG_PINCTRL_ARMADA_375) += pinctrl-armada-375.o
 obj-$(CONFIG_PINCTRL_ARMADA_XP)  += pinctrl-armada-xp.o
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
new file mode 100644
index 0000000..c741a34
--- /dev/null
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -0,0 +1,441 @@
+/*
+ * Marvell Armada 375 pinctrl driver based on mvebu pinctrl core
+ *
+ * Copyright (C) 2012 Marvell
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
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-mvebu.h"
+
+static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
+	MPP_MODE(0,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "ad2"),
+		 MPP_FUNCTION(0x2, "spi0", "cs1"),
+		 MPP_FUNCTION(0x3, "spi1", "cs1"),
+		 MPP_FUNCTION(0x5, "nand", "io2")),
+	MPP_MODE(1,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "ad3"),
+		 MPP_FUNCTION(0x2, "spi0", "mosi"),
+		 MPP_FUNCTION(0x3, "spi1", "mosi"),
+		 MPP_FUNCTION(0x5, "nand", "io3")),
+	MPP_MODE(2,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "ad4"),
+		 MPP_FUNCTION(0x2, "ptp", "eventreq"),
+		 MPP_FUNCTION(0x3, "led", "c0"),
+		 MPP_FUNCTION(0x4, "audio", "sdi"),
+		 MPP_FUNCTION(0x5, "nand", "io4"),
+		 MPP_FUNCTION(0x6, "spi1", "mosi")),
+	MPP_MODE(3,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "ad5"),
+		 MPP_FUNCTION(0x2, "ptp", "triggen"),
+		 MPP_FUNCTION(0x3, "led", "p3"),
+		 MPP_FUNCTION(0x4, "audio", "mclk"),
+		 MPP_FUNCTION(0x5, "nand", "io5"),
+		 MPP_FUNCTION(0x6, "spi1", "miso")),
+	MPP_MODE(4,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "ad6"),
+		 MPP_FUNCTION(0x2, "spi0", "miso"),
+		 MPP_FUNCTION(0x3, "spi1", "miso"),
+		 MPP_FUNCTION(0x5, "nand", "io6")),
+	MPP_MODE(5,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "ad7"),
+		 MPP_FUNCTION(0x2, "spi0", "cs2"),
+		 MPP_FUNCTION(0x3, "spi1", "cs2"),
+		 MPP_FUNCTION(0x5, "nand", "io7"),
+		 MPP_FUNCTION(0x6, "spi1", "miso")),
+	MPP_MODE(6,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "ad0"),
+		 MPP_FUNCTION(0x3, "led", "p1"),
+		 MPP_FUNCTION(0x4, "audio", "rclk"),
+		 MPP_FUNCTION(0x5, "nand", "io0")),
+	MPP_MODE(7,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "ad1"),
+		 MPP_FUNCTION(0x2, "ptp", "clk"),
+		 MPP_FUNCTION(0x3, "led", "p2"),
+		 MPP_FUNCTION(0x4, "audio", "extclk"),
+		 MPP_FUNCTION(0x5, "nand", "io1")),
+	MPP_MODE(8,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev ", "bootcs"),
+		 MPP_FUNCTION(0x2, "spi0", "cs0"),
+		 MPP_FUNCTION(0x3, "spi1", "cs0"),
+		 MPP_FUNCTION(0x5, "nand", "ce")),
+	MPP_MODE(9,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "nf", "wen"),
+		 MPP_FUNCTION(0x2, "spi0", "sck"),
+		 MPP_FUNCTION(0x3, "spi1", "sck"),
+		 MPP_FUNCTION(0x5, "nand", "we")),
+	MPP_MODE(10,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "nf", "ren"),
+		 MPP_FUNCTION(0x2, "dram", "vttctrl"),
+		 MPP_FUNCTION(0x3, "led", "c1"),
+		 MPP_FUNCTION(0x5, "nand", "re"),
+		 MPP_FUNCTION(0x6, "spi1", "sck")),
+	MPP_MODE(11,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "a0"),
+		 MPP_FUNCTION(0x3, "led", "c2"),
+		 MPP_FUNCTION(0x4, "audio", "sdo"),
+		 MPP_FUNCTION(0x5, "nand", "cle")),
+	MPP_MODE(12,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "a1"),
+		 MPP_FUNCTION(0x4, "audio", "bclk"),
+		 MPP_FUNCTION(0x5, "nand", "ale")),
+	MPP_MODE(13,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "dev", "readyn"),
+		 MPP_FUNCTION(0x2, "pcie0", "rstoutn"),
+		 MPP_FUNCTION(0x3, "pcie1", "rstoutn"),
+		 MPP_FUNCTION(0x5, "nand", "rb"),
+		 MPP_FUNCTION(0x6, "spi1", "mosi")),
+	MPP_MODE(14,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "i2c0", "sda"),
+		 MPP_FUNCTION(0x3, "uart1", "txd")),
+	MPP_MODE(15,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "i2c0", "sck"),
+		 MPP_FUNCTION(0x3, "uart1", "rxd")),
+	MPP_MODE(16,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "uart0", "txd")),
+	MPP_MODE(17,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "uart0", "rxd")),
+	MPP_MODE(18,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "tdm", "intn")),
+	MPP_MODE(19,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "tdm", "rstn")),
+	MPP_MODE(20,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "tdm", "pclk")),
+	MPP_MODE(21,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "tdm", "fsync")),
+	MPP_MODE(22,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "tdm", "drx")),
+	MPP_MODE(23,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "tdm", "dtx")),
+	MPP_MODE(24,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "p0"),
+		 MPP_FUNCTION(0x2, "ge1", "rxd0"),
+		 MPP_FUNCTION(0x3, "sd", "cmd"),
+		 MPP_FUNCTION(0x4, "uart0", "rts"),
+		 MPP_FUNCTION(0x5, "spi0", "cs0"),
+		 MPP_FUNCTION(0x6, "dev", "cs1")),
+	MPP_MODE(25,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "p2"),
+		 MPP_FUNCTION(0x2, "ge1", "rxd1"),
+		 MPP_FUNCTION(0x3, "sd", "d0"),
+		 MPP_FUNCTION(0x4, "uart0", "cts"),
+		 MPP_FUNCTION(0x5, "spi0", "mosi"),
+		 MPP_FUNCTION(0x6, "dev", "cs2")),
+	MPP_MODE(26,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "pcie0", "clkreq"),
+		 MPP_FUNCTION(0x2, "ge1", "rxd2"),
+		 MPP_FUNCTION(0x3, "sd", "d2"),
+		 MPP_FUNCTION(0x4, "uart1", "rts"),
+		 MPP_FUNCTION(0x5, "spi0", "cs1"),
+		 MPP_FUNCTION(0x6, "led", "c1")),
+	MPP_MODE(27,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "pcie1", "clkreq"),
+		 MPP_FUNCTION(0x2, "ge1", "rxd3"),
+		 MPP_FUNCTION(0x3, "sd", "d1"),
+		 MPP_FUNCTION(0x4, "uart1", "cts"),
+		 MPP_FUNCTION(0x5, "spi0", "miso"),
+		 MPP_FUNCTION(0x6, "led", "c2")),
+	MPP_MODE(28,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "p3"),
+		 MPP_FUNCTION(0x2, "ge1", "txctl"),
+		 MPP_FUNCTION(0x3, "sd", "clk"),
+		 MPP_FUNCTION(0x5, "dram", "vttctrl")),
+	MPP_MODE(29,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "pcie1", "clkreq"),
+		 MPP_FUNCTION(0x2, "ge1", "rxclk"),
+		 MPP_FUNCTION(0x3, "sd", "d3"),
+		 MPP_FUNCTION(0x5, "spi0", "sck"),
+		 MPP_FUNCTION(0x6, "pcie0", "rstoutn")),
+	MPP_MODE(30,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge1", "txd0"),
+		 MPP_FUNCTION(0x3, "spi1", "cs0"),
+		 MPP_FUNCTION(0x5, "led", "p3"),
+		 MPP_FUNCTION(0x6, "ptp", "eventreq")),
+	MPP_MODE(31,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge1", "txd1"),
+		 MPP_FUNCTION(0x3, "spi1", "mosi"),
+		 MPP_FUNCTION(0x5, "led", "p0")),
+	MPP_MODE(32,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge1", "txd2"),
+		 MPP_FUNCTION(0x3, "spi1", "sck"),
+		 MPP_FUNCTION(0x4, "ptp", "triggen"),
+		 MPP_FUNCTION(0x5, "led", "c0")),
+	MPP_MODE(33,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge1", "txd3"),
+		 MPP_FUNCTION(0x3, "spi1", "miso"),
+		 MPP_FUNCTION(0x5, "led", "p2")),
+	MPP_MODE(34,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge1", "txclkout"),
+		 MPP_FUNCTION(0x3, "spi1", "sck"),
+		 MPP_FUNCTION(0x5, "led", "c1")),
+	MPP_MODE(35,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge1", "rxctl"),
+		 MPP_FUNCTION(0x3, "spi1", "cs1"),
+		 MPP_FUNCTION(0x4, "spi0", "cs2"),
+		 MPP_FUNCTION(0x5, "led", "p1")),
+	MPP_MODE(36,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "pcie0", "clkreq"),
+		 MPP_FUNCTION(0x5, "led", "c2")),
+	MPP_MODE(37,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "pcie0", "clkreq"),
+		 MPP_FUNCTION(0x2, "tdm", "intn"),
+		 MPP_FUNCTION(0x4, "ge", "mdc")),
+	MPP_MODE(38,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "pcie1", "clkreq"),
+		 MPP_FUNCTION(0x4, "ge", "mdio")),
+	MPP_MODE(39,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x4, "ref", "clkout"),
+		 MPP_FUNCTION(0x5, "led", "p3")),
+	MPP_MODE(40,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x4, "uart1", "txd"),
+		 MPP_FUNCTION(0x5, "led", "p0")),
+	MPP_MODE(41,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x4, "uart1", "rxd"),
+		 MPP_FUNCTION(0x5, "led", "p1")),
+	MPP_MODE(42,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x3, "spi1", "cs2"),
+		 MPP_FUNCTION(0x4, "led", "c0"),
+		 MPP_FUNCTION(0x6, "ptp", "clk")),
+	MPP_MODE(43,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "sata0", "prsnt"),
+		 MPP_FUNCTION(0x4, "dram", "vttctrl"),
+		 MPP_FUNCTION(0x5, "led", "c1")),
+	MPP_MODE(44,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x4, "sata0", "prsnt")),
+	MPP_MODE(45,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "spi0", "cs2"),
+		 MPP_FUNCTION(0x4, "pcie0", "rstoutn"),
+		 MPP_FUNCTION(0x5, "led", "c2"),
+		 MPP_FUNCTION(0x6, "spi1", "cs2")),
+	MPP_MODE(46,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "p0"),
+		 MPP_FUNCTION(0x2, "ge0", "txd0"),
+		 MPP_FUNCTION(0x3, "ge1", "txd0"),
+		 MPP_FUNCTION(0x6, "dev", "wen1")),
+	MPP_MODE(47,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "p1"),
+		 MPP_FUNCTION(0x2, "ge0", "txd1"),
+		 MPP_FUNCTION(0x3, "ge1", "txd1"),
+		 MPP_FUNCTION(0x5, "ptp", "triggen"),
+		 MPP_FUNCTION(0x6, "dev", "ale0")),
+	MPP_MODE(48,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "p2"),
+		 MPP_FUNCTION(0x2, "ge0", "txd2"),
+		 MPP_FUNCTION(0x3, "ge1", "txd2"),
+		 MPP_FUNCTION(0x6, "dev", "ale1")),
+	MPP_MODE(49,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "p3"),
+		 MPP_FUNCTION(0x2, "ge0", "txd3"),
+		 MPP_FUNCTION(0x3, "ge1", "txd3"),
+		 MPP_FUNCTION(0x6, "dev", "a2")),
+	MPP_MODE(50,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "c0"),
+		 MPP_FUNCTION(0x2, "ge0", "rxd0"),
+		 MPP_FUNCTION(0x3, "ge1", "rxd0"),
+		 MPP_FUNCTION(0x5, "ptp", "eventreq"),
+		 MPP_FUNCTION(0x6, "dev", "ad12")),
+	MPP_MODE(51,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "c1"),
+		 MPP_FUNCTION(0x2, "ge0", "rxd1"),
+		 MPP_FUNCTION(0x3, "ge1", "rxd1"),
+		 MPP_FUNCTION(0x6, "dev", "ad8")),
+	MPP_MODE(52,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "led", "c2"),
+		 MPP_FUNCTION(0x2, "ge0", "rxd2"),
+		 MPP_FUNCTION(0x3, "ge1", "rxd2"),
+		 MPP_FUNCTION(0x5, "i2c0", "sda"),
+		 MPP_FUNCTION(0x6, "dev", "ad9")),
+	MPP_MODE(53,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "pcie1", "rstoutn"),
+		 MPP_FUNCTION(0x2, "ge0", "rxd3"),
+		 MPP_FUNCTION(0x3, "ge1", "rxd3"),
+		 MPP_FUNCTION(0x5, "i2c0", "sck"),
+		 MPP_FUNCTION(0x6, "dev", "ad10")),
+	MPP_MODE(54,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "pcie0", "rstoutn"),
+		 MPP_FUNCTION(0x2, "ge0", "rxctl"),
+		 MPP_FUNCTION(0x3, "ge1", "rxctl"),
+		 MPP_FUNCTION(0x6, "dev", "ad11")),
+	MPP_MODE(55,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge0", "rxclk"),
+		 MPP_FUNCTION(0x3, "ge1", "rxclk"),
+		 MPP_FUNCTION(0x6, "dev", "cs0")),
+	MPP_MODE(56,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge0", "txclkout"),
+		 MPP_FUNCTION(0x3, "ge1", "txclkout"),
+		 MPP_FUNCTION(0x6, "dev", "oe")),
+	MPP_MODE(57,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ge0", "txctl"),
+		 MPP_FUNCTION(0x3, "ge1", "txctl"),
+		 MPP_FUNCTION(0x6, "dev", "wen0")),
+	MPP_MODE(58,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x4, "led", "c0")),
+	MPP_MODE(59,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x4, "led", "c1")),
+	MPP_MODE(60,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "uart1", "txd"),
+		 MPP_FUNCTION(0x4, "led", "c2"),
+		 MPP_FUNCTION(0x6, "dev", "ad13")),
+	MPP_MODE(61,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "i2c1", "sda"),
+		 MPP_FUNCTION(0x2, "uart1", "rxd"),
+		 MPP_FUNCTION(0x3, "spi1", "cs2"),
+		 MPP_FUNCTION(0x4, "led", "p0"),
+		 MPP_FUNCTION(0x6, "dev", "ad14")),
+	MPP_MODE(62,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "i2c1", "sck"),
+		 MPP_FUNCTION(0x4, "led", "p1"),
+		 MPP_FUNCTION(0x6, "dev", "ad15")),
+	MPP_MODE(63,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ptp", "triggen"),
+		 MPP_FUNCTION(0x4, "led", "p2"),
+		 MPP_FUNCTION(0x6, "dev", "burst")),
+	MPP_MODE(64,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "dram", "vttctrl"),
+		 MPP_FUNCTION(0x4, "led", "p3")),
+	MPP_MODE(65,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x1, "sata1", "prsnt")),
+	MPP_MODE(66,
+		 MPP_FUNCTION(0x0, "gpio", NULL),
+		 MPP_FUNCTION(0x2, "ptp", "eventreq"),
+		 MPP_FUNCTION(0x4, "spi1", "cs3"),
+		 MPP_FUNCTION(0x5, "pcie0", "rstoutn"),
+		 MPP_FUNCTION(0x6, "dev", "cs3")),
+};
+
+static struct mvebu_pinctrl_soc_info armada_375_pinctrl_info;
+
+static struct of_device_id armada_375_pinctrl_of_match[] = {
+	{ .compatible = "marvell,mv88f6720-pinctrl" },
+	{ },
+};
+
+static struct mvebu_mpp_ctrl mv88f6720_mpp_controls[] = {
+	MPP_REG_CTRL(0, 69),
+};
+
+static struct pinctrl_gpio_range mv88f6720_mpp_gpio_ranges[] = {
+	MPP_GPIO_RANGE(0,   0,  0, 32),
+	MPP_GPIO_RANGE(1,  32, 32, 32),
+	MPP_GPIO_RANGE(2,  64, 64,  3),
+};
+
+static int armada_375_pinctrl_probe(struct platform_device *pdev)
+{
+	struct mvebu_pinctrl_soc_info *soc = &armada_375_pinctrl_info;
+
+	soc->variant = 0; /* no variants for Armada 375 */
+	soc->controls = mv88f6720_mpp_controls;
+	soc->ncontrols = ARRAY_SIZE(mv88f6720_mpp_controls);
+	soc->modes = mv88f6720_mpp_modes;
+	soc->nmodes = ARRAY_SIZE(mv88f6720_mpp_modes);
+	soc->gpioranges = mv88f6720_mpp_gpio_ranges;
+	soc->ngpioranges = ARRAY_SIZE(mv88f6720_mpp_gpio_ranges);
+
+	pdev->dev.platform_data = soc;
+
+	return mvebu_pinctrl_probe(pdev);
+}
+
+static int armada_375_pinctrl_remove(struct platform_device *pdev)
+{
+	return mvebu_pinctrl_remove(pdev);
+}
+
+static struct platform_driver armada_375_pinctrl_driver = {
+	.driver = {
+		.name = "armada-375-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(armada_375_pinctrl_of_match),
+	},
+	.probe = armada_375_pinctrl_probe,
+	.remove = armada_375_pinctrl_remove,
+};
+
+module_platform_driver(armada_375_pinctrl_driver);
+
+MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell Armada 375 pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.2
