From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 19 Oct 2016 21:39:37 +0900
Subject: [PATCH] ARM: mm: add ARM_L1_CACHE_SHIFT_7 for UniPhier outer cache
Message-ID: <1476880777-5068-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier outer cache (arch/arm/mm/cache-uniphier.c) has 128 byte
line length and its tags are also managed per 128 byte line.  This
is very unfortunate, but the current 64 byte alignment for kmalloc()
causes sharing problems on DMA if used with this outer cache.

This commit adds ARM_L1_CACHE_SHIFT_7 to increase the DMA minimum
alignment to 128 byte if CACHE_UNIPHIER is enabled.  There are
several drivers that assume aligning to L1_CACHE_BYTES will be DMA
safe, so this commit also changes the L1_CACHE_BYTES for safety.

Having said that, I hesitate to align all the other SoCs in Multi
platform to the UniPhier's requirement.  So, I am disabling the
CONFIG_CACHE_UNIPHIER by default, so that multi_v7_defconfig will
still with CONFIG_ARM_L1_CACHE_SHIFT=6.  With this, UniPhier SoCs
become a bit slower, but it is much better than system crash.
If desired, the outer-cache can be enabled by the merge_config or
something.

Note:
The UniPhier PH1-Pro5 SoC is equipped also with L3 cache with 256 byte
line size but its tags are managed per 128 byte sub-line.
So, ARM_L1_CACHE_SHIFT_7 should be fine for all the UniPhier SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I threw a question in January this year:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/400289.html

After a long interval, I came back to this topic.


 arch/arm/mm/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c1799dd..f68e8ec 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -991,7 +991,7 @@ config CACHE_TAUROS2
 config CACHE_UNIPHIER
 	bool "Enable the UniPhier outer cache controller"
 	depends on ARCH_UNIPHIER
-	default y
+	select ARM_L1_CACHE_SHIFT_7
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
 	help
@@ -1012,8 +1012,14 @@ config ARM_L1_CACHE_SHIFT_6
 	help
 	  Setting ARM L1 cache line size to 64 Bytes.
 
+config ARM_L1_CACHE_SHIFT_7
+	bool
+	help
+	  Setting ARM L1 cache line size to 128 Bytes.
+
 config ARM_L1_CACHE_SHIFT
 	int
+	default 7 if ARM_L1_CACHE_SHIFT_7
 	default 6 if ARM_L1_CACHE_SHIFT_6
 	default 5
 
-- 
1.9.1
