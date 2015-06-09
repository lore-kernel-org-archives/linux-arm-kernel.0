From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:23 +0200
Subject: [PATCH 31/34] pinctrl: mvebu: armada-38x: add ptp functions
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-32-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest version of the Armada 38x datasheet documents several new
PTP related functions on various MPP pins. This commit adds the
description of these new functions to the Armada 38x pinctrl driver as
well as to its DT binding documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt   | 6 +++---
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c                       | 9 ++++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 4330676..54ec4c0 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -66,9 +66,9 @@ mpp47         47       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3
 mpp48         48       gpio, sata0(prsnt), dram(vttctrl), tdm(pclk), audio(mclk), sd0(d4), pcie0(clkreq)
 mpp49         49       gpio, sata2(prsnt) [2], sata3(prsnt) [2], tdm(fsync), audio(lrclk), sd0(d5), pcie1(clkreq)
 mpp50         50       gpio, pcie0(rstout), tdm(drx), audio(extclk), sd0(cmd)
-mpp51         51       gpio, tdm(dtx), audio(sdo), dram(deccerr)
-mpp52         52       gpio, pcie0(rstout), tdm(int), audio(sdi), sd0(d6)
-mpp53         53       gpio, sata1(prsnt), sata0(prsnt), tdm(rst), audio(bclk), sd0(d7)
+mpp51         51       gpio, tdm(dtx), audio(sdo), dram(deccerr), ptp(trig)
+mpp52         52       gpio, pcie0(rstout), tdm(int), audio(sdi), sd0(d6), ptp(clk)
+mpp53         53       gpio, sata1(prsnt), sata0(prsnt), tdm(rst), audio(bclk), sd0(d7), ptp(evreq)
 mpp54         54       gpio, sata0(prsnt), sata1(prsnt), pcie0(rstout), ge0(txerr), sd0(d3)
 mpp55         55       gpio, ua1(cts), ge(mdio), pcie1(clkreq) [1], spi1(cs1), sd0(d0), ua1(rxd)
 mpp56         56       gpio, ua1(rts), ge(mdc), dram(deccerr), spi1(mosi), ua1(txd)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 370c73b..6ec82c6 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -331,20 +331,23 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",   "dtx",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "sdo",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "dram",  "deccerr",    V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "dram",  "deccerr",    V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ptp",   "trig",       V_88F6810_PLUS)),
 	MPP_MODE(52,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0", "rstout",     V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",   "int",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "sdi",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd0",   "d6",         V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d6",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ptp",   "clk",        V_88F6810_PLUS)),
 	MPP_MODE(53,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata1", "prsnt",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "sata0", "prsnt",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",   "rst",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "bclk",       V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd0",   "d7",         V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "sd0",   "d7",         V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ptp",   "evreq",      V_88F6810_PLUS)),
 	MPP_MODE(54,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
-- 
2.1.0
