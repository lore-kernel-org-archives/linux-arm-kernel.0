From: govindraj.raja@ti.com (Govindraj.R)
Date: Wed, 21 Sep 2011 16:54:12 +0530
Subject: [PATCH] OMAP2+: UART: Do not gate uart clocks if used for debug_pr=
Message-ID: <mailman.194.1319099986.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ints

If OMAP UART is used as console uart and debug is enabled,
avoid gating of uart clocks to print all debug prints.

If uart clocks are gated then the debug prints from omap_device
framework or hwmod framework can cause uart to enter recursive
pm_runtime calls, which can cause a deadlock over power lock usage.

For example: Say, uart clocks are cut and we get a print from
omap_device_disable stating disabling uart clocks. This print
calls omap_uart driver console_write which will call runtime API
get_sync which means we enter from runtime API put context to
runtime API get context.

--> runtime put (take power lock)
    --> print disabling uart clocks
        --> call uart console write
            --> call get_sync (try to take power lock)

Also any clock enable API call from uart driver should not call any uart
operation until clocks are enabled back. Like get_sync having debug print
calling uart console write even before clocks are enabled.

So to avoid these scenarios, identify from bootargs if OMAP_UART(ttyO) is u=
sed
in debug mode. If so, do not set device_may_wakeup. This will prevent
pm_runtime_enable in uart driver and will avoid uart clock gating.
Debug is enabled either by adding debug word in bootarg or by setting
loglevel=3D10

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5e3bbce..b3d0086 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -65,6 +65,7 @@ static LIST_HEAD(uart_list);
 static u8 num_uarts;
 static u8 console_uart_id =3D -1;
 static u8 no_console_suspend;
+static u8 uart_debug;

 #define DEFAULT_RXDMA_POLLRATE		1	/* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
@@ -310,6 +311,14 @@ static int __init omap_serial_early_init(void)
 		if (cmdline_find_option(uart_name)) {
 			console_uart_id =3D uart->num;

+			if (cmdline_find_option("debug") ||
+						console_loglevel >=3D 10) {
+				uart_debug =3D true;
+				pr_info("%s used as console in debug mode"
+						" uart%d clocks will not be"
+						" gated", uart_name, uart->num);
+			}
+
 			if (cmdline_find_option("no_console_suspend"))
 				no_console_suspend =3D true;

@@ -414,7 +423,8 @@ void __init omap_serial_init_port(struct
omap_board_data *bdata,

 	oh->dev_attr =3D uart;

-	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+			&& !uart_debug)
 		device_init_wakeup(&pdev->dev, true);
 }

--=20
1.7.4.1
