From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  7 Nov 2014 15:33:46 +1300
Subject: [RFC PATCHv2] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <20141106201603.GF4974@lunn.ch>
References: <20141106201603.GF4974@lunn.ch>
Message-ID: <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The machine specific SMP operations can be configured either via
setup_arch or via arm_dt_init_cpu_maps. For the ARMADA_370_XP_DT devices
both of these are called and setup_arch wins because it is called last.
This means that it is not possible to substitute a different set of SMP
operations via the device-tree.

For the ARMADA_370_XP_DT compatible devices add a smp_init function that
detects if the device tree has an enable-method defined. If it does
return true to indicate that the smp_ops have already been set which
will prevent setup_arch from overriding them.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Hi,

On 11/07/2014 09:16 AM, Andrew Lunn wrote:
>> Darn. I thought that might be the case but I wanted to keep the scope of
>> my change small. How about making setup_arch check if smp_ops is already
>> set?
> 
> I think that would be last resort solution. Try not to touch core code
> unless you really have to.
> 
>> Alternatively if we gave ARMADA_370_XP_DT a smp_init function that
>> returned non-zero if smp_ops is already set then I think it'd be
>> backwards compatible and keep the scope of the change restricted to
>> the 370-XP platforms.
> 
> This sounds more reasonable.
> 
>       Andrew
> 

So here's my next attempt at a patch that is backwards compatible but allows
the device tree to determine smp_ops. The device-tree searching was borrowed
from arm_dt_init_cpu_maps which is probably an indication that I'm duplicating
something that perhaps I shouldn't.

I have reservations about the fact that my code is active upon the device-tree
having and enable-method rather than the combination of the device tree having
the method and the kernel having that method declared. 

I'm also not sure that this is the intended use of the smp_init callback (a
quick grep through Documentation/ doesn't yield any hits and asm/mach/arch.h
doesn't say anything either) but nobody seemed to object when I proposed this
usage.

For v3 I wonder if I should just add a getter for smp_ops and have
armada_smp_init just use that or perhaps have a flag that is set by
set_smp_ops_by_method when it knows that the enable-method is something we can
use. Or perhaps I'm over-thinking things :).

Thanks,
Chris

 arch/arm/mach-mvebu/board-v7.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 6478626..7e79eb1 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -198,6 +198,31 @@ static void __init mvebu_dt_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+static bool __init armada_smp_init(void)
+{
+	struct device_node *cpu, *cpus;
+	int len;
+	bool found_method = false;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (!cpus)
+		return false;
+
+	for_each_child_of_node(cpus, cpu) {
+		if (of_node_cmp(cpu->type, "cpu"))
+			continue;
+		if (of_find_property(cpu, "enable-method", &len))
+			found_method = true;
+	}
+
+	/* Fallback to an enable-method in the cpus node */
+	if (!found_method)
+		if (of_find_property(cpus, "enable-method", &len))
+			found_method = true;
+
+	return found_method;
+}
+
 static const char * const armada_370_xp_dt_compat[] = {
 	"marvell,armada-370-xp",
 	NULL,
@@ -206,6 +231,7 @@ static const char * const armada_370_xp_dt_compat[] = {
 DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
+	.smp_init	= armada_smp_init,
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= mvebu_dt_init,
 	.init_irq       = mvebu_init_irq,
-- 
2.2.0.rc0
