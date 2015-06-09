From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  9 Jun 2015 17:49:57 +0800
Subject: [PATCH v6 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
References: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1433843400-24831-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need different orderings when turning a core on and turning a core
off.  In one case we need to assert reset before turning power off.
In ther other case we need to turn power on and the deassert reset.

In general, the correct flow is:

CPU off:
    reset_control_assert
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))
    wait_for_power_domain_to_turn_off
CPU on:
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
    wait_for_power_domain_to_turn_on
    reset_control_deassert

This is needed for stressing CPU up/down, as per:
    cd /sys/devices/system/cpu/
    for i in $(seq 10000); do
        echo "================= $i ============"
        for j in $(seq 100); do
            while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" != "000"" ]]
                echo 0 > cpu1/online
                echo 0 > cpu2/online
                echo 0 > cpu3/online
            done
            while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" != "111" ]]; do
                echo 1 > cpu1/online
                echo 1 > cpu2/online
                echo 1 > cpu3/online
            done
        done
    done

The following is reproducable log:
    [34466.186812] PM: noirq suspend of devices complete after 0.669 msecs
    [34466.186824] Disabling non-boot CPUs ...
    [34466.187509] CPU1: shutdown
    [34466.188672] CPU2: shutdown
    [34473.736627] Kernel panic - not syncing:Watchdog detected hard LOCKUP on cpu 0
    .......
or others similar log:
    .......
    [ 4072.454453] CPU1: shutdown
    [ 4072.504436] CPU2: shutdown
    [ 4072.554426] CPU3: shutdown
    [ 4072.577827] CPU1: Booted secondary processor
    [ 4072.582611] CPU2: Booted secondary processor
    <hang>

    Tested by cpu up/down scripts, the results told us need delay more time
before write the sram. The wait time is affected by many aspects
(e.g: cpu frequency, bootrom frequency, sram frequency, bus speed, ...).

    Although the cpus other than cpu0 will write the sram, the speedy is
no the same as cpu0, if the cpu0 early wake up, perhaps the other cpus
can't startup. As we know, the cpu0 can wake up when the cpu1/2/3 write
the 'sram+4/8' and send the sev.
    Anyway.....
    At the moment, 1ms delay will be happy work for cpu up/down scripts test.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>

---

Changes in v6:
- As Russell suggestion, detect whether of_reset_control_get() failed
- add the comment for 1ms delay.
Series-changes: 5
- back to v2 cpu on/off flow, As Heiko point out in patch v3.
- delay more time in rockchip_boot_secondary().
  From CPU up/down tests, Needed more time to complete CPU process.
  In order to ensure a more, Here that be delayed 1ms.
Series-changes: 4
- Add reset_control_put(rstc) for the non-error case.
Series-changes: 3
- FIx the PATCH v2, it doesn't work on chromium 3.14.
Series-changes: 2
- As Heiko suggestion, re-adjust the cpu on/off flow.
  CPU off:
    reset_control_assert
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))
    wait_for_power_domain_to_turn_off
  CPU on:
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
    wait_for_power_domain_to_turn_on
    reset_control_deassert

 arch/arm/mach-rockchip/platsmp.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 5b4ca3c..b379cc8 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -72,29 +72,22 @@ static struct reset_control *rockchip_get_core_reset(int cpu)
 static int pmu_set_power_domain(int pd, bool on)
 {
 	u32 val = (on) ? 0 : BIT(pd);
+	struct reset_control *rstc = rockchip_get_core_reset(pd);
 	int ret;
 
+	if (IS_ERR(rstc) && read_cpuid_part() != ARM_CPU_PART_CORTEX_A9) {
+		pr_err("%s: could not get reset control for core %d\n",
+		       __func__, pd);
+		return PTR_ERR(rstc);
+	}
+
 	/*
 	 * We need to soft reset the cpu when we turn off the cpu power domain,
 	 * or else the active processors might be stalled when the individual
 	 * processor is powered down.
 	 */
-	if (read_cpuid_part() != ARM_CPU_PART_CORTEX_A9) {
-		struct reset_control *rstc = rockchip_get_core_reset(pd);
-
-		if (IS_ERR(rstc)) {
-			pr_err("%s: could not get reset control for core %d\n",
-			       __func__, pd);
-			return PTR_ERR(rstc);
-		}
-
-		if (on)
-			reset_control_deassert(rstc);
-		else
-			reset_control_assert(rstc);
-
-		reset_control_put(rstc);
-	}
+	if (!IS_ERR(rstc) && !on)
+		reset_control_assert(rstc);
 
 	ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
 	if (ret < 0) {
@@ -112,6 +105,12 @@ static int pmu_set_power_domain(int pd, bool on)
 		}
 	}
 
+	if (!IS_ERR(rstc)) {
+		if (on)
+			reset_control_deassert(rstc);
+		reset_control_put(rstc);
+	}
+
 	return 0;
 }
 
@@ -147,8 +146,12 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 		 * the mailbox:
 		 * sram_base_addr + 4: 0xdeadbeaf
 		 * sram_base_addr + 8: start address for pc
+		 * The cpu0 need to wait the other cpus other than cpu0 entering
+		 * the wfe state.The wait time is affected by many aspects.
+		 * (e.g: cpu frequency, bootrom frequency, sram frequency, ...)
 		 * */
-		udelay(10);
+		mdelay(1); /* ensure the cpus other than cpu0 to startup */
+
 		writel(virt_to_phys(rockchip_secondary_startup),
 			sram_base_addr + 8);
 		writel(0xDEADBEAF, sram_base_addr + 4);
-- 
1.9.1
