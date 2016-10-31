From: code@mmayer.net (Markus Mayer)
Date: Mon, 31 Oct 2016 12:44:14 -0700
Subject: [PATCH] arm64: errata: Check for --fix-cortex-a53-843419 and
 --fix-cortex-a53
Message-ID: <20161031194414.61287-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

The new errata check leads to a warning with some older versions of the
linker that do know how to work around the errata, but still use the
original name of the command line option: --fix-cortex-a53. The commit
in question that changed the name of the option can be found at [1].
It looks like only "gold" is affected by this rename. Traditional "ld"
isn't. (There, the argument was always called --fix-cortex-a53-843419.)

To allow older versions of gold to properly handle the erratum if they
can, check whether ld supports the old name of this option in addition
to checking the new one.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=7a2a1c793578a8468604e661dda025ecb8d0bd20;hp=cfbf0e3c5b637d66b2b1aeadecae9c187b825b2f

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

Using the change proposed here, things work for me as expected:

$ aarch64-linux-ld -v
GNU ld (GNU Binutils) Linaro 2014.11-2 2.24.0.20141017

$ grep fix-cortex aarch64.log 
  /bin/bash scripts/link-vmlinux.sh aarch64-linux-ld -EL  -p --no-undefined
-X --fix-cortex-a53 --build-id ;  true
+ aarch64-linux-ld -EL -p --no-undefined -X --fix-cortex-a53 --build-id -o
.tmp_vmlinux1 -T ./arch/arm64/kernel/vmlinux.lds arch/arm64/kernel/head.o
init/built-in.o --start-group usr/built-in.o arch/arm64/kernel/built-in.o
arch/arm64/mm/built-in.o arch/arm64/net/built-in.o arch/arm64/kvm/built-in.o
arch/arm64/xen/built-in.o arch/arm64/crypto/built-in.o
./drivers/firmware/efi/libstub/lib.a kernel/built-in.o certs/built-in.o
mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o
crypto/built-in.o block/built-in.o arch/arm64/lib/lib.a lib/lib.a
arch/arm64/lib/built-in.o lib/built-in.o drivers/built-in.o sound/built-in.o
firmware/built-in.o net/built-in.o virt/built-in.o --end-group
[...]

 arch/arm64/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index ab51aed..231ba69 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -20,7 +20,13 @@ endif
 
 ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
   ifeq ($(call ld-option, --fix-cortex-a53-843419),)
-$(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
+    ifeq ($(call ld-option, --fix-cortex-a53),)
+$(warning ld does not support --fix-cortex-a53-843419 or --fix-cortex-a53; kernel may be susceptible to erratum)
+    else
+# When this option was first introduced, it was called --fix-cortex-a53 in gold.
+# So, let's use that as fall-back if the linker understands it.
+LDFLAGS_vmlinux	+= --fix-cortex-a53
+    endif
   else
 LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
-- 
2.7.4
