From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jan 2014 12:01:50 +0000
Subject: Building with gcc 4.6.4
Message-ID: <20140128120150.GG15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, yesterday I built gcc 4.6.4 (mainline) for the autobuilder, and the
result is that every build failed with the same error:

scripts/mod/empty.c:1:0: error: FPA is unsupported in the AAPCS

This seems to be because linux-elf targets default to fpe3 in mainline
gcc, but specifying -mabi=aapcs-linux switches us into EABI mode where
the compiler errors out with the default FPU.

Hence, I believe we need this to ensure that a compatible VFP is
selected.  One can argue that building EABI ARMv4 with VFP is silly,
but it seems that's what the gcc folk have decided (rightly or
wrongly.)

Maybe this is a bug in mainline GCC - which begs the question why
(presumably, since no one has picked this up) Linaro's toolchain
has fixes but mainline GCC doesn't.

Comments?

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 23d5e3946589..08a9ef58d9c3 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -96,7 +96,7 @@ tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
 tune-y := $(tune-y)
 
 ifeq ($(CONFIG_AEABI),y)
-CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork
+CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
 else
 CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-thumb-interwork,)
 endif


-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
