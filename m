From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Feb 2013 09:58:45 +0100
Subject: [PATCH 2/2] arm: mm: Add support for booting the kernel out of the
 first 16MB of memory
In-Reply-To: <1360745925-20952-1-git-send-email-michal.simek@xilinx.com>
References: <1360745925-20952-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <1360745925-20952-2-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel should be loaded to the first 16MB memory and DTS
memory node should reflect this as well.

In case when the kernel is loaded to addresses higher than 16MB, the kernel
doesn't boot and fail.
This patch fix this case by changing the current memory bank start address
to the kernel loading address. The memory which is in front of the kernel
loading address will be ignored (which is also the current behavior
if memory is described with several memory banks).

Here is the example of behavior:
dts memory reg = <0x0 0x40000000>;
kernel load address = 0x10000000 (respectively 0x1000800)

Current:
The kernel doesn't boot and fails with this error:
"Ignoring RAM at 00000000-3fffffff (vmalloc region overlap).
Memory policy: ECC disabled, Data cache writeback
Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0."

When this patch is applied:
The kernel works only with 0x10000000-0x3fffffff. (0x0-0x0fffffff is ignored)
And the kernel bootlog contains "Change memory bank to 10000000-3fffffff"
message.

The patch just add the same behavior as is the case
when you setup mem=768M on the command line and load the kernel
to the 0x10000000(0x10008000) address. When mem is specified
dts memory description is simply ignored.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mm/mmu.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e60f370..78fd18b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -936,6 +936,17 @@ void __init sanity_check_meminfo(void)
 		if (bank->start > ULONG_MAX)
 			highmem = 1;
 
+		if (bank->start < __pa(PAGE_OFFSET) &&
+			__pa(PAGE_OFFSET) <= (bank->start + bank->size - 1)) {
+				int offset = __pa(PAGE_OFFSET) - bank->start;
+				bank->start += offset;
+				bank->size -= offset;
+				pr_crit("Change memory bank to %.8llx-%.8llx\n",
+					(unsigned long long)bank->start,
+					(unsigned long long)bank->start +
+								bank->size - 1);
+		}
+
 #ifdef CONFIG_HIGHMEM
 		if (__va(bank->start + bank->size - 1) < (void *)PAGE_OFFSET) {
 			pr_notice("Ignoring RAM@%.8llx-%.8llx ",
-- 
1.7.0.4
