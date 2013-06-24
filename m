From: dianders@chromium.org (Doug Anderson)
Date: Mon, 24 Jun 2013 13:41:57 -0700
Subject: [PATCH] ARM: Fix dtb dependency to use order-only prerequisites
Message-ID: <1372106517-19105-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The %.dtb dependency is specified to depend on the PHONY "scripts".
That means that it'll build every time even if the underlying dtb file
hasn't been touched.  Use an order-only prerequisites to fix this.
Also mark "dtbs" as PHONY for correctness.

This was broken in (70b0476 ARM: 7513/1: Make sure dtc is built before
running it).

Reported-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1ba358b..fe8144e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -289,9 +289,10 @@ zImage Image xipImage bootpImage uImage: vmlinux
 zinstall uinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
-%.dtb: scripts
+%.dtb: | scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
 
+PHONY += dtbs
 dtbs: scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) dtbs
 
-- 
1.8.3
