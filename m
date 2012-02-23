From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Feb 2012 17:48:29 +0000
Subject: [PATCH-WIP 08/13] xen/arm: fix arm xen guest handle definitions
In-Reply-To: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
Message-ID: <1330019314-20865-8-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__XEN__ is never defined in Linux: remove non-relevant functions and
macros

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/interface.h |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/xen/interface.h b/arch/arm/include/asm/xen/interface.h
index 93b0139..2ee39e8 100644
--- a/arch/arm/include/asm/xen/interface.h
+++ b/arch/arm/include/asm/xen/interface.h
@@ -9,27 +9,20 @@
 
 #include <linux/types.h>
 
-#ifdef __XEN__
-#define __DEFINE_GUEST_HANDLE(name, type) \
-    typedef struct { type *p; } __guest_handle_ ## name
-#else
 #define __DEFINE_GUEST_HANDLE(name, type) \
     typedef type * __guest_handle_ ## name
-#endif
 
 #define DEFINE_GUEST_HANDLE_STRUCT(name) \
 	__DEFINE_GUEST_HANDLE(name, struct name)
 #define DEFINE_GUEST_HANDLE(name) __DEFINE_GUEST_HANDLE(name, name)
 #define GUEST_HANDLE(name)        __guest_handle_ ## name
 
-#ifdef __XEN__
 #define set_xen_guest_handle(hnd, val)			\
 	do {						\
 		if (sizeof(hnd) == 8)			\
 			*(uint64_t *)&(hnd) = 0;	\
-		(hnd).p = val;				\
+		(hnd) = val;				\
 	} while (0)
-#endif
 
 #ifndef __ASSEMBLY__
 /* Guest handles for primitive C types. */
-- 
1.7.2.5
