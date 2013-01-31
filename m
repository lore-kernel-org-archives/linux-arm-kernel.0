From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:24:02 +0900
Subject: [PATCH 9/9] ARM: shmobile: armadillo800eva: set clock rates before
 timer init
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hideki EIRAKU <hdk@igel.co.jp>

Previously clock rates were set after initialization of timer.
Therefore the timer used the default extal1 clock rate (25MHz)
instead of the correct rate for this board (24MHz).

Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index f107e82..9008ad1 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1169,8 +1169,6 @@ static void __init eva_init(void)
 	platform_add_devices(eva_devices,
 			     ARRAY_SIZE(eva_devices));
 
-	eva_clock_init();
-
 	rmobile_add_device_to_domain("A4LC", &lcdc0_device);
 	rmobile_add_device_to_domain("A4LC", &hdmi_lcdc_device);
 	if (usb)
@@ -1181,6 +1179,9 @@ static void __init eva_earlytimer_init(void)
 {
 	r8a7740_clock_init(MD_CK0 | MD_CK2);
 	shmobile_earlytimer_init();
+
+	/* the rate of extal1 clock must be set before late_time_init */
+	eva_clock_init();
 }
 
 static void __init eva_add_early_devices(void)
-- 
1.7.10.4
