From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:17 +0200
Subject: [PATCH 25/34] pinctrl: mvebu: armada-xp: add spi1 function
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-26-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest Armada XP datasheet documents that some of the MPP pins can
be used to access the second SPI bus, labelled 'spi1'. This commit
adds the corresponding pins in the pinctrl driver and its DT binding
documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt | 26 +++++++++++++---------
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 25 +++++++++++++++------
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index e8e0a27..5f64ee1 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -31,11 +31,11 @@ mpp9          9        gpio, ge0(rxd3), lcd(d9)
 mpp10         10       gpio, ge0(rxctl), lcd(d10)
 mpp11         11       gpio, ge0(rxclk), lcd(d11)
 mpp12         12       gpio, ge0(txd4), ge1(txclkout), lcd(d12)
-mpp13         13       gpio, ge0(txd5), ge1(txd0), lcd(d13)
-mpp14         14       gpio, ge0(txd6), ge1(txd1), lcd(d15)
+mpp13         13       gpio, ge0(txd5), ge1(txd0), spi1(mosi), lcd(d13)
+mpp14         14       gpio, ge0(txd6), ge1(txd1), spi1(sck), lcd(d15)
 mpp15         15       gpio, ge0(txd7), ge1(txd2), lcd(d16)
-mpp16         16       gpio, ge0(txd7), ge1(txd3), lcd(d16)
-mpp17         17       gpio, ge0(col), ge1(txctl), lcd(d17)
+mpp16         16       gpio, ge0(txd7), ge1(txd3), spi1(cs0), lcd(d16)
+mpp17         17       gpio, ge0(col), ge1(txctl), spi1(miso), lcd(d17)
 mpp18         18       gpio, ge0(rxerr), ge1(rxd0), lcd(d18), ptp(trig)
 mpp19         19       gpio, ge0(crs), ge1(rxd1), lcd(d19), ptp(evreq)
 mpp20         20       gpio, ge0(rxd4), ge1(rxd2), lcd(d20), ptp(clk)
@@ -58,17 +58,21 @@ mpp36         36       gpio, spi0(mosi)
 mpp37         37       gpio, spi0(miso)
 mpp38         38       gpio, spi0(sck)
 mpp39         39       gpio, spi0(cs0)
-mpp40         40       gpio, spi0(cs1), uart2(cts), lcd(vga-hsync), pcie(clkreq0)
+mpp40         40       gpio, spi0(cs1), uart2(cts), lcd(vga-hsync), pcie(clkreq0),
+                       spi1(cs1)
 mpp41         41       gpio, spi0(cs2), uart2(rts), lcd(vga-vsync), sata1(prsnt),
-                       pcie(clkreq1)
+                       pcie(clkreq1), spi1(cs2)
 mpp42         42       gpio, uart2(rxd), uart0(cts), tdm(int7), tdm(timer)
-mpp43         43       gpio, uart2(txd), uart0(rts), spi0(cs3), pcie(rstout)
+mpp43         43       gpio, uart2(txd), uart0(rts), spi0(cs3), pcie(rstout),
+                       spi1(cs3)
 mpp44         44       gpio, uart2(cts), uart3(rxd), spi0(cs4), pcie(clkreq2),
-                       dram(bat)
-mpp45         45       gpio, uart2(rts), uart3(txd), spi0(cs5), sata1(prsnt)
-mpp46         46       gpio, uart3(rts), uart1(rts), spi0(cs6), sata0(prsnt)
+                       dram(bat), spi1(cs4)
+mpp45         45       gpio, uart2(rts), uart3(txd), spi0(cs5), sata1(prsnt),
+                       spi1(cs5)
+mpp46         46       gpio, uart3(rts), uart1(rts), spi0(cs6), sata0(prsnt),
+                       spi1(cs6)
 mpp47         47       gpio, uart3(cts), uart1(cts), spi0(cs7), pcie(clkreq3),
-                       ref(clkout)
+                       ref(clkout), spi1(cs7)
 mpp48         48       gpio, dev(clkout), dev(burst/last)
 
 * Marvell Armada XP (mv78260 and mv78460 only)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 74ff211..4674462 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -109,11 +109,13 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "ge0", "txd5",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "ge1", "txd0",       V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi1", "mosi",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "d13",        V_MV78230_PLUS)),
 	MPP_MODE(14,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "ge0", "txd6",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "ge1", "txd1",       V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi1", "sck",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "d14",        V_MV78230_PLUS)),
 	MPP_MODE(15,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
@@ -124,11 +126,13 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "ge0", "txclk",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "ge1", "txd3",       V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi1", "cs0",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "d16",        V_MV78230_PLUS)),
 	MPP_MODE(17,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "ge0", "col",        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "ge1", "txctl",      V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi1", "miso",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "d17",        V_MV78230_PLUS)),
 	MPP_MODE(18,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
@@ -239,14 +243,16 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x1, "spi0", "cs1",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart2", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "vga-hsync",  V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq0",   V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq0",   V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x6, "spi1", "cs1",       V_MV78230_PLUS)),
 	MPP_MODE(41,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "spi0", "cs2",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart2", "rts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "sata1", "prsnt",    V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "vga-vsync",  V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq1",   V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq1",   V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x6, "spi1", "cs2",       V_MV78230_PLUS)),
 	MPP_MODE(42,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart2", "rxd",      V_MV78230_PLUS),
@@ -258,33 +264,38 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x1, "uart2", "txd",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart0", "rts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "spi0", "cs3",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x4, "pcie", "rstout",    V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "pcie", "rstout",    V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x6, "spi1", "cs3",       V_MV78230_PLUS)),
 	MPP_MODE(44,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart2", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart3", "rxd",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "spi0", "cs4",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "dram", "bat",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq2",   V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq2",   V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x6, "spi1", "cs4",       V_MV78230_PLUS)),
 	MPP_MODE(45,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart2", "rts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart3", "txd",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "spi0", "cs5",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x4, "sata1", "prsnt",    V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "sata1", "prsnt",    V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x6, "spi1", "cs5",       V_MV78230_PLUS)),
 	MPP_MODE(46,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart3", "rts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart1", "rts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "spi0", "cs6",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x4, "sata0", "prsnt",    V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "sata0", "prsnt",    V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x6, "spi1", "cs6",       V_MV78230_PLUS)),
 	MPP_MODE(47,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart3", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart1", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "spi0", "cs7",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "ref", "clkout",     V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq3",   V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq3",   V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x6, "spi1", "cs7",       V_MV78230_PLUS)),
 	MPP_MODE(48,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "dev", "clkout",     V_MV78230_PLUS),
-- 
2.1.0
