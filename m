From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu,  8 Nov 2018 15:36:14 +0100
Subject: [PATCH v8 7/8] arm64: update Documentation/arm64/tagged-pointers.txt
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
Message-ID: <8526edb07fd5a762847306bba89fbadbb19210b7.1541687720.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the changes in Documentation/arm64/tagged-pointers.txt.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/arm64/tagged-pointers.txt | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..f4cf1f5cf362 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -17,13 +17,22 @@ this byte for application use.
 Passing tagged addresses to the kernel
 --------------------------------------
 
-All interpretation of userspace memory addresses by the kernel assumes
-an address tag of 0x00.
+The kernel supports tags in pointer arguments (including pointers in
+structures) for a limited set of syscalls, the exceptions are:
 
-This includes, but is not limited to, addresses found in:
+ - memory syscalls: brk, madvise, mbind, mincore, mlock, mlock2, move_pages,
+   mprotect, mremap, msync, munlock, munmap, pkey_mprotect, process_vm_readv,
+   process_vm_writev, remap_file_pages;
 
- - pointer arguments to system calls, including pointers in structures
-   passed to system calls,
+ - ioctls that accept user pointers that describe virtual memory ranges;
+
+ - TCP_ZEROCOPY_RECEIVE setsockopt.
+
+The kernel supports tags in user fault addresses. However the fault_address
+field in the sigcontext struct will contain an untagged address.
+
+All other interpretations of userspace memory addresses by the kernel
+assume an address tag of 0x00, in particular:
 
  - the stack pointer (sp), e.g. when interpreting it to deliver a
    signal,
@@ -33,11 +42,7 @@ This includes, but is not limited to, addresses found in:
 
 Using non-zero address tags in any of these locations may result in an
 error code being returned, a (fatal) signal being raised, or other modes
-of failure.
-
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
-strongly discouraged.
+of failure. Using a non-zero address tag for sp is strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
 address tags may suffer impaired or inaccurate debug and profiling
-- 
2.19.1.930.g4563a0d9d0-goog
