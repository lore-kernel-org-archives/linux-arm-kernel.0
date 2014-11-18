From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 19 Nov 2014 12:37:55 +1300
Subject: [RFC PATCHv4] ARM: mvebu: use dt_fixup to provide fallback for
 enable-method
In-Reply-To: <20141118082151.GX6414@lukather>
References: <20141118082151.GX6414@lukather>
Message-ID: <1416353875-15602-1-git-send-email-chris.packham@alliedtelesis.co.nz>
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
Hi,

For those loosing track

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300182.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300480.html
v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302945.html

(snip)
>>> Instead of inserting something into the device tree I could just call
>>> set_smp_ops here. That might be safer than trying to insert something
>>> into the device tree.
>>
>> I don't think this is necessary. Injecting something in the DT is
>> safe, u-boot does that at every boot :)
>>
>
> Actually I thought a bit more about this option this morning. What I'm
> trying to do is provide a fallback that defines smp_ops when there isn't
> an enable-method in the device tree. I don't actually need do do
> anything to the incoming device tree, I don't even need to look at it. I
> can unconditionally call set_smp_ops() and if the device tree has an
> enable-method it will override whatever has been configured. If the
> device tree doesn't define an enable-method it will use the default that
> I've configured here. That's actually very little code and can all be
> contained in board-v7.c.

I'm pretty happy with this incarnation. It doesn't touch core code. It provides
a fallback for old device trees and it achieves my original goal of allowing
the device tree to configure the smp_ops via the enable-method property. 

 arch/arm/mach-mvebu/board-v7.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index b2524d6..a4ece42 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -184,6 +184,11 @@ static void __init mvebu_dt_init(void)
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
@@ -192,11 +197,11 @@ static const char * const armada_370_xp_dt_compat[] = {
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
