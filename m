From: mmarek@suse.com (Michal Marek)
Date: Tue, 22 Nov 2016 22:34:29 +0100
Subject: [PATCH 1/6] arm64: Use full path in KBUILD_IMAGE definition
Message-ID: <20161122213434.14788-1-mmarek@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KBUILD_IMAGE variable is used by the rpm and deb-pkg targets, which
expect it to point to the image file in the build directory. The
builddeb script has a workaround for architectures which only provide
the basename, but let's provide a clean interface for packaging tools.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Michal Marek <mmarek@suse.com>
---
 arch/arm64/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 3635b8662724..80b6866bcacb 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -94,12 +94,12 @@ libs-y		:= arch/arm64/lib/ $(libs-y)
 core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # Default target when executing plain make
-KBUILD_IMAGE	:= Image.gz
+boot		:= arch/arm64/boot
+KBUILD_IMAGE	:= $(boot)/Image.gz
 KBUILD_DTBS	:= dtbs
 
-all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
+all:	Image.gz $(KBUILD_DTBS)
 
-boot := arch/arm64/boot
 
 Image: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-- 
2.10.0
