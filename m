From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:26 +0200
Subject: [PATCH 34/34] pinctrl: mvebu: armada-39x: add support for Armada 395
 variant
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-35-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 39x SoC family has grown a new variant, the Armada 395,
which sits between the Armada 390 and Armada 398 in terms of
features. This commit adds support for this additional variant to the
Armada 39x pinctrl driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../pinctrl/marvell,armada-39x-pinctrl.txt         | 30 ++++++++--------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c         | 40 +++++++++++++---------
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index bceb6c5..a40b60f1 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -4,8 +4,9 @@ Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
 part and usage.
 
 Required properties:
-- compatible: "marvell,88f6920-pinctrl", "marvell,88f6928-pinctrl"
-  depending on the specific variant of the SoC being used.
+- compatible: "marvell,88f6920-pinctrl", "marvell,88f6925-pinctrl" or
+  "marvell,88f6928-pinctrl" depending on the specific variant of the
+  SoC being used.
 - reg: register specifier of MPP registers
 
 Available mpp pins/groups and functions:
@@ -59,19 +60,19 @@ mpp40	40	gpio, i2c1(sda), ua0(rts), sd0(d2), dev(ad6), ge(rxd3)
 mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burst/last), nand(rb0), ge(rxctl)
 mpp42	42	gpio, ua1(txd), ua0(rts), dev(ad7)
 mpp43	43	gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nand(rb1)
-mpp44	44	gpio, sata0(prsnt) [1], sata1(prsnt) [1], sata2(prsnt) [1],
-                sata3(prsnt) [1], led(clk)
+mpp44	44	gpio, sata0(prsnt) [1], sata1(prsnt) [1], sata2(prsnt) [2],
+                sata3(prsnt) [2], led(clk)
 mpp45	45	gpio, ref(clk), pcie0(rstout), ua1(rxd)
 mpp46	46	gpio, ref(clk), pcie0(rstout), ua1(txd), led(stb)
-mpp47	47	gpio, sata0(prsnt) [1], sata1(prsnt) [1], sata2(prsnt) [1],
-                sata3(prsnt) [1], led(data)
-mpp48	48	gpio, sata0(prsnt) [1], dram(vttctrl), tdm(pclk) [1], audio(mclk) [1], sd0(d4), pcie0(clkreq), ua1(txd)
-mpp49	49	gpio, sata2(prsnt) [1], sata3(prsnt) [1], tdm(fsync) [1],
-                audio(lrclk) [1], sd0(d5), ua2(rxd)
-mpp50	50	gpio, pcie0(rstout), tdm(drx) [1], audio(extclk) [1], sd0(cmd), ua2(rxd)
-mpp51	51	gpio, tdm(dtx) [1], audio(sdo) [1], dram(deccerr), ua2(txd)
-mpp52	52	gpio, pcie0(rstout), tdm(int) [1], audio(sdi) [1], sd0(d6), i2c3(sck)
-mpp53	53	gpio, sata1(prsnt) [1], sata0(prsnt) [1], tdm(rst) [1], audio(bclk) [1], sd0(d7), i2c3(sda)
+mpp47	47	gpio, sata0(prsnt) [1], sata1(prsnt) [1], sata2(prsnt) [2],
+                sata3(prsnt) [2], led(data)
+mpp48	48	gpio, sata0(prsnt) [1], dram(vttctrl), tdm(pclk) [2], audio(mclk) [2], sd0(d4), pcie0(clkreq), ua1(txd)
+mpp49	49	gpio, sata2(prsnt) [2], sata3(prsnt) [2], tdm(fsync) [2],
+                audio(lrclk) [2], sd0(d5), ua2(rxd)
+mpp50	50	gpio, pcie0(rstout), tdm(drx) [2], audio(extclk) [2], sd0(cmd), ua2(rxd)
+mpp51	51	gpio, tdm(dtx) [2], audio(sdo) [2], dram(deccerr), ua2(txd)
+mpp52	52	gpio, pcie0(rstout), tdm(int) [2], audio(sdi) [2], sd0(d6), i2c3(sck)
+mpp53	53	gpio, sata1(prsnt) [1], sata0(prsnt) [1], tdm(rst) [2], audio(bclk) [2], sd0(d7), i2c3(sda)
 mpp54	54	gpio, sata0(prsnt) [1], sata1(prsnt) [1], pcie0(rstout), sd0(d3), ua3(txd)
 mpp55	55	gpio, ua1(cts), spi1(cs1), sd0(d0), ua1(rxd), ua3(rxd)
 mpp56	56	gpio, ua1(rts), dram(deccerr), spi1(mosi), ua1(txd)
@@ -79,4 +80,5 @@ mpp57	57	gpio, spi1(sck), sd0(clk), ua1(txd)
 mpp58	58	gpio, i2c1(sck), pcie2(clkreq), spi1(miso), sd0(d1), ua1(rxd)
 mpp59	59	gpio, pcie0(rstout), i2c1(sda), spi1(cs0), sd0(d2)
 
-[1]: only available on 88F6928
+[1]: only available on 88F6925/88F6928
+[2]: only available on 88F6928
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index bae1199..fcfe9b4 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -36,8 +36,10 @@ static int armada_39x_mpp_ctrl_set(unsigned pid, unsigned long config)
 
 enum {
 	V_88F6920 = BIT(0),
-	V_88F6928 = BIT(1),
-	V_88F6920_PLUS = (V_88F6920 | V_88F6928),
+	V_88F6925 = BIT(1),
+	V_88F6928 = BIT(2),
+	V_88F6920_PLUS = (V_88F6920 | V_88F6925 | V_88F6928),
+	V_88F6925_PLUS = (V_88F6925 | V_88F6928),
 };
 
 static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
@@ -117,8 +119,8 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua1",     "rxd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",    "sck",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "sata1",   "prsnt",    V_88F6928),
-		 MPP_VAR_FUNCTION(6, "sata0",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(5, "sata1",   "prsnt",    V_88F6925_PLUS),
+		 MPP_VAR_FUNCTION(6, "sata0",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(7, "smi",     "mdio",     V_88F6920_PLUS)),
 	MPP_MODE(18,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -127,23 +129,23 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "i2c2",    "sck",      V_88F6920_PLUS)),
 	MPP_MODE(19,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(4, "sata1",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(5, "ua0",     "cts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "rxd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c2",    "sda",      V_88F6920_PLUS)),
 	MPP_MODE(20,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sata0",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(4, "sata0",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(5, "ua0",     "rts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "txd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "smi",     "mdc",      V_88F6920_PLUS)),
 	MPP_MODE(21,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",    "cs1",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(3, "sata0",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(3, "sata0",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(4, "sd0",     "cmd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "bootcs",   V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(6, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(6, "sata1",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxd0",     V_88F6920_PLUS)),
 	MPP_MODE(22,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -263,8 +265,8 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(6, "nand",    "rb1",      V_88F6920_PLUS)),
 	MPP_MODE(44,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
-		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6925_PLUS),
+		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(3, "sata2",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(4, "sata3",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(7, "led",     "clk",      V_88F6920_PLUS)),
@@ -281,14 +283,14 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "led",     "stb",      V_88F6920_PLUS)),
 	MPP_MODE(47,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
-		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6925_PLUS),
+		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(3, "sata2",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(5, "sata3",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(7, "led",     "data",     V_88F6920_PLUS)),
 	MPP_MODE(48,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(2, "dram",    "vttctrl",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "pclk",     V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "mclk",     V_88F6928),
@@ -325,16 +327,16 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "i2c3",    "sck",      V_88F6920_PLUS)),
 	MPP_MODE(53,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata1",   "prsnt",    V_88F6928),
-		 MPP_VAR_FUNCTION(2, "sata0",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata1",   "prsnt",    V_88F6925_PLUS),
+		 MPP_VAR_FUNCTION(2, "sata0",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "rst",      V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "bclk",     V_88F6928),
 		 MPP_VAR_FUNCTION(5, "sd0",     "d7",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c3",    "sda",      V_88F6920_PLUS)),
 	MPP_MODE(54,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
-		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6925_PLUS),
+		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6925_PLUS),
 		 MPP_VAR_FUNCTION(3, "pcie0",   "rstout",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "sd0",     "d3",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua3",     "txd",      V_88F6920_PLUS)),
@@ -379,6 +381,10 @@ static const struct of_device_id armada_39x_pinctrl_of_match[] = {
 		.data       = (void *) V_88F6920,
 	},
 	{
+		.compatible = "marvell,mv88f6925-pinctrl",
+		.data       = (void *) V_88F6925,
+	},
+	{
 		.compatible = "marvell,mv88f6928-pinctrl",
 		.data       = (void *) V_88F6928,
 	},
-- 
2.1.0
