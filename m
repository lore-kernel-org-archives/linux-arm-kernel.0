From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:19 -0700
Subject: [PATCH 24/31] serial: tegra: use reset framework
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-25-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra's clock driver now provides an implementation of the common
reset API (include/linux/reset.h). Use this instead of the old Tegra-
specific API; that will soon be removed.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/tty/serial/serial-tegra.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index dfe79ccc4fb3..4455481a3517 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -34,6 +34,7 @@
 #include <linux/of_device.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
@@ -44,8 +45,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
-#include <linux/clk/tegra.h>
-
 #define TEGRA_UART_TYPE				"TEGRA_UART"
 #define TX_EMPTY_STATUS				(UART_LSR_TEMT | UART_LSR_THRE)
 #define BYTES_TO_ALIGN(x)			((unsigned long)(x) & 0x3)
@@ -103,6 +102,7 @@ struct tegra_uart_port {
 	const struct tegra_uart_chip_data	*cdata;
 
 	struct clk				*uart_clk;
+	struct reset_control			*rst;
 	unsigned int				current_baud;
 
 	/* Register shadow */
@@ -832,9 +832,9 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	clk_prepare_enable(tup->uart_clk);
 
 	/* Reset the UART controller to clear all previous status.*/
-	tegra_periph_reset_assert(tup->uart_clk);
+	reset_control_assert(tup->rst);
 	udelay(10);
-	tegra_periph_reset_deassert(tup->uart_clk);
+	reset_control_deassert(tup->rst);
 
 	tup->rx_in_progress = 0;
 	tup->tx_in_progress = 0;
@@ -1320,6 +1320,12 @@ static int tegra_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(tup->uart_clk);
 	}
 
+	tup->rst = devm_reset_control_get(&pdev->dev, "serial");
+	if (IS_ERR(tup->rst)) {
+		dev_err(&pdev->dev, "Couldn't get the reset\n");
+		return PTR_ERR(tup->rst);
+	}
+
 	u->iotype = UPIO_MEM32;
 	u->irq = platform_get_irq(pdev, 0);
 	u->regshift = 2;
-- 
1.8.1.5
