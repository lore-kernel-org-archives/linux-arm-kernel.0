From: govindraj.raja@ti.com (Govindraj.R)
Date: Tue, 18 Oct 2011 21:05:09 +0530
Subject: [PATCH v7 18/21] OMAP2+: UART: remove temporary variable used to
	count uart instance
In-Reply-To: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <1318952110-10659-4-git-send-email-govindraj.raja@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse the num_uarts variable itself to count number of uarts.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 55ce950..e1eba7f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -253,15 +253,13 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
 
 static int __init omap_serial_early_init(void)
 {
-	int i = 0;
-
 	do {
 		char oh_name[MAX_UART_HWMOD_NAME_LEN];
 		struct omap_hwmod *oh;
 		struct omap_uart_state *uart;
 
 		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
-			 "uart%d", i + 1);
+			 "uart%d", num_uarts + 1);
 		oh = omap_hwmod_lookup(oh_name);
 		if (!oh)
 			break;
@@ -271,9 +269,8 @@ static int __init omap_serial_early_init(void)
 			return -ENODEV;
 
 		uart->oh = oh;
-		uart->num = i++;
+		uart->num = num_uarts++;
 		list_add_tail(&uart->node, &uart_list);
-		num_uarts++;
 
 		/*
 		 * NOTE: omap_hwmod_setup*() has not yet been called,
-- 
1.7.4.1
