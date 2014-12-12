From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 12 Dec 2014 17:53:55 +1300
Subject: [RFC/PATCH 1/4 PATCH] ARM: mvebu: use dt_fixup to provide
 fallback for enable-method
In-Reply-To: <5488A2C0.5040804@alliedtelesis.co.nz>
References: <5488A2C0.5040804@alliedtelesis.co.nz>
Message-ID: <1418360035-27975-1-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> On 12/10/2014 10:44 PM, Arnd Bergmann wrote:
>> On Wednesday 10 December 2014 15:39:44 Chris Packham wrote:
>>>
>>> +static void __init armada_370_xp_dt_fixup(void)
>>> +{
>>> +       smp_set_ops(smp_ops(armada_xp_smp_ops));
>>> +}
>>> +
>>>
>>
>> The dt_fixup callback pointer is meant to fix up a legacy dtb file in
>> memory. I think this would be fairly easy in this case, just add in the
>> missing enable-method property here to make the normal boot path
>> work for old dtbs.
>>
>>     Arnd
>>
> 
> I briefly explored that approach here[1]. The tricky part would be 
> handling the fact that the enable method can be attached to either the 
> /cpus node or and individual /cpu entry (or is that something I can 
> ignore?).
> 
> In the end I thought that the unconditional setting of smp_ops was 
> easier to implement and would achieve the same result.

Actually as it turns out it's not that hard to implement something that
checks both /cpus and /cpus/cpu at n. I'll include this with the next round
after I've waited for anymore feedback.

---8<---
Subject: [PATCH] ARM: mvebu: use dt_fixup to provide fallback for enable-method

When the device tree doesn't define an enable-method insert a property
into the flattened device tree. arm_dt_init_cpu_maps() will then parse
this an set smp_ops appropriately. Now that we have this fallback it is
no longer necessary to set .smp in the DT_MACHINE definition.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/mach-mvebu/Makefile   |  2 ++
 arch/arm/mach-mvebu/board-v7.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index e24136b..68310f8 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -14,3 +14,5 @@ endif
 obj-$(CONFIG_MACH_DOVE)		 += dove.o
 obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
 obj-$(CONFIG_MACH_NETXBIG)	 += netxbig.o
+
+CFLAGS_board-v7.o = -I$(src)/../../../scripts/dtc/libfdt
\ No newline at end of file
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index d0d39f1..0592c76 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -17,6 +17,8 @@
 #include <linux/clk-provider.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
@@ -198,6 +200,39 @@ static void __init mvebu_dt_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+static void __init armada_370_xp_dt_fixup(void)
+{
+	int offset, node;
+	int i, len;
+	void *prop;
+	char buffer[20];
+
+	offset = fdt_path_offset(initial_boot_params, "/cpus");
+	if (offset < 0)
+		return;
+
+	prop = fdt_getprop(initial_boot_params, offset, "enable-method", &len);
+	if (prop)
+		return;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		snprintf(buffer, sizeof(buffer), "cpu@%d", i);
+		node = fdt_subnode_offset(initial_boot_params, offset, buffer);
+		if (node < 0)
+			break;
+		prop = fdt_getprop(initial_boot_params, node,
+				   "enable-method", &len);
+		if (prop)
+			return;
+	}
+
+	pr_info("No enable-method defined. "
+		"Falling back to \"marvell,armada-xp-smp\"\n");
+
+	fdt_setprop(initial_boot_params, offset, "enable-method",
+		    "marvell,armada-xp-smp", sizeof("marvell,armada-xp-smp"));
+}
+
 static const char * const armada_370_xp_dt_compat[] = {
 	"marvell,armada-370-xp",
 	NULL,
@@ -206,11 +241,11 @@ static const char * const armada_370_xp_dt_compat[] = {
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
