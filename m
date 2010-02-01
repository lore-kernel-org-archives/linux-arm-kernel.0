From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Feb 2010 12:34:31 -0800
Subject: [PATCH] omap: Disable serial port autoidle by default
Message-ID: <mailman.182.1265168583.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the omap serial clocks are autoidled after 5 seconds.
However, this causes lost characters on the serial ports. As this
is considered non-standard behaviour for Linux, disable the timeout.

Note that this will also cause blocking of any deeper omap sleep
states.

To enable the autoidling of the serial ports, do something like
this for each serial port:

# echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout
# echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout
...

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 8c964be..e10a02d 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -36,7 +36,13 @@
 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
-#define DEFAULT_TIMEOUT (5 * HZ)
+/*
+ * NOTE: By default the serial timeout is disabled as it causes lost characters
+ * over the serial ports. This means that the UART clocks will stay on until
+ * disabled via sysfs. This also causes that any deeper omap sleep states are
+ * blocked. 
+ */
+#define DEFAULT_TIMEOUT 0
 
 struct omap_uart_state {
 	int num;
@@ -422,7 +428,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	uart->timeout = DEFAULT_TIMEOUT;
 	setup_timer(&uart->timer, omap_uart_idle_timer,
 		    (unsigned long) uart);
-	mod_timer(&uart->timer, jiffies + uart->timeout);
+	if (uart->timeout)
+		mod_timer(&uart->timer, jiffies + uart->timeout);
 	omap_uart_smart_idle_enable(uart, 0);
 
 	if (cpu_is_omap34xx()) {

--FN+gV9K+162wdwwF--
