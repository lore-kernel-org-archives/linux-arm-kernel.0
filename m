From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 20 Oct 2016 11:12:57 +0100
Subject: [PATCH] arm64: kernel: force ET_DYN ELF type for CONFIG_RELOCATABLE=y
Message-ID: <1476958377-13900-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GNU ld used to set the ELF file type to ET_DYN for PIE executables, which
is the same file type used for shared libraries. However, this was changed
recently, and now PIE executables are emitted as ET_EXEC instead.

The distinction is only relevant for ELF loaders, and so there is little
reason to care about the difference when building the kernel, which is
why the change has gone unnoticed until now.

However, debuggers do use the ELF binary, and expect ET_EXEC type files
to appear in memory at the exact offset described in the ELF metadata.
This means source level debugging is no longer possible when KASLR is in
effect or when executing the stub.

So add the -shared LD option when building with CONFIG_RELOCATABLE=y. This
forces the ELF file type to be set to ET_DYN (which is what you get when
building with binutils 2.24 and earlier anyway), and has no other ill
effects.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

The difference in output between ET_EXEC and ET_DYN file types for
'readelf -a vmlinux':

--- /tmp/exec	2016-10-19 17:46:51.368841538 +0100
+++ /tmp/dyn	2016-10-19 17:46:01.774879088 +0100
@@ -5,7 +5,7 @@
   Version:                           1 (current)
   OS/ABI:                            UNIX - System V
   ABI Version:                       0
-  Type:                              EXEC (Executable file)
+  Type:                              DYN (Shared object file)
   Machine:                           AArch64
   Version:                           0x1
   Entry point address:               0xffff000008080000
@@ -239199,7 +239199,7 @@
 108973: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS 
 108974: ffff0000089800a0     0 OBJECT  LOCAL  DEFAULT  ABS _GLOBAL_OFFSET_TABLE_
 108975: ffff0000081a7c70     0 NOTYPE  LOCAL  DEFAULT    2 $x
-108976: ffff0000081a7c74     8 FUNC    LOCAL  DEFAULT    2 e843419 at 001a_00000473_99c
+108976: ffff0000081a7c74     8 FUNC    LOCAL  DEFAULT    2 e843419 at 001a_00000472_99c
 108977: ffff0000081a7c74     0 NOTYPE  LOCAL  DEFAULT    2 $x
 108978: ffff000008d7c118   136 FUNC    GLOBAL DEFAULT   19 __efistub_fdt_delprop
 108979: ffff000008819db8    36 FUNC    GLOBAL DEFAULT    2 arch_timer_get_kvm_info
@@ -269256,4 +269256,4 @@
 Displaying notes found at file offset 0x00cf5740 with length 0x00000024:
   Owner                 Data size	Description
   GNU                  0x00000014	NT_GNU_BUILD_ID (unique build ID bitstring)
-    Build ID: a63334609e04d620ea175bb9e88bc68989dc0402
+    Build ID: 7f489d756b1799111b0128ffa61546c2ac1f6e2a

 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index ab51aed6b6c1..3635b8662724 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -15,7 +15,7 @@ CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
 GZFLAGS		:=-9
 
 ifneq ($(CONFIG_RELOCATABLE),)
-LDFLAGS_vmlinux		+= -pie -Bsymbolic
+LDFLAGS_vmlinux		+= -pie -shared -Bsymbolic
 endif
 
 ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
-- 
2.7.4
