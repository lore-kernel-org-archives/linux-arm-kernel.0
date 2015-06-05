From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  5 Jun 2015 23:11:42 +0800
Subject: [PATCH v3 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1433517104-7595-1-git-send-email-wxt@rock-chips.com>
References: <1433517104-7595-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1433517104-7595-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need different orderings when turning a core on and turning a core
off.  In one case we need to assert reset before turning power off.
In ther other case we need to turn power on and the deassert reset.

In general, the correct flow is:

CPU off:
    reset_control_assert
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))
CPU on:
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
    reset_control_deassert

This is needed for stressing CPU up/down, as per:
    cd /sys/devices/system/cpu/
    for i in $(seq 1000); do
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

The following is reproducile log:
    [34466.186812] PM: noirq suspend of devices complete after 0.669 msecs
    [34466.186824] Disabling non-boot CPUs ...
    [34466.187509] CPU1: shutdown
    [34466.188672] CPU2: shutdown
    [34473.736627] Kernel panic - not syncing:Watchdog detected hard LOCKUP on cpu 0
    .......

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/mach-rockchip/platsmp.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 5b4ca3c..25da16f 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -88,18 +88,24 @@ static int pmu_set_power_domain(int pd, bool on)
 			return PTR_ERR(rstc);
 		}
 
-		if (on)
-			reset_control_deassert(rstc);
-		else
+		if (!on)
 			reset_control_assert(rstc);
 
-		reset_control_put(rstc);
-	}
+		ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
+		if (ret < 0) {
+			pr_err("%s: could not update power domain\n", __func__);
+			reset_control_put(rstc);
+			return ret;
+		}
 
-	ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
-	if (ret < 0) {
-		pr_err("%s: could not update power domain\n", __func__);
-		return ret;
+		if (on)
+			reset_control_deassert(rstc);
+	} else {
+		ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
+		if (ret < 0) {
+			pr_err("%s: could not update power domain\n", __func__);
+			return ret;
+		}
 	}
 
 	ret = -1;
-- 
1.9.1
