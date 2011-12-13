From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Dec 2011 18:06:12 +0000
Subject: [RFC PATCH] ARM: vmlinux.lds.S: do not hardcode cacheline size as 32
 bytes
Message-ID: <1323799572-5641-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The linker script assumes a cacheline size of 32 bytes when aligning
the .data..cacheline_aligned and .data..percpu sections.

This patch updates the script to use L1_CACHE_BYTES, which should be set
to 64 on platforms that require it.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

I'm posting this as an RFC because, whilst this fixes a bug, it looks
like many platforms don't select ARM_L1_CACHE_SHIFT_6 when they should
(all Cortex-A8 platforms should select this, for example).

I'd be happy to select ARM_L1_CACHE_SHIFT_6 if CPU_V7, but this doesn't
help us for combined v6/v7 kernels...

Answers on a postcard (although email is preferable),

Will

 arch/arm/kernel/vmlinux.lds.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 20b3041..98067b7 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -4,6 +4,7 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
@@ -174,7 +175,7 @@ SECTIONS
 	}
 #endif
 
-	PERCPU_SECTION(32)
+	PERCPU_SECTION(L1_CACHE_BYTES)
 
 #ifdef CONFIG_XIP_KERNEL
 	__data_loc = ALIGN(4);		/* location in binary */
@@ -205,7 +206,7 @@ SECTIONS
 #endif
 
 		NOSAVE_DATA
-		CACHELINE_ALIGNED_DATA(32)
+		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
 		READ_MOSTLY_DATA(32)
 
 		/*
-- 
1.7.4.1
