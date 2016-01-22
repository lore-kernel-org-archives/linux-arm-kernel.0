From: wcohen@redhat.com (William Cohen)
Date: Thu, 21 Jan 2016 22:56:26 -0500
Subject: [PATCH] Eliminate the .eh_frame sections from the aarch64 vmlinux and
 kernel modules
Message-ID: <1453434986-19307-1-git-send-email-wcohen@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default the aarch64 gcc generates .eh_frame sections.  Unlike
.debug_frame sections, the .eh_frame sections are loaded into memory
when the associated code is loaded.  On an example kernel being built
with this default the .eh_frame section in vmlinux used an extra 1.7MB
of memory.  The x86 disables the creation of the .eh_frame section.
The aarch64 should probably do the same to save some memory.

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index cd822d8..094a137 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -27,6 +27,7 @@ $(warning LSE atomics not supported by binutils)
 endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr)
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_AFLAGS	+= $(lseinstr)
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
-- 
2.5.0
