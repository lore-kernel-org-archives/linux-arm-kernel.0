From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Sep 2012 17:03:38 +0100
Subject: [RESEND PATCH 2/2] ARM: kexec: Check segment memory addresses
In-Reply-To: <1348157018-31059-1-git-send-email-will.deacon@arm.com>
References: <1348157018-31059-1-git-send-email-will.deacon@arm.com>
Message-ID: <1348157018-31059-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Leach <matthew.leach@arm.com>

Ensure that the memory regions that are set within the segments
correspond to physical contiguous memory regions.

Reviewed-by: Simon Horman <horms@verge.net.au>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/machine_kexec.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index dee34ef..e29c333 100644
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
@@ -44,6 +45,11 @@ int machine_kexec_prepare(struct kimage *image)
 	for (i = 0; i < image->nr_segments; i++) {
 		current_segment = &image->segment[i];
 
+		err = memblock_is_region_memory(current_segment->mem,
+						current_segment->memsz);
+		if (err)
+			return - EINVAL;
+
 		err = get_user(header, (__be32*)current_segment->buf);
 		if (err)
 			return err;
-- 
1.7.4.1
