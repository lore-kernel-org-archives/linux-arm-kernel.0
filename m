From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 19:42:54 +0100
Subject: [PATCH] ARM: poison initmem when it is freed
Message-ID: <20110705184254.GH8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the initmem is freed, we can no longer rely on its contents.  In
lightly loaded systems, this memory may persist for some time, making
it harder discover run-time issues (caused by the build warnings being
ignored.)

Poison the initmem at the point where it is freed to encourage run-time
problems when initmem is dereferenced as an aid to finding such problems.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/init.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 2c2cce9..46c39bd 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
+#include <linux/poison.h>
 #include <linux/sort.h>
 
 #include <asm/mach-types.h>
@@ -701,6 +702,8 @@ void free_initmem(void)
 				    "TCM link");
 #endif
 
+	memset(__init_begin, POISON_FREE_INITMEM, __init_end - __init_begin);
+
 	if (!machine_is_integrator() && !machine_is_cintegrator())
 		totalram_pages += free_area(__phys_to_pfn(__pa(__init_begin)),
 					    __phys_to_pfn(__pa(__init_end)),
