From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  5 Jun 2015 12:47:55 +0800
Subject: [PATCH 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1433479677-18086-1-git-send-email-wxt@rock-chips.com>
References: <1433479677-18086-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1433479677-18086-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general, the correct flow is:

cpu off:
    reset_control_assert
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))

cpu on:
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
    reset_control_deassert

You can repro it with bringing CPU up and down.
Says:(test scripts)

    cd /sys/devices/system/cpu/
    for i in $(seq 1000); do
    echo "================= $i ============"
        for j in $(seq 100); do
            while [[ "$(cat cpu1/online)$(cat cpu2/online)$(cat cpu3/online)" != "000" ]]; do
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

The following is reproducile log:
[34466.186812] PM: noirq suspend of devices complete after 0.669 msecs
[34466.186824] Disabling non-boot CPUs ...
[34466.187509] CPU1: shutdown
[34466.188672] CPU2: shutdown
[34473.736627] Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 0
[34473.736646] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 3.14.0 #1
[34473.736687] [<c010dfb0>] (unwind_backtrace) from [<c010a460>] (show_stack+0x20/0x24)
[34473.736711] [<c010a460>] (show_stack) from [<c0630670>] (dump_stack+0x70/0x8c)
[34473.736731] [<c0630670>] (dump_stack) from [<c062fa0c>] (panic+0xa8/0x1fc)
[34473.736754] [<c062fa0c>] (panic) from [<c0191efc>] (watchdog_timer_fn+0x234/0x26c)
[34473.736777] [<c0191efc>] (watchdog_timer_fn) from [<c014103c>] (__run_hrtimer+0x118/0x1e0)
[34473.736797] [<c014103c>] (__run_hrtimer) from [<c0141c04>] (hrtimer_interrupt+0x148/0x2a0)
[34473.736820] [<c0141c04>] (hrtimer_interrupt) from [<c04d9994>] (arch_timer_handler_phys+0x38/0x48)
[34473.736844] [<c04d9994>] (arch_timer_handler_phys) from [<c016acc4>] (handle_percpu_devid_irq+0xb8/0x124)
[34473.736867] [<c016acc4>] (handle_percpu_devid_irq) from [<c0166a30>] (generic_handle_irq+0x30/0x40)
[34473.736887] [<c0166a30>] (generic_handle_irq) from [<c0166d28>] (__handle_domain_irq+0x8c/0xb0)
[34473.736905] [<c0166d28>] (__handle_domain_irq) from [<c01003a0>] (gic_handle_irq+0x48/0x6c)
[34473.736922] [<c01003a0>] (gic_handle_irq) from [<c010b040>] (__irq_svc+0x40/0x50)
[34473.736936] Exception stack(0xee127f70 to 0xee127fb8)
[34473.736948] 7f60:                                     ffffffed 00000000 2dd6d000 00000000
[34473.736964] 7f80: ee126000 00000015 c0b46bac c0b46bac 0000406a 410fc0d1 00000000 ee127fc4
[34473.736979] 7fa0: ee127fb8 ee127fb8 c0107038 c010703c 600f0013 ffffffff
[34473.736995] [<c010b040>] (__irq_svc) from [<c010703c>] (arch_cpu_idle+0x40/0x48)
[34473.737013] [<c010703c>] (arch_cpu_idle) from [<c0166978>] (cpu_startup_entry+0x170/0x1d0)
[34473.737031] [<c0166978>] (cpu_startup_entry) from [<c010c254>] (secondary_start_kernel+0x138/0x160)
[34473.737059] [<c010c254>] (secondary_start_kernel) from [<00100464>] (0x100464)
[34474.903740] SMP: failed to stop secondary CPUs
[34476.099964] SMP: failed to stop secondary CPUs
...

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/mach-rockchip/platsmp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 5b4ca3c..1230d3d 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -88,20 +88,17 @@ static int pmu_set_power_domain(int pd, bool on)
 			return PTR_ERR(rstc);
 		}
 
-		if (on)
+		if (on) {
+			regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
 			reset_control_deassert(rstc);
-		else
+		} else {
 			reset_control_assert(rstc);
+			regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
+		}
 
 		reset_control_put(rstc);
 	}
 
-	ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
-	if (ret < 0) {
-		pr_err("%s: could not update power domain\n", __func__);
-		return ret;
-	}
-
 	ret = -1;
 	while (ret != on) {
 		ret = pmu_power_domain_is_on(pd);
-- 
1.9.1
