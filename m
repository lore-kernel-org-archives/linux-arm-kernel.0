From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Nov 2016 11:38:50 -0800
Subject: [PATCH] iommu: mtk: add common-clk dependency
In-Reply-To: <20161116152837.3508723-1-arnd@arndb.de>
References: <20161116152837.3508723-1-arnd@arndb.de>
Message-ID: <20161116193850.GK25626@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16, Arnd Bergmann wrote:
> After the MT2701 clock driver was added, we get a harmless warning for
> the iommu driver that selects it, when compile-testing without
> COMMON_CLK.
> 
> warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK)
> 
> Adding a dependency on COMMON_CLK avoids the warning.
> 
> Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hm.. why is an iommu driver selecting a clk driver? They should
be using standard clk APIs so it's not like they need it for
build time correctness. Shouldn't we drop the selects instead?
Those look to have been introduced a few kernel versions ago, but
they were selecting options that didn't exist until a few days
ago when I merged the mediatek clk driver. The clk options are
user-visible, so it should be possible to select them in the
configuration phase.

----8<----
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8ee54d71c7eb..37e204f3d9be 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -352,9 +352,6 @@ config MTK_IOMMU_V1
 	select IOMMU_API
 	select MEMORY
 	select MTK_SMI
-	select COMMON_CLK_MT2701_MMSYS
-	select COMMON_CLK_MT2701_IMGSYS
-	select COMMON_CLK_MT2701_VDECSYS
 	help
 	  Support for the M4U on certain Mediatek SoCs. M4U generation 1 HW is
 	  Multimedia Memory Managememt Unit. This option enables remapping of

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
