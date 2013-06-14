From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:48 +0200
Subject: [PATCH 12/28] ARM: EXYNOS: firmware: Remove check for device tree
 presence
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-13-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the firmware setup code assume presence of DT, since it
is now the only way of booting supported for Exynos.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index ed11f10..932129e 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -48,20 +48,18 @@ static const struct firmware_ops exynos_firmware_ops = {
 
 void __init exynos_firmware_init(void)
 {
-	if (of_have_populated_dt()) {
-		struct device_node *nd;
-		const __be32 *addr;
+	struct device_node *nd;
+	const __be32 *addr;
 
-		nd = of_find_compatible_node(NULL, NULL,
-						"samsung,secure-firmware");
-		if (!nd)
-			return;
+	nd = of_find_compatible_node(NULL, NULL,
+					"samsung,secure-firmware");
+	if (!nd)
+		return;
 
-		addr = of_get_address(nd, 0, NULL, NULL);
-		if (!addr) {
-			pr_err("%s: No address specified.\n", __func__);
-			return;
-		}
+	addr = of_get_address(nd, 0, NULL, NULL);
+	if (!addr) {
+		pr_err("%s: No address specified.\n", __func__);
+		return;
 	}
 
 	pr_info("Running under secure firmware.\n");
-- 
1.8.2.1
