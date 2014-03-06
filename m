From: s-anna@ti.com (Suman Anna)
Date: Wed, 5 Mar 2014 18:24:12 -0600
Subject: [PATCH 03/10] ARM: OMAP2+: change the ISP device archdata MMU name
 for DT
In-Reply-To: <1394065459-16409-1-git-send-email-s-anna@ti.com>
References: <1394065459-16409-1-git-send-email-s-anna@ti.com>
Message-ID: <1394065459-16409-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOMMU DT adaptation support uses the device name instead
of an iommu object name. Fixup the ISP device archdata MMU
name at runtime if using DT-boot. This allows the OMAP3 camera
to be functional in both legacy and DT boots. The iommu object
names should eventually vanish when all the IOMMU users have
been converted to DT nodes.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/devices.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 0dd6398..e58609b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -229,6 +229,9 @@ static struct omap_iommu_arch_data omap3_isp_iommu = {
 
 int omap3_init_camera(struct isp_platform_data *pdata)
 {
+	if (of_have_populated_dt())
+		omap3_isp_iommu.name = "480bd400.mmu";
+
 	omap3isp_device.dev.platform_data = pdata;
 	omap3isp_device.dev.archdata.iommu = &omap3_isp_iommu;
 
-- 
1.9.0
