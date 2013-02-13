From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Feb 2013 09:58:44 +0100
Subject: [PATCH 1/2] arm: mm: Ignore memory banks which are in front of the
 kernel when HIGHMEM is ON
Message-ID: <1360745925-20952-1-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm kernel with HIGHMEM ON will fail when dts memory node is described
by memory banks and the starting address is not inside the first 16MB
of the first memory bank. If HIGHMEM is OFF and the configuration is the same
then the first memory bank is ignored and the kernel boots.

Here is the example of behavior:
dts memory reg = <0x0 0x10000000 0x10000000 0x30000000>
kernel load address = 0x10000000 (respectively 0x1000800)

Current:
"Machine: Xilinx Zynq Platform, model: Zynq ZC702 Development Board
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0."

After:
The kernel ignore ram 0x0-0x0fffffff because is lower than the kernel starting
address and the kernel bootlog contains.
"Ignoring RAM at 00000000-0fffffff (CONFIG_HIGHMEM)."

Also using mem=768M on the command line will overwrite dts memory
map and kernel will boot with HIGHMEM ON too.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mm/mmu.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ce328c7..e60f370 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -937,6 +937,15 @@ void __init sanity_check_meminfo(void)
 			highmem = 1;
 
 #ifdef CONFIG_HIGHMEM
+		if (__va(bank->start + bank->size - 1) < (void *)PAGE_OFFSET) {
+			pr_notice("Ignoring RAM@%.8llx-%.8llx ",
+				(unsigned long long)bank->start,
+				(unsigned long long)bank->start
+							+ bank->size - 1);
+			pr_cont("(CONFIG_HIGHMEM).\n");
+			continue;
+		}
+
 		if (__va(bank->start) >= vmalloc_min ||
 		    __va(bank->start) < (void *)PAGE_OFFSET)
 			highmem = 1;
-- 
1.7.0.4
