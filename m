From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  8 Feb 2011 14:54:10 +0000
Subject: [PATCH] arm: Place correctly notes section in the linker script
Message-ID: <1297176850-30144-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 18991197b4b588255ccabf472ebc84db7b66a19c added --build-id
linker option when toolchain supports it. ARM one does, but for some
reason places the section at 0 when linker script doesn't mention it
explicitly.

The 1e621a8e3752367d4aae78a8ab00a18fb2793f34 worked around the problem
removing this section from binary image with explicit objcopy options,
but it still exists in vmlinux, confusing tools like debuggers and perf.

This problem was discussed here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/015994.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/015994.html
but the proposed changes to the linker script were substantial.

This patch simply places NOTES (36 bytes long, at least when compiled
with CodeSourcery toolchain) between data and bss, which seem to be
the right place (and suggested by the sample linker script in
include/asm-generic/vmlinux.lds.h).

It is enough to place it correctly in vmlinux (so debuggers are happy):

Section Headers:
  [11] .data             PROGBITS        c07ce000 7ce000 020fc0 00  WA  0   0 32
  [12] .notes            NOTE            c07eefc0 7eefc0 000024 00  AX  0   0  4
  [13] .bss              NOBITS          c07ef000 7eefe4 01e628 00  WA  0   0 32
Program Headers:
  LOAD           0x008000 0xc0008000 0xc0008000 0x7e6fe4 0x805628 RWE 0x8000
  NOTE           0x7eefc0 0xc07eefc0 0xc07eefc0 0x00024 0x00024 R E 0x4
Section to Segment mapping:
  Segment Sections...
   00     <...> .data .notes .bss
   01     .notes

and to get it exposed as /sys/kernel/notes used by perf tools.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Makefile             |    2 +-
 arch/arm/kernel/vmlinux.lds.S |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c22c1ad..6f7b292 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -15,7 +15,7 @@ ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 endif
 
-OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
+OBJCOPYFLAGS	:=-O binary -R .comment -S
 GZFLAGS		:=-9
 #KBUILD_CFLAGS	+=-pipe
 # Explicitly specifiy 32-bit ARM ISA since toolchain default can be -mthumb:
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 86b66f3..558bd81 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -247,6 +247,8 @@ SECTIONS
 	}
 #endif
 
+	NOTES
+
 	BSS_SECTION(0, 0, 0)
 	_end = .;
 
-- 
1.6.3.3
