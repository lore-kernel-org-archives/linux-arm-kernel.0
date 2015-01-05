From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Mon, 5 Jan 2015 07:55:30 +0000
Subject: [PATCH v6 14/17] ARM64 / ACPI: Parse GTDT to initialize arch timer
In-Reply-To: <1420368918-5086-15-git-send-email-hanjun.guo@linaro.org>
Message-ID: <D0CF9C94.CD69%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/15, 04:55, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:

>Using the information presented by GTDT to initialize the arch
>timer (not memory-mapped).
>
>Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>---
> arch/arm64/kernel/time.c             |   7 ++
> drivers/clocksource/arm_arch_timer.c | 132
>++++++++++++++++++++++++++++-------
> include/linux/clocksource.h          |   6 ++
> 3 files changed, 118 insertions(+), 27 deletions(-)
>
>diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
>index 1a7125c..42f9195 100644
>--- a/arch/arm64/kernel/time.c
>+++ b/arch/arm64/kernel/time.c
>@@ -35,6 +35,7 @@
> #include <linux/delay.h>
> #include <linux/clocksource.h>
> #include <linux/clk-provider.h>
>+#include <linux/acpi.h>
> 
> #include <clocksource/arm_arch_timer.h>
> 
>@@ -72,6 +73,12 @@ void __init time_init(void)
> 
> 	tick_setup_hrtimer_broadcast();
> 
>+	/*
>+	 * Since ACPI or FDT will only one be available in the system,
>+	 * we can use acpi_generic_timer_init() here safely
>+	 */
>+	acpi_generic_timer_init();
>+
> 	arch_timer_rate = arch_timer_get_rate();
> 	if (!arch_timer_rate)
> 		panic("Unable to initialise architected timer.\n");
>diff --git a/drivers/clocksource/arm_arch_timer.c
>b/drivers/clocksource/arm_arch_timer.c
>index 6a79fc4..612f2a0 100644
>--- a/drivers/clocksource/arm_arch_timer.c
>+++ b/drivers/clocksource/arm_arch_timer.c
>@@ -21,6 +21,7 @@
> #include <linux/io.h>
> #include <linux/slab.h>
> #include <linux/sched_clock.h>
>+#include <linux/acpi.h>
> 
> #include <asm/arch_timer.h>
> #include <asm/virt.h>
>@@ -370,8 +371,12 @@ arch_timer_detect_rate(void __iomem *cntbase, struct
>device_node *np)
> 	if (arch_timer_rate)
> 		return;
> 
>-	/* Try to determine the frequency from the device tree or CNTFRQ */
>-	if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
>+	/*
>+	 * Try to determine the frequency from the device tree or CNTFRQ,
>+	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
>+	 */
>+	if (!acpi_disabled ||
>+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
> 		if (cntbase)
> 			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
> 		else
>@@ -690,28 +695,8 @@ static void __init arch_timer_common_init(void)
> 	arch_timer_arch_init();
> }
> 
>-static void __init arch_timer_init(struct device_node *np)
>+static void __init arch_timer_init(void)
> {
>-	int i;
>-
>-	if (arch_timers_present & ARCH_CP15_TIMER) {
>-		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
>-		return;
>-	}
>-
>-	arch_timers_present |= ARCH_CP15_TIMER;
>-	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
>-		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
>-	arch_timer_detect_rate(NULL, np);
>-
>-	/*
>-	 * If we cannot rely on firmware initializing the timer registers then
>-	 * we should use the physical timers instead.
>-	 */
>-	if (IS_ENABLED(CONFIG_ARM) &&
>-	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>-			arch_timer_use_virtual = false;
>-
> 	/*
> 	 * If HYP mode is available, we know that the physical timer
> 	 * has been configured to be accessible from PL1. Use it, so
>@@ -730,13 +715,39 @@ static void __init arch_timer_init(struct
>device_node *np)
> 		}
> 	}
> 
>-	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>-
> 	arch_timer_register();
> 	arch_timer_common_init();
> }
>-CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer",
>arch_timer_init);
>-CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer",
>arch_timer_init);
>+
>+static void __init arch_timer_of_init(struct device_node *np)
>+{
>+	int i;
>+
>+	if (arch_timers_present & ARCH_CP15_TIMER) {
>+		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
>+		return;
>+	}
>+
>+	arch_timers_present |= ARCH_CP15_TIMER;
>+	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
>+		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
>+
>+	arch_timer_detect_rate(NULL, np);
>+
>+	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>+
>+	/*
>+	 * If we cannot rely on firmware initializing the timer registers then
>+	 * we should use the physical timers instead.
>+	 */
>+	if (IS_ENABLED(CONFIG_ARM) &&
>+	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>+			arch_timer_use_virtual = false;
>+
>+	arch_timer_init();
>+}
>+CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer",
>arch_timer_of_init);
>+CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer",
>arch_timer_of_init);

Hanjun,

FYI, it seems that the tree that you have rebased the patch series has an
issue determining clocksource in ARM64 introduced by this commit.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0
b46b8a718c6e90910a1b1b0fe797be3c167e186

Here is the fix from Catalin that already went upstream:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drive
rs/clocksource/arm_arch_timer.c?id=d6ad36913083d683aad4e02e53580c995f1a6ede

Thanks,

Suravee
