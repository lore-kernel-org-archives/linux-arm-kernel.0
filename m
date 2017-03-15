From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 15 Mar 2017 13:31:51 +0000
Subject: [PATCH 1/5] ARM: tegra: WARN if flowctrl is not supported
In-Reply-To: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
References: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1489584715-23138-2-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we fail to map the IO space for the Tegra flowctrl module in
tegra_flowctrl_init(), then if any of the public APIs for the Tegra
flowctrl driver are called we still still attempt to access the
hardware. Fix this by only accessing the hardware if the
'tegra_flowctrl_base' address has not been setup correctly and warn
if we attempt to access the hardware when it has not.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-tegra/flowctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index 475e783992fd..40b15e39f849 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -47,6 +47,9 @@ static void __iomem *tegra_flowctrl_base;
 
 static void flowctrl_update(u8 offset, u32 value)
 {
+	if (WARN_ONCE(!tegra_flowctrl_base, "Tegra flowctrl not supported!"))
+		return;
+
 	writel(value, tegra_flowctrl_base + offset);
 
 	/* ensure the update has reached the flow controller */
@@ -58,6 +61,9 @@ u32 flowctrl_read_cpu_csr(unsigned int cpuid)
 {
 	u8 offset = flowctrl_offset_cpu_csr[cpuid];
 
+	if (WARN_ONCE(!tegra_flowctrl_base, "Tegra flowctrl not supported!"))
+		return 0;
+
 	return readl(tegra_flowctrl_base + offset);
 }
 
-- 
2.7.4
