From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Dec 2014 15:39:44 +1300
Subject: [RFC/PATCH 1/4] ARM: mvebu: use dt_fixup to provide fallback for
 enable-method
In-Reply-To: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <1418179187-18486-2-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to maintain backwards compatibility with device trees that don't
define an enable method. At the same time we want the device tree to be
able to specify an enable-method and have it stick.

Previously by having smp assigned in the DT_MACHINE definition this
would be picked up by setup_arch() and override whatever
arm_dt_init_cpu_maps() had configured. Now we move the initial
assignment of default smp_ops to a dt_fixup and let
arm_dt_init_cpu_maps() override that if the device tree defines an
enable-method.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

This didn't get much attention last time and is unchanged from v4. I'm
pretty happy with this incarnation. It doesn't touch core code. It
provides a fallback for old device trees and it achieves my original
goal of allowing the device tree to configure the smp_ops via the
enable-method property.

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300182.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300480.html
v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302945.html
v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303899.html

 arch/arm/mach-mvebu/board-v7.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index d0d39f1..ce23c6a 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -198,6 +198,11 @@ static void __init mvebu_dt_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+static void __init armada_370_xp_dt_fixup(void)
+{
+	smp_set_ops(smp_ops(armada_xp_smp_ops));
+}
+
 static const char * const armada_370_xp_dt_compat[] = {
 	"marvell,armada-370-xp",
 	NULL,
@@ -206,11 +211,11 @@ static const char * const armada_370_xp_dt_compat[] = {
 DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= mvebu_dt_init,
 	.init_irq       = mvebu_init_irq,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_compat,
+	.dt_fixup	= armada_370_xp_dt_fixup,
 MACHINE_END
 
 static const char * const armada_375_dt_compat[] = {
-- 
2.2.0.rc0
