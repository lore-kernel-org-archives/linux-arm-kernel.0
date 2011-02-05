From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 5 Feb 2011 10:08:15 +0800
Subject: [PATCH 4/5] ARM: mxs/mx23evk: add dma device
In-Reply-To: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1296871696-21008-5-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx23evk.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index cd2fbdf..0b9bb03 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -19,6 +19,7 @@ config MACH_MX23EVK
 	bool "Support MX23EVK Platform"
 	select SOC_IMX23
 	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_DMA
 	default y
 	help
 	  Include support for MX23EVK platform. This includes specific
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index aa06400..13c22a0 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -37,6 +37,14 @@ static void __init mx23evk_init(void)
 	mxs_iomux_setup_multiple_pads(mx23evk_pads, ARRAY_SIZE(mx23evk_pads));
 
 	mx23_add_duart();
+
+	/*
+	 * the order of adding dma device matters here, otherwise
+	 * dma_device.dev_id may differ from mxs_dma_engine.dev_id,
+	 * in which case mxs-dma will fail to probe.
+	 */
+	mx23_add_apbh_dma();
+	mx23_add_apbx_dma();
 }
 
 static void __init mx23evk_timer_init(void)
-- 
1.7.1
