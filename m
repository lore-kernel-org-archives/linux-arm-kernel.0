From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue,  9 Oct 2018 17:33:57 +0200
Subject: [PATCH] config: arm: exynos: remove PROVE_LOCKING from defconfig
References: <CGME20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a@eucas1p1.samsung.com>
Message-ID: <20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
bus transactions.

On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
The overhead can be measures using hackbench test which will speed up
by x3 times (11sec -> 3.4sec).
When you check transaction on cache or buses, the results are way higher
than normal for the same hackbench test:
L1d cache invalidations: 26mln vs 4mln
L2u cache invalidations: 42mln vs 12mln
bus cyc/access: 30cyc/access vs. 20cyc/access
context switch is x3 times cheaper

Enable this option only when you have some locking issue to investigate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 27ea6dfc..fbf52f3 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -324,7 +324,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DETECT_HUNG_TASK is not set
-CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_RSA=m
-- 
2.7.4
