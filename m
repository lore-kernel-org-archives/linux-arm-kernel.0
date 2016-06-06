From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 18:01:08 +0100
Subject: [PATCH kexec-tools v2 28/32] arm: add support for boot-time crash
 kernel resource
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xtk-0003u8-CQ@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for detecting and using the boot-time crash kernel
resource, which is needed for systems which have special boot-time
memory views, such as Keystone 2.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 9113f5e..25fdbe9 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -52,7 +52,7 @@ struct memory_ranges usablemem_rgns = {
 	.ranges = crash_memory_ranges,
 };
 
-/* memory range reserved for crashkernel */
+/* The boot-time physical memory range reserved for crashkernel region */
 static struct memory_range crash_kernel_mem;
 
 /* reserved regions */
@@ -366,13 +366,22 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 				char *str, unsigned long long base,
 				unsigned long long length)
 {
-	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
+	if (strncmp(str, CRASH_KERNEL_BOOT, strlen(CRASH_KERNEL_BOOT)) == 0) {
 		crash_kernel_mem.start = base;
 		crash_kernel_mem.end = base + length - 1;
 		crash_kernel_mem.type = RANGE_RAM;
 		return mem_regions_add(&crash_reserved_rgns,
 				       base, length, RANGE_RAM);
 	}
+	else if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0) {
+		if (crash_kernel_mem.start == crash_kernel_mem.end) {
+			crash_kernel_mem.start = base;
+			crash_kernel_mem.end = base + length - 1;
+			crash_kernel_mem.type = RANGE_RAM;
+		}
+		return mem_regions_add(&crash_reserved_rgns,
+				       base, length, RANGE_RAM);
+	}
 	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
 		return mem_regions_add(&usablemem_rgns,
 				       base, length, RANGE_RAM);
-- 
1.9.1
