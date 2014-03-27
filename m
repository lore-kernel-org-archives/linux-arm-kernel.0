From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 27 Mar 2014 14:38:05 +0100
Subject: [PATCH 6/6] ARM: mvebu: use a separate function to set the boot
 address of CPUs
In-Reply-To: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1395927485-11842-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Setting the start (or boot) address of a CPU is no more used only
during SMP bring up on Armada 370/XP, but it will also be used by the
CPU idle function of Armada XP, and by the Armada 38x SMP support.

Therefore this commit creates a separate PMSU function to set the boot
address of a CPU with the PMSU.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 4ae3ea1..8361281 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -41,6 +41,12 @@ static struct of_device_id of_pmsu_table[] = {
 	{ /* end of list */ },
 };
 
+static void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
+{
+	writel(virt_to_phys(boot_addr), pmsu_mp_base +
+		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+}
+
 #ifdef CONFIG_SMP
 int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 {
@@ -53,8 +59,7 @@ int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 
 	hw_cpu = cpu_logical_map(cpu_id);
 
-	writel(virt_to_phys(boot_addr), pmsu_mp_base +
-			PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+	mvebu_pmsu_set_cpu_boot_addr(hw_cpu, boot_addr);
 
 	ret = mvebu_cpu_reset_deassert(hw_cpu);
 	if (ret) {
-- 
1.8.3.2
