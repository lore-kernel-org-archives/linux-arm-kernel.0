From: horms@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2012 17:34:56 +0900
Subject: [PATCH 2/4] ARM: shmobile: r8a7740: add USB24 clock explain
In-Reply-To: <1352277298-23312-1-git-send-email-horms@verge.net.au>
References: <1352277298-23312-1-git-send-email-horms@verge.net.au>
Message-ID: <1352277298-23312-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

USBCKCR is controlling USB parent clock and divide rate.
This parent clock is used as a "usb24s" from other devices,
but the "divide rate" is not used.
Further, this clock itself is known as "usb24".
So, to set this clock is a little confusable.
This patch adds quick explain and sample settings for this clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 6729e00..c012bbf 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -188,6 +188,22 @@ static struct clk pllc1_div2_clk = {
 };
 
 /* USB clock */
+/*
+ * USBCKCR is controlling usb24 clock
+ * bit[7] : parent clock
+ * bit[6] : clock divide rate
+ * And this bit[7] is used as a "usb24s" from other devices.
+ * (Video clock / Sub clock / SPU clock)
+ * You can controll this clock as a below.
+ *
+ * struct clk *usb24	= clk_get(dev,  "usb24");
+ * struct clk *usb24s	= clk_get(NULL, "usb24s");
+ * struct clk *system	= clk_get(NULL, "system_clk");
+ * int rate = clk_get_rate(system);
+ *
+ * clk_set_parent(usb24s, system);  // for bit[7]
+ * clk_set_rate(usb24, rate / 2);   // for bit[6]
+ */
 static struct clk *usb24s_parents[] = {
 	[0] = &system_clk,
 	[1] = &extal2_clk
-- 
1.7.10.4
