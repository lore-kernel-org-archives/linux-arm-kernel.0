From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Wed, 18 May 2011 10:34:40 +0800
Subject: [PATCH] ARM: fix mistaken dependency for CPU_HAS_PMU
Message-ID: <1305686080-13182-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <tom.leiming@gmail.com>

Obviously it is mistake for CPU_HAS_PMU to depend on
(!ARCH_OMAP3 || OMAP3_EMU).

No mattery it is omap3 or not, we can build pmu.o into
kernel safely. In fact, arm-v7 of omap3 has pmu inside
also.

So fix it that we can build pmu into kernel to support perf
for some valid config(such as enable both omap4 and omap3,
but OMAP3_EMU).

Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-omap at vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..ba314d5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1061,8 +1061,7 @@ config XSCALE_PMU
 	default y
 
 config CPU_HAS_PMU
-	depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU) && \
-		   (!ARCH_OMAP3 || OMAP3_EMU)
+	depends on CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU
 	default y
 	bool
 
-- 
1.7.4.1
