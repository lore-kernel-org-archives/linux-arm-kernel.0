From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 28 Aug 2018 15:32:08 +0300
Subject: [PATCH 3/7] ARM: dts: add support for individual build flags for DT
 subdirs
In-Reply-To: <1535459532-17211-1-git-send-email-t-kristo@ti.com>
References: <1535459532-17211-1-git-send-email-t-kristo@ti.com>
Message-ID: <1535459532-17211-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the makefile is setup in such manner that even if
we build a DT file in a subdirectory under arch/arm/boot/dts,
it gets built based on the base boot/dts/Makefile rules.
This patch modifies the base makefile in such manner, that
it detects which makefile to use based on build target path.
This allows setting for example per-directory DTC_FLAGS and
using those for the subdir build. The dtbdir local variable
is setup to target to the build path.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ab555a0..b7c21e8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -339,8 +339,10 @@ $(BOOT_TARGETS): vmlinux
 $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
+%.dtb %.dtbo: dtbdir = $(patsubst %/,%,$(patsubst %./,%,$(boot)/dts/$(dir $@)))
+
 %.dtb %.dtbo: | scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
+	$(Q)$(MAKE) $(build)=$(dtbdir) MACHINE=$(MACHINE) $(boot)/dts/$@
 
 PHONY += dtbs dtbs_install
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
