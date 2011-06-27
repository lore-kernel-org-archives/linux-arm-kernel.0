From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 27 Jun 2011 17:12:08 -0300
Subject: [PATCH 1/4] ARM: mx53: Add support for missing UARTs
Message-ID: <1309205531-18103-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX53 has five UART ports.

Add support for the missing UART4 and UART5 ports.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c           |   10 ++++++++++
 arch/arm/mach-mx5/crm_regs.h                  |    2 ++
 arch/arm/plat-mxc/devices/platform-imx-uart.c |    2 ++
 arch/arm/plat-mxc/include/mach/mx53.h         |    4 ++--
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 4fb63d9..789c6cf 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1254,12 +1254,20 @@ DEFINE_CLOCK(uart2_ipg_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG5_OFFSET,
 	NULL,  NULL, &ipg_clk, &aips_tz1_clk);
 DEFINE_CLOCK(uart3_ipg_clk, 2, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG7_OFFSET,
 	NULL,  NULL, &ipg_clk, &spba_clk);
+DEFINE_CLOCK(uart4_ipg_clk, 3, MXC_CCM_CCGR7, MXC_CCM_CCGRx_CG4_OFFSET,
+	NULL,  NULL, &ipg_clk, &spba_clk);
+DEFINE_CLOCK(uart5_ipg_clk, 4, MXC_CCM_CCGR7, MXC_CCM_CCGRx_CG6_OFFSET,
+	NULL,  NULL, &ipg_clk, &spba_clk);
 DEFINE_CLOCK(uart1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG4_OFFSET,
 	NULL,  NULL, &uart_root_clk, &uart1_ipg_clk);
 DEFINE_CLOCK(uart2_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG6_OFFSET,
 	NULL,  NULL, &uart_root_clk, &uart2_ipg_clk);
 DEFINE_CLOCK(uart3_clk, 2, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG8_OFFSET,
 	NULL,  NULL, &uart_root_clk, &uart3_ipg_clk);
+DEFINE_CLOCK(uart4_clk, 3, MXC_CCM_CCGR7, MXC_CCM_CCGRx_CG5_OFFSET,
+	NULL,  NULL, &uart_root_clk, &uart4_ipg_clk);
+DEFINE_CLOCK(uart5_clk, 4, MXC_CCM_CCGR7, MXC_CCM_CCGRx_CG7_OFFSET,
+	NULL,  NULL, &uart_root_clk, &uart5_ipg_clk);
 
 /* GPT */
 DEFINE_CLOCK(gpt_ipg_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG10_OFFSET,
@@ -1464,6 +1472,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
 	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
 	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
+	_REGISTER_CLOCK("imx-uart.3", NULL, uart4_clk)
+	_REGISTER_CLOCK("imx-uart.4", NULL, uart5_clk)
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
diff --git a/arch/arm/mach-mx5/crm_regs.h b/arch/arm/mach-mx5/crm_regs.h
index 87c0c58..5e11ba7 100644
--- a/arch/arm/mach-mx5/crm_regs.h
+++ b/arch/arm/mach-mx5/crm_regs.h
@@ -114,6 +114,8 @@
 #define MXC_CCM_CCGR4		(MX51_CCM_BASE + 0x78)
 #define MXC_CCM_CCGR5		(MX51_CCM_BASE + 0x7C)
 #define MXC_CCM_CCGR6		(MX51_CCM_BASE + 0x80)
+#define MXC_CCM_CCGR7		(MX51_CCM_BASE + 0x84)
+
 #define MXC_CCM_CMEOR		(MX51_CCM_BASE + 0x84)
 
 /* Define the bits in register CCR */
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index 3c854c2..cfce8c9 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -123,6 +123,8 @@ const struct imx_imx_uart_1irq_data imx53_imx_uart_data[] __initconst = {
 	imx53_imx_uart_data_entry(0, 1),
 	imx53_imx_uart_data_entry(1, 2),
 	imx53_imx_uart_data_entry(2, 3),
+	imx53_imx_uart_data_entry(3, 4),
+	imx53_imx_uart_data_entry(4, 5),
 };
 #endif /* ifdef CONFIG_SOC_IMX53 */
 
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index e14a4f0..7b54eb6 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -241,7 +241,7 @@
 #define MX53_INT_IPU_ERR	10
 #define MX53_INT_IPU_SYN	11
 #define MX53_INT_GPU	12
-#define MX53_INT_RESV13	13
+#define MX53_INT_UART4	13
 #define MX53_INT_USB_H1	14
 #define MX53_INT_EMI	15
 #define MX53_INT_USB_H2	16
@@ -314,7 +314,7 @@
 #define MX53_INT_CAN2	83
 #define MX53_INT_GPU2_IRQ	84
 #define MX53_INT_GPU2_BUSY	85
-#define MX53_INT_RESV86	86
+#define MX53_INT_UART5	86
 #define MX53_INT_FEC	87
 #define MX53_INT_OWIRE	88
 #define MX53_INT_CTI1_TG2	89
-- 
1.6.0.4
