From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 4 Sep 2011 11:01:12 +0200
Subject: [PATCH] ARM: l2x0: make sure I&D are not locked down on init
Message-ID: <1315126872-3290-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Fighting unfixed U-Boots and other beasts that may the cache in
a locked-down state when starting the kernel, we make sure to
disable all cache lock-down when initializing the l2x0 so we
are in a known state.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Adrian Bunk <adrian.bunk@movial.com>
Cc: Rob Herring <robherring2@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reported-by: Jan Rinze <janrinze@gmail.com>
Tested-by: Robert Marklund <robert.marklund@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/cache-l2x0.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 44c0867..b03c835 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -338,6 +338,10 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 		writel_relaxed(1, l2x0_base + L2X0_CTRL);
 	}
 
+	/* Make sure that I&D is not locked down when starting */
+	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D);
+	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I);
+
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
-- 
1.7.3.2
