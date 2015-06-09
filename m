From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  9 Jun 2015 17:49:58 +0800
Subject: [PATCH v6 2/3] ARM: rockchip: ensure CPU to enter WFI/WFE state
In-Reply-To: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
References: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1433843400-24831-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch can ensure that v7_exit_coherency_flush() in rockchip_cpu_die()
executed in time.
The mdelay(1) has enough time to fix the problem of CPU offlining.
That's a workaround way in rockchip hotplug code,
At least, we haven't a better way to solve it. Who know,
that maybe fixed by chip (hardware) in the future.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v6:
- Fix the delay 1ms describing.
Series-changes: 5
- Fix the patch decription.
- Add the changelog.
Series-changes: 2
- As Kever points out, Fix the subject typo WFI/WFE.

 arch/arm/mach-rockchip/platsmp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index b379cc8..d629206 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -322,6 +322,13 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 #ifdef CONFIG_HOTPLUG_CPU
 static int rockchip_cpu_kill(unsigned int cpu)
 {
+	/*
+	 * We need a delay here to ensure that the dying CPU can finish
+	 * executing v7_coherency_exit() and reach the WFI/WFE state
+	 * prior to having the power domain disabled.
+	 */
+	mdelay(1);
+
 	pmu_set_power_domain(0 + cpu, false);
 	return 1;
 }
-- 
1.9.1
