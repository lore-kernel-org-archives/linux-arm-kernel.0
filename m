From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:36 +0100
Subject: [RFC PATCH 01/23] arm: add kconfig fragments support
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-2-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for generating defconfigs from kconfig fragments.

This is based on changes to arch/powerpc/Makefile from
commit ea4d1a87e6de ("powerpc/configs: Replace pseries_le_defconfig
with a Makefile target using merge_config") by Cyril Bur.

Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6be9ee1..f2c0683 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -343,6 +343,17 @@ dtbs: prepare scripts
 dtbs_install:
 	$(Q)$(MAKE) $(dtbinst)=$(boot)/dts
 
+# Used to create 'merged defconfigs'
+# To use it $(call) it with the first argument as the base defconfig
+# and the second argument as a space separated list of .config files to merge,
+# without the .config suffix.
+define merge_into_defconfig
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
+		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
+		$(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(config).config)
+	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
+endef
+
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
-- 
1.9.1
