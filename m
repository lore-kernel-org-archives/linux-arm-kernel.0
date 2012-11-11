From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:33 +0530
Subject: [PATCH 11/14] ARM: SPEAr1310: Fix AUXDATA for compact flash controller
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <4d8f93cb25c6d29c20972e3b1fd8945c299034a5.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

This patch fixes the platform data for compact flash controller.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear13xx/spear1310.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 451f3b1..02f4724 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -15,6 +15,7 @@
 
 #include <linux/amba/pl022.h>
 #include <linux/of_platform.h>
+#include <linux/pata_arasan_cf_data.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -32,6 +33,12 @@
 #define SPEAR1310_RAS_BASE			UL(0xD8400000)
 #define VA_SPEAR1310_RAS_BASE			IOMEM(UL(0xFA400000))
 
+static struct arasan_cf_pdata cf_pdata = {
+	.cf_if_clk = CF_IF_CLK_166M,
+	.quirk = CF_BROKEN_UDMA,
+	.dma_priv = &cf_dma_priv,
+};
+
 /* ssp device registration */
 static struct pl022_ssp_controller ssp1_plat_data = {
 	.enable_dma = 0,
@@ -39,7 +46,7 @@ static struct pl022_ssp_controller ssp1_plat_data = {
 
 /* Add SPEAr1310 auxdata to pass platform data */
 static struct of_dev_auxdata spear1310_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_dma_priv),
+	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_pdata),
 	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
 	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
 	OF_DEV_AUXDATA("arm,pl022", SSP_BASE, NULL, &pl022_plat_data),
-- 
1.7.12.rc2.18.g61b472e
