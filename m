From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 17:17:27 +0800
Subject: [PATCH 1/5] ARM: imx: add more imx5 ssi clocks
In-Reply-To: <20120511074701.GD27341@pengutronix.de>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-2-git-send-email-shawn.guo@linaro.org>
 <20120511074701.GD27341@pengutronix.de>
Message-ID: <20120511091725.GZ17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 09:47:01AM +0200, Sascha Hauer wrote:
> > +	clk_register_clkdev(clk[ssi_ext1_gate], NULL, "ssi_ext.0");
> > +	clk_register_clkdev(clk[ssi_ext2_gate], NULL, "ssi_ext.1");
> 
> Another thing I just noticed is that you use ssi_ext.0|1 as the device id,
> is that what you want? I think the device id should either match a real
> device present in the system or be NULL.
> 
Good catch.  Thanks, Sascha.  Fixed as below.

Regards,
Shawn

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 26ba1c5..fcd94f3 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -269,8 +269,8 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
        clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
        clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
        clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
-       clk_register_clkdev(clk[ssi_ext1_gate], NULL, "ssi_ext.0");
-       clk_register_clkdev(clk[ssi_ext2_gate], NULL, "ssi_ext.1");
+       clk_register_clkdev(clk[ssi_ext1_gate], "ssi_ext1", NULL);
+       clk_register_clkdev(clk[ssi_ext2_gate], "ssi_ext2", NULL);
        clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
        clk_register_clkdev(clk[cpu_podf], "cpu", NULL);
        clk_register_clkdev(clk[iim_gate], "iim", NULL);
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index 52455ea..8b002fcd 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -87,9 +87,9 @@ static void __init imx53_qsb_init(void)
 {
        struct clk *clk;

-       clk = clk_get_sys("ssi_ext.0", NULL);
+       clk = clk_get_sys(NULL, "ssi_ext1");
        if (IS_ERR(clk)) {
-               pr_err("failed to get clk ssi_ext.0\n");
+               pr_err("failed to get clk ssi_ext1\n");
                return;
        }
