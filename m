From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 27 Aug 2015 18:39:14 +0200
Subject: [PATCH 1/8] clk: imx: add common logic to detect early UART usage
In-Reply-To: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
References: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1440693561-28095-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both earlycon and eralyprintk depend on the bootloader setup UART
clocks being retained. This patch adds the common logic to detect such
situations and make the information available to the clock drivers, as
well as adding the facilities to disable those clocks at the end of
the kernel init.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk.c | 33 +++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index df12b5307175..70580c8d1a3c 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -73,3 +73,36 @@ void imx_cscmr1_fixup(u32 *val)
 	*val ^= CSCMR1_FIXUP;
 	return;
 }
+
+static int __initdata imx_keep_uart_clocks;
+static void __initdata (*imx_uart_disable_fn)(void);
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
+int __init imx_clk_keep_uart(void)
+{
+	return imx_keep_uart_clocks;
+}
+
+void __init imx_clk_set_uart_disable_callback(void (*disable_cb)(void))
+{
+	imx_uart_disable_fn = disable_cb;
+}
+
+static int __init imx_clk_disable_uart(void)
+{
+	if (imx_uart_disable_fn)
+		imx_uart_disable_fn();
+
+	return 0;
+}
+late_initcall_sync(imx_clk_disable_uart);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 1049b0c7d818..41725a92c63c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -7,6 +7,8 @@
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
+int imx_clk_keep_uart(void);
+void imx_clk_set_uart_disable_callback(void (*disable_cb)(void));
 
 extern void imx_cscmr1_fixup(u32 *val);
 
-- 
2.5.0
