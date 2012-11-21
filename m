From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 16:57:07 +0100
Subject: [PATCH 3/4] serial: i.MX: evaluate linux,stdout-path property
In-Reply-To: <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121121155312.GX4398@game.jcrosoft.org>
 <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353513428-25697-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

devicetrees may have the linux,stdout-path property to specify the
console. This patch adds support to the i.MX serial driver for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-serial at vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel at pengutronix.de
Cc: Alan Cox <alan@linux.intel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/imx.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 07a8ca1..28a3193 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1398,6 +1398,7 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 			of_match_device(imx_uart_dt_ids, &pdev->dev);
+	char *option = NULL;
 	int ret;
 
 	if (!np)
@@ -1419,6 +1420,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 
 	sport->devdata = of_id->data;
 
+	if (of_device_is_stdout_path(np, &option))
+		add_preferred_console(imx_reg.cons->name, sport->port.line, option);
+
 	return 0;
 }
 #else
-- 
1.7.10.4
