From: rric@kernel.org (Robert Richter)
Date: Fri, 29 Aug 2014 15:49:42 +0200
Subject: [PATCH] arm64, dts: Add dtbs_install make target
In-Reply-To: <20140829121023.GW13038@rric.localhost>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
 <1406732794-20920-3-git-send-email-rric@kernel.org>
 <CAOesGMh9KkdKB_ytJ7CCbkPW7dHTX91NdfDMsMNfbmOBVOJ8PQ@mail.gmail.com>
 <20140828161556.GN4703@rric.localhost>
 <20140828162549.GP14650@leverpostej>
 <CAOesGMjtjcgUNV8WLp6_Zbok-0zq5afg_KS8QJYp=kDVabrQvg@mail.gmail.com>
 <20140828181429.GO4703@rric.localhost>
 <CAOesGMh3TEKZkyPjopfSm07C2ydw5=2VrzY0xQ=9jkhoA-Z_kQ@mail.gmail.com>
 <20140829121023.GW13038@rric.localhost>
Message-ID: <20140829134942.GP4703@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On 29.08.14 14:10:23, Robert Richter wrote:
> On 28.08.14 16:01:08, Olof Johansson wrote:
> > Thinking about it a bit more, the even more obvious solution that I
> > for some reason didn't think of at the time, is to have the
> > dtbs_install target create the appropriate subdirectories on the
> > install side, so that the structure is preserved.
> > 
> > That comes a bit closer to how modules are handled as well.
> 
> Yes, dtbs_install target would be useful.
> 
> Will come with a solution for this too.

below is a patch that adds the dtbs_install target to arm64. Taken
from arm where this was already implemented.

-Robert



>From bbb09a3775a385f4a549b1c4b8518658bcbc382d Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@cavium.com>
Date: Fri, 29 Aug 2014 14:17:02 +0200
Subject: [PATCH] arm64, dts: Add dtbs_install make target

This adds the dtbs_install make target to arm64. The target has been
introduced already to arch/arm with the following commit:

 f4d4ffc03efc kbuild: dtbs_install: new make target

Implementation for arm64 is the same as for arm.

With 'dtbs_install' all config enabled dtb files are installed to
either the INSTALL_DTBS_PATH directory or the default location:

 $INSTALL_PATH/dtbs/$KERNELRELEASE

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Makefile          | 6 ++++--
 arch/arm64/boot/dts/Makefile | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 8185a913c5ed..c68efa07c5f3 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -66,8 +66,9 @@ zinstall install: vmlinux
 %.dtb: scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
 
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts dtbs
+PHONY += dtbs dtbs_install
+dtbs dtbs_install: prepare scripts
+	$(Q)$(MAKE) $(build)=$(boot)/dts $@
 
 PHONY += vdso_install
 vdso_install:
@@ -81,6 +82,7 @@ define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
   echo  '* dtbs          - Build device tree blobs for enabled boards'
+  echo  '  dtbs_install  - Install dtbs to $(INSTALL_DTBS_PATH)'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index f8001a62029c..3a75cdc2d087 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -2,9 +2,11 @@ dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
-targets += dtbs
+targets += dtbs dtbs_install
 targets += $(dtb-y)
 
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 
 clean-files := *.dtb
+
+dtbs_install: $(addsuffix _dtbinst_, $(dtb-y))
-- 
2.0.1
