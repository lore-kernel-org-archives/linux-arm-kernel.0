From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 May 2018 17:25:14 +0200
Subject: [PATCH 4/6] ARM: shmobile: r8a7779: Use rcar_sysc_power_{down,
 up}_cpu()
In-Reply-To: <1527693916-11215-1-git-send-email-geert+renesas@glider.be>
References: <1527693916-11215-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1527693916-11215-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r8a7779 SMP code calls rcar_sysc_power_{down,up}() to control power
to the SYSC power areas containing CPUs. This requires passing full CPU
power area parameter blocks.

Migrate the code to call the new rcar_sysc_power_{down,up}_cpu()
helpers, which just take a CPU index, and use the SYSC power area
definitions from the r8a7779-sysc driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 47 +++++-------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index ff1e6fc0b861c4fc..3036f910046118ee 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -31,59 +31,24 @@
 #define AVECR IOMEM(0xfe700040)
 #define R8A7779_SCU_BASE 0xf0000000
 
-static const struct rcar_sysc_ch r8a7779_ch_cpu1 = {
-	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
-	.chan_bit = 1, /* ARM1 */
-	.isr_bit = 1, /* ARM1 */
-};
-
-static const struct rcar_sysc_ch r8a7779_ch_cpu2 = {
-	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
-	.chan_bit = 2, /* ARM2 */
-	.isr_bit = 2, /* ARM2 */
-};
-
-static const struct rcar_sysc_ch r8a7779_ch_cpu3 = {
-	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
-	.chan_bit = 3, /* ARM3 */
-	.isr_bit = 3, /* ARM3 */
-};
-
-static const struct rcar_sysc_ch * const r8a7779_ch_cpu[4] = {
-	[1] = &r8a7779_ch_cpu1,
-	[2] = &r8a7779_ch_cpu2,
-	[3] = &r8a7779_ch_cpu3,
-};
-
 static int r8a7779_platform_cpu_kill(unsigned int cpu)
 {
-	const struct rcar_sysc_ch *ch = NULL;
 	int ret = -EIO;
 
 	cpu = cpu_logical_map(cpu);
-
-	if (cpu < ARRAY_SIZE(r8a7779_ch_cpu))
-		ch = r8a7779_ch_cpu[cpu];
-
-	if (ch)
-		ret = rcar_sysc_power_down(ch);
+	if (cpu)
+		ret = rcar_sysc_power_down_cpu(cpu);
 
 	return ret ? ret : 1;
 }
 
 static int r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	const struct rcar_sysc_ch *ch = NULL;
-	unsigned int lcpu = cpu_logical_map(cpu);
-	int ret;
-
-	if (lcpu < ARRAY_SIZE(r8a7779_ch_cpu))
-		ch = r8a7779_ch_cpu[lcpu];
+	int ret = -EIO;
 
-	if (ch)
-		ret = rcar_sysc_power_up(ch);
-	else
-		ret = -EIO;
+	cpu = cpu_logical_map(cpu);
+	if (cpu)
+		ret = rcar_sysc_power_up_cpu(cpu);
 
 	return ret;
 }
-- 
2.7.4
