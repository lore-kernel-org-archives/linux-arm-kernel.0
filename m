From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:22 +0200
Subject: [PATCH 30/34] pinctrl: mvebu: armada-38x: add ua1 functions
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-31-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest version of the Armada 38x datasheet documents several new
UART1 related functions on various MPP pins. This commit adds the
description of these new functions to the Armada 38x pinctrl driver as
well as to its DT binding documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/pinctrl/marvell,armada-38x-pinctrl.txt    | 12 ++++++------
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c             | 18 ++++++++++++------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 278887d..4330676 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -60,8 +60,8 @@ mpp41         41       gpio, ua1(rxd), ge1(rxctl), ua0(cts), spi1(cs3), dev(burs
 mpp42         42       gpio, ua1(txd), ua0(rts), dev(ad7)
 mpp43         43       gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nand(rb1)
 mpp44         44       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3(prsnt) [3]
-mpp45         45       gpio, ref(clk_out0), pcie0(rstout)
-mpp46         46       gpio, ref(clk_out1), pcie0(rstout)
+mpp45         45       gpio, ref(clk_out0), pcie0(rstout), ua1(rxd)
+mpp46         46       gpio, ref(clk_out1), pcie0(rstout), ua1(txd)
 mpp47         47       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3(prsnt) [2]
 mpp48         48       gpio, sata0(prsnt), dram(vttctrl), tdm(pclk), audio(mclk), sd0(d4), pcie0(clkreq)
 mpp49         49       gpio, sata2(prsnt) [2], sata3(prsnt) [2], tdm(fsync), audio(lrclk), sd0(d5), pcie1(clkreq)
@@ -70,10 +70,10 @@ mpp51         51       gpio, tdm(dtx), audio(sdo), dram(deccerr)
 mpp52         52       gpio, pcie0(rstout), tdm(int), audio(sdi), sd0(d6)
 mpp53         53       gpio, sata1(prsnt), sata0(prsnt), tdm(rst), audio(bclk), sd0(d7)
 mpp54         54       gpio, sata0(prsnt), sata1(prsnt), pcie0(rstout), ge0(txerr), sd0(d3)
-mpp55         55       gpio, ua1(cts), ge(mdio), pcie1(clkreq) [1], spi1(cs1), sd0(d0)
-mpp56         56       gpio, ua1(rts), ge(mdc), dram(deccerr), spi1(mosi)
-mpp57         57       gpio, spi1(sck), sd0(clk)
-mpp58         58       gpio, pcie1(clkreq) [1], i2c1(sck), pcie2(clkreq), spi1(miso), sd0(d1)
+mpp55         55       gpio, ua1(cts), ge(mdio), pcie1(clkreq) [1], spi1(cs1), sd0(d0), ua1(rxd)
+mpp56         56       gpio, ua1(rts), ge(mdc), dram(deccerr), spi1(mosi), ua1(txd)
+mpp57         57       gpio, spi1(sck), sd0(clk), ua1(txd)
+mpp58         58       gpio, pcie1(clkreq) [1], i2c1(sck), pcie2(clkreq), spi1(miso), sd0(d1), ua1(rxd)
 mpp59         59       gpio, pcie0(rstout), i2c1(sda), spi1(cs0), sd0(d2)
 
 [1]: only available on 88F6820 and 88F6828
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index ac8f297..370c73b 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -292,11 +292,13 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 	MPP_MODE(45,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ref",   "clk_out0",   V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(2, "pcie0", "rstout",     V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(2, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ua1",   "rxd",        V_88F6810_PLUS)),
 	MPP_MODE(46,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ref",   "clk_out1",   V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(2, "pcie0", "rstout",     V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(2, "pcie0", "rstout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ua1",   "txd",        V_88F6810_PLUS)),
 	MPP_MODE(47,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
@@ -356,24 +358,28 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "ge",    "mdio",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "pcie1", "clkreq",     V_88F6820_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",  "cs1",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd0",   "d0",         V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d0",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ua1",   "rxd",        V_88F6810_PLUS)),
 	MPP_MODE(56,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ua1",   "rts",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ge",    "mdc",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "dram",  "deccerr",    V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(4, "spi1",  "mosi",       V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(4, "spi1",  "mosi",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ua1",   "txd",        V_88F6810_PLUS)),
 	MPP_MODE(57,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",  "sck",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd0",   "clk",        V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "sd0",   "clk",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ua1",   "txd",        V_88F6810_PLUS)),
 	MPP_MODE(58,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie1", "clkreq",     V_88F6820_PLUS),
 		 MPP_VAR_FUNCTION(2, "i2c1",  "sck",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "pcie2", "clkreq",     V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",  "miso",       V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd0",   "d1",         V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d1",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ua1",   "rxd",        V_88F6810_PLUS)),
 	MPP_MODE(59,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0", "rstout",     V_88F6810_PLUS),
-- 
2.1.0
