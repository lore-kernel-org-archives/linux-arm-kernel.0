From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 14 Oct 2013 10:32:57 -0700
Subject: [PATCH v2 4/4] ARM: keystone: add PM bus support for clock
 management
In-Reply-To: <5257431A.5090301@ti.com> (Santosh Shilimkar's message of "Thu,
 10 Oct 2013 20:15:22 -0400")
References: <1377819404-9671-1-git-send-email-santosh.shilimkar@ti.com>
 <1377819404-9671-5-git-send-email-santosh.shilimkar@ti.com>
 <5257431A.5090301@ti.com>
Message-ID: <87hacj92ra.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Thursday 29 August 2013 07:36 PM, Santosh Shilimkar wrote:
>> Add runtime PM core support to Keystone SOCs by using the pm_clk
>> infrastructure of the PM core. Patch is based on Kevin's pm_domain
>> work on DaVinci SOCs.
>> 
>> Keystone SOC doesn't have depedency to enable clocks in early
>> in the boot and hence the clock and PM bus initialisation is done
>> at subsys_init() level.
>> 
>> Cc: Kevin Hilman <khilman@linaro.org>
>> 
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
> For record, updated patch end of the email as discussed here [1]

Unfortunately, this one broke boot for muilti_v7_defconfig:

   http://lists.linaro.org/pipermail/kernel-build-reports/2013-October/000652.html

[...]

> +int __init keystone_pm_runtime_init(void)
> +{
> +	of_clk_init(NULL);
> +	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
> +
> +	return 0;
> +}
> +subsys_initcall(keystone_pm_runtime_init);

The reason is this initcall which runs on *all* platforms, so needs some
sort of platform specific check.  

The patch below does the trick, but I'm not sure if you want to match on
something more specific for this check.  If you're OK, with this, I'll
add it to next/soc with your ack.

Kevin

>From 435ed298c804048548276b60fd5efdf697f6b82f Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@linaro.org>
Date: Mon, 14 Oct 2013 10:30:11 -0700
Subject: [PATCH] ARM: keystone: fix PM domain initcall to be keystone only

initcalls need to have platform specific checks so they are not run in
multi-platform builds.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/mach-keystone/pm_domain.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index beac3fb..2962523 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -17,6 +17,7 @@
 #include <linux/pm_clock.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/of.h>
 
 #ifdef CONFIG_PM_RUNTIME
 static int keystone_pm_runtime_suspend(struct device *dev)
@@ -60,8 +61,19 @@ static struct pm_clk_notifier_block platform_domain_notifier = {
 	.pm_domain = &keystone_pm_domain,
 };
 
+static struct of_device_id of_keystone_table[] = {
+	{.compatible = "ti,keystone"},
+	{ /* end of list */ },
+};
+
 int __init keystone_pm_runtime_init(void)
 {
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, of_keystone_table);
+	if (!np)
+		return 0;
+
 	of_clk_init(NULL);
 	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
 
-- 
1.8.3
