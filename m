From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 May 2014 10:22:04 -0700
Subject: [PATCH] ARM: exynos: don't run exynos4 l2x0 setup on other platforms
Message-ID: <1401556924-18006-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was caught by a panic on Broadcom mobile platforms.

Note that this code is all going away with the pending l2x0 cleanup
series from Russell, but we need this here until that's landed so we
can enable exynos multiplatform.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-exynos/exynos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index d51d5af7e7df..4800b1ce3d71 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -246,6 +246,9 @@ static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
 
+	if (!soc_is_exynos4())
+		return 0;
+
 	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
 	if (ret)
 		return ret;
-- 
2.0.0.1.g63e6b3d
