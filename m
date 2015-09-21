From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 21 Sep 2015 18:53:57 +0200
Subject: [PATCH v4 1/8] clk: imx: add common logic to detect early UART usage
In-Reply-To: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
References: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1442854444-4460-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both earlycon and eralyprintk depend on the bootloader setup UART
clocks being retained. This patch adds the common logic to detect such
situations and make the information available to the clock drivers, as
well as adding the facilities to disable those clocks at the end of
the kernel init.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index df12b5307175..a634b1185be3 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -73,3 +73,41 @@ void imx_cscmr1_fixup(u32 *val)
 	*val ^= CSCMR1_FIXUP;
 	return;
 }
+
+static int imx_keep_uart_clocks __initdata;
+static struct clk ** const *imx_uart_clocks __initdata;
+
+static int __init imx_keep_uart_clocks_param(char *str)
+{
+	imx_keep_uart_clocks = 1;
+
+	return 0;
+}
+__setup_param("earlycon", imx_keep_uart_earlycon,
+	      imx_keep_uart_clocks_param, 0);
+__setup_param("earlyprintk", imx_keep_uart_earlyprintk,
+	      imx_keep_uart_clocks_param, 0);
+
+void __init imx_register_uart_clocks(struct clk ** const clks[])
+{
+	if (imx_keep_uart_clocks) {
+		int i;
+
+		imx_uart_clocks = clks;
+		for (i = 0; imx_uart_clocks[i]; i++)
+			clk_prepare_enable(*imx_uart_clocks[i]);
+	}
+}
+
+static int __init imx_clk_disable_uart(void)
+{
+	if (imx_keep_uart_clocks && imx_uart_clocks) {
+		int i;
+
+		for (i = 0; imx_uart_clocks[i]; i++)
+			clk_disable_unprepare(*imx_uart_clocks[i]);
+	}
+
+	return 0;
+}
+late_initcall_sync(imx_clk_disable_uart);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 1049b0c7d818..c94ac5c26226 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -7,6 +7,7 @@
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
+void imx_register_uart_clocks(struct clk ** const clks[]);
 
 extern void imx_cscmr1_fixup(u32 *val);
 
-- 
2.5.1
