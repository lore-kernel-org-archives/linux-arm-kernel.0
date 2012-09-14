From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 14 Sep 2012 12:13:11 +0100
Subject: [PATCH v4 09/24] xen/arm: Introduce xen_ulong_t for unsigned long
In-Reply-To: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
Message-ID: <1347621207-11294-9-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the original Xen headers have xen_ulong_t as unsigned long type, however
when they have been imported in Linux, xen_ulong_t has been replaced with
unsigned long. That might work for x86 and ia64 but it does not for arm.
Bring back xen_ulong_t and let each architecture define xen_ulong_t as they
see fit.

Also explicitly size pointers (__DEFINE_GUEST_HANDLE) to 64 bit.


Changes in v3:

- remove the incorrect changes to multicall_entry;
- remove the change to apic_physbase.


Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/interface.h  |    8 ++++++--
 arch/ia64/include/asm/xen/interface.h |    1 +
 arch/x86/include/asm/xen/interface.h  |    1 +
 include/xen/interface/memory.h        |   12 ++++++------
 include/xen/interface/physdev.h       |    2 +-
 include/xen/interface/version.h       |    2 +-
 6 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/xen/interface.h b/arch/arm/include/asm/xen/interface.h
index 74c72b5..ae05e56 100644
--- a/arch/arm/include/asm/xen/interface.h
+++ b/arch/arm/include/asm/xen/interface.h
@@ -9,8 +9,11 @@
 
 #include <linux/types.h>
 
+#define uint64_aligned_t uint64_t __attribute__((aligned(8)))
+
 #define __DEFINE_GUEST_HANDLE(name, type) \
-	typedef type * __guest_handle_ ## name
+	typedef struct { union { type *p; uint64_aligned_t q; }; }  \
+        __guest_handle_ ## name
 
 #define DEFINE_GUEST_HANDLE_STRUCT(name) \
 	__DEFINE_GUEST_HANDLE(name, struct name)
@@ -21,13 +24,14 @@
 	do {						\
 		if (sizeof(hnd) == 8)			\
 			*(uint64_t *)&(hnd) = 0;	\
-		(hnd) = val;				\
+		(hnd).p = val;				\
 	} while (0)
 
 #ifndef __ASSEMBLY__
 /* Explicitly size integers that represent pfns in the interface with
  * Xen so that we can have one ABI that works for 32 and 64 bit guests. */
 typedef uint64_t xen_pfn_t;
+typedef uint64_t xen_ulong_t;
 /* Guest handles for primitive C types. */
 __DEFINE_GUEST_HANDLE(uchar, unsigned char);
 __DEFINE_GUEST_HANDLE(uint,  unsigned int);
diff --git a/arch/ia64/include/asm/xen/interface.h b/arch/ia64/include/asm/xen/interface.h
index 686464e..7c83445 100644
--- a/arch/ia64/include/asm/xen/interface.h
+++ b/arch/ia64/include/asm/xen/interface.h
@@ -71,6 +71,7 @@
  * with Xen so that we could have one ABI that works for 32 and 64 bit
  * guests. */
 typedef unsigned long xen_pfn_t;
+typedef unsigned long xen_ulong_t;
 /* Guest handles for primitive C types. */
 __DEFINE_GUEST_HANDLE(uchar, unsigned char);
 __DEFINE_GUEST_HANDLE(uint, unsigned int);
diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
index 2289075..25cc8df 100644
--- a/arch/x86/include/asm/xen/interface.h
+++ b/arch/x86/include/asm/xen/interface.h
@@ -51,6 +51,7 @@
  * with Xen so that on ARM we can have one ABI that works for 32 and 64
  * bit guests. */
 typedef unsigned long xen_pfn_t;
+typedef unsigned long xen_ulong_t;
 /* Guest handles for primitive C types. */
 __DEFINE_GUEST_HANDLE(uchar, unsigned char);
 __DEFINE_GUEST_HANDLE(uint,  unsigned int);
diff --git a/include/xen/interface/memory.h b/include/xen/interface/memory.h
index abbbff0..b5c3098 100644
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -34,7 +34,7 @@ struct xen_memory_reservation {
     GUEST_HANDLE(xen_pfn_t) extent_start;
 
     /* Number of extents, and size/alignment of each (2^extent_order pages). */
-    unsigned long  nr_extents;
+    xen_ulong_t  nr_extents;
     unsigned int   extent_order;
 
     /*
@@ -92,7 +92,7 @@ struct xen_memory_exchange {
      *     command will be non-zero.
      *  5. THIS FIELD MUST BE INITIALISED TO ZERO BY THE CALLER!
      */
-    unsigned long nr_exchanged;
+    xen_ulong_t nr_exchanged;
 };
 
 DEFINE_GUEST_HANDLE_STRUCT(xen_memory_exchange);
@@ -148,8 +148,8 @@ DEFINE_GUEST_HANDLE_STRUCT(xen_machphys_mfn_list);
  */
 #define XENMEM_machphys_mapping     12
 struct xen_machphys_mapping {
-    unsigned long v_start, v_end; /* Start and end virtual addresses.   */
-    unsigned long max_mfn;        /* Maximum MFN that can be looked up. */
+    xen_ulong_t v_start, v_end; /* Start and end virtual addresses.   */
+    xen_ulong_t max_mfn;        /* Maximum MFN that can be looked up. */
 };
 DEFINE_GUEST_HANDLE_STRUCT(xen_machphys_mapping_t);
 
@@ -169,7 +169,7 @@ struct xen_add_to_physmap {
     unsigned int space;
 
     /* Index into source mapping space. */
-    unsigned long idx;
+    xen_ulong_t idx;
 
     /* GPFN where the source mapping page should appear. */
     xen_pfn_t gpfn;
@@ -186,7 +186,7 @@ struct xen_translate_gpfn_list {
     domid_t domid;
 
     /* Length of list. */
-    unsigned long nr_gpfns;
+    xen_ulong_t nr_gpfns;
 
     /* List of GPFNs to translate. */
     GUEST_HANDLE(ulong) gpfn_list;
diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
index 9ce788d..f616514 100644
--- a/include/xen/interface/physdev.h
+++ b/include/xen/interface/physdev.h
@@ -56,7 +56,7 @@ struct physdev_eoi {
 #define PHYSDEVOP_pirq_eoi_gmfn_v2       28
 struct physdev_pirq_eoi_gmfn {
     /* IN */
-    unsigned long gmfn;
+    xen_ulong_t gmfn;
 };
 
 /*
diff --git a/include/xen/interface/version.h b/include/xen/interface/version.h
index e8b6519..30280c9 100644
--- a/include/xen/interface/version.h
+++ b/include/xen/interface/version.h
@@ -45,7 +45,7 @@ struct xen_changeset_info {
 
 #define XENVER_platform_parameters 5
 struct xen_platform_parameters {
-    unsigned long virt_start;
+    xen_ulong_t virt_start;
 };
 
 #define XENVER_get_features 6
-- 
1.7.2.5
