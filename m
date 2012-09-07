From: matthew.leach@arm.com (Matthew Leach)
Date: Fri,  7 Sep 2012 09:41:00 +0100
Subject: [PATCH 2/2] ARM: kexec: Check segment memory addresses
In-Reply-To: <1347007260-13271-1-git-send-email-matthew.leach@arm.com>
References: <1347007260-13271-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1347007260-13271-3-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the memory regions that are set within the segments
correspond to physical contiguous memory regions.

Reviewed-by: Simon Horman <horms@verge.net.au>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm/kernel/machine_kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index a6bbc0f..524139a 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -8,6 +8,7 @@
 #include <linux/reboot.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/memblock.h>
 #include <asm/pgtable.h>
 #include <linux/of_fdt.h>
 #include <asm/pgalloc.h>
@@ -42,6 +43,12 @@ int machine_kexec_prepare(struct kimage *image)
 	for (i = 0; i < image->nr_segments; i++) {
 		current_segment = &image->segment[i];
 
+		err = memblock_is_region_memory(current_segment->mem,
+						current_segment->memsz);
+		if (err)
+			return - EINVAL;
+
+
 		err = get_user(header, (__be32*)current_segment->buf);
 		if (err)
 			return err;
-- 
1.7.12
