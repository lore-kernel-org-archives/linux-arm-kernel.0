From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Apr 2016 20:31:51 +0200
Subject: [PATCH] ARM: Drop CONFIG_RTC_LIB dependency
In-Reply-To: <CAAEAJfCXpY5vUxXv3N1mpMzVsouTLsOCKGyADyPQw5QC5EYjWQ@mail.gmail.com>
References: <1459569633-6470-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAAEAJfCXpY5vUxXv3N1mpMzVsouTLsOCKGyADyPQw5QC5EYjWQ@mail.gmail.com>
Message-ID: <4624574.xXAYWxU134@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 14:58:10 Ezequiel Garcia wrote:
> +Arnd
> 
> On 2 April 2016 at 01:00, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> > The rtc-lib dependency seems to be here for very old historical
> > reasons, but nowadays it shouldn't be needed. If any ARM
> > platform requires rtc-lib, they should select it individually.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > ---
> >  arch/arm/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index cdfa6c2b7626..8efb1c605ac8 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -84,7 +84,6 @@ config ARM
> >         select OLD_SIGACTION
> >         select OLD_SIGSUSPEND3
> >         select PERF_USE_VMALLOC
> > -       select RTC_LIB
> >         select SYS_SUPPORTS_APM_EMULATION
> >         # Above selects are sorted alphabetically; please add new ones
> >         # according to that.  Thanks.
> > --
> > 2.7.0
> >
> 
> If there's no feedback on this, I'll add it to Russell's patch tracker.

Sorry for missing this the first time around. The patch looks fine to me,
but I wonder if we should just do this for all architectures, the patch
below looks like it should do the trick. If you want to have your ARM
patch merged separately, that's fine too, please add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

	Arnd

8<------
[PATCH] RTC: Drop CONFIG_RTC_LIB symbol

The rtc-lib dependency seems to be here for very old historical
reasons, but nowadays it shouldn't be needed. If any architecture
platform requires rtc-lib support, it already needs to enable the
CONFIG_RTC_CLASS along with the specific driver.

This also fixes the dependency list for CONFIG_RTC and CONFIG_GEN_RTC
so they don't include x86, which could no longer select these drivers
after 3195ef59cb42 ("x86: Do full rtc synchronization with ntp").

Based on patch from Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cba8bd6172c..62c209504c0a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -85,7 +85,6 @@ config ARM
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PERF_USE_VMALLOC
-	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c9a3161e0aed..635dce3ee9cc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -93,7 +93,6 @@ config ARM64
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
-	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35d92a119f9d..2dbc7893fba8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -28,7 +28,6 @@ config MIPS
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
-	select RTC_LIB if !MACH_LOONGSON64
 	select GENERIC_ATOMIC64 if !64BIT
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select HAVE_DMA_CONTIGUOUS
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index cb93af8f8017..86c180436396 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -30,7 +30,6 @@ config SUPERH
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select MAY_HAVE_SPARSE_IRQ
 	select IRQ_FORCED_THREADING
-	select RTC_LIB
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2632f6017cc1..3fea91106533 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -149,7 +149,6 @@ config X86
 	select OLD_SIGACTION			if X86_32
 	select OLD_SIGSUSPEND3			if X86_32 || IA32_EMULATION
 	select PERF_EVENTS
-	select RTC_LIB
 	select SPARSE_IRQ
 	select SRCU
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/drivers/Makefile b/drivers/Makefile
index 8be1ea2d1936..e71f4c7cd579 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -98,7 +98,7 @@ obj-y				+= usb/
 obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
-obj-$(CONFIG_RTC_LIB)		+= rtc/
+obj-$(CONFIG_RTC_CLASS)		+= rtc/
 obj-y				+= i2c/ media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-$(CONFIG_PTP_1588_CLOCK)	+= ptp/
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 629f1ff389b6..b5abc048362f 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -275,11 +275,11 @@ config NVRAM
 # These legacy RTC drivers just cause too many conflicts with the generic
 # RTC framework ... let's not even try to coexist any more.
 #
-if RTC_LIB=n
+if RTC_CLASS=n
 
 config RTC
 	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
-	depends on ALPHA || M32R || M68K || MIPS || MN10300 || PPC || X86
+	depends on ALPHA || M32R || M68K || (MIPS && MACH_LOONGSON64) || MN10300 || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on ALPHA || M68K || MN10300 || PARISC || PPC || X86
+	depends on ALPHA || M68K || MN10300 || PARISC || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -364,7 +364,7 @@ config DS1302
 	  will get access to the real time clock (or hardware clock) built
 	  into your computer.
 
-endif # RTC_LIB
+endif # RTC_CLASS
 
 config DTLK
 	tristate "Double Talk PC internal speech card support"
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index f1e1f502be5d..59150f6c22f3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -2,14 +2,10 @@
 # RTC class/drivers configuration
 #
 
-config RTC_LIB
-	bool
-
 menuconfig RTC_CLASS
 	bool "Real Time Clock"
 	default n
 	depends on !S390 && !UML
-	select RTC_LIB
 	help
 	  Generic RTC class support. If you say yes here, you will
 	  be allowed to plug one or more RTCs to your system. You will
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index ea2833723fa9..e44a0af93e7e 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -4,11 +4,10 @@
 
 ccflags-$(CONFIG_RTC_DEBUG)	:= -DDEBUG
 
-obj-$(CONFIG_RTC_LIB)		+= rtc-lib.o
 obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
 obj-$(CONFIG_RTC_SYSTOHC)	+= systohc.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
-rtc-core-y			:= class.o interface.o
+rtc-core-y			:= class.o interface.o rtc-lib.o
 
 ifdef CONFIG_RTC_DRV_EFI
 rtc-core-y			+= rtc-efi-platform.o
