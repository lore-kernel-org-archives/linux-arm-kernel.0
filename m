From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:11 +0200
Subject: [PATCH 19/34] pinctrl: mvebu: armada-{370,
 xp}: normalize ethernet txclkout pins
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-20-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit normalizes the naming of the Ethernet txclkout pin to be
the same accross Marvell SoCs. It is worth mentioning that the DT
binding documentation of the Armada XP was wrong for MPP12: it said
the function was ge1(txd0), while it is in fact ge1(txclkout). It is
however not really a fix worth sending to stable since it does not
change the behavior, and the driver itself was correct.

Since only the subnames are changed, DT backward compatibility is not
affected.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt        | 2 +-
 .../devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt         | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-370.c                            | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c                             | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index cc0be9d..44aedd5 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -18,7 +18,7 @@ mpp1          1        gpo, uart0(txd)
 mpp2          2        gpio, i2c0(sck), uart0(txd)
 mpp3          3        gpio, i2c0(sda), uart0(rxd)
 mpp4          4        gpio, cpu_pd(vdd)
-mpp5          5        gpo, ge0(txclko), uart1(txd), spi1(clk), audio(mclk)
+mpp5          5        gpo, ge0(txclkout), uart1(txd), spi1(clk), audio(mclk)
 mpp6          6        gpio, ge0(txd0), sata0(prsnt), tdm(rst), audio(sdo)
 mpp7          7        gpo, ge0(txd1), tdm(dtx), audio(lrclk)
 mpp8          8        gpio, ge0(txd2), uart0(rts), tdm(drx), audio(bclk)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index 561e519..0bd7d2f 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -18,7 +18,7 @@ only for more detailed description in this document.
 
 name          pins     functions
 ================================================================================
-mpp0          0        gpio, ge0(txclko), lcd(d0)
+mpp0          0        gpio, ge0(txclkout), lcd(d0)
 mpp1          1        gpio, ge0(txd0), lcd(d1)
 mpp2          2        gpio, ge0(txd1), lcd(d2)
 mpp3          3        gpio, ge0(txd2), lcd(d3)
@@ -30,7 +30,7 @@ mpp8          8        gpio, ge0(rxd2), lcd(d8)
 mpp9          9        gpio, ge0(rxd3), lcd(d9)
 mpp10         10       gpio, ge0(rxctl), lcd(d10)
 mpp11         11       gpio, ge0(rxclk), lcd(d11)
-mpp12         12       gpio, ge0(txd4), ge1(txd0), lcd(d12)
+mpp12         12       gpio, ge0(txd4), ge1(txclkout), lcd(d12)
 mpp13         13       gpio, ge0(txd5), ge1(txd1), lcd(d13)
 mpp14         14       gpio, ge0(txd6), ge1(txd2), lcd(d15)
 mpp15         15       gpio, ge0(txd7), ge1(txd3), lcd(d16)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 5337468..1429872 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -55,7 +55,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	   MPP_FUNCTION(0x1, "cpu_pd", "vdd")),
 	MPP_MODE(5,
 	   MPP_FUNCTION(0x0, "gpo", NULL),
-	   MPP_FUNCTION(0x1, "ge0", "txclko"),
+	   MPP_FUNCTION(0x1, "ge0", "txclkout"),
 	   MPP_FUNCTION(0x2, "uart1", "txd"),
 	   MPP_FUNCTION(0x4, "spi1", "clk"),
 	   MPP_FUNCTION(0x5, "audio", "mclk")),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 9a8b714..fb5ffa5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -54,7 +54,7 @@ enum armada_xp_variant {
 static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 	MPP_MODE(0,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "ge0", "txclko",     V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "ge0", "txclkout",   V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "d0",         V_MV78230_PLUS)),
 	MPP_MODE(1,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
@@ -103,7 +103,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 	MPP_MODE(12,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "ge0", "txd4",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x2, "ge1", "clkout",     V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "ge1", "txclkout",   V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "d12",        V_MV78230_PLUS)),
 	MPP_MODE(13,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-- 
2.1.0
