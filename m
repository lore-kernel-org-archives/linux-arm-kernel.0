From: james.hogan@imgtec.com (James Hogan)
Date: Mon, 29 Jul 2013 12:25:01 +0100
Subject: [PATCH v6 4/5] clk: add CLK_SET_RATE_NO_REPARENT flag
In-Reply-To: <1375097102-28892-1-git-send-email-james.hogan@imgtec.com>
References: <1375097102-28892-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <1375097102-28892-5-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a CLK_SET_RATE_NO_REPARENT clock flag, which will prevent muxes
being reparented during clk_set_rate.

To avoid breaking existing platforms, all callers of clk_register_mux()
are adjusted to pass the new flag. Platform maintainers are encouraged
to remove the flag if they wish to allow mux reparenting on set_rate.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Emilio L?pez" <emilio@elopez.com.ar>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Chew <achew@nvidia.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: spear-devel at list.st.com
Cc: linux-tegra at vger.kernel.org
Tested-by: Haojian Zhuang <haojian.zhuang@gmail.com>
Acked-by: Stephen Warren <swarren@nvidia.com> [tegra]
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> [sunxi]
---
Changes in v6:

* Rebased on v3.11-rc1.
* Added changes to samsung/clk-exynos-audss.c, zynq/clkc.c.

Changes in v5:

* Rebased on latest clk-next ("clk: tegra: Use common of_clk_init
  function")

Changes in v3:

* rename/invert CLK_SET_RATE_REMUX to CLK_SET_RATE_NO_REPARENT and move
  to this new patch.
* patch 3: add CLK_SET_RATE_NO_REPARENT flag to all callers of
  clk_register_mux. If you don't mind your clocks being reparented in
  response to set_rate please let me know and I'll drop the relevant
  portion of the patch.

 arch/arm/mach-imx/clk.h                |   5 +-
 drivers/clk/mmp/clk-mmp2.c             |  39 ++++---
 drivers/clk/mmp/clk-pxa168.c           |  40 +++++---
 drivers/clk/mmp/clk-pxa910.c           |  31 ++++--
 drivers/clk/mxs/clk.h                  |   4 +-
 drivers/clk/samsung/clk-exynos-audss.c |   6 +-
 drivers/clk/samsung/clk.h              |   2 +-
 drivers/clk/spear/spear1310_clock.c    | 179 +++++++++++++++++----------------
 drivers/clk/spear/spear1340_clock.c    |  97 ++++++++++--------
 drivers/clk/spear/spear3xx_clock.c     |  57 +++++++----
 drivers/clk/spear/spear6xx_clock.c     |  35 ++++---
 drivers/clk/sunxi/clk-sunxi.c          |   3 +-
 drivers/clk/tegra/clk-tegra114.c       |  36 ++++---
 drivers/clk/tegra/clk-tegra20.c        |   6 +-
 drivers/clk/tegra/clk-tegra30.c        |  33 ++++--
 drivers/clk/versatile/clk-vexpress.c   |   4 +-
 drivers/clk/zynq/clkc.c                |  86 +++++++++-------
 include/linux/clk-provider.h           |   1 +
 18 files changed, 388 insertions(+), 276 deletions(-)

diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 0e4e8bb..c8575fb 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -79,7 +79,8 @@ static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
-	return clk_register_mux(NULL, name, parents, num_parents, 0, reg, shift,
+	return clk_register_mux(NULL, name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT, reg, shift,
 			width, 0, &imx_ccm_lock);
 }
 
@@ -88,7 +89,7 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 		int num_parents, unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			flags, reg, shift, width, 0,
+			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
 			&imx_ccm_lock);
 }
 
diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index d1f1a19..b2721ca 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -248,7 +248,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp2-pwm.3");
 
 	clk = clk_register_mux(NULL, "uart0_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
@@ -258,7 +259,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.0");
 
 	clk = clk_register_mux(NULL, "uart1_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
@@ -268,7 +270,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.1");
 
 	clk = clk_register_mux(NULL, "uart2_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART2, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
@@ -278,7 +281,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.2");
 
 	clk = clk_register_mux(NULL, "uart3_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART3, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.3", NULL);
@@ -288,7 +292,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.3");
 
 	clk = clk_register_mux(NULL, "ssp0_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP0, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
@@ -297,7 +302,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.0");
 
 	clk = clk_register_mux(NULL, "ssp1_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP1, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.1", NULL);
 
@@ -306,7 +312,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.1");
 
 	clk = clk_register_mux(NULL, "ssp2_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP2, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.2", NULL);
 
@@ -315,7 +322,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.2");
 
 	clk = clk_register_mux(NULL, "ssp3_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP3, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.3", NULL);
 
@@ -324,7 +332,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.3");
 
 	clk = clk_register_mux(NULL, "sdh_mux", sdh_parent,
-				ARRAY_SIZE(sdh_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(sdh_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_SDH0, 8, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "sdh_mux", NULL);
 
@@ -354,7 +363,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, "usb_clk", NULL);
 
 	clk = clk_register_mux(NULL, "disp0_mux", disp_parent,
-				ARRAY_SIZE(disp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(disp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_DISP0, 6, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "disp_mux.0", NULL);
 
@@ -376,7 +386,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, "disp_sphy.0", NULL);
 
 	clk = clk_register_mux(NULL, "disp1_mux", disp_parent,
-				ARRAY_SIZE(disp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(disp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_DISP1, 6, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "disp_mux.1", NULL);
 
@@ -394,7 +405,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, "ccic_arbiter", NULL);
 
 	clk = clk_register_mux(NULL, "ccic0_mux", ccic_parent,
-				ARRAY_SIZE(ccic_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ccic_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_CCIC0, 6, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.0", NULL);
 
@@ -421,7 +433,8 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, "sphyclk", "mmp-ccic.0");
 
 	clk = clk_register_mux(NULL, "ccic1_mux", ccic_parent,
-				ARRAY_SIZE(ccic_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ccic_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_CCIC1, 6, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.1", NULL);
 
diff --git a/drivers/clk/mmp/clk-pxa168.c b/drivers/clk/mmp/clk-pxa168.c
index 28b3b51..014396b 100644
--- a/drivers/clk/mmp/clk-pxa168.c
+++ b/drivers/clk/mmp/clk-pxa168.c
@@ -199,7 +199,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa168-pwm.3");
 
 	clk = clk_register_mux(NULL, "uart0_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
@@ -209,7 +210,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.0");
 
 	clk = clk_register_mux(NULL, "uart1_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
@@ -219,7 +221,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.1");
 
 	clk = clk_register_mux(NULL, "uart2_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART2, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
@@ -229,7 +232,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.2");
 
 	clk = clk_register_mux(NULL, "ssp0_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP0, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
@@ -238,7 +242,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.0");
 
 	clk = clk_register_mux(NULL, "ssp1_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP1, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.1", NULL);
 
@@ -247,7 +252,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.1");
 
 	clk = clk_register_mux(NULL, "ssp2_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP2, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.2", NULL);
 
@@ -256,7 +262,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.2");
 
 	clk = clk_register_mux(NULL, "ssp3_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP3, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.3", NULL);
 
@@ -265,7 +272,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.3");
 
 	clk = clk_register_mux(NULL, "ssp4_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP4, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.4", NULL);
 
@@ -278,7 +286,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa3xx-nand.0");
 
 	clk = clk_register_mux(NULL, "sdh0_mux", sdh_parent,
-				ARRAY_SIZE(sdh_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(sdh_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_SDH0, 6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "sdh0_mux", NULL);
 
@@ -287,7 +296,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, NULL, "sdhci-pxa.0");
 
 	clk = clk_register_mux(NULL, "sdh1_mux", sdh_parent,
-				ARRAY_SIZE(sdh_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(sdh_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_SDH1, 6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "sdh1_mux", NULL);
 
@@ -304,7 +314,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, "sph_clk", NULL);
 
 	clk = clk_register_mux(NULL, "disp0_mux", disp_parent,
-				ARRAY_SIZE(disp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(disp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_DISP0, 6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "disp_mux.0", NULL);
 
@@ -317,7 +328,8 @@ void __init pxa168_clk_init(void)
 	clk_register_clkdev(clk, "hclk", "mmp-disp.0");
 
 	clk = clk_register_mux(NULL, "ccic0_mux", ccic_parent,
-				ARRAY_SIZE(ccic_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ccic_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_CCIC0, 6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.0", NULL);
 
@@ -327,8 +339,8 @@ void __init pxa168_clk_init(void)
 
 	clk = clk_register_mux(NULL, "ccic0_phy_mux", ccic_phy_parent,
 				ARRAY_SIZE(ccic_phy_parent),
-				CLK_SET_RATE_PARENT, apmu_base + APMU_CCIC0,
-				7, 1, 0, &clk_lock);
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+				apmu_base + APMU_CCIC0, 7, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_phy_mux.0", NULL);
 
 	clk = mmp_clk_register_apmu("ccic0_phy", "ccic0_phy_mux",
diff --git a/drivers/clk/mmp/clk-pxa910.c b/drivers/clk/mmp/clk-pxa910.c
index 6ec0569..9efc6a4 100644
--- a/drivers/clk/mmp/clk-pxa910.c
+++ b/drivers/clk/mmp/clk-pxa910.c
@@ -204,7 +204,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa910-pwm.3");
 
 	clk = clk_register_mux(NULL, "uart0_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
@@ -214,7 +215,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.0");
 
 	clk = clk_register_mux(NULL, "uart1_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
@@ -224,7 +226,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.1");
 
 	clk = clk_register_mux(NULL, "uart2_mux", uart_parent,
-				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(uart_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbcp_base + APBCP_UART2, 4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
@@ -234,7 +237,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.2");
 
 	clk = clk_register_mux(NULL, "ssp0_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP0, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
@@ -243,7 +247,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-ssp.0");
 
 	clk = clk_register_mux(NULL, "ssp1_mux", ssp_parent,
-				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ssp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_SSP1, 4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.1", NULL);
 
@@ -256,7 +261,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, NULL, "pxa3xx-nand.0");
 
 	clk = clk_register_mux(NULL, "sdh0_mux", sdh_parent,
-				ARRAY_SIZE(sdh_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(sdh_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_SDH0, 6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "sdh0_mux", NULL);
 
@@ -265,7 +271,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, NULL, "sdhci-pxa.0");
 
 	clk = clk_register_mux(NULL, "sdh1_mux", sdh_parent,
-				ARRAY_SIZE(sdh_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(sdh_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_SDH1, 6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "sdh1_mux", NULL);
 
@@ -282,7 +289,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, "sph_clk", NULL);
 
 	clk = clk_register_mux(NULL, "disp0_mux", disp_parent,
-				ARRAY_SIZE(disp_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(disp_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_DISP0, 6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "disp_mux.0", NULL);
 
@@ -291,7 +299,8 @@ void __init pxa910_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mmp-disp.0");
 
 	clk = clk_register_mux(NULL, "ccic0_mux", ccic_parent,
-				ARRAY_SIZE(ccic_parent), CLK_SET_RATE_PARENT,
+				ARRAY_SIZE(ccic_parent),
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apmu_base + APMU_CCIC0, 6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.0", NULL);
 
@@ -301,8 +310,8 @@ void __init pxa910_clk_init(void)
 
 	clk = clk_register_mux(NULL, "ccic0_phy_mux", ccic_phy_parent,
 				ARRAY_SIZE(ccic_phy_parent),
-				CLK_SET_RATE_PARENT, apmu_base + APMU_CCIC0,
-				7, 1, 0, &clk_lock);
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+				apmu_base + APMU_CCIC0, 7, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_phy_mux.0", NULL);
 
 	clk = mmp_clk_register_apmu("ccic0_phy", "ccic0_phy_mux",
diff --git a/drivers/clk/mxs/clk.h b/drivers/clk/mxs/clk.h
index 81421e2..ef10ad9 100644
--- a/drivers/clk/mxs/clk.h
+++ b/drivers/clk/mxs/clk.h
@@ -52,8 +52,8 @@ static inline struct clk *mxs_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parent_names, int num_parents)
 {
 	return clk_register_mux(NULL, name, parent_names, num_parents,
-				CLK_SET_RATE_PARENT, reg, shift, width,
-				0, &mxs_lock);
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+				reg, shift, width, 0, &mxs_lock);
 }
 
 static inline struct clk *mxs_clk_fixed_factor(const char *name,
diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 9b1bbd5..50af9f7 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -82,11 +82,13 @@ void __init exynos_audss_clk_init(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
-				mout_audss_p, ARRAY_SIZE(mout_audss_p), 0,
+				mout_audss_p, ARRAY_SIZE(mout_audss_p),
+				CLK_SET_RATE_NO_REPARENT,
 				reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
 
 	clk_table[EXYNOS_MOUT_I2S] = clk_register_mux(NULL, "mout_i2s",
-				mout_i2s_p, ARRAY_SIZE(mout_i2s_p), 0,
+				mout_i2s_p, ARRAY_SIZE(mout_i2s_p),
+				CLK_SET_RATE_NO_REPARENT,
 				reg_base + ASS_CLK_SRC, 2, 2, 0, &lock);
 
 	clk_table[EXYNOS_DOUT_SRP] = clk_register_divider(NULL, "dout_srp",
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 2f7dba2..2613c91a 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -127,7 +127,7 @@ struct samsung_mux_clock {
 		.name		= cname,			\
 		.parent_names	= pnames,			\
 		.num_parents	= ARRAY_SIZE(pnames),		\
-		.flags		= f,				\
+		.flags		= (f) | CLK_SET_RATE_NO_REPARENT, \
 		.offset		= o,				\
 		.shift		= s,				\
 		.width		= w,				\
diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index aedbbe1..65894f7 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -416,9 +416,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	/* clock derived from 24 or 25 MHz osc clk */
 	/* vco-pll */
 	clk = clk_register_mux(NULL, "vco1_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), 0, SPEAR1310_PLL_CFG,
-			SPEAR1310_PLL1_CLK_SHIFT, SPEAR1310_PLL_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_PLL_CFG, SPEAR1310_PLL1_CLK_SHIFT,
+			SPEAR1310_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco1_mclk", NULL);
 	clk = clk_register_vco_pll("vco1_clk", "pll1_clk", NULL, "vco1_mclk",
 			0, SPEAR1310_PLL1_CTR, SPEAR1310_PLL1_FRQ, pll_rtbl,
@@ -427,9 +427,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk1, "pll1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "vco2_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), 0, SPEAR1310_PLL_CFG,
-			SPEAR1310_PLL2_CLK_SHIFT, SPEAR1310_PLL_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_PLL_CFG, SPEAR1310_PLL2_CLK_SHIFT,
+			SPEAR1310_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco2_mclk", NULL);
 	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL, "vco2_mclk",
 			0, SPEAR1310_PLL2_CTR, SPEAR1310_PLL2_FRQ, pll_rtbl,
@@ -438,9 +438,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk1, "pll2_clk", NULL);
 
 	clk = clk_register_mux(NULL, "vco3_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), 0, SPEAR1310_PLL_CFG,
-			SPEAR1310_PLL3_CLK_SHIFT, SPEAR1310_PLL_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_PLL_CFG, SPEAR1310_PLL3_CLK_SHIFT,
+			SPEAR1310_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco3_mclk", NULL);
 	clk = clk_register_vco_pll("vco3_clk", "pll3_clk", NULL, "vco3_mclk",
 			0, SPEAR1310_PLL3_CTR, SPEAR1310_PLL3_FRQ, pll_rtbl,
@@ -515,9 +515,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	/* gpt clocks */
 	clk = clk_register_mux(NULL, "gpt0_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), 0, SPEAR1310_PERIP_CLK_CFG,
-			SPEAR1310_GPT0_CLK_SHIFT, SPEAR1310_GPT_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT0_CLK_SHIFT,
+			SPEAR1310_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt0_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt0_clk", "gpt0_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_GPT0_CLK_ENB, 0,
@@ -525,9 +525,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "gpt0");
 
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), 0, SPEAR1310_PERIP_CLK_CFG,
-			SPEAR1310_GPT1_CLK_SHIFT, SPEAR1310_GPT_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT1_CLK_SHIFT,
+			SPEAR1310_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_GPT1_CLK_ENB, 0,
@@ -535,9 +535,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "gpt1");
 
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), 0, SPEAR1310_PERIP_CLK_CFG,
-			SPEAR1310_GPT2_CLK_SHIFT, SPEAR1310_GPT_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT2_CLK_SHIFT,
+			SPEAR1310_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
 			SPEAR1310_PERIP2_CLK_ENB, SPEAR1310_GPT2_CLK_ENB, 0,
@@ -545,9 +545,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "gpt2");
 
 	clk = clk_register_mux(NULL, "gpt3_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), 0, SPEAR1310_PERIP_CLK_CFG,
-			SPEAR1310_GPT3_CLK_SHIFT, SPEAR1310_GPT_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT3_CLK_SHIFT,
+			SPEAR1310_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt3_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mclk", 0,
 			SPEAR1310_PERIP2_CLK_ENB, SPEAR1310_GPT3_CLK_ENB, 0,
@@ -562,7 +562,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk1, "uart_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
-			ARRAY_SIZE(uart0_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uart0_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_UART_CLK_SHIFT,
 			SPEAR1310_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
@@ -602,7 +603,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk1, "c3_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "c3_mclk", c3_parents,
-			ARRAY_SIZE(c3_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(c3_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_C3_CLK_SHIFT,
 			SPEAR1310_C3_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "c3_mclk", NULL);
@@ -614,8 +616,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	/* gmac */
 	clk = clk_register_mux(NULL, "phy_input_mclk", gmac_phy_input_parents,
-			ARRAY_SIZE(gmac_phy_input_parents), 0,
-			SPEAR1310_GMAC_CLK_CFG,
+			ARRAY_SIZE(gmac_phy_input_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1310_GMAC_CLK_CFG,
 			SPEAR1310_GMAC_PHY_INPUT_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_INPUT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "phy_input_mclk", NULL);
@@ -627,15 +629,16 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk1, "phy_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "phy_mclk", gmac_phy_parents,
-			ARRAY_SIZE(gmac_phy_parents), 0,
+			ARRAY_SIZE(gmac_phy_parents), CLK_SET_RATE_NO_REPARENT,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GMAC_PHY_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
-			ARRAY_SIZE(clcd_synth_parents), 0,
-			SPEAR1310_CLCD_CLK_SYNT, SPEAR1310_CLCD_SYNT_CLK_SHIFT,
+			ARRAY_SIZE(clcd_synth_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1310_CLCD_CLK_SYNT,
+			SPEAR1310_CLCD_SYNT_CLK_SHIFT,
 			SPEAR1310_CLCD_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_syn_mclk", NULL);
 
@@ -645,7 +648,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, "clcd_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "clcd_pixel_mclk", clcd_pixel_parents,
-			ARRAY_SIZE(clcd_pixel_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(clcd_pixel_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_CLCD_CLK_SHIFT,
 			SPEAR1310_CLCD_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_pixel_mclk", NULL);
@@ -657,9 +661,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	/* i2s */
 	clk = clk_register_mux(NULL, "i2s_src_mclk", i2s_src_parents,
-			ARRAY_SIZE(i2s_src_parents), 0, SPEAR1310_I2S_CLK_CFG,
-			SPEAR1310_I2S_SRC_CLK_SHIFT, SPEAR1310_I2S_SRC_CLK_MASK,
-			0, &_lock);
+			ARRAY_SIZE(i2s_src_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_I2S_CLK_CFG, SPEAR1310_I2S_SRC_CLK_SHIFT,
+			SPEAR1310_I2S_SRC_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_src_mclk", NULL);
 
 	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mclk", 0,
@@ -668,7 +672,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, "i2s_prs1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "i2s_ref_mclk", i2s_ref_parents,
-			ARRAY_SIZE(i2s_ref_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(i2s_ref_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1310_I2S_CLK_CFG, SPEAR1310_I2S_REF_SHIFT,
 			SPEAR1310_I2S_REF_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_mclk", NULL);
@@ -806,13 +811,15 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	/* RAS clks */
 	clk = clk_register_mux(NULL, "gen_syn0_1_mclk", gen_synth0_1_parents,
-			ARRAY_SIZE(gen_synth0_1_parents), 0, SPEAR1310_PLL_CFG,
+			ARRAY_SIZE(gen_synth0_1_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1310_PLL_CFG,
 			SPEAR1310_RAS_SYNT0_1_CLK_SHIFT,
 			SPEAR1310_RAS_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen_syn0_1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "gen_syn2_3_mclk", gen_synth2_3_parents,
-			ARRAY_SIZE(gen_synth2_3_parents), 0, SPEAR1310_PLL_CFG,
+			ARRAY_SIZE(gen_synth2_3_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1310_PLL_CFG,
 			SPEAR1310_RAS_SYNT2_3_CLK_SHIFT,
 			SPEAR1310_RAS_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen_syn2_3_clk", NULL);
@@ -929,8 +936,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "smii_rgmii_phy_mclk",
 			smii_rgmii_phy_parents,
-			ARRAY_SIZE(smii_rgmii_phy_parents), 0,
-			SPEAR1310_RAS_CTRL_REG1,
+			ARRAY_SIZE(smii_rgmii_phy_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1310_RAS_CTRL_REG1,
 			SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "stmmacphy.1", NULL);
@@ -938,15 +945,15 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, "stmmacphy.4", NULL);
 
 	clk = clk_register_mux(NULL, "rmii_phy_mclk", rmii_phy_parents,
-			ARRAY_SIZE(rmii_phy_parents), 0,
+			ARRAY_SIZE(rmii_phy_parents), CLK_SET_RATE_NO_REPARENT,
 			SPEAR1310_RAS_CTRL_REG1, SPEAR1310_RMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "stmmacphy.3", NULL);
 
 	clk = clk_register_mux(NULL, "uart1_mclk", uart_parents,
-			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_UART1_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
-			0, &_lock);
+			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART1_CLK_SHIFT,
+			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart1_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "uart1_clk", "uart1_mclk", 0,
@@ -955,9 +962,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5c800000.serial");
 
 	clk = clk_register_mux(NULL, "uart2_mclk", uart_parents,
-			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_UART2_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
-			0, &_lock);
+			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART2_CLK_SHIFT,
+			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart2_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "uart2_clk", "uart2_mclk", 0,
@@ -966,9 +973,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5c900000.serial");
 
 	clk = clk_register_mux(NULL, "uart3_mclk", uart_parents,
-			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_UART3_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
-			0, &_lock);
+			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART3_CLK_SHIFT,
+			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart3_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "uart3_clk", "uart3_mclk", 0,
@@ -977,9 +984,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5ca00000.serial");
 
 	clk = clk_register_mux(NULL, "uart4_mclk", uart_parents,
-			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_UART4_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
-			0, &_lock);
+			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART4_CLK_SHIFT,
+			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart4_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "uart4_clk", "uart4_mclk", 0,
@@ -988,9 +995,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5cb00000.serial");
 
 	clk = clk_register_mux(NULL, "uart5_mclk", uart_parents,
-			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_UART5_CLK_SHIFT, SPEAR1310_RAS_UART_CLK_MASK,
-			0, &_lock);
+			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART5_CLK_SHIFT,
+			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart5_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "uart5_clk", "uart5_mclk", 0,
@@ -999,9 +1006,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5cc00000.serial");
 
 	clk = clk_register_mux(NULL, "i2c1_mclk", i2c_parents,
-			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_I2C1_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C1_CLK_SHIFT,
+			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c1_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2c1_clk", "i2c1_mclk", 0,
@@ -1010,9 +1017,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5cd00000.i2c");
 
 	clk = clk_register_mux(NULL, "i2c2_mclk", i2c_parents,
-			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_I2C2_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C2_CLK_SHIFT,
+			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c2_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2c2_clk", "i2c2_mclk", 0,
@@ -1021,9 +1028,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5ce00000.i2c");
 
 	clk = clk_register_mux(NULL, "i2c3_mclk", i2c_parents,
-			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_I2C3_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C3_CLK_SHIFT,
+			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c3_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2c3_clk", "i2c3_mclk", 0,
@@ -1032,9 +1039,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5cf00000.i2c");
 
 	clk = clk_register_mux(NULL, "i2c4_mclk", i2c_parents,
-			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_I2C4_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C4_CLK_SHIFT,
+			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c4_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2c4_clk", "i2c4_mclk", 0,
@@ -1043,9 +1050,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5d000000.i2c");
 
 	clk = clk_register_mux(NULL, "i2c5_mclk", i2c_parents,
-			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_I2C5_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C5_CLK_SHIFT,
+			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c5_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2c5_clk", "i2c5_mclk", 0,
@@ -1054,9 +1061,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5d100000.i2c");
 
 	clk = clk_register_mux(NULL, "i2c6_mclk", i2c_parents,
-			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_I2C6_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C6_CLK_SHIFT,
+			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c6_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2c6_clk", "i2c6_mclk", 0,
@@ -1065,9 +1072,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5d200000.i2c");
 
 	clk = clk_register_mux(NULL, "i2c7_mclk", i2c_parents,
-			ARRAY_SIZE(i2c_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_I2C7_CLK_SHIFT, SPEAR1310_I2C_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C7_CLK_SHIFT,
+			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c7_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2c7_clk", "i2c7_mclk", 0,
@@ -1076,9 +1083,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5d300000.i2c");
 
 	clk = clk_register_mux(NULL, "ssp1_mclk", ssp1_parents,
-			ARRAY_SIZE(ssp1_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_SSP1_CLK_SHIFT, SPEAR1310_SSP1_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(ssp1_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_SSP1_CLK_SHIFT,
+			SPEAR1310_SSP1_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ssp1_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "ssp1_clk", "ssp1_mclk", 0,
@@ -1087,9 +1094,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "5d400000.spi");
 
 	clk = clk_register_mux(NULL, "pci_mclk", pci_parents,
-			ARRAY_SIZE(pci_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_PCI_CLK_SHIFT, SPEAR1310_PCI_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(pci_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_PCI_CLK_SHIFT,
+			SPEAR1310_PCI_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "pci_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "pci_clk", "pci_mclk", 0,
@@ -1098,9 +1105,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "pci");
 
 	clk = clk_register_mux(NULL, "tdm1_mclk", tdm_parents,
-			ARRAY_SIZE(tdm_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_TDM1_CLK_SHIFT, SPEAR1310_TDM_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(tdm_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_TDM1_CLK_SHIFT,
+			SPEAR1310_TDM_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "tdm1_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "tdm1_clk", "tdm1_mclk", 0,
@@ -1109,9 +1116,9 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk_register_clkdev(clk, NULL, "tdm_hdlc.0");
 
 	clk = clk_register_mux(NULL, "tdm2_mclk", tdm_parents,
-			ARRAY_SIZE(tdm_parents), 0, SPEAR1310_RAS_CTRL_REG0,
-			SPEAR1310_TDM2_CLK_SHIFT, SPEAR1310_TDM_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(tdm_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_TDM2_CLK_SHIFT,
+			SPEAR1310_TDM_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "tdm2_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "tdm2_clk", "tdm2_mclk", 0,
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 9d0b394..fe835c1 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -473,9 +473,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	/* clock derived from 24 or 25 MHz osc clk */
 	/* vco-pll */
 	clk = clk_register_mux(NULL, "vco1_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), 0, SPEAR1340_PLL_CFG,
-			SPEAR1340_PLL1_CLK_SHIFT, SPEAR1340_PLL_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_PLL_CFG, SPEAR1340_PLL1_CLK_SHIFT,
+			SPEAR1340_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco1_mclk", NULL);
 	clk = clk_register_vco_pll("vco1_clk", "pll1_clk", NULL, "vco1_mclk", 0,
 			SPEAR1340_PLL1_CTR, SPEAR1340_PLL1_FRQ, pll_rtbl,
@@ -484,9 +484,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "pll1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "vco2_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), 0, SPEAR1340_PLL_CFG,
-			SPEAR1340_PLL2_CLK_SHIFT, SPEAR1340_PLL_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_PLL_CFG, SPEAR1340_PLL2_CLK_SHIFT,
+			SPEAR1340_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco2_mclk", NULL);
 	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL, "vco2_mclk", 0,
 			SPEAR1340_PLL2_CTR, SPEAR1340_PLL2_FRQ, pll_rtbl,
@@ -495,9 +495,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "pll2_clk", NULL);
 
 	clk = clk_register_mux(NULL, "vco3_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), 0, SPEAR1340_PLL_CFG,
-			SPEAR1340_PLL3_CLK_SHIFT, SPEAR1340_PLL_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_PLL_CFG, SPEAR1340_PLL3_CLK_SHIFT,
+			SPEAR1340_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco3_mclk", NULL);
 	clk = clk_register_vco_pll("vco3_clk", "pll3_clk", NULL, "vco3_mclk", 0,
 			SPEAR1340_PLL3_CTR, SPEAR1340_PLL3_FRQ, pll_rtbl,
@@ -561,8 +561,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "amba_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "sys_mclk", sys_parents,
-			ARRAY_SIZE(sys_parents), 0, SPEAR1340_SYS_CLK_CTRL,
-			SPEAR1340_SCLK_SRC_SEL_SHIFT,
+			ARRAY_SIZE(sys_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_SYS_CLK_CTRL, SPEAR1340_SCLK_SRC_SEL_SHIFT,
 			SPEAR1340_SCLK_SRC_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "sys_mclk", NULL);
 
@@ -583,8 +583,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "smp_twd");
 
 	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
-			ARRAY_SIZE(ahb_parents), 0, SPEAR1340_SYS_CLK_CTRL,
-			SPEAR1340_HCLK_SRC_SEL_SHIFT,
+			ARRAY_SIZE(ahb_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_SYS_CLK_CTRL, SPEAR1340_HCLK_SRC_SEL_SHIFT,
 			SPEAR1340_HCLK_SRC_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ahb_clk", NULL);
 
@@ -594,9 +594,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	/* gpt clocks */
 	clk = clk_register_mux(NULL, "gpt0_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), 0, SPEAR1340_PERIP_CLK_CFG,
-			SPEAR1340_GPT0_CLK_SHIFT, SPEAR1340_GPT_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GPT0_CLK_SHIFT,
+			SPEAR1340_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt0_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt0_clk", "gpt0_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_GPT0_CLK_ENB, 0,
@@ -604,9 +604,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "gpt0");
 
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), 0, SPEAR1340_PERIP_CLK_CFG,
-			SPEAR1340_GPT1_CLK_SHIFT, SPEAR1340_GPT_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GPT1_CLK_SHIFT,
+			SPEAR1340_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_GPT1_CLK_ENB, 0,
@@ -614,9 +614,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "gpt1");
 
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), 0, SPEAR1340_PERIP_CLK_CFG,
-			SPEAR1340_GPT2_CLK_SHIFT, SPEAR1340_GPT_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GPT2_CLK_SHIFT,
+			SPEAR1340_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_GPT2_CLK_ENB, 0,
@@ -624,9 +624,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "gpt2");
 
 	clk = clk_register_mux(NULL, "gpt3_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), 0, SPEAR1340_PERIP_CLK_CFG,
-			SPEAR1340_GPT3_CLK_SHIFT, SPEAR1340_GPT_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GPT3_CLK_SHIFT,
+			SPEAR1340_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt3_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mclk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_GPT3_CLK_ENB, 0,
@@ -641,7 +641,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "uart0_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
-			ARRAY_SIZE(uart0_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uart0_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_UART0_CLK_SHIFT,
 			SPEAR1340_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
@@ -658,9 +659,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "uart1_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "uart1_mclk", uart1_parents,
-			ARRAY_SIZE(uart1_parents), 0, SPEAR1340_PERIP_CLK_CFG,
-			SPEAR1340_UART1_CLK_SHIFT, SPEAR1340_UART_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(uart1_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_UART1_CLK_SHIFT,
+			SPEAR1340_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart1_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "uart1_clk", "uart1_mclk", 0,
@@ -698,7 +699,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "c3_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "c3_mclk", c3_parents,
-			ARRAY_SIZE(c3_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(c3_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_C3_CLK_SHIFT,
 			SPEAR1340_C3_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "c3_mclk", NULL);
@@ -710,8 +712,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	/* gmac */
 	clk = clk_register_mux(NULL, "phy_input_mclk", gmac_phy_input_parents,
-			ARRAY_SIZE(gmac_phy_input_parents), 0,
-			SPEAR1340_GMAC_CLK_CFG,
+			ARRAY_SIZE(gmac_phy_input_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1340_GMAC_CLK_CFG,
 			SPEAR1340_GMAC_PHY_INPUT_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_INPUT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "phy_input_mclk", NULL);
@@ -723,15 +725,16 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "phy_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "phy_mclk", gmac_phy_parents,
-			ARRAY_SIZE(gmac_phy_parents), 0,
+			ARRAY_SIZE(gmac_phy_parents), CLK_SET_RATE_NO_REPARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GMAC_PHY_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
-			ARRAY_SIZE(clcd_synth_parents), 0,
-			SPEAR1340_CLCD_CLK_SYNT, SPEAR1340_CLCD_SYNT_CLK_SHIFT,
+			ARRAY_SIZE(clcd_synth_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1340_CLCD_CLK_SYNT,
+			SPEAR1340_CLCD_SYNT_CLK_SHIFT,
 			SPEAR1340_CLCD_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_syn_mclk", NULL);
 
@@ -741,7 +744,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "clcd_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "clcd_pixel_mclk", clcd_pixel_parents,
-			ARRAY_SIZE(clcd_pixel_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(clcd_pixel_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_CLCD_CLK_SHIFT,
 			SPEAR1340_CLCD_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_pixel_mclk", NULL);
@@ -753,9 +757,9 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	/* i2s */
 	clk = clk_register_mux(NULL, "i2s_src_mclk", i2s_src_parents,
-			ARRAY_SIZE(i2s_src_parents), 0, SPEAR1340_I2S_CLK_CFG,
-			SPEAR1340_I2S_SRC_CLK_SHIFT, SPEAR1340_I2S_SRC_CLK_MASK,
-			0, &_lock);
+			ARRAY_SIZE(i2s_src_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR1340_I2S_CLK_CFG, SPEAR1340_I2S_SRC_CLK_SHIFT,
+			SPEAR1340_I2S_SRC_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_src_mclk", NULL);
 
 	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mclk",
@@ -765,7 +769,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "i2s_prs1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "i2s_ref_mclk", i2s_ref_parents,
-			ARRAY_SIZE(i2s_ref_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(i2s_ref_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1340_I2S_CLK_CFG, SPEAR1340_I2S_REF_SHIFT,
 			SPEAR1340_I2S_REF_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_mclk", NULL);
@@ -891,13 +896,15 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	/* RAS clks */
 	clk = clk_register_mux(NULL, "gen_syn0_1_mclk", gen_synth0_1_parents,
-			ARRAY_SIZE(gen_synth0_1_parents), 0, SPEAR1340_PLL_CFG,
+			ARRAY_SIZE(gen_synth0_1_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1340_PLL_CFG,
 			SPEAR1340_GEN_SYNT0_1_CLK_SHIFT,
 			SPEAR1340_GEN_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen_syn0_1_mclk", NULL);
 
 	clk = clk_register_mux(NULL, "gen_syn2_3_mclk", gen_synth2_3_parents,
-			ARRAY_SIZE(gen_synth2_3_parents), 0, SPEAR1340_PLL_CFG,
+			ARRAY_SIZE(gen_synth2_3_parents),
+			CLK_SET_RATE_NO_REPARENT, SPEAR1340_PLL_CFG,
 			SPEAR1340_GEN_SYNT2_3_CLK_SHIFT,
 			SPEAR1340_GEN_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen_syn2_3_mclk", NULL);
@@ -938,7 +945,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "spear_cec.1");
 
 	clk = clk_register_mux(NULL, "spdif_out_mclk", spdif_out_parents,
-			ARRAY_SIZE(spdif_out_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(spdif_out_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_SPDIF_OUT_CLK_SHIFT,
 			SPEAR1340_SPDIF_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "spdif_out_mclk", NULL);
@@ -949,7 +957,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "d0000000.spdif-out");
 
 	clk = clk_register_mux(NULL, "spdif_in_mclk", spdif_in_parents,
-			ARRAY_SIZE(spdif_in_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(spdif_in_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_SPDIF_IN_CLK_SHIFT,
 			SPEAR1340_SPDIF_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "spdif_in_mclk", NULL);
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index 080c3c5..c2d2043 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -294,7 +294,8 @@ static void __init spear320_clk_init(void __iomem *soc_config_base)
 	clk_register_clkdev(clk, NULL, "a9400000.i2s");
 
 	clk = clk_register_mux(NULL, "i2s_ref_clk", i2s_ref_parents,
-			ARRAY_SIZE(i2s_ref_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(i2s_ref_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_CONTROL_REG, I2S_REF_PCLK_SHIFT,
 			I2S_REF_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_clk", NULL);
@@ -313,57 +314,66 @@ static void __init spear320_clk_init(void __iomem *soc_config_base)
 	clk_register_clkdev(clk, "hclk", "ab000000.eth");
 
 	clk = clk_register_mux(NULL, "rs485_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uartx_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_EXT_CTRL_REG, SPEAR320_RS485_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9300000.serial");
 
 	clk = clk_register_mux(NULL, "sdhci_clk", sdhci_parents,
-			ARRAY_SIZE(sdhci_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(sdhci_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_CONTROL_REG, SDHCI_PCLK_SHIFT, SDHCI_PCLK_MASK,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "70000000.sdhci");
 
 	clk = clk_register_mux(NULL, "smii_pclk", smii0_parents,
-			ARRAY_SIZE(smii0_parents), 0, SPEAR320_CONTROL_REG,
-			SMII_PCLK_SHIFT, SMII_PCLK_MASK, 0, &_lock);
+			ARRAY_SIZE(smii0_parents), CLK_SET_RATE_NO_REPARENT,
+			SPEAR320_CONTROL_REG, SMII_PCLK_SHIFT, SMII_PCLK_MASK,
+			0, &_lock);
 	clk_register_clkdev(clk, NULL, "smii_pclk");
 
 	clk = clk_register_fixed_factor(NULL, "smii_clk", "smii_pclk", 0, 1, 1);
 	clk_register_clkdev(clk, NULL, "smii");
 
 	clk = clk_register_mux(NULL, "uart1_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uartx_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_CONTROL_REG, UART1_PCLK_SHIFT, UART1_PCLK_MASK,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "a3000000.serial");
 
 	clk = clk_register_mux(NULL, "uart2_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uartx_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_EXT_CTRL_REG, SPEAR320_UART2_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a4000000.serial");
 
 	clk = clk_register_mux(NULL, "uart3_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uartx_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_EXT_CTRL_REG, SPEAR320_UART3_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9100000.serial");
 
 	clk = clk_register_mux(NULL, "uart4_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uartx_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_EXT_CTRL_REG, SPEAR320_UART4_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9200000.serial");
 
 	clk = clk_register_mux(NULL, "uart5_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uartx_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_EXT_CTRL_REG, SPEAR320_UART5_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "60000000.serial");
 
 	clk = clk_register_mux(NULL, "uart6_clk", uartx_parents,
-			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uartx_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SPEAR320_EXT_CTRL_REG, SPEAR320_UART6_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "60100000.serial");
@@ -427,7 +437,8 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk_register_clkdev(clk1, "uart_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
-			ARRAY_SIZE(uart0_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(uart0_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			PERIP_CLK_CFG, UART_CLK_SHIFT, UART_CLK_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
@@ -444,7 +455,8 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk_register_clkdev(clk1, "firda_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "firda_mclk", firda_parents,
-			ARRAY_SIZE(firda_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(firda_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			PERIP_CLK_CFG, FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "firda_mclk", NULL);
@@ -458,14 +470,16 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk_register_gpt("gpt0_syn_clk", "pll1_clk", 0, PRSC0_CLK_CFG, gpt_rtbl,
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt0_clk", gpt0_parents,
-			ARRAY_SIZE(gpt0_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(gpt0_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			PERIP_CLK_CFG, GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
 	clk_register_gpt("gpt1_syn_clk", "pll1_clk", 0, PRSC1_CLK_CFG, gpt_rtbl,
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt1_parents,
-			ARRAY_SIZE(gpt1_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(gpt1_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			PERIP_CLK_CFG, GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk",
@@ -476,7 +490,8 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk_register_gpt("gpt2_syn_clk", "pll1_clk", 0, PRSC2_CLK_CFG, gpt_rtbl,
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt2_parents,
-			ARRAY_SIZE(gpt2_parents), CLK_SET_RATE_PARENT,
+			ARRAY_SIZE(gpt2_parents),
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			PERIP_CLK_CFG, GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk",
@@ -498,9 +513,9 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk_register_clkdev(clk1, "gen1_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "gen2_3_par_clk", gen2_3_parents,
-			ARRAY_SIZE(gen2_3_parents), 0, CORE_CLK_CFG,
-			GEN_SYNTH2_3_CLK_SHIFT, GEN_SYNTH2_3_CLK_MASK, 0,
-			&_lock);
+			ARRAY_SIZE(gen2_3_parents), CLK_SET_RATE_NO_REPARENT,
+			CORE_CLK_CFG, GEN_SYNTH2_3_CLK_SHIFT,
+			GEN_SYNTH2_3_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen2_3_par_clk", NULL);
 
 	clk = clk_register_aux("gen2_syn_clk", "gen2_syn_gclk",
@@ -540,8 +555,8 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk_register_clkdev(clk, "ahbmult2_clk", NULL);
 
 	clk = clk_register_mux(NULL, "ddr_clk", ddr_parents,
-			ARRAY_SIZE(ddr_parents), 0, PLL_CLK_CFG, MCTR_CLK_SHIFT,
-			MCTR_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(ddr_parents), CLK_SET_RATE_NO_REPARENT,
+			PLL_CLK_CFG, MCTR_CLK_SHIFT, MCTR_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ddr_clk", NULL);
 
 	clk = clk_register_divider(NULL, "apb_clk", "ahb_clk",
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index 9406f24..4f649c9 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -169,8 +169,9 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "uart_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "uart_mclk", uart_parents,
-			ARRAY_SIZE(uart_parents), 0, PERIP_CLK_CFG,
-			UART_CLK_SHIFT, UART_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
+			PERIP_CLK_CFG, UART_CLK_SHIFT, UART_CLK_MASK, 0,
+			&_lock);
 	clk_register_clkdev(clk, "uart_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "uart0", "uart_mclk", 0, PERIP1_CLK_ENB,
@@ -188,8 +189,9 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "firda_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "firda_mclk", firda_parents,
-			ARRAY_SIZE(firda_parents), 0, PERIP_CLK_CFG,
-			FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(firda_parents), CLK_SET_RATE_NO_REPARENT,
+			PERIP_CLK_CFG, FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0,
+			&_lock);
 	clk_register_clkdev(clk, "firda_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "firda_clk", "firda_mclk", 0,
@@ -203,8 +205,9 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "clcd_syn_gclk", NULL);
 
 	clk = clk_register_mux(NULL, "clcd_mclk", clcd_parents,
-			ARRAY_SIZE(clcd_parents), 0, PERIP_CLK_CFG,
-			CLCD_CLK_SHIFT, CLCD_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(clcd_parents), CLK_SET_RATE_NO_REPARENT,
+			PERIP_CLK_CFG, CLCD_CLK_SHIFT, CLCD_CLK_MASK, 0,
+			&_lock);
 	clk_register_clkdev(clk, "clcd_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "clcd_clk", "clcd_mclk", 0,
@@ -217,13 +220,13 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "gpt0_1_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "gpt0_mclk", gpt0_1_parents,
-			ARRAY_SIZE(gpt0_1_parents), 0, PERIP_CLK_CFG,
-			GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(gpt0_1_parents), CLK_SET_RATE_NO_REPARENT,
+			PERIP_CLK_CFG, GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt0_1_parents,
-			ARRAY_SIZE(gpt0_1_parents), 0, PERIP_CLK_CFG,
-			GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(gpt0_1_parents), CLK_SET_RATE_NO_REPARENT,
+			PERIP_CLK_CFG, GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
@@ -235,8 +238,8 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "gpt2_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt2_parents,
-			ARRAY_SIZE(gpt2_parents), 0, PERIP_CLK_CFG,
-			GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(gpt2_parents), CLK_SET_RATE_NO_REPARENT,
+			PERIP_CLK_CFG, GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
@@ -248,8 +251,8 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "gpt3_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "gpt3_mclk", gpt3_parents,
-			ARRAY_SIZE(gpt3_parents), 0, PERIP_CLK_CFG,
-			GPT3_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(gpt3_parents), CLK_SET_RATE_NO_REPARENT,
+			PERIP_CLK_CFG, GPT3_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt3_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mclk", 0,
@@ -277,8 +280,8 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "ahbmult2_clk", NULL);
 
 	clk = clk_register_mux(NULL, "ddr_clk", ddr_parents,
-			ARRAY_SIZE(ddr_parents), 0, PLL_CLK_CFG, MCTR_CLK_SHIFT,
-			MCTR_CLK_MASK, 0, &_lock);
+			ARRAY_SIZE(ddr_parents), CLK_SET_RATE_NO_REPARENT,
+			PLL_CLK_CFG, MCTR_CLK_SHIFT, MCTR_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ddr_clk", NULL);
 
 	clk = clk_register_divider(NULL, "apb_clk", "ahb_clk",
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 412912b..8c44236 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -261,7 +261,8 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 	while (i < 5 && (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
 		i++;
 
-	clk = clk_register_mux(NULL, clk_name, parents, i, 0, reg,
+	clk = clk_register_mux(NULL, clk_name, parents, i,
+			       CLK_SET_RATE_NO_REPARENT, reg,
 			       data->shift, SUNXI_MUX_GATE_WIDTH,
 			       0, &clk_lock);
 
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index b6015cb..c0715f6 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1558,7 +1558,8 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 
 	/* audio0 */
 	clk = clk_register_mux(NULL, "audio0_mux", mux_audio_sync_clk,
-			       ARRAY_SIZE(mux_audio_sync_clk), 0,
+			       ARRAY_SIZE(mux_audio_sync_clk),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + AUDIO_SYNC_CLK_I2S0, 0, 3, 0,
 			       NULL);
 	clks[audio0_mux] = clk;
@@ -1570,7 +1571,8 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 
 	/* audio1 */
 	clk = clk_register_mux(NULL, "audio1_mux", mux_audio_sync_clk,
-			       ARRAY_SIZE(mux_audio_sync_clk), 0,
+			       ARRAY_SIZE(mux_audio_sync_clk),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + AUDIO_SYNC_CLK_I2S1, 0, 3, 0,
 			       NULL);
 	clks[audio1_mux] = clk;
@@ -1582,7 +1584,8 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 
 	/* audio2 */
 	clk = clk_register_mux(NULL, "audio2_mux", mux_audio_sync_clk,
-			       ARRAY_SIZE(mux_audio_sync_clk), 0,
+			       ARRAY_SIZE(mux_audio_sync_clk),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + AUDIO_SYNC_CLK_I2S2, 0, 3, 0,
 			       NULL);
 	clks[audio2_mux] = clk;
@@ -1594,7 +1597,8 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 
 	/* audio3 */
 	clk = clk_register_mux(NULL, "audio3_mux", mux_audio_sync_clk,
-			       ARRAY_SIZE(mux_audio_sync_clk), 0,
+			       ARRAY_SIZE(mux_audio_sync_clk),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + AUDIO_SYNC_CLK_I2S3, 0, 3, 0,
 			       NULL);
 	clks[audio3_mux] = clk;
@@ -1606,7 +1610,8 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 
 	/* audio4 */
 	clk = clk_register_mux(NULL, "audio4_mux", mux_audio_sync_clk,
-			       ARRAY_SIZE(mux_audio_sync_clk), 0,
+			       ARRAY_SIZE(mux_audio_sync_clk),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + AUDIO_SYNC_CLK_I2S4, 0, 3, 0,
 			       NULL);
 	clks[audio4_mux] = clk;
@@ -1618,7 +1623,8 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 
 	/* spdif */
 	clk = clk_register_mux(NULL, "spdif_mux", mux_audio_sync_clk,
-			       ARRAY_SIZE(mux_audio_sync_clk), 0,
+			       ARRAY_SIZE(mux_audio_sync_clk),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + AUDIO_SYNC_CLK_SPDIF, 0, 3, 0,
 			       NULL);
 	clks[spdif_mux] = clk;
@@ -1713,7 +1719,8 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
 
 	/* clk_out_1 */
 	clk = clk_register_mux(NULL, "clk_out_1_mux", clk_out1_parents,
-			       ARRAY_SIZE(clk_out1_parents), 0,
+			       ARRAY_SIZE(clk_out1_parents),
+			       CLK_SET_RATE_NO_REPARENT,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 6, 3, 0,
 			       &clk_out_lock);
 	clks[clk_out_1_mux] = clk;
@@ -1725,7 +1732,8 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
 
 	/* clk_out_2 */
 	clk = clk_register_mux(NULL, "clk_out_2_mux", clk_out2_parents,
-			       ARRAY_SIZE(clk_out2_parents), 0,
+			       ARRAY_SIZE(clk_out2_parents),
+			       CLK_SET_RATE_NO_REPARENT,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 14, 3, 0,
 			       &clk_out_lock);
 	clks[clk_out_2_mux] = clk;
@@ -1737,7 +1745,8 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
 
 	/* clk_out_3 */
 	clk = clk_register_mux(NULL, "clk_out_3_mux", clk_out3_parents,
-			       ARRAY_SIZE(clk_out3_parents), 0,
+			       ARRAY_SIZE(clk_out3_parents),
+			       CLK_SET_RATE_NO_REPARENT,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 22, 3, 0,
 			       &clk_out_lock);
 	clks[clk_out_3_mux] = clk;
@@ -2055,7 +2064,8 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base)
 
 	/* dsia */
 	clk = clk_register_mux(NULL, "dsia_mux", mux_plld_out0_plld2_out0,
-			       ARRAY_SIZE(mux_plld_out0_plld2_out0), 0,
+			       ARRAY_SIZE(mux_plld_out0_plld2_out0),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + PLLD_BASE, 25, 1, 0, &pll_d_lock);
 	clks[dsia_mux] = clk;
 	clk = tegra_clk_register_periph_gate("dsia", "dsia_mux", 0, clk_base,
@@ -2065,7 +2075,8 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base)
 
 	/* dsib */
 	clk = clk_register_mux(NULL, "dsib_mux", mux_plld_out0_plld2_out0,
-			       ARRAY_SIZE(mux_plld_out0_plld2_out0), 0,
+			       ARRAY_SIZE(mux_plld_out0_plld2_out0),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + PLLD2_BASE, 25, 1, 0, &pll_d2_lock);
 	clks[dsib_mux] = clk;
 	clk = tegra_clk_register_periph_gate("dsib", "dsib_mux", 0, clk_base,
@@ -2102,7 +2113,8 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base)
 
 	/* emc */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm), 0,
+			       ARRAY_SIZE(mux_pllmcp_clkm),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
 			       29, 3, 0, NULL);
 	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base,
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 759ca47..73ad49d0 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -778,7 +778,8 @@ static void __init tegra20_audio_clk_init(void)
 
 	/* audio */
 	clk = clk_register_mux(NULL, "audio_mux", audio_parents,
-				ARRAY_SIZE(audio_parents), 0,
+				ARRAY_SIZE(audio_parents),
+				CLK_SET_RATE_NO_REPARENT,
 				clk_base + AUDIO_SYNC_CLK, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio", "audio_mux", 0,
 				clk_base + AUDIO_SYNC_CLK, 4,
@@ -941,7 +942,8 @@ static void __init tegra20_periph_clk_init(void)
 
 	/* emc */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm), 0,
+			       ARRAY_SIZE(mux_pllmcp_clkm),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
 			       30, 2, 0, NULL);
 	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index e2c6ca0..0291ef2 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1026,7 +1026,8 @@ static void __init tegra30_pll_init(void)
 
 	/* PLLE */
 	clk = clk_register_mux(NULL, "pll_e_mux", pll_e_parents,
-			       ARRAY_SIZE(pll_e_parents), 0,
+			       ARRAY_SIZE(pll_e_parents),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + PLLE_AUX, 2, 1, 0, NULL);
 	clk = tegra_clk_register_plle("pll_e", "pll_e_mux", clk_base, pmc_base,
 			     CLK_GET_RATE_NOCACHE, 100000000, &pll_e_params,
@@ -1086,7 +1087,8 @@ static void __init tegra30_audio_clk_init(void)
 
 	/* audio0 */
 	clk = clk_register_mux(NULL, "audio0_mux", mux_audio_sync_clk,
-				ARRAY_SIZE(mux_audio_sync_clk), 0,
+				ARRAY_SIZE(mux_audio_sync_clk),
+				CLK_SET_RATE_NO_REPARENT,
 				clk_base + AUDIO_SYNC_CLK_I2S0, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio0", "audio0_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S0, 4,
@@ -1096,7 +1098,8 @@ static void __init tegra30_audio_clk_init(void)
 
 	/* audio1 */
 	clk = clk_register_mux(NULL, "audio1_mux", mux_audio_sync_clk,
-				ARRAY_SIZE(mux_audio_sync_clk), 0,
+				ARRAY_SIZE(mux_audio_sync_clk),
+				CLK_SET_RATE_NO_REPARENT,
 				clk_base + AUDIO_SYNC_CLK_I2S1, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio1", "audio1_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S1, 4,
@@ -1106,7 +1109,8 @@ static void __init tegra30_audio_clk_init(void)
 
 	/* audio2 */
 	clk = clk_register_mux(NULL, "audio2_mux", mux_audio_sync_clk,
-				ARRAY_SIZE(mux_audio_sync_clk), 0,
+				ARRAY_SIZE(mux_audio_sync_clk),
+				CLK_SET_RATE_NO_REPARENT,
 				clk_base + AUDIO_SYNC_CLK_I2S2, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio2", "audio2_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S2, 4,
@@ -1116,7 +1120,8 @@ static void __init tegra30_audio_clk_init(void)
 
 	/* audio3 */
 	clk = clk_register_mux(NULL, "audio3_mux", mux_audio_sync_clk,
-				ARRAY_SIZE(mux_audio_sync_clk), 0,
+				ARRAY_SIZE(mux_audio_sync_clk),
+				CLK_SET_RATE_NO_REPARENT,
 				clk_base + AUDIO_SYNC_CLK_I2S3, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio3", "audio3_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S3, 4,
@@ -1126,7 +1131,8 @@ static void __init tegra30_audio_clk_init(void)
 
 	/* audio4 */
 	clk = clk_register_mux(NULL, "audio4_mux", mux_audio_sync_clk,
-				ARRAY_SIZE(mux_audio_sync_clk), 0,
+				ARRAY_SIZE(mux_audio_sync_clk),
+				CLK_SET_RATE_NO_REPARENT,
 				clk_base + AUDIO_SYNC_CLK_I2S4, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio4", "audio4_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S4, 4,
@@ -1136,7 +1142,8 @@ static void __init tegra30_audio_clk_init(void)
 
 	/* spdif */
 	clk = clk_register_mux(NULL, "spdif_mux", mux_audio_sync_clk,
-				ARRAY_SIZE(mux_audio_sync_clk), 0,
+				ARRAY_SIZE(mux_audio_sync_clk),
+				CLK_SET_RATE_NO_REPARENT,
 				clk_base + AUDIO_SYNC_CLK_SPDIF, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "spdif", "spdif_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_SPDIF, 4,
@@ -1229,7 +1236,8 @@ static void __init tegra30_pmc_clk_init(void)
 
 	/* clk_out_1 */
 	clk = clk_register_mux(NULL, "clk_out_1_mux", clk_out1_parents,
-			       ARRAY_SIZE(clk_out1_parents), 0,
+			       ARRAY_SIZE(clk_out1_parents),
+			       CLK_SET_RATE_NO_REPARENT,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 6, 3, 0,
 			       &clk_out_lock);
 	clks[clk_out_1_mux] = clk;
@@ -1241,7 +1249,8 @@ static void __init tegra30_pmc_clk_init(void)
 
 	/* clk_out_2 */
 	clk = clk_register_mux(NULL, "clk_out_2_mux", clk_out2_parents,
-			       ARRAY_SIZE(clk_out2_parents), 0,
+			       ARRAY_SIZE(clk_out2_parents),
+			       CLK_SET_RATE_NO_REPARENT,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 14, 3, 0,
 			       &clk_out_lock);
 	clk = clk_register_gate(NULL, "clk_out_2", "clk_out_2_mux", 0,
@@ -1252,7 +1261,8 @@ static void __init tegra30_pmc_clk_init(void)
 
 	/* clk_out_3 */
 	clk = clk_register_mux(NULL, "clk_out_3_mux", clk_out3_parents,
-			       ARRAY_SIZE(clk_out3_parents), 0,
+			       ARRAY_SIZE(clk_out3_parents),
+			       CLK_SET_RATE_NO_REPARENT,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 22, 3, 0,
 			       &clk_out_lock);
 	clk = clk_register_gate(NULL, "clk_out_3", "clk_out_3_mux", 0,
@@ -1679,7 +1689,8 @@ static void __init tegra30_periph_clk_init(void)
 
 	/* emc */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm), 0,
+			       ARRAY_SIZE(mux_pllmcp_clkm),
+			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
 			       30, 2, 0, NULL);
 	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
index a4a728d..2d5e1b4 100644
--- a/drivers/clk/versatile/clk-vexpress.c
+++ b/drivers/clk/versatile/clk-vexpress.c
@@ -37,8 +37,8 @@ static void __init vexpress_sp810_init(void __iomem *base)
 		snprintf(name, ARRAY_SIZE(name), "timerclken%d", i);
 
 		vexpress_sp810_timerclken[i] = clk_register_mux(NULL, name,
-				parents, 2, 0, base + SCCTRL,
-				SCCTRL_TIMERENnSEL_SHIFT(i), 1,
+				parents, 2, CLK_SET_RATE_NO_REPARENT,
+				base + SCCTRL, SCCTRL_TIMERENnSEL_SHIFT(i), 1,
 				0, &vexpress_sp810_lock);
 
 		if (WARN_ON(IS_ERR(vexpress_sp810_timerclken[i])))
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 5c205b6..e05c9e3 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -124,8 +124,9 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 	div0_name = kasprintf(GFP_KERNEL, "%s_div0", clk_name);
 	div1_name = kasprintf(GFP_KERNEL, "%s_div1", clk_name);
 
-	clk = clk_register_mux(NULL, mux_name, parents, 4, 0,
-			fclk_ctrl_reg, 4, 2, 0, fclk_lock);
+	clk = clk_register_mux(NULL, mux_name, parents, 4,
+			CLK_SET_RATE_NO_REPARENT, fclk_ctrl_reg, 4, 2, 0,
+			fclk_lock);
 
 	clk = clk_register_divider(NULL, div0_name, mux_name,
 			0, fclk_ctrl_reg, 8, 6, CLK_DIVIDER_ONE_BASED |
@@ -167,8 +168,8 @@ static void __init zynq_clk_register_periph_clk(enum zynq_clk clk0,
 	mux_name = kasprintf(GFP_KERNEL, "%s_mux", clk_name0);
 	div_name = kasprintf(GFP_KERNEL, "%s_div", clk_name0);
 
-	clk = clk_register_mux(NULL, mux_name, parents, 4, 0,
-			clk_ctrl, 4, 2, 0, lock);
+	clk = clk_register_mux(NULL, mux_name, parents, 4,
+			CLK_SET_RATE_NO_REPARENT, clk_ctrl, 4, 2, 0, lock);
 
 	clk = clk_register_divider(NULL, div_name, mux_name, 0, clk_ctrl, 8, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO, lock);
@@ -235,25 +236,26 @@ static void __init zynq_clk_setup(struct device_node *np)
 	clk = clk_register_zynq_pll("armpll_int", "ps_clk", SLCR_ARMPLL_CTRL,
 			SLCR_PLL_STATUS, 0, &armpll_lock);
 	clks[armpll] = clk_register_mux(NULL, clk_output_name[armpll],
-			armpll_parents, 2, 0, SLCR_ARMPLL_CTRL, 4, 1, 0,
-			&armpll_lock);
+			armpll_parents, 2, CLK_SET_RATE_NO_REPARENT,
+			SLCR_ARMPLL_CTRL, 4, 1, 0, &armpll_lock);
 
 	clk = clk_register_zynq_pll("ddrpll_int", "ps_clk", SLCR_DDRPLL_CTRL,
 			SLCR_PLL_STATUS, 1, &ddrpll_lock);
 	clks[ddrpll] = clk_register_mux(NULL, clk_output_name[ddrpll],
-			ddrpll_parents, 2, 0, SLCR_DDRPLL_CTRL, 4, 1, 0,
-			&ddrpll_lock);
+			ddrpll_parents, 2, CLK_SET_RATE_NO_REPARENT,
+			SLCR_DDRPLL_CTRL, 4, 1, 0, &ddrpll_lock);
 
 	clk = clk_register_zynq_pll("iopll_int", "ps_clk", SLCR_IOPLL_CTRL,
 			SLCR_PLL_STATUS, 2, &iopll_lock);
 	clks[iopll] = clk_register_mux(NULL, clk_output_name[iopll],
-			iopll_parents, 2, 0, SLCR_IOPLL_CTRL, 4, 1, 0,
-			&iopll_lock);
+			iopll_parents, 2, CLK_SET_RATE_NO_REPARENT,
+			SLCR_IOPLL_CTRL, 4, 1, 0, &iopll_lock);
 
 	/* CPU clocks */
 	tmp = readl(SLCR_621_TRUE) & 1;
-	clk = clk_register_mux(NULL, "cpu_mux", cpu_parents, 4, 0,
-			SLCR_ARM_CLK_CTRL, 4, 2, 0, &armclk_lock);
+	clk = clk_register_mux(NULL, "cpu_mux", cpu_parents, 4,
+			CLK_SET_RATE_NO_REPARENT, SLCR_ARM_CLK_CTRL, 4, 2, 0,
+			&armclk_lock);
 	clk = clk_register_divider(NULL, "cpu_div", "cpu_mux", 0,
 			SLCR_ARM_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &armclk_lock);
@@ -292,8 +294,9 @@ static void __init zynq_clk_setup(struct device_node *np)
 			swdt_ext_clk_mux_parents[i + 1] = dummy_nm;
 	}
 	clks[swdt] = clk_register_mux(NULL, clk_output_name[swdt],
-			swdt_ext_clk_mux_parents, 2, CLK_SET_RATE_PARENT,
-			SLCR_SWDT_CLK_SEL, 0, 1, 0, &gem0clk_lock);
+			swdt_ext_clk_mux_parents, 2, CLK_SET_RATE_PARENT |
+			CLK_SET_RATE_NO_REPARENT, SLCR_SWDT_CLK_SEL, 0, 1, 0,
+			&gem0clk_lock);
 
 	/* DDR clocks */
 	clk = clk_register_divider(NULL, "ddr2x_div", "ddrpll", 0,
@@ -355,8 +358,9 @@ static void __init zynq_clk_setup(struct device_node *np)
 			gem0_mux_parents[i + 1] = of_clk_get_parent_name(np,
 					idx);
 	}
-	clk = clk_register_mux(NULL, "gem0_mux", periph_parents, 4, 0,
-			SLCR_GEM0_CLK_CTRL, 4, 2, 0, &gem0clk_lock);
+	clk = clk_register_mux(NULL, "gem0_mux", periph_parents, 4,
+			CLK_SET_RATE_NO_REPARENT, SLCR_GEM0_CLK_CTRL, 4, 2, 0,
+			&gem0clk_lock);
 	clk = clk_register_divider(NULL, "gem0_div0", "gem0_mux", 0,
 			SLCR_GEM0_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &gem0clk_lock);
@@ -364,8 +368,9 @@ static void __init zynq_clk_setup(struct device_node *np)
 			CLK_SET_RATE_PARENT, SLCR_GEM0_CLK_CTRL, 20, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			&gem0clk_lock);
-	clk = clk_register_mux(NULL, "gem0_emio_mux", gem0_mux_parents, 2, 0,
-			SLCR_GEM0_CLK_CTRL, 6, 1, 0, &gem0clk_lock);
+	clk = clk_register_mux(NULL, "gem0_emio_mux", gem0_mux_parents, 2,
+			CLK_SET_RATE_NO_REPARENT, SLCR_GEM0_CLK_CTRL, 6, 1, 0,
+			&gem0clk_lock);
 	clks[gem0] = clk_register_gate(NULL, clk_output_name[gem0],
 			"gem0_emio_mux", CLK_SET_RATE_PARENT,
 			SLCR_GEM0_CLK_CTRL, 0, 0, &gem0clk_lock);
@@ -377,8 +382,9 @@ static void __init zynq_clk_setup(struct device_node *np)
 			gem1_mux_parents[i + 1] = of_clk_get_parent_name(np,
 					idx);
 	}
-	clk = clk_register_mux(NULL, "gem1_mux", periph_parents, 4, 0,
-			SLCR_GEM1_CLK_CTRL, 4, 2, 0, &gem1clk_lock);
+	clk = clk_register_mux(NULL, "gem1_mux", periph_parents, 4,
+			CLK_SET_RATE_NO_REPARENT, SLCR_GEM1_CLK_CTRL, 4, 2, 0,
+			&gem1clk_lock);
 	clk = clk_register_divider(NULL, "gem1_div0", "gem1_mux", 0,
 			SLCR_GEM1_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &gem1clk_lock);
@@ -386,8 +392,9 @@ static void __init zynq_clk_setup(struct device_node *np)
 			CLK_SET_RATE_PARENT, SLCR_GEM1_CLK_CTRL, 20, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			&gem1clk_lock);
-	clk = clk_register_mux(NULL, "gem1_emio_mux", gem1_mux_parents, 2, 0,
-			SLCR_GEM1_CLK_CTRL, 6, 1, 0, &gem1clk_lock);
+	clk = clk_register_mux(NULL, "gem1_emio_mux", gem1_mux_parents, 2,
+			CLK_SET_RATE_NO_REPARENT, SLCR_GEM1_CLK_CTRL, 6, 1, 0,
+			&gem1clk_lock);
 	clks[gem1] = clk_register_gate(NULL, clk_output_name[gem1],
 			"gem1_emio_mux", CLK_SET_RATE_PARENT,
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
@@ -406,8 +413,9 @@ static void __init zynq_clk_setup(struct device_node *np)
 			can_mio_mux_parents[i] = dummy_nm;
 	}
 	kfree(clk_name);
-	clk = clk_register_mux(NULL, "can_mux", periph_parents, 4, 0,
-			SLCR_CAN_CLK_CTRL, 4, 2, 0, &canclk_lock);
+	clk = clk_register_mux(NULL, "can_mux", periph_parents, 4,
+			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
+			&canclk_lock);
 	clk = clk_register_divider(NULL, "can_div0", "can_mux", 0,
 			SLCR_CAN_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &canclk_lock);
@@ -422,17 +430,21 @@ static void __init zynq_clk_setup(struct device_node *np)
 			CLK_SET_RATE_PARENT, SLCR_CAN_CLK_CTRL, 1, 0,
 			&canclk_lock);
 	clk = clk_register_mux(NULL, "can0_mio_mux",
-			can_mio_mux_parents, 54, CLK_SET_RATE_PARENT,
-			SLCR_CAN_MIOCLK_CTRL, 0, 6, 0, &canmioclk_lock);
+			can_mio_mux_parents, 54, CLK_SET_RATE_PARENT |
+			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 0, 6, 0,
+			&canmioclk_lock);
 	clk = clk_register_mux(NULL, "can1_mio_mux",
-			can_mio_mux_parents, 54, CLK_SET_RATE_PARENT,
-			SLCR_CAN_MIOCLK_CTRL, 16, 6, 0, &canmioclk_lock);
+			can_mio_mux_parents, 54, CLK_SET_RATE_PARENT |
+			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 16, 6,
+			0, &canmioclk_lock);
 	clks[can0] = clk_register_mux(NULL, clk_output_name[can0],
-			can0_mio_mux2_parents, 2, CLK_SET_RATE_PARENT,
-			SLCR_CAN_MIOCLK_CTRL, 6, 1, 0, &canmioclk_lock);
+			can0_mio_mux2_parents, 2, CLK_SET_RATE_PARENT |
+			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 6, 1, 0,
+			&canmioclk_lock);
 	clks[can1] = clk_register_mux(NULL, clk_output_name[can1],
-			can1_mio_mux2_parents, 2, CLK_SET_RATE_PARENT,
-			SLCR_CAN_MIOCLK_CTRL, 22, 1, 0, &canmioclk_lock);
+			can1_mio_mux2_parents, 2, CLK_SET_RATE_PARENT |
+			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 22, 1,
+			0, &canmioclk_lock);
 
 	for (i = 0; i < ARRAY_SIZE(dbgtrc_emio_input_names); i++) {
 		int idx = of_property_match_string(np, "clock-names",
@@ -441,13 +453,15 @@ static void __init zynq_clk_setup(struct device_node *np)
 			dbg_emio_mux_parents[i + 1] = of_clk_get_parent_name(np,
 					idx);
 	}
-	clk = clk_register_mux(NULL, "dbg_mux", periph_parents, 4, 0,
-			SLCR_DBG_CLK_CTRL, 4, 2, 0, &dbgclk_lock);
+	clk = clk_register_mux(NULL, "dbg_mux", periph_parents, 4,
+			CLK_SET_RATE_NO_REPARENT, SLCR_DBG_CLK_CTRL, 4, 2, 0,
+			&dbgclk_lock);
 	clk = clk_register_divider(NULL, "dbg_div", "dbg_mux", 0,
 			SLCR_DBG_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &dbgclk_lock);
-	clk = clk_register_mux(NULL, "dbg_emio_mux", dbg_emio_mux_parents, 2, 0,
-			SLCR_DBG_CLK_CTRL, 6, 1, 0, &dbgclk_lock);
+	clk = clk_register_mux(NULL, "dbg_emio_mux", dbg_emio_mux_parents, 2,
+			CLK_SET_RATE_NO_REPARENT, SLCR_DBG_CLK_CTRL, 6, 1, 0,
+			&dbgclk_lock);
 	clks[dbg_trc] = clk_register_gate(NULL, clk_output_name[dbg_trc],
 			"dbg_emio_mux", CLK_SET_RATE_PARENT, SLCR_DBG_CLK_CTRL,
 			0, 0, &dbgclk_lock);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d37e518..8ffe06c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -27,6 +27,7 @@
 #define CLK_IS_ROOT		BIT(4) /* root clk, has no parent */
 #define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
+#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 
 struct clk_hw;
 
-- 
1.8.1.2
