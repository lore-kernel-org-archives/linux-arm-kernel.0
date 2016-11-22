From: mmarek@suse.com (Michal Marek)
Date: Tue, 22 Nov 2016 22:34:30 +0100
Subject: [PATCH 2/6] arm: Use full path in KBUILD_IMAGE definition
In-Reply-To: <20161122213434.14788-1-mmarek@suse.com>
References: <20161122213434.14788-1-mmarek@suse.com>
Message-ID: <20161122213434.14788-2-mmarek@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KBUILD_IMAGE variable is used by the rpm and deb-pkg targets, which
expect it to point to the image file in the build directory. The
builddeb script has a workaround for architectures which only provide
the basename, but let's provide a clean interface for packaging tools.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Michal Marek <mmarek@suse.com>
---
 arch/arm/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6be9ee148b78..f3fa2cafca15 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -296,10 +296,11 @@ drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 libs-y				:= arch/arm/lib/ $(libs-y)
 
 # Default target when executing plain make
+boot := arch/arm/boot
 ifeq ($(CONFIG_XIP_KERNEL),y)
-KBUILD_IMAGE := xipImage
+KBUILD_IMAGE := $(boot)/xipImage
 else
-KBUILD_IMAGE := zImage
+KBUILD_IMAGE := $(boot)/zImage
 endif
 
 # Build the DT binary blobs if we have OF configured
@@ -307,9 +308,8 @@ ifeq ($(CONFIG_USE_OF),y)
 KBUILD_DTBS := dtbs
 endif
 
-all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
+all:	$(notdir $(KBUILD_IMAGE)) $(KBUILD_DTBS)
 
-boot := arch/arm/boot
 
 archprepare:
 	$(Q)$(MAKE) $(build)=arch/arm/tools include/generated/mach-types.h
-- 
2.10.0
