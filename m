From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Oct 2013 15:58:22 +0200
Subject: [PATCH v3 10/14] ARM: mvebu: Set the start address of a CPU in a
 separate function
In-Reply-To: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1381759106-15004-11-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the start (or boot) address of A CPU is no more used only
during SMP bring up, but will also be used by the CPU idle functions
or later by the CPU hot plug ones.

This commit moves it in a separate function and exports it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c         | 10 ++++++++--
 include/linux/armada-370-xp-pmsu.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index d0a02bc..e394f08 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -56,6 +56,13 @@ static struct of_device_id of_pmsu_table[] = {
 	{ /* end of list */ },
 };
 
+void armada_370_xp_pmsu_set_start_addr(void *start_addr, int hw_cpu)
+{
+	writel(virt_to_phys(start_addr), pmsu_mp_base +
+		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+}
+EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_set_start_addr);
+
 #ifdef CONFIG_SMP
 int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 {
@@ -68,8 +75,7 @@ int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 
 	hw_cpu = cpu_logical_map(cpu_id);
 
-	writel(virt_to_phys(boot_addr), pmsu_mp_base +
-			PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+	armada_370_xp_pmsu_set_start_addr(boot_addr, hw_cpu);
 
 	/* Release CPU from reset by clearing reset bit*/
 	reg = readl(pmsu_reset_base + PMSU_RESET_CTL_OFFSET(hw_cpu));
diff --git a/include/linux/armada-370-xp-pmsu.h b/include/linux/armada-370-xp-pmsu.h
index 235a40c..e09977b 100644
--- a/include/linux/armada-370-xp-pmsu.h
+++ b/include/linux/armada-370-xp-pmsu.h
@@ -14,5 +14,6 @@
 void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void);
 void armada_370_xp_pmsu_idle_prepare(bool deepidle);
 void armada_370_xp_pmsu_idle_restore(void);
+void armada_370_xp_pmsu_set_start_addr(void *start_addr, int hw_cpu);
 
 #endif	/* __ARMADA_370_XP__PMSU_H */
-- 
1.8.1.2
