From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 May 2013 13:50:55 +0100
Subject: [PATCH] serial: pl011: protect attribute read from NULL platform data
 struct
Message-ID: <1368103855-28363-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's completely feasible that platform data will be empty i.e. when
booting with Device Tree with no device AUXDATA. So we must protect
it's use in these use-cases, or risk a kernel Oops.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial at vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
*******                                                        *******
If this issue has not already been fixed, this patch should be applied
during the v3.10 -rc:s, as it fixes a serious bug which was introduced
in the merge-window.
*******                                                        *******

 drivers/tty/serial/amba-pl011.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ab70a6..e2774f9 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -332,7 +332,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 		dmaengine_slave_config(chan, &rx_conf);
 		uap->dmarx.chan = chan;
 
-		if (plat->dma_rx_poll_enable) {
+		if (plat && plat->dma_rx_poll_enable) {
 			/* Set poll rate if specified. */
 			if (plat->dma_rx_poll_rate) {
 				uap->dmarx.auto_poll_rate = false;
-- 
1.7.10.4
