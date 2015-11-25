From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 25 Nov 2015 22:56:52 +0300
Subject: [question] kernel build fails with O0 gcc optimization flag
In-Reply-To: <20151125180606.GM8644@n2100.arm.linux.org.uk>
References: <20151125171229.GA8415@yury-N73SV>
 <20151125180606.GM8644@n2100.arm.linux.org.uk>
Message-ID: <20151125195652.GB8415@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 06:06:08PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 25, 2015 at 08:12:29PM +0300, Yury Norov wrote:
> > Hi all.
> > 
> > I changed optimization from O2 to O0 in Makefile:
> >         609 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >         610 KBUILD_CFLAGS   += -Os $(call cc-disable-warning,maybe-uninitialized,)
> >         611 else
> >         612 KBUILD_CFLAGS   += -O2 <-- here
> >         613 endif
> 
> -O0 is not supported, sorry.
> 

If so, why not to notify explicitly?

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 Makefile            | 2 +-
 arch/arm64/Makefile | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 418e98a..a2e8d3a 100644
--- a/Makefile
+++ b/Makefile
@@ -602,7 +602,6 @@ all: vmlinux
 ARCH_CPPFLAGS :=
 ARCH_AFLAGS :=
 ARCH_CFLAGS :=
-include arch/$(SRCARCH)/Makefile
 
 KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
 
@@ -775,6 +774,7 @@ ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC)), y)
 	KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
 endif
 
+include arch/$(SRCARCH)/Makefile
 include scripts/Makefile.kasan
 include scripts/Makefile.extrawarn
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 432b69a..d865544 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -20,6 +20,10 @@ KBUILD_DEFCONFIG := defconfig
 # Check for binutils support for specific extensions
 lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)
 
+# Check KBUILD_CFLAGS for  '-O0' as it's not supported now.
+$(if $(findstring -O0,$(KBUILD_CFLAGS)), \
+	$(error ARM64 does not support O0 optimization level. Try O1 or higher))
+
 ifeq ($(CONFIG_ARM64_LSE_ATOMICS), y)
   ifeq ($(lseinstr),)
 $(warning LSE atomics not supported by binutils)
-- 
2.5.0
