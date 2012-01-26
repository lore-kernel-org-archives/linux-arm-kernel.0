From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 25 Jan 2012 19:50:56 -0700
Subject: [PATCH v2 3/3] tty: serial: omap-serial: wakeup latency constraint is
 in microseconds, not milliseconds
In-Reply-To: <20120126024903.31613.24730.stgit@dusk>
References: <20120126024903.31613.24730.stgit@dusk>
Message-ID: <20120126025052.31613.37828.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The receive FIFO wakeup latency estimate in the omap-serial driver is
three orders of magnitude too small.  This effectively prevents the
MPU from going to a low-power state when CONFIG_CPU_IDLE=y.  This is a
major power management regression and masks some other FIFO-related
bugs in the driver.

Fix by correcting the most egregious problem in the RX wakeup latency
estimate.  There are several other flaws in the estimator; these will
be fixed by a separate patch series intended for 3.4.

The difference in low-power states with this patch can be observed via
debugfs in pm_debug/count.

This estimate does not have any effect when CONFIG_CPU_IDLE=n.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/omap-serial.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 11fa156..72fa783 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -740,8 +740,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	quot = serial_omap_get_divisor(port, baud);
 
 	/* calculate wakeup latency constraint */
-	up->calc_latency = (1000000 * up->port.fifosize) /
-				(1000 * baud / 8);
+	up->calc_latency = (USEC_PER_SEC * up->port.fifosize) / (baud / 8);
 	up->latency = up->calc_latency;
 	schedule_work(&up->qos_work);
 
