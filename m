From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:09 +0200
Subject: [PATCH 17/34] pinctrl: mvebu: armada-{370,375}: normalize PCIe pins
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-18-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit normalizes the naming of PCIe pins to use 'rstout' instead
of 'rstoutn' or 'rst-out'.

Since only the subnames are changed, DT compatibility is not affected.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/pinctrl/marvell,armada-370-pinctrl.txt        |  2 +-
 .../bindings/pinctrl/marvell,armada-375-pinctrl.txt        |  8 ++++----
 drivers/pinctrl/mvebu/pinctrl-armada-370.c                 |  2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c                 | 14 +++++++-------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index e6dce5d..24a7450 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -86,7 +86,7 @@ mpp57         57       gpio, dev(cs3), uart1(rxd), tdm(fsync), sata0(prsnt),
 mpp58         58       gpio, dev(cs0), uart1(rts), tdm(int), audio(extclk),
                        uart0(rts)
 mpp59         59       gpo, dev(ale0), uart1(rts), uart0(rts), audio(bclk)
-mpp60         60       gpio, dev(ale1), uart1(rxd), sata0(prsnt), pcie(rst-out),
+mpp60         60       gpio, dev(ale1), uart1(rxd), sata0(prsnt), pcie(rstout),
                        audio(sdi)
 mpp61         61       gpo, dev(we1), uart1(txd), audio(rclk)
 mpp62         62       gpio, dev(a2), uart1(cts), tdm(drx), pcie(clkreq0),
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
index 3140324..f942a00 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
@@ -26,7 +26,7 @@ mpp9          9        gpio, spi0(sck), spi1(sck), nand(we)
 mpp10        10        gpio, dram(vttctrl), led(c1), nand(re)
 mpp11        11        gpio, dev(a0), led(c2), audio(sdo)
 mpp12        12        gpio, dev(a1), audio(bclk)
-mpp13        13        gpio, dev(ready), pcie0(rstoutn), pcie1(rstoutn)
+mpp13        13        gpio, dev(ready), pcie0(rstout), pcie1(rstout)
 mpp14        14        gpio, i2c0(sda), uart1(txd)
 mpp15        15        gpio, i2c0(sck), uart1(rxd)
 mpp16        16        gpio, uart0(txd)
@@ -58,7 +58,7 @@ mpp41        41        gpio, uart1(rxd)
 mpp42        42        gpio, spi1(cs2), led(c0)
 mpp43        43        gpio, sata0(prsnt), dram(vttctrl)
 mpp44        44        gpio, sata0(prsnt)
-mpp45        45        gpio, spi0(cs2), pcie0(rstoutn)
+mpp45        45        gpio, spi0(cs2), pcie0(rstout)
 mpp46        46        gpio, led(p0), ge0(txd0), ge1(txd0), dev(we1)
 mpp47        47        gpio, led(p1), ge0(txd1), ge1(txd1)
 mpp48        48        gpio, led(p2), ge0(txd2), ge1(txd2)
@@ -66,8 +66,8 @@ mpp49        49        gpio, led(p3), ge0(txd3), ge1(txd3)
 mpp50        50        gpio, led(c0), ge0(rxd0), ge1(rxd0)
 mpp51        51        gpio, led(c1), ge0(rxd1), ge1(rxd1)
 mpp52        52        gpio, led(c2), ge0(rxd2), ge1(rxd2)
-mpp53        53        gpio, pcie1(rstoutn), ge0(rxd3), ge1(rxd3)
-mpp54        54        gpio, pcie0(rstoutn), ge0(rxctl), ge1(rxctl)
+mpp53        53        gpio, pcie1(rstout), ge0(rxd3), ge1(rxd3)
+mpp54        54        gpio, pcie0(rstout), ge0(rxctl), ge1(rxctl)
 mpp55        55        gpio, ge0(rxclk), ge1(rxclk)
 mpp56        56        gpio, ge0(txclkout), ge1(txclkout)
 mpp57        57        gpio, ge0(txctl), ge1(txctl), dev(we0)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index fe2439c..e295636 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -348,7 +348,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	   MPP_FUNCTION(0x1, "dev", "ale1"),
 	   MPP_FUNCTION(0x2, "uart1", "rxd"),
 	   MPP_FUNCTION(0x3, "sata0", "prsnt"),
-	   MPP_FUNCTION(0x4, "pcie", "rst-out"),
+	   MPP_FUNCTION(0x4, "pcie", "rstout"),
 	   MPP_FUNCTION(0x5, "audio", "sdi")),
 	MPP_MODE(61,
 	   MPP_FUNCTION(0x0, "gpo", NULL),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index c41dd19..4d3e235 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -121,8 +121,8 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 	MPP_MODE(13,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x1, "dev", "ready"),
-		 MPP_FUNCTION(0x2, "pcie0", "rstoutn"),
-		 MPP_FUNCTION(0x3, "pcie1", "rstoutn"),
+		 MPP_FUNCTION(0x2, "pcie0", "rstout"),
+		 MPP_FUNCTION(0x3, "pcie1", "rstout"),
 		 MPP_FUNCTION(0x5, "nand", "rb"),
 		 MPP_FUNCTION(0x6, "spi1", "mosi")),
 	MPP_MODE(14,
@@ -201,7 +201,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x2, "ge1", "rxclk"),
 		 MPP_FUNCTION(0x3, "sd", "d3"),
 		 MPP_FUNCTION(0x5, "spi0", "sck"),
-		 MPP_FUNCTION(0x6, "pcie0", "rstoutn")),
+		 MPP_FUNCTION(0x6, "pcie0", "rstout")),
 	MPP_MODE(30,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "ge1", "txd0"),
@@ -276,7 +276,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 	MPP_MODE(45,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "spi0", "cs2"),
-		 MPP_FUNCTION(0x4, "pcie0", "rstoutn"),
+		 MPP_FUNCTION(0x4, "pcie0", "rstout"),
 		 MPP_FUNCTION(0x5, "led", "c2"),
 		 MPP_FUNCTION(0x6, "spi1", "cs2")),
 	MPP_MODE(46,
@@ -326,14 +326,14 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x6, "dev", "ad9")),
 	MPP_MODE(53,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x1, "pcie1", "rstoutn"),
+		 MPP_FUNCTION(0x1, "pcie1", "rstout"),
 		 MPP_FUNCTION(0x2, "ge0", "rxd3"),
 		 MPP_FUNCTION(0x3, "ge1", "rxd3"),
 		 MPP_FUNCTION(0x5, "i2c0", "sck"),
 		 MPP_FUNCTION(0x6, "dev", "ad10")),
 	MPP_MODE(54,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x1, "pcie0", "rstoutn"),
+		 MPP_FUNCTION(0x1, "pcie0", "rstout"),
 		 MPP_FUNCTION(0x2, "ge0", "rxctl"),
 		 MPP_FUNCTION(0x3, "ge1", "rxctl"),
 		 MPP_FUNCTION(0x6, "dev", "ad11")),
@@ -391,7 +391,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "ptp", "evreq"),
 		 MPP_FUNCTION(0x4, "spi1", "cs3"),
-		 MPP_FUNCTION(0x5, "pcie0", "rstoutn"),
+		 MPP_FUNCTION(0x5, "pcie0", "rstout"),
 		 MPP_FUNCTION(0x6, "dev", "cs3")),
 };
 
-- 
2.1.0
