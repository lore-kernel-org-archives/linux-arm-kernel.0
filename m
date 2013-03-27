From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Wed, 27 Mar 2013 16:21:34 +0100
Subject: [PATCH] ARM: ux500: update V-INTCORE constraints
Message-ID: <1364397694-14126-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update V-INTCORE regulator constraints to allow voltage and
configuration changes from consumer drivers.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
Hi Linus,

this patch adds the regulators bits I'm missing for ux500-musb patches.
Without this I just get a runtime warning like:

V-INTCORE: operation not allowed

but the driver works anyway and there are no build dependencies, so I
think this can safely go in the arm-soc tree on its own, and the whole
thing should work happily in -next.

Thanks,
Fabio

 arch/arm/mach-ux500/board-mop500-regulators.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 2a17bc5..0a428db 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -392,7 +392,15 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 	[AB8500_LDO_INTCORE] = {
 		.constraints = {
 			.name = "V-INTCORE",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.min_uV = 1250000,
+			.max_uV = 1350000,
+			.input_uV = 1800000,
+			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+					  REGULATOR_CHANGE_STATUS |
+					  REGULATOR_CHANGE_MODE |
+					  REGULATOR_CHANGE_DRMS,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL |
+					    REGULATOR_MODE_IDLE,
 		},
 		.num_consumer_supplies = ARRAY_SIZE(ab8500_vintcore_consumers),
 		.consumer_supplies = ab8500_vintcore_consumers,
-- 
1.8.1.3
