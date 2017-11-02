From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Thu,  2 Nov 2017 18:43:22 +0100
Subject: [PATCH v2] arm64: support __int128 on gcc 5+
In-Reply-To: <20171102134720.GA17333@arm.com>
References: <20171102134720.GA17333@arm.com>
Message-ID: <20171102174322.21853-1-Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Versions of gcc prior to gcc 5 emitted a __multi3 function call when
dealing with TI types, resulting in failures when trying to link to
libgcc, and more generally, bad performance. However, since gcc 5,
the compiler supports actually emitting fast instructions, which means
we can at long last enable this option and receive the speedups.

The gcc commit that added proper Aarch64 support is:
https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=d1ae7bb994f49316f6f63e6173f2931e837a351d
This commit appears to be part of the gcc 5 release.

There are still a few instructions, such as __ashlti3 and __ashrti3,
that require libgcc, which is fine. So, we also link to libgcc for these
functions when needed, which is what several other architectures already
have been doing for a long time.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm64/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 939b310913cf..70c7c0c1bccb 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -53,6 +53,8 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
@@ -108,7 +110,7 @@ core-$(CONFIG_NET) += arch/arm64/net/
 core-$(CONFIG_KVM) += arch/arm64/kvm/
 core-$(CONFIG_XEN) += arch/arm64/xen/
 core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
-libs-y		:= arch/arm64/lib/ $(libs-y)
+libs-y		:= arch/arm64/lib/ $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name) $(libs-y)
 core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # Default target when executing plain make
-- 
2.14.2
