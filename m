From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 Dec 2009 22:14:09 +0100
Subject: [PATCH 4/5] spi-imx: Add mx25 support
In-Reply-To: <1260306850-14945-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
	<1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260306850-14945-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/spi/spi_imx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 0ccbd1c..59b3a30 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -208,7 +208,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
 
 	if (cpu_is_mx31())
 		reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
-	else if (cpu_is_mx35()) {
+	else if (cpu_is_mx25() || cpu_is_mx35()) {
 		reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
 		reg |= MX31_CSPICTRL_SSCTL;
 	}
@@ -222,7 +222,7 @@ static int mx31_config(struct spi_imx_data *spi_imx,
 	if (config->cs < 0) {
 		if (cpu_is_mx31())
 			reg |= (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
-		else if (cpu_is_mx35())
+		else if (cpu_is_mx25() || cpu_is_mx35())
 			reg |= (config->cs + 32) << MX35_CSPICTRL_CS_SHIFT;
 	}
 
@@ -565,7 +565,7 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
-	if (cpu_is_mx31() || cpu_is_mx35()) {
+	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
 		spi_imx->intctrl = mx31_intctrl;
 		spi_imx->config = mx31_config;
 		spi_imx->trigger = mx31_trigger;
@@ -597,7 +597,7 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 		writel(1, spi_imx->base + MXC_RESET);
 
 	/* drain receive buffer */
-	if (cpu_is_mx31() || cpu_is_mx35())
+	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35())
 		while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
 			readl(spi_imx->base + MXC_CSPIRXDATA);
 
-- 
1.6.5.2
