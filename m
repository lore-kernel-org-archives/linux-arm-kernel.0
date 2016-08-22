From: mikko.rapeli@iki.fi (Mikko Rapeli)
Date: Mon, 22 Aug 2016 20:33:11 +0200
Subject: [PATCH v05 54/72] include/uapi/xen/privcmd.h: fix compilation in
 userspace
In-Reply-To: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <1471890809-4383-55-git-send-email-mikko.rapeli@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xen/interface/xen.h is not exported from kernel headers so remove the
dependency and provide needed defines for domid_t and xen_pfn_t if they
are not already defined by some other e.g. Xen specific headers.

Suggested by Andrew Cooper <andrew.cooper3@citrix.com> on lkml message
<5569F9C9.8000607@citrix.com>.

The ifdef for ARM is ugly but did not find better solutions for it.

Fixes userspace compilation error:

xen/privcmd.h:38:31: fatal error: xen/interface/xen.h: No such file or directory

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: David Vrabel <david.vrabel@citrix.com>
---
 arch/arm/include/asm/xen/interface.h |  2 +-
 include/uapi/xen/privcmd.h           | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/xen/interface.h b/arch/arm/include/asm/xen/interface.h
index 75d5968..6898ee1 100644
--- a/arch/arm/include/asm/xen/interface.h
+++ b/arch/arm/include/asm/xen/interface.h
@@ -38,7 +38,7 @@
  * fine since it simply wouldn't be able to create any sure pfns in
  * the first place.
  */
-typedef uint64_t xen_pfn_t;
+typedef __u64 xen_pfn_t;
 #define PRI_xen_pfn "llx"
 typedef uint64_t xen_ulong_t;
 #define PRI_xen_ulong "llx"
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index 7ddeeda..16c11f9 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -35,7 +35,17 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
-#include <xen/interface/xen.h>
+
+/* Defined by include/xen/interface/xen.h, but it is not part of Linux uapi */
+#ifndef __XEN_PUBLIC_XEN_H__
+typedef __u16 domid_t;
+
+#if (defined __ARMEL__ || defined __ARMEB__)
+typedef __u64 xen_pfn_t;
+#else
+typedef unsigned long xen_pfn_t;
+#endif /* (defined __ARMEL__ || defined __ARMEB__) */
+#endif /* __XEN_PUBLIC_XEN_H__ */
 
 struct privcmd_hypercall {
 	__u64 op;
-- 
2.8.1
