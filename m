From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed, 20 Sep 2017 13:14:08 +0200
Subject: [PATCH V2 8/8] MIPS: BCM63XX: split out swpkt_sar/usb clocks
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Message-ID: <20170920111408.29711-9-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the secondary switch clocks their own clocks. This allows proper
enable reference counting between SAR/XTM and the main switch clocks,
and controlling them individually from drivers.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 61 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 2018425fe97e..164115944a7f 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -122,21 +122,56 @@ static struct clk clk_ephy = {
 };
 
 /*
+ * Ethernet switch SAR clock
+ */
+static void swpkt_sar_set(struct clk *clk, int enable)
+{
+	if (BCMCPU_IS_6368())
+		bcm_hwclock_set(CKCTL_6368_SWPKT_SAR_EN, enable);
+	else
+		return;
+}
+
+static struct clk clk_swpkt_sar = {
+	.set	= swpkt_sar_set,
+};
+
+/*
+ * Ethernet switch USB clock
+ */
+static void swpkt_usb_set(struct clk *clk, int enable)
+{
+	if (BCMCPU_IS_6368())
+		bcm_hwclock_set(CKCTL_6368_SWPKT_USB_EN, enable);
+	else
+		return;
+}
+
+static struct clk clk_swpkt_usb = {
+	.set	= swpkt_usb_set,
+};
+
+/*
  * Ethernet switch clock
  */
 static void enetsw_set(struct clk *clk, int enable)
 {
-	if (BCMCPU_IS_6328())
+	if (BCMCPU_IS_6328()) {
 		bcm_hwclock_set(CKCTL_6328_ROBOSW_EN, enable);
-	else if (BCMCPU_IS_6362())
+	} else if (BCMCPU_IS_6362()) {
 		bcm_hwclock_set(CKCTL_6362_ROBOSW_EN, enable);
-	else if (BCMCPU_IS_6368())
-		bcm_hwclock_set(CKCTL_6368_ROBOSW_EN |
-				CKCTL_6368_SWPKT_USB_EN |
-				CKCTL_6368_SWPKT_SAR_EN,
-				enable);
-	else
+	} else if (BCMCPU_IS_6368()) {
+		if (enable) {
+			clk_enable_unlocked(&clk_swpkt_sar);
+			clk_enable_unlocked(&clk_swpkt_usb);
+		} else {
+			clk_disable_unlocked(&clk_swpkt_usb);
+			clk_disable_unlocked(&clk_swpkt_sar);
+		}
+		bcm_hwclock_set(CKCTL_6368_ROBOSW_EN, enable);
+	} else {
 		return;
+	}
 
 	if (enable) {
 		/* reset switch core afer clock change */
@@ -261,8 +296,12 @@ static void xtm_set(struct clk *clk, int enable)
 	if (!BCMCPU_IS_6368())
 		return;
 
-	bcm_hwclock_set(CKCTL_6368_SAR_EN |
-			CKCTL_6368_SWPKT_SAR_EN, enable);
+	if (enable)
+		clk_enable_unlocked(&clk_swpkt_sar);
+	else
+		clk_disable_unlocked(&clk_swpkt_sar);
+
+	bcm_hwclock_set(CKCTL_6368_SAR_EN, enable);
 
 	if (enable) {
 		/* reset sar core afer clock change */
@@ -451,6 +490,8 @@ static struct clk_lookup bcm6358_clks[] = {
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
 	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+	CLKDEV_INIT(NULL, "swpkt_sar", &clk_swpkt_sar),
+	CLKDEV_INIT(NULL, "swpkt_usb", &clk_swpkt_usb),
 	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet0),
 	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet1),
 };
-- 
2.13.2
