From: jason@lakedaemon.net (Jason Cooper)
Date: Sun,  2 Nov 2014 20:52:29 +0000
Subject: [PATCH] ARM: kbuild: Fix forced rebuild after 'make dtbs'
In-Reply-To: <CACRpkdYmJWy1_vs0tWRA7SvkQnvbXXKqf7pHpH5b5tZ6vR+KJg@mail.gmail.com>
References: <CACRpkdYmJWy1_vs0tWRA7SvkQnvbXXKqf7pHpH5b5tZ6vR+KJg@mail.gmail.com>
Message-ID: <1414961549-31666-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After this patch:

  f4d4ffc03efc kbuild: dtbs_install: new make target

was added the kernel tree, Linus Walleij noticed that 'make dtbs' forced
a following 'make zImage' to rebuild the entire tree, even though
nothing had changed.  His report:

  After this patch a while back I have observed the following behaviour
  of the kernel build:

  make zImage
  make zImage
  -> incremental build, just relink

  make zImage
  make dtbs
  make zImage
  -> The whole kernel gets rebuilt

  So now if I happen to recompile my device trees, I suddenly want
  the entire zImage to be rebuilt to? It's by definition not changes
  that affect the kernel build :-(

  I noticed this because my build scripts calls make dtbs && make
  zImage, and started to rebuild absolutely everything all the time.

To fix this, we make only the dtbs_install target depend on the prepare
target.  It's needed to make sure KERNELVERSION is calculated prior to
installing.

Fixes: f4d4ffc03efc: ("kbuild: dtbs_install: new make target")
Reported-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Note: I've no idea if this is a 100% correct solution or not.  I know it's
definitely better than what we have currently.  If there is another way to
guarantee KERNELVERSION is set other than depending on 'prepare', I'd love to
hear it.

thx,

Jason.

 arch/arm/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 034a94904d69..ae1c278128f8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -312,7 +312,9 @@ $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
 
 PHONY += dtbs dtbs_install
-dtbs dtbs_install: prepare scripts
+dtbs: scripts
+	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $@
+dtbs_install: prepare scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $@
 
 # We use MRPROPER_FILES and CLEAN_FILES now
-- 
2.1.3
