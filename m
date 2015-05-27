From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 27 May 2015 11:42:07 +0200
Subject: [PATCH RFC] ARM: use -marm unconditionally for THUMB2_KERNEL=n builds
Message-ID: <1432719727-28860-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using a toolchain that defaults to v7-m code generation using
cc-option fails to add -marm because it conflicts with the default cpu
type:

	$ echo > test.c
	$ arm-cortexm3-uclinuxeabi-gcc -marm -c test.c
	test.c:1:0: error: target CPU does not support ARM mode

resulting in errors like

	Error: selected processor does not support Thumb mode `mrs r1,cpsr'

Dropping the use of cc-option and using -marm unconditionally works fine
for this compiler because it's only ever used together with $(arch-y)
(e.g. -march=armv4).

The only possible culprit is a compiler that doesn't understand -marm.
My compiler collection only goes back to 4.0.3 which does work with this
option. The use of cc-option to test for -marm was introduced in commit
5636810d6f17 ([ARM] 3982/2: Explicitly select 32-bit ARM ISA (-marm))
back in 2006 when the minimal compiler version was already 3.3.

The next best fix is using

	CFLAGS_ISA := $(call cc-option,$(arch-y) -marm,)

and dropping arch-y from KBUILD_CFLAGS in case this change breaks gcc
3.x.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

Arnd told me on irc that Nico did some build tests with ancient
compilers some time ago. Maybe you can tell which was the first compiler
to support -marm?

Best regards
Uwe

 arch/arm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0ce9d0f71f2a..6773c74a8f8b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -115,8 +115,8 @@ ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
 CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
 else
-CFLAGS_ISA	:=$(call cc-option,-marm,)
-AFLAGS_ISA	:=$(CFLAGS_ISA)
+CFLAGS_ISA	:= -marm
+AFLAGS_ISA	:= $(CFLAGS_ISA)
 endif
 
 # Need -Uarm for gcc < 3.x
-- 
2.1.4
