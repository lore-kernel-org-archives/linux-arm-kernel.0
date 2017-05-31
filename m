From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 31 May 2017 16:59:10 +0300
Subject: [PATCHv2 1/2] arm64:vdso: Rewrite gettimeofday into C.
In-Reply-To: <20170531124430.GG9723@arm.com>
References: <1496190860-5116-1-git-send-email-apinski@cavium.com>
 <20170531124430.GG9723@arm.com>
Message-ID: <20170531135910.4rxkh4lcfsbjye5t@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 01:44:30PM +0100, Will Deacon wrote:
> Hi Andrew,
> 
> Thanks for posting this, but please try to cc the maintainers in future -- I
> almost missed it!
> 
> On Tue, May 30, 2017 at 05:34:19PM -0700, Andrew Pinski wrote:
> > This allows the compiler to optimize the divide by 1000.
> > And remove the other divide.
> > 
> > On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
> > gettimeofday improves by 18%.
> > 
> > Note I noticed a bug in the old implementation of __kernel_clock_getres;
> > it was checking only the lower 32bits of the pointer; this would work
> > for most cases but could fail in a few.
> > 
> > Changes from v1:
> > * Fixed bug in __kernel_clock_getres for checking the pointer argument.
> > * Fix comments to refer to functions in arm64.
> 
> I tested this patch on a few platforms I have access to and didn't see the
> perf regressions I saw when I looked at this in the past with an older
> toolchain (it was mostly about the same, with a couple of improvements).
> 
> So, in principle, I'm not opposed to moving this into C. However, we're
> currently close to a "vDSO-explosion" on arm64 with people wanting a compat
> variant and also an ILP32 variant.

Hi Will,

This is the patch for ilp32. It's based on v1 but should be OK for v2
too. If vdso rework will be upstreamed prior to ilp32 series, I'll
incorporate it in ilp32.

Yury

>From e6f22d8ea41e6f7919de30509ac95989cd8076a4 Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@caviumnetworks.com>
Date: Wed, 24 May 2017 15:02:43 +0300
Subject: [PATCH 28/28] arm64a/ilp32:vdso: Rewrite gettimeofday into C.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/vdso-ilp32/Makefile | 20 +++++++++++++++++---
 arch/arm64/kernel/vdso/gettimeofday.c |  9 ++++++++-
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso-ilp32/Makefile b/arch/arm64/kernel/vdso-ilp32/Makefile
index 0671e88ce860..ecf62e7d1c8b 100644
--- a/arch/arm64/kernel/vdso-ilp32/Makefile
+++ b/arch/arm64/kernel/vdso-ilp32/Makefile
@@ -11,10 +11,22 @@ obj-ilp32-vdso := gettimeofday-ilp32.o note-ilp32.o sigreturn-ilp32.o
 targets := $(obj-ilp32-vdso) vdso-ilp32.so vdso-ilp32.so.dbg
 obj-ilp32-vdso := $(addprefix $(obj)/, $(obj-ilp32-vdso))
 
-ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
+ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -nostdlib -Wl,-soname=linux-ilp32-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
+# Force -O2 to avoid libgcc dependencies
+CFLAGS_REMOVE_gettimeofday-ilp32.o = -pg -Os
+CFLAGS_gettimeofday-ilp32.o = -O2 -mcmodel=tiny -mabi=ilp32
+
+# Disable gcov profiling for VDSO code
+GCOV_PROFILE := n
+
+# Workaround for bare-metal (ELF) toolchains that neglect to pass -shared
+# down to collect2, resulting in silent corruption of the vDSO image.
+ccflags-y += -Wl,-shared
+
 obj-y += vdso-ilp32.o
 extra-y += vdso-ilp32.lds vdso-ilp32-offsets.h
 CPPFLAGS_vdso-ilp32.lds += -P -C -U$(ARCH) -mabi=ilp32
@@ -46,8 +58,8 @@ $(obj)/vdso-ilp32-offsets.h: $(obj)/vdso-ilp32.so.dbg FORCE
 #$(obj-ilp32-vdso): %.o: $(src)/../vdso/$(subst -ilp32,,%.S)
 #	$(call if_changed_dep,vdso-ilp32as)
 
-$(obj)/gettimeofday-ilp32.o: $(src)/../vdso/gettimeofday.S
-	$(call if_changed_dep,vdso-ilp32as)
+$(obj)/gettimeofday-ilp32.o: $(src)/../vdso/gettimeofday.c
+	$(call if_changed_dep,vdso-ilp32cc)
 
 $(obj)/note-ilp32.o: $(src)/../vdso/note.S
 	$(call if_changed_dep,vdso-ilp32as)
@@ -60,6 +72,8 @@ $(obj)/sigreturn-ilp32.o: $(src)/../vdso/sigreturn.S
 # Actual build commands
 quiet_cmd_vdso-ilp32ld = VDSOILP32L $@
       cmd_vdso-ilp32ld = $(CC) $(c_flags) -mabi=ilp32  -Wl,-n -Wl,-T $^ -o $@
+quiet_cmd_vdso-ilp32as = VDSOILP32C $@
+      cmd_vdso-ilp32cc= $(CC) $(c_flags) -mabi=ilp32 -c -o $@ $<
 quiet_cmd_vdso-ilp32as = VDSOILP32A $@
       cmd_vdso-ilp32as = $(CC) $(a_flags) -mabi=ilp32 -c -o $@ $<
 
diff --git a/arch/arm64/kernel/vdso/gettimeofday.c b/arch/arm64/kernel/vdso/gettimeofday.c
index a0ab8b1bd53e..0c4a00b58963 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.c
+++ b/arch/arm64/kernel/vdso/gettimeofday.c
@@ -26,8 +26,15 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+
+#ifdef __ILP32__
+#undef BITS_PER_LONG
+#define BITS_PER_LONG 32
+#endif
+
 #include <linux/hrtimer.h>
 
+
 extern struct vdso_data _vdso_data;
 
 static notrace int gettimeofday_fallback(struct timeval *_tv,
@@ -122,7 +129,7 @@ static notrace u64 get_clock_shifted_nsec(u64 cycle_last, u64 mult)
 
 	res = res - cycle_last;
 	/* We can only guarantee 56 bits of precision. */
-	res &= ~(0xff00ul<<48);
+	res &= ~(0xff00ull<<48);
 	return res * mult;
 }
 
-- 
2.11.0
