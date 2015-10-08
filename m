From: robh@kernel.org (Rob Herring)
Date: Thu,  8 Oct 2015 12:53:39 -0500
Subject: [PATCH v2 05/13] arm64: enable building of all dtbs
In-Reply-To: <1444326827-3565-1-git-send-email-robh@kernel.org>
References: <1444326827-3565-1-git-send-email-robh@kernel.org>
Message-ID: <1444326827-3565-6-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building all dtb files when CONFIG_OF_ALL_DTBS is enabled. The dtbs
are not really dependent on a platform being enabled or any other kernel
config, so for testing coverage it is convenient to build all of the dtbs.
This builds all dts files in the tree, not just targets listed. This
is simpler for arm64 which has a bunch of sub-dirs.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/boot/dts/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index d9f8833..b01ec43 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -14,3 +14,9 @@ dts-dirs += sprd
 dts-dirs += xilinx
 
 subdir-y	:= $(dts-dirs)
+
+dtstree		:= $(srctree)/$(src)
+
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
+
+always		:= $(dtb-y)
-- 
2.1.4
