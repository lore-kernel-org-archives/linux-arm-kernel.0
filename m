From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  3 Jun 2013 11:53:52 +0200
Subject: [PATCH] zynq: Not to rewrite jump code when starting address is 0x0
Message-ID: <7f0e7852622e72e0e3cb9ccec0b6409b8e32e530.1370253191.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This configuration is used by remoteproc.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/platsmp.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 5fc167e..023f225 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -53,34 +53,34 @@ int __cpuinit zynq_cpun_start(u32 address, int cpu)
 						&zynq_secondary_trampoline;

 		zynq_slcr_cpu_stop(cpu);
-
-		if (__pa(PAGE_OFFSET)) {
-			zero = ioremap(0, trampoline_code_size);
-			if (!zero) {
-				pr_warn("BOOTUP jump vectors not accessible\n");
-				return -1;
+		if (address) {
+			if (__pa(PAGE_OFFSET)) {
+				zero = ioremap(0, trampoline_code_size);
+				if (!zero) {
+					pr_warn("BOOTUP jump vectors not accessible\n");
+					return -1;
+				}
+			} else {
+				zero = (__force u8 __iomem *)PAGE_OFFSET;
 			}
-		} else {
-			zero = (__force u8 __iomem *)PAGE_OFFSET;
-		}
-
-		/*
-		 * This is elegant way how to jump to any address
-		 * 0x0: Load address at 0x8 to r0
-		 * 0x4: Jump by mov instruction
-		 * 0x8: Jumping address
-		 */
-		memcpy((__force void *)zero, &zynq_secondary_trampoline,
-						trampoline_size);
-		writel(address, zero + trampoline_size);
-
-		flush_cache_all();
-		outer_flush_range(0, trampoline_code_size);
-		smp_wmb();
-
-		if (__pa(PAGE_OFFSET))
-			iounmap(zero);

+			/*
+			* This is elegant way how to jump to any address
+			* 0x0: Load address at 0x8 to r0
+			* 0x4: Jump by mov instruction
+			* 0x8: Jumping address
+			*/
+			memcpy((__force void *)zero, &zynq_secondary_trampoline,
+							trampoline_size);
+			writel(address, zero + trampoline_size);
+
+			flush_cache_all();
+			outer_flush_range(0, trampoline_code_size);
+			smp_wmb();
+
+			if (__pa(PAGE_OFFSET))
+				iounmap(zero);
+		}
 		zynq_slcr_cpu_start(cpu);

 		return 0;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130603/d72dd9ff/attachment.sig>
