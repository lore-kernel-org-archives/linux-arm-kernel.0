From: olof@lixom.net (Olof Johansson)
Date: Fri, 13 Jul 2018 07:59:10 -0700
Subject: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
In-Reply-To: <20180710093615.GA30095@arm.com>
References: <20180709200956.31158-1-labbott@redhat.com>
 <20180710090125.GA28924@arm.com>
 <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
 <20180710093615.GA30095@arm.com>
Message-ID: <20180713145910.2mlzip5ssk72cleo@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:36:16AM +0100, Will Deacon wrote:
> On Tue, Jul 10, 2018 at 11:30:39AM +0200, Paul Kocialkowski wrote:
> > On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
> > > Thanks, Laura.
> > > 
> > > I'll take this as a fix, and add a comment to the Makefile to justify
> > > why we need the linux target.
> > 
> > So this comes down to either breaking fedora/debian toolchains (that
> > don't support elf emulation mode) or breaking bare-metal toolchains
> > (that don't support linux emulation mode).
> > 
> > Since Linux is a bare-metal project that does not technically require
> > the linux target (who said using "Linux" for all things is confusing?),
> > I think it should aim for the elf target in the long term.
> > 
> > But well, breaking Linux build in common distros isn't good either, so I
> > guess it makes sense to revert this while distros toolchains are being
> > fixed. Hopefully, it won't take too long.
> > 
> > What do you think?
> 
> Yes, we need to revert the change since it's a regression otherwise. I think
> the best course of action here would be to find a way that we can either
> tell the linker that it doesn't need the missing linker scripts because
> we're providing our own, or find a way to pass different LD flags depending
> on whether or not we have a linux toolchain.
> 
> For now, I've pushed the revert to for-next/fixes.

Hi Will,

This is regressed in mainline as well. But I think we can just use a (slightly
improved) ld-option here? I checked it for x86 regression since it uses the
one-argument version. Patch is here, can you pick that up instead and get it in
for 4.18-rc?

Thanks,


-Olof

>From 0d73b2d1774d5edce20aac919ba356b61d098646 Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Fri, 13 Jul 2018 07:56:11 -0700
Subject: [PATCH] arm64: Fix build on some toolchains

Not all toolchains have the baremetal elf targets, RedHat/Fedora ones in
particular. So, probe for whether it's available and use the previous
(linux) targets if it isn't.

Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/Makefile    | 4 ++--
 scripts/Kbuild.include | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7976d2d242fa..c5ce97f69731 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
-LDFLAGS		+= -EB -maarch64elfb
+LDFLAGS		+= -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
-LDFLAGS		+= -EL -maarch64elf
+LDFLAGS		+= -EL $(call ld-option, -maarch64elf, -maarch64linux)
 UTS_MACHINE	:= aarch64
 endif
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c8156d61678c..1e13f502b42f 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
 	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
-# Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
+# Usage: LDFLAGS += $(call ld-option, -X, -Y)
+ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2),$(3))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-- 
2.11.0
