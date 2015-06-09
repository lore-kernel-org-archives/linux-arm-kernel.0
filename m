From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:25 +0200
Subject: [PATCH 33/34] pinctrl: mvebu: armada-39x: add missing SATA functions
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-34-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest version of the Armada 39x datasheet documents several new
SATA related functions on various MPP pins. This commit adds the
description of these new functions to the Armada 39x pinctrl driver as
well as to its DT binding documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/pinctrl/marvell,armada-39x-pinctrl.txt        | 14 +++++++++-----
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c                 |  9 +++++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index 2e4725f..bceb6c5 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -31,11 +31,12 @@ mpp13	13	gpio, dev(ad15), pcie2(clkreq), led(data)
 mpp14	14	gpio, dram(vttctrl), dev(we1), ua1(txd)
 mpp15	15	gpio, pcie0(rstout), spi0(mosi), i2c1(sck)
 mpp16	16	gpio, dram(deccerr), spi0(miso), pcie0(clkreq), i2c1(sda)
-mpp17	17	gpio, ua1(rxd), spi0(sck), smi(mdio)
+mpp17	17	gpio, ua1(rxd), spi0(sck), sata1(prsnt) [1], sata0(prsnt) [1], smi(mdio)
 mpp18	18	gpio, ua1(txd), spi0(cs0), i2c2(sck)
 mpp19	19	gpio, sata1(prsnt) [1], ua0(cts), ua1(rxd), i2c2(sda)
 mpp20	20	gpio, sata0(prsnt) [1], ua0(rts), ua1(txd), smi(mdc)
-mpp21	21	gpio, spi0(cs1), sata0(prsnt) [1], sd0(cmd), dev(bootcs), ge(rxd0)
+mpp21	21	gpio, spi0(cs1), sata0(prsnt) [1], sd0(cmd), dev(bootcs),
+                sata1(prsnt) [1], ge(rxd0)
 mpp22	22	gpio, spi0(mosi), dev(ad0)
 mpp23	23	gpio, spi0(sck), dev(ad2)
 mpp24	24	gpio, spi0(miso), ua0(cts), ua1(rxd), sd0(d4), dev(ready)
@@ -58,12 +59,15 @@ mpp40	40	gpio, i2c1(sda), ua0(rts), sd0(d2), dev(ad6), ge(rxd3)
 mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burst/last), nand(rb0), ge(rxctl)
 mpp42	42	gpio, ua1(txd), ua0(rts), dev(ad7)
 mpp43	43	gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nand(rb1)
-mpp44	44	gpio, sata0(prsnt) [1], sata1(prsnt) [1], led(clk)
+mpp44	44	gpio, sata0(prsnt) [1], sata1(prsnt) [1], sata2(prsnt) [1],
+                sata3(prsnt) [1], led(clk)
 mpp45	45	gpio, ref(clk), pcie0(rstout), ua1(rxd)
 mpp46	46	gpio, ref(clk), pcie0(rstout), ua1(txd), led(stb)
-mpp47	47	gpio, sata0(prsnt) [1], sata1(prsnt) [1], led(data)
+mpp47	47	gpio, sata0(prsnt) [1], sata1(prsnt) [1], sata2(prsnt) [1],
+                sata3(prsnt) [1], led(data)
 mpp48	48	gpio, sata0(prsnt) [1], dram(vttctrl), tdm(pclk) [1], audio(mclk) [1], sd0(d4), pcie0(clkreq), ua1(txd)
-mpp49	49	gpio, tdm(fsync) [1], audio(lrclk) [1], sd0(d5), ua2(rxd)
+mpp49	49	gpio, sata2(prsnt) [1], sata3(prsnt) [1], tdm(fsync) [1],
+                audio(lrclk) [1], sd0(d5), ua2(rxd)
 mpp50	50	gpio, pcie0(rstout), tdm(drx) [1], audio(extclk) [1], sd0(cmd), ua2(rxd)
 mpp51	51	gpio, tdm(dtx) [1], audio(sdo) [1], dram(deccerr), ua2(txd)
 mpp52	52	gpio, pcie0(rstout), tdm(int) [1], audio(sdi) [1], sd0(d6), i2c3(sck)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index afab0c1..bae1199 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -117,6 +117,8 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua1",     "rxd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",    "sck",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(6, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(7, "smi",     "mdio",     V_88F6920_PLUS)),
 	MPP_MODE(18,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -141,6 +143,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(3, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(4, "sd0",     "cmd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "bootcs",   V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(6, "sata1",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxd0",     V_88F6920_PLUS)),
 	MPP_MODE(22,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -262,6 +265,8 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(3, "sata2",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(4, "sata3",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(7, "led",     "clk",      V_88F6920_PLUS)),
 	MPP_MODE(45,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -278,6 +283,8 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(3, "sata2",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(5, "sata3",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(7, "led",     "data",     V_88F6920_PLUS)),
 	MPP_MODE(48,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -290,6 +297,8 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "ua1",     "txd",      V_88F6920_PLUS)),
 	MPP_MODE(49,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(1, "sata2",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(2, "sata3",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(3, "tdm",     "fsync",    V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "lrclk",    V_88F6928),
 		 MPP_VAR_FUNCTION(5, "sd0",     "d5",       V_88F6920_PLUS),
-- 
2.1.0
