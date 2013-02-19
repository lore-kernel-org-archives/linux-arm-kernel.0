From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 19 Feb 2013 14:49:22 +0000
Subject: [PATCH XEN] xen: event channel arrays are xen_ulong_t and not
 unsigned long
In-Reply-To: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
Message-ID: <1361285363-27133-1-git-send-email-ian.campbell@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM we want these to be the same size on 32- and 64-bit.

This is an ABI change on ARM. X86 does not change.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Keir (Xen.org) <keir@xen.org>
Cc: Tim Deegan <tim@xen.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: xen-devel at lists.xen.org
---
 tools/include/xen-foreign/mkheader.py |    6 ++++++
 xen/include/public/xen.h              |    8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/include/xen-foreign/mkheader.py b/tools/include/xen-foreign/mkheader.py
index d189b07..57681fa 100644
--- a/tools/include/xen-foreign/mkheader.py
+++ b/tools/include/xen-foreign/mkheader.py
@@ -21,13 +21,18 @@ inttypes["arm"] = {
     "unsigned long" : "uint32_t",
     "long"          : "uint32_t",
     "xen_pfn_t"     : "uint64_t",
+    "xen_ulong_t"   : "uint64_t",
 };
+header["arm"] = """
+#define __arm___ARM32 1
+""";
 
 # x86_32
 inttypes["x86_32"] = {
     "unsigned long" : "uint32_t",
     "long"          : "uint32_t",
     "xen_pfn_t"     : "uint32_t",
+    "xen_ulong_t"   : "uint32_t",
 };
 header["x86_32"] = """
 #define __i386___X86_32 1
@@ -42,6 +47,7 @@ inttypes["x86_64"] = {
     "unsigned long" : "__align8__ uint64_t",
     "long"          : "__align8__ uint64_t",
     "xen_pfn_t"     : "__align8__ uint64_t",
+    "xen_ulong_t"   : "__align8__ uint64_t",
 };
 header["x86_64"] = """
 #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
diff --git a/xen/include/public/xen.h b/xen/include/public/xen.h
index 5593066..99c8212 100644
--- a/xen/include/public/xen.h
+++ b/xen/include/public/xen.h
@@ -556,7 +556,7 @@ DEFINE_XEN_GUEST_HANDLE(multicall_entry_t);
  * Event channel endpoints per domain:
  *  1024 if a long is 32 bits; 4096 if a long is 64 bits.
  */
-#define NR_EVENT_CHANNELS (sizeof(unsigned long) * sizeof(unsigned long) * 64)
+#define NR_EVENT_CHANNELS (sizeof(xen_ulong_t) * sizeof(xen_ulong_t) * 64)
 
 struct vcpu_time_info {
     /*
@@ -613,7 +613,7 @@ struct vcpu_info {
      */
     uint8_t evtchn_upcall_pending;
     uint8_t evtchn_upcall_mask;
-    unsigned long evtchn_pending_sel;
+    xen_ulong_t evtchn_pending_sel;
     struct arch_vcpu_info arch;
     struct vcpu_time_info time;
 }; /* 64 bytes (x86) */
@@ -663,8 +663,8 @@ struct shared_info {
      * per-vcpu selector word to be set. Each bit in the selector covers a
      * 'C long' in the PENDING bitfield array.
      */
-    unsigned long evtchn_pending[sizeof(unsigned long) * 8];
-    unsigned long evtchn_mask[sizeof(unsigned long) * 8];
+    xen_ulong_t evtchn_pending[sizeof(xen_ulong_t) * 8];
+    xen_ulong_t evtchn_mask[sizeof(xen_ulong_t) * 8];
 
     /*
      * Wallclock time: updated only by control software. Guests should base
-- 
1.7.9.1
