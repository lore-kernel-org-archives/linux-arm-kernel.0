From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 28 Aug 2018 15:32:10 +0300
Subject: [PATCH 5/7] arm64: dts: add support for per sub-dir makefiles for DT
 building
In-Reply-To: <1535459532-17211-1-git-send-email-t-kristo@ti.com>
References: <1535459532-17211-1-git-send-email-t-kristo@ti.com>
Message-ID: <1535459532-17211-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the makefile for arm64 builds all the DT files based on
rules in the arch/arm64/boot/dts/Makefile, as this is statically
passed via the $(build)= parameter. Change the $(build) parameter
to actually point to the subdir itself, so the makefile from
that subdir can be used to set-up build flags etc., for example
setting up DTC_FLAGS. The patsubst magic is used to strip the
trailing "/" from the path, as that confuses the kbuild system.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f04c814..2ac4358 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -128,7 +128,7 @@ zinstall install:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 %.dtb %.dtbo: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
+	$(Q)$(MAKE) $(build)=$(patsubst %/,%,$(boot)/dts/$(dir $@)) $(boot)/dts/$@
 
 PHONY += dtbs dtbs_install
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
