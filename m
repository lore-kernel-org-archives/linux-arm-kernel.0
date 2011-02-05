From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 5 Feb 2011 10:08:16 +0800
Subject: [PATCH 5/5] ARM: mxs/mx28evk: add dma device
In-Reply-To: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1296871696-21008-6-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 0b9bb03..c9ac415 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -29,6 +29,7 @@ config MACH_MX28EVK
 	bool "Support MX28EVK Platform"
 	select SOC_IMX28
 	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_DMA
 	select MXS_HAVE_PLATFORM_FEC
 	select MXS_OCOTP
 	default y
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index e8db99f..04ddec1 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -165,6 +165,14 @@ static void __init mx28evk_init(void)
 
 	mx28_add_duart();
 
+	/*
+	 * the order of adding dma device matters here, otherwise
+	 * dma_device.dev_id may differ from mxs_dma_engine.dev_id,
+	 * in which case mxs-dma will fail to probe.
+	 */
+	mx28_add_apbh_dma();
+	mx28_add_apbx_dma();
+
 	if (mx28evk_fec_get_mac())
 		pr_warn("%s: failed on fec mac setup\n", __func__);
 
-- 
1.7.1
