Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82527C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:30:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7B52075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AsQgKzuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7B52075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pQf9uK6gHZ3ZIMXS+v7BtlZzHLBYhlLG2UCyvNZ7/os=; b=AsQgKzuoi0UrAb
	xnRmfJt0DK27/Io3ljqtZtkhDdK6kWMdAv0TKbViZzkweWMtafJf+zdEtFTDk1Ktat2U9jANU2CtU
	4h2P4yav/bEnlLKyY51ymd+/dG7LtBuH0074z5hNmjweiqE16WHrotB3pdSTsXMhEJbxYYK8r4f4G
	wBgrFkg1Qkd3rikvpV951KyXE8y68sbNZS1aFaOuwaCGZETCdX4B/4+obrIIsSSSzoQKvGdWC3GbU
	Bt/RKk4fbmE2n9vEXnis4h4lC/MWe3QU+b7Gn8D+xG9KTH/q/3hdB041YVYB07df4vMwIj/mj6N2w
	tkEjC7c7PXx62wGmTgmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9xl-00046J-24; Fri, 22 Feb 2019 12:29:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9uZ-0000EQ-Qw
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:27:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF07DA78;
 Fri, 22 Feb 2019 04:26:39 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4115B3F690;
 Fri, 22 Feb 2019 04:26:37 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 22/23] x86: Add support for generic vDSO
Date: Fri, 22 Feb 2019 12:24:29 +0000
Message-Id: <20190222122430.21180-23-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042640_347329_319273F3 
X-CRM114-Status: GOOD (  26.26  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The x86 vDSO library requires some adaptations to take advantage of the
newly introduced generic vDSO library.

Introduce the following changes:
 - Modification of vdso.c to be compliant with the common vdso datapage
 - Use of lib/vdso for gettimeofday

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/x86/Kconfig                         |   3 +
 arch/x86/entry/vdso/Makefile             |   9 +
 arch/x86/entry/vdso/vclock_gettime.c     | 239 +++--------------------
 arch/x86/entry/vdso/vdso.lds.S           |   2 +
 arch/x86/entry/vdso/vdso32/vdso32.lds.S  |   1 +
 arch/x86/entry/vdso/vdsox32.lds.S        |   1 +
 arch/x86/entry/vsyscall/vsyscall_gtod.c  | 110 +++++++----
 arch/x86/include/asm/vdso/gettimeofday.h | 203 +++++++++++++++++++
 arch/x86/include/asm/vgtod.h             |  73 +------
 arch/x86/include/asm/vvar.h              |   2 +-
 10 files changed, 318 insertions(+), 325 deletions(-)
 create mode 100644 arch/x86/include/asm/vdso/gettimeofday.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..9422cc122567 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -18,6 +18,7 @@ config X86_32
 	select HAVE_GENERIC_DMA_COHERENT
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
+	select GENERIC_VDSO_32
 
 config X86_64
 	def_bool y
@@ -111,6 +112,7 @@ config X86
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
@@ -194,6 +196,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
+	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 5bfe2243a08f..5dc3f251ca13 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -3,6 +3,12 @@
 # Building vDSO images for x86.
 #
 
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_X86_64_JUMP_SLOT|R_X86_64_GLOB_DAT|R_X86_64_RELATIVE|
+ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
+include $(srctree)/lib/vdso/Makefile
+
 KBUILD_CFLAGS += $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
@@ -51,6 +57,7 @@ VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
 hostprogs-y			+= vdso2c
@@ -121,6 +128,7 @@ $(obj)/%.so: $(obj)/%.so.dbg
 
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
@@ -160,6 +168,7 @@ $(obj)/vdso32.so.dbg: FORCE \
 		      $(obj)/vdso32/system_call.o \
 		      $(obj)/vdso32/sigreturn.o
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 #
 # The DSO images are built using a special linker script.
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 007b3fe9d727..6ff8cabf4c3e 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -1,240 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2006 Andi Kleen, SUSE Labs.
- * Subject to the GNU Public License, v.2
- *
  * Fast user context implementation of clock_gettime, gettimeofday, and time.
  *
+ * Copyright 2019 ARM Limited
+ * Copyright 2006 Andi Kleen, SUSE Labs.
  * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
  *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
- *
- * The code should have no internal unresolved relocations.
- * Check with readelf after changing.
  */
-
-#include <uapi/linux/time.h>
-#include <asm/vgtod.h>
-#include <asm/vvar.h>
-#include <asm/unistd.h>
-#include <asm/msr.h>
-#include <asm/pvclock.h>
-#include <asm/mshyperv.h>
-#include <linux/math64.h>
 #include <linux/time.h>
-#include <linux/kernel.h>
+#include <linux/types.h>
 
-#define gtod (&VVAR(vsyscall_gtod_data))
+#include "../../../../lib/vdso/gettimeofday.c"
 
-extern int __vdso_clock_gettime(clockid_t clock, struct timespec *ts);
-extern int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz);
+extern int __vdso_clock_gettime(clockid_t clock, struct __vdso_timespec *ts);
+extern int __vdso_gettimeofday(struct __vdso_timeval *tv, struct timezone *tz);
 extern time_t __vdso_time(time_t *t);
+extern int __vdso_clock_getres(clockid_t clock, struct __vdso_timespec *res);
 
-#ifdef CONFIG_PARAVIRT_CLOCK
-extern u8 pvclock_page
-	__attribute__((visibility("hidden")));
-#endif
-
-#ifdef CONFIG_HYPERV_TSCPAGE
-extern u8 hvclock_page
-	__attribute__((visibility("hidden")));
-#endif
-
-#ifndef BUILD_VDSO32
-
-notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
-{
-	long ret;
-	asm ("syscall" : "=a" (ret), "=m" (*ts) :
-	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
-	     "rcx", "r11");
-	return ret;
-}
-
-#else
-
-notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
-{
-	long ret;
-
-	asm (
-		"mov %%ebx, %%edx \n"
-		"mov %[clock], %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=a" (ret), "=m" (*ts)
-		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
-		: "edx");
-	return ret;
-}
-
-#endif
-
-#ifdef CONFIG_PARAVIRT_CLOCK
-static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
-{
-	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
-}
-
-static notrace u64 vread_pvclock(void)
-{
-	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
-	u32 version;
-	u64 ret;
-
-	/*
-	 * Note: The kernel and hypervisor must guarantee that cpu ID
-	 * number maps 1:1 to per-CPU pvclock time info.
-	 *
-	 * Because the hypervisor is entirely unaware of guest userspace
-	 * preemption, it cannot guarantee that per-CPU pvclock time
-	 * info is updated if the underlying CPU changes or that that
-	 * version is increased whenever underlying CPU changes.
-	 *
-	 * On KVM, we are guaranteed that pvti updates for any vCPU are
-	 * atomic as seen by *all* vCPUs.  This is an even stronger
-	 * guarantee than we get with a normal seqlock.
-	 *
-	 * On Xen, we don't appear to have that guarantee, but Xen still
-	 * supplies a valid seqlock using the version field.
-	 *
-	 * We only do pvclock vdso timing at all if
-	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
-	 * mean that all vCPUs have matching pvti and that the TSC is
-	 * synced, so we can just look at vCPU 0's pvti.
-	 */
-
-	do {
-		version = pvclock_read_begin(pvti);
-
-		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
-			return U64_MAX;
-
-		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
-	} while (pvclock_read_retry(pvti, version));
-
-	return ret;
-}
-#endif
-#ifdef CONFIG_HYPERV_TSCPAGE
-static notrace u64 vread_hvclock(void)
-{
-	const struct ms_hyperv_tsc_page *tsc_pg =
-		(const struct ms_hyperv_tsc_page *)&hvclock_page;
-
-	return hv_read_tsc_page(tsc_pg);
-}
-#endif
-
-notrace static inline u64 vgetcyc(int mode)
-{
-	if (mode == VCLOCK_TSC)
-		return (u64)rdtsc_ordered();
-#ifdef CONFIG_PARAVIRT_CLOCK
-	else if (mode == VCLOCK_PVCLOCK)
-		return vread_pvclock();
-#endif
-#ifdef CONFIG_HYPERV_TSCPAGE
-	else if (mode == VCLOCK_HVCLOCK)
-		return vread_hvclock();
-#endif
-	return U64_MAX;
-}
-
-notrace static int do_hres(clockid_t clk, struct timespec *ts)
+notrace int __vdso_clock_gettime(clockid_t clock, struct __vdso_timespec *ts)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
-	u64 cycles, last, sec, ns;
-	unsigned int seq;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		cycles = vgetcyc(gtod->vclock_mode);
-		ns = base->nsec;
-		last = gtod->cycle_last;
-		if (unlikely((s64)cycles < 0))
-			return vdso_fallback_gettime(clk, ts);
-		if (cycles > last)
-			ns += (cycles - last) * gtod->mult;
-		ns >>= gtod->shift;
-		sec = base->sec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
-notrace static void do_coarse(clockid_t clk, struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[clk];
-	unsigned int seq;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		ts->tv_sec = base->sec;
-		ts->tv_nsec = base->nsec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
+	return __cvdso_clock_gettime(clock, ts);
 }
 
-notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
-{
-	unsigned int msk;
-
-	/* Sort out negative (CPU/FD) and invalid clocks */
-	if (unlikely((unsigned int) clock >= MAX_CLOCKS))
-		return vdso_fallback_gettime(clock, ts);
-
-	/*
-	 * Convert the clockid to a bitmask and use it to check which
-	 * clocks are handled in the VDSO directly.
-	 */
-	msk = 1U << clock;
-	if (likely(msk & VGTOD_HRES)) {
-		return do_hres(clock, ts);
-	} else if (msk & VGTOD_COARSE) {
-		do_coarse(clock, ts);
-		return 0;
-	}
-	return vdso_fallback_gettime(clock, ts);
-}
-
-int clock_gettime(clockid_t, struct timespec *)
+int clock_gettime(clockid_t, struct __vdso_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+notrace int __vdso_gettimeofday(struct __vdso_timeval *tv,
+				struct timezone *tz)
 {
-	if (likely(tv != NULL)) {
-		struct timespec *ts = (struct timespec *) tv;
-
-		do_hres(CLOCK_REALTIME, ts);
-		tv->tv_usec /= 1000;
-	}
-	if (unlikely(tz != NULL)) {
-		tz->tz_minuteswest = gtod->tz_minuteswest;
-		tz->tz_dsttime = gtod->tz_dsttime;
-	}
-
-	return 0;
+	return __cvdso_gettimeofday(tv, tz);
 }
-int gettimeofday(struct timeval *, struct timezone *)
+int gettimeofday(struct __vdso_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-/*
- * This will break when the xtime seconds get inaccurate, but that is
- * unlikely
- */
 notrace time_t __vdso_time(time_t *t)
 {
-	/* This is atomic on x86 so we don't need any locks. */
-	time_t result = READ_ONCE(gtod->basetime[CLOCK_REALTIME].sec);
-
-	if (t)
-		*t = result;
-	return result;
+	return __cvdso_time(t);
 }
 time_t time(time_t *t)
 	__attribute__((weak, alias("__vdso_time")));
+
+notrace int __vdso_clock_getres(clockid_t clock,
+				struct __vdso_timespec *res)
+{
+	return __cvdso_clock_getres(clock, res);
+}
+int clock_getres(clockid_t, struct __vdso_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index d3a2dce4cfa9..36b644e16272 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -25,6 +25,8 @@ VERSION {
 		__vdso_getcpu;
 		time;
 		__vdso_time;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 422764a81d32..991b26cc855b 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -26,6 +26,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
+		__vdso_clock_getres;
 	};
 
 	LINUX_2.5 {
diff --git a/arch/x86/entry/vdso/vdsox32.lds.S b/arch/x86/entry/vdso/vdsox32.lds.S
index 05cd1c5c4a15..16a8050a4fb6 100644
--- a/arch/x86/entry/vdso/vdsox32.lds.S
+++ b/arch/x86/entry/vdso/vdsox32.lds.S
@@ -21,6 +21,7 @@ VERSION {
 		__vdso_gettimeofday;
 		__vdso_getcpu;
 		__vdso_time;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index cfcdba082feb..f7b0978f3919 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -19,65 +19,97 @@
 
 int vclocks_used __read_mostly;
 
-DEFINE_VVAR(struct vsyscall_gtod_data, vsyscall_gtod_data);
+DEFINE_VVAR(struct vdso_data, vdso_data);
 
 void update_vsyscall_tz(void)
 {
-	vsyscall_gtod_data.tz_minuteswest = sys_tz.tz_minuteswest;
-	vsyscall_gtod_data.tz_dsttime = sys_tz.tz_dsttime;
+	vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
+	vdso_data.tz_dsttime = sys_tz.tz_dsttime;
 }
 
 void update_vsyscall(struct timekeeper *tk)
 {
 	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
-	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
-	struct vgtod_ts *base;
+	struct vdso_data *vdata = &vdso_data;
+	struct vdso_timestamp *vdso_ts;
 	u64 nsec;
 
 	/* Mark the new vclock used. */
 	BUILD_BUG_ON(VCLOCK_MAX >= 32);
 	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
 
-	gtod_write_begin(vdata);
+	vdso_write_begin(vdata);
 
 	/* copy vsyscall data */
-	vdata->vclock_mode	= vclock_mode;
+	vdata->clock_mode	= vclock_mode;
 	vdata->cycle_last	= tk->tkr_mono.cycle_last;
-	vdata->mask		= tk->tkr_mono.mask;
-	vdata->mult		= tk->tkr_mono.mult;
-	vdata->shift		= tk->tkr_mono.shift;
-
-	base = &vdata->basetime[CLOCK_REALTIME];
-	base->sec = tk->xtime_sec;
-	base->nsec = tk->tkr_mono.xtime_nsec;
-
-	base = &vdata->basetime[CLOCK_TAI];
-	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
-	base->nsec = tk->tkr_mono.xtime_nsec;
-
-	base = &vdata->basetime[CLOCK_MONOTONIC];
-	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec = tk->tkr_mono.xtime_nsec;
-	nsec +=	((u64)tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
+	vdata->cs[CLOCKSOURCE_MONO].mask
+				= tk->tkr_mono.mask;
+	vdata->cs[CLOCKSOURCE_MONO].mult
+				= tk->tkr_mono.mult;
+	vdata->cs[CLOCKSOURCE_MONO].shift
+				= tk->tkr_mono.shift;
+	vdata->cs[CLOCKSOURCE_RAW].mask
+				= tk->tkr_raw.mask;
+	vdata->cs[CLOCKSOURCE_RAW].mult
+				= tk->tkr_raw.mult;
+	vdata->cs[CLOCKSOURCE_RAW].shift
+				= tk->tkr_raw.shift;
+	/* CLOCK_REALTIME */
+	vdso_ts			= &vdata->basetime[CLOCK_REALTIME];
+	vdso_ts->sec		= tk->xtime_sec;
+	vdso_ts->nsec		= tk->tkr_mono.xtime_nsec;
+	/* CLOCK_MONOTONIC */
+	vdso_ts			= &vdata->basetime[CLOCK_MONOTONIC];
+	vdso_ts->sec		= tk->xtime_sec +
+					tk->wall_to_monotonic.tv_sec;
+	nsec			= tk->tkr_mono.xtime_nsec;
+	nsec			= nsec +
+				  ((u64)tk->wall_to_monotonic.tv_nsec <<
+				   tk->tkr_mono.shift);
 	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
-		nsec -= ((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
-		base->sec++;
+		nsec = nsec -
+			(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
+		vdso_ts->sec++;
 	}
-	base->nsec = nsec;
-
-	base = &vdata->basetime[CLOCK_REALTIME_COARSE];
-	base->sec = tk->xtime_sec;
-	base->nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
-
-	base = &vdata->basetime[CLOCK_MONOTONIC_COARSE];
-	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
-	nsec += tk->wall_to_monotonic.tv_nsec;
+	vdso_ts->nsec		= nsec;
+	/* CLOCK_MONOTONIC_RAW */
+	vdso_ts			= &vdata->basetime[CLOCK_MONOTONIC_RAW];
+	vdso_ts->sec		= tk->raw_sec;
+	vdso_ts->nsec		= tk->tkr_raw.xtime_nsec;
+	/* CLOCK_BOOTTIME */
+	vdso_ts			= &vdata->basetime[CLOCK_BOOTTIME];
+	vdso_ts->sec		= tk->xtime_sec +
+					tk->wall_to_monotonic.tv_sec;
+	nsec			= tk->tkr_mono.xtime_nsec;
+	nsec			= nsec +
+				  ((u64)(tk->wall_to_monotonic.tv_nsec +
+				   ktime_to_ns(tk->offs_boot)) <<
+				   tk->tkr_mono.shift);
+	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+		nsec = nsec -
+			(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
+		vdso_ts->sec++;
+	}
+	vdso_ts->nsec		= nsec;
+	/* CLOCK_TAI */
+	vdso_ts			= &vdata->basetime[CLOCK_TAI];
+	vdso_ts->sec		= tk->xtime_sec + (s64)tk->tai_offset;
+	vdso_ts->nsec		= tk->tkr_mono.xtime_nsec;
+	/* CLOCK_REALTIME_COARSE */
+	vdso_ts			= &vdata->basetime[CLOCK_REALTIME_COARSE];
+	vdso_ts->sec		= tk->xtime_sec;
+	vdso_ts->nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	/* CLOCK_MONOTONIC_COARSE */
+	vdso_ts			= &vdata->basetime[CLOCK_MONOTONIC_COARSE];
+	vdso_ts->sec		= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec			= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec			= nsec + tk->wall_to_monotonic.tv_nsec;
 	while (nsec >= NSEC_PER_SEC) {
-		nsec -= NSEC_PER_SEC;
-		base->sec++;
+		nsec = nsec - NSEC_PER_SEC;
+		vdso_ts->sec++;
 	}
-	base->nsec = nsec;
+	vdso_ts->nsec		= nsec;
 
-	gtod_write_end(vdata);
+	vdso_write_end(vdata);
 }
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..1a86fdc1e400
--- /dev/null
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Fast user context implementation of clock_gettime, gettimeofday, and time.
+ *
+ * Copyright (C) 2019 ARM Limited.
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
+ *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <uapi/linux/time.h>
+#include <asm/vgtod.h>
+#include <asm/vvar.h>
+#include <asm/unistd.h>
+#include <asm/msr.h>
+#include <asm/pvclock.h>
+#include <asm/mshyperv.h>
+
+#define _vdso_data (&VVAR(vdso_data))
+
+#define VDSO_HAS_TIME 1
+
+#ifdef CONFIG_PARAVIRT_CLOCK
+extern u8 pvclock_page
+	__attribute__((visibility("hidden")));
+#endif
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+extern u8 hvclock_page
+	__attribute__((visibility("hidden")));
+#endif
+
+#ifndef BUILD_VDSO32
+
+static __always_inline notrace long clock_gettime_fallback(
+						clockid_t _clkid,
+						struct __vdso_timespec *_ts)
+{
+	long ret;
+	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
+	     "0" (__NR_clock_gettime), "D" (_clkid), "S" (_ts) :
+	     "rcx", "r11");
+	return ret;
+}
+
+static __always_inline notrace long gettimeofday_fallback(
+						struct __vdso_timeval *_tv,
+						struct timezone *_tz)
+{
+	long ret;
+	asm("syscall" : "=a" (ret) :
+	    "0" (__NR_gettimeofday), "D" (_tv), "S" (_tz) : "memory");
+	return ret;
+}
+
+static __always_inline notrace long clock_getres_fallback(
+						clockid_t _clkid,
+						struct __vdso_timespec *_ts)
+{
+	long ret;
+	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
+	     "0" (__NR_clock_getres), "D" (_clkid), "S" (_ts) :
+	     "rcx", "r11");
+	return ret;
+}
+
+#else
+
+static __always_inline notrace long clock_gettime_fallback(
+						clockid_t _clkid,
+						struct __vdso_timespec *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_gettime), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+	return ret;
+}
+
+static __always_inline notrace long gettimeofday_fallback(
+						struct __vdso_timeval *_tv,
+						struct timezone *_tz)
+{
+	long ret;
+	asm(
+		"mov %%ebx, %%edx \n"
+		"mov %2, %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday), "g" (_tv), "c" (_tz)
+		: "memory", "edx");
+	return ret;
+}
+
+static __always_inline notrace long clock_getres_fallback(
+						clockid_t _clkid,
+						struct __vdso_timespec *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_getres), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+	return ret;
+}
+
+#endif
+
+#ifdef CONFIG_PARAVIRT_CLOCK
+static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
+{
+	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
+}
+
+static notrace u64 vread_pvclock(void)
+{
+	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
+	u32 version;
+	u64 ret;
+
+	/*
+	 * Note: The kernel and hypervisor must guarantee that cpu ID
+	 * number maps 1:1 to per-CPU pvclock time info.
+	 *
+	 * Because the hypervisor is entirely unaware of guest userspace
+	 * preemption, it cannot guarantee that per-CPU pvclock time
+	 * info is updated if the underlying CPU changes or that that
+	 * version is increased whenever underlying CPU changes.
+	 *
+	 * On KVM, we are guaranteed that pvti updates for any vCPU are
+	 * atomic as seen by *all* vCPUs.  This is an even stronger
+	 * guarantee than we get with a normal seqlock.
+	 *
+	 * On Xen, we don't appear to have that guarantee, but Xen still
+	 * supplies a valid seqlock using the version field.
+	 *
+	 * We only do pvclock vdso timing at all if
+	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
+	 * mean that all vCPUs have matching pvti and that the TSC is
+	 * synced, so we can just look at vCPU 0's pvti.
+	 */
+
+	do {
+		version = pvclock_read_begin(pvti);
+
+		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
+			return U64_MAX;
+
+		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
+	} while (pvclock_read_retry(pvti, version));
+
+	return ret;
+}
+#endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+static notrace u64 vread_hvclock(void)
+{
+	const struct ms_hyperv_tsc_page *tsc_pg =
+		(const struct ms_hyperv_tsc_page *)&hvclock_page;
+
+	return hv_read_tsc_page(tsc_pg);
+}
+#endif
+
+notrace static inline u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	if (clock_mode == VCLOCK_TSC)
+		return (u64)rdtsc_ordered();
+#ifdef CONFIG_PARAVIRT_CLOCK
+	else if (clock_mode == VCLOCK_PVCLOCK)
+		return vread_pvclock();
+#endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+	else if (clock_mode == VCLOCK_HVCLOCK)
+		return vread_hvclock();
+#endif
+	return U64_MAX;
+}
+
+static __always_inline notrace const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return _vdso_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 913a133f8e6f..0b4e343c62be 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -4,6 +4,8 @@
 
 #include <linux/compiler.h>
 #include <linux/clocksource.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
 
 #include <uapi/linux/time.h>
 
@@ -13,43 +15,7 @@ typedef u64 gtod_long_t;
 typedef unsigned long gtod_long_t;
 #endif
 
-/*
- * There is one of these objects in the vvar page for each
- * vDSO-accelerated clockid.  For high-resolution clocks, this encodes
- * the time corresponding to vsyscall_gtod_data.cycle_last.  For coarse
- * clocks, this encodes the actual time.
- *
- * To confuse the reader, for high-resolution clocks, nsec is left-shifted
- * by vsyscall_gtod_data.shift.
- */
-struct vgtod_ts {
-	u64		sec;
-	u64		nsec;
-};
-
-#define VGTOD_BASES	(CLOCK_TAI + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
-#define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
-
-/*
- * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
- * so be carefull by modifying this structure.
- */
-struct vsyscall_gtod_data {
-	unsigned int	seq;
-
-	int		vclock_mode;
-	u64		cycle_last;
-	u64		mask;
-	u32		mult;
-	u32		shift;
-
-	struct vgtod_ts	basetime[VGTOD_BASES];
-
-	int		tz_minuteswest;
-	int		tz_dsttime;
-};
-extern struct vsyscall_gtod_data vsyscall_gtod_data;
+extern struct vdso_data vdso_data;
 
 extern int vclocks_used;
 static inline bool vclock_was_used(int vclock)
@@ -57,37 +23,4 @@ static inline bool vclock_was_used(int vclock)
 	return READ_ONCE(vclocks_used) & (1 << vclock);
 }
 
-static inline unsigned int gtod_read_begin(const struct vsyscall_gtod_data *s)
-{
-	unsigned int ret;
-
-repeat:
-	ret = READ_ONCE(s->seq);
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
-	smp_rmb();
-	return ret;
-}
-
-static inline int gtod_read_retry(const struct vsyscall_gtod_data *s,
-				  unsigned int start)
-{
-	smp_rmb();
-	return unlikely(s->seq != start);
-}
-
-static inline void gtod_write_begin(struct vsyscall_gtod_data *s)
-{
-	++s->seq;
-	smp_wmb();
-}
-
-static inline void gtod_write_end(struct vsyscall_gtod_data *s)
-{
-	smp_wmb();
-	++s->seq;
-}
-
 #endif /* _ASM_X86_VGTOD_H */
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 3f32dfc2ab73..e5598cb4d3a6 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -44,7 +44,7 @@ extern char __vvar_page;
 
 /* DECLARE_VVAR(offset, type, name) */
 
-DECLARE_VVAR(128, struct vsyscall_gtod_data, vsyscall_gtod_data)
+DECLARE_VVAR(128, struct vdso_data, vdso_data)
 
 #undef DECLARE_VVAR
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
