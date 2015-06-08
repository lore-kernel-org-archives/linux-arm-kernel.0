From: wxt@rock-chips.com (Caesar Wang)
Date: Mon,  8 Jun 2015 15:11:35 +0800
Subject: [PATCH v5 2/3] ARM: rockchip: ensure CPU to enter WFI/WFE state
In-Reply-To: <1433747496-7642-1-git-send-email-wxt@rock-chips.com>
References: <1433747496-7642-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1433747496-7642-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch can ensure that v7_exit_coherency_flush() in rockchip_cpu_die()
executed in time.
The mdelay(1) has enough time to fix the problem of CPU offlining.
That's a workaround way in rockchip hotplug code,
At least, we haven't a better way to solve it. Who know,
that maybe fixed by chip (hardware) in the future.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Changes in v5:
    - Fix the patch decription.
    - Add the changelog.

Changes in v4: None

Changes in v3: None

Changes in v2: None

Changes in v2:
    - As Kever points out, Fix the subject typo WFI/WFE.

---

 arch/arm/mach-rockchip/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index bd40852..5bc2a89 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -321,6 +321,9 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 #ifdef CONFIG_HOTPLUG_CPU
 static int rockchip_cpu_kill(unsigned int cpu)
 {
+	/* ensure CPU can enter the WFI/WFE state */
+	mdelay(1);
+
 	pmu_set_power_domain(0 + cpu, false);
 	return 1;
 }
-- 
1.9.1
