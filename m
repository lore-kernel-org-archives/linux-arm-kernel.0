From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 Apr 2018 16:25:47 +0100
Subject: [PATCH] arm64: Select ARCH_HAS_FAST_MULTIPLIER
Message-ID: <877b532d8d240c1d9e9db923c84b924443a218ed.1524583390.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is probably safe to assume that all Armv8-A implementations have a
multiplier whose efficiency is comparable or better than a sequence of
three or so register-dependent arithmetic instructions. Select
ARCH_HAS_FAST_MULTIPLIER to get ever-so-slightly nicer codegen in the
few dusty old corners which care.

In a contrived benchmark calling hweight64() in a loop, this does indeed
turn out to be a small win overall, with no measurable impact on
Cortex-A57 but about 5% performance improvement on Cortex-A53.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Apropos of stumbling across this option whilst digging down into some
bitmap-juggling code...

 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..9c850f3b398f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -12,6 +12,7 @@ config ARM64
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
-- 
2.17.0.dirty
