From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 09 Jul 2014 15:29:56 +0400
Subject: [RFC/PATCH RESEND -next 02/21] init: main: initialize kasan's shadow
 area on boot
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1404905415-9046-3-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch initializes shadow area after it was allocated by arch code.
All low memory marked as accessible except shadow area itself.
Later free_all_bootmem() will release pages to buddy allocator
and these pages will be marked as unaccessible, untill somebody
will allocate them.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 init/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index bb1aed9..d06a636 100644
--- a/init/main.c
+++ b/init/main.c
@@ -78,6 +78,7 @@
 #include <linux/context_tracking.h>
 #include <linux/random.h>
 #include <linux/list.h>
+#include <linux/kasan.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -549,7 +550,7 @@ asmlinkage __visible void __init start_kernel(void)
 			   set_init_arg);
 
 	jump_label_init();
-
+	kasan_init_shadow();
 	/*
 	 * These use large bootmem allocations and must precede
 	 * kmem_cache_init()
-- 
1.8.5.5
