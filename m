From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 Jan 2016 18:56:22 -0800
Subject: [PATCH] pwm: ftm: use flat regmap cache
Message-ID: <1453344982-4529-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use flat regmap cache to avoid lockdep warning at probe:
[    0.697285] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:2755 lockdep_trace_alloc+0x15c/0x160()
[    0.697449] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))

The RB-tree regmap cache needs to allocate new space on first
writes. However, allocations in an atomic context (e.g. when a
spinlock is held) are not allowed. The function regmap_write
calls map->lock, which acquires a spinlock in the fast_io case.
Since the pwm-fsl-ftm driver uses MMIO, the regmap bus of type
regmap_mmio is being used which has fast_io set to true.

The MMIO space of the pwm-fsl-ftm driver is reasonable condense,
hence using the much faster flat regmap cache is anyway the better
choice.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/pwm/pwm-fsl-ftm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index f9dfc8b..ed39e8e 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -414,7 +414,7 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 
 	.max_register = FTM_PWMLOAD,
 	.volatile_reg = fsl_pwm_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int fsl_pwm_probe(struct platform_device *pdev)
-- 
2.7.0
