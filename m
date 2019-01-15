Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C19C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:27:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F22220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jyg5z+vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F22220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FVM9thFZqCj+v/lmcJy2L3G4VCp23Ryo9NbTHiYB+CE=; b=jyg5z+vhOlZzZR
	WFMpKLd4ppDMcRkgyUyeGTn03gLfu7lxGvRqXhc/YVdVy9z+Tg0YfTFi+XIB2MgAWKTiAbSE21Msa
	gkLJFHQ2Y58y/NvE+ylIO/rxOAQow54QfCBHpRpScXyty3uBVaXUfz6m3F2Tr8bMtIsPZr5f7QcgO
	YqoXfU+Y3QfobG7x5Ftr+IMv12UaMfGoJ5SrhKnL9FVsQI2UCodjGiWuxQVa43eczpwBmDgkwENqE
	XwlD9WVzT/91kPG8JBxY9s96tNYxII/ptZ9xcc1hOw6NNu0dWfZmwch4hm8PU0hCV2tb+vMzviG1L
	1mgtQ/GEEvAS79/acA8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQco-0007iC-AQ; Tue, 15 Jan 2019 15:27:34 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQcl-0007ho-B8
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:27:33 +0000
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gjQci-0005Rx-F3; Tue, 15 Jan 2019 16:27:28 +0100
Date: Tue, 15 Jan 2019 16:27:27 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v4 02/24] kernel: Define gettimeofday vdso common code
In-Reply-To: <20190115135539.24762-3-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1901151558140.1561@nanos.tec.linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <20190115135539.24762-3-vincenzo.frascino@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_072731_566883_4000DF9F 
X-CRM114-Status: GOOD (  30.30  )
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 15 Jan 2019, Vincenzo Frascino wrote:

> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
> 
> This patch tries to unify the gettimeofday vdso implementation

# git grep 'This patch' Documentation/process

> +/*
> + * To improve performances, in this file, __always_inline it is used

performances?

> + * for the functions called multiple times.
> + */
> +static __always_inline notrace u32 vdso_read_begin(const struct vdso_data *vd)
> +{
> +	u32 seq;
> +
> +repeat:
> +	/* Trying to access concurrent shared memory */

I think I know what you try to say, but the comment does not make sense.

> +	seq = READ_ONCE(vd->seq);
> +	if (seq & 1) {
> +		cpu_relax();
> +		goto repeat;
> +	}
> +
> +	smp_rmb();
> +	return seq;
> +}
> +
> +static __always_inline notrace u32 vdso_read_retry(const struct vdso_data *vd,
> +						   u32 start)
> +{
> +	u32 seq;
> +
> +	smp_rmb();
> +	/* Trying to access concurrent shared memory */

This one even less.

> +	seq = READ_ONCE(vd->seq);
> +	return seq != start;
> +}
> +if HAVE_GENERIC_VDSO
> +
> +config GENERIC_GETTIMEOFDAY
> +	bool
> +	help
> +	  This is a generic implementation of gettimeofday vdso.
> +	  Each architecture that enables this feature has to
> +	  provide the fallback implementation.
> +
> +config GENERIC_VDSO_32
> +	bool
> +	depends on GENERIC_GETTIMEOFDAY && !64BIT
> +	help
> +	  This config option helps to avoid possible performance issues
> +	  in 32 bit only architectures.
> +
> +config HAVE_HW_COUNTER
> +	bool
> +	depends on GENERIC_GETTIMEOFDAY
> +	help
> +	  Select this configuration option if the architecture has an arch
> +	  timer.

What? If the architecture does not have a timer which is VDSO capable in
the first place then why would it ever enable VDSO? Get rid of these
pointless extras please.

> +config CROSS_COMPILE_COMPAT_VDSO
> +	string "32 bit Toolchain prefix for compat vDSO"
> +	depends on GENERIC_COMPAT_VDSO
> +	help
> +	  Defines the cross-compiler prefix for compiling compat vDSO.

Really? Why would every architecture see this Kconfig entry even if it's
not needed?

x8664 compilers can compile the VDSO for 32bit just fine and all they need
are the proper compiler flags.

> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> new file mode 100644
> index 000000000000..f008795f454a
> --- /dev/null
> +++ b/lib/vdso/gettimeofday.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic userspace implementations of gettimeofday() and similar.
> + *
> + * Copyright (C) 2018 ARM Limited
> + * Copyright (C) 2017 Cavium, Inc.
> + * Copyright (C) 2015 Mentor Graphics Corporation

Interesting. Most of that code comes from x86 but everyone and his dog has
it's copyright on it.

> +/*
> + * The generic vDSO implementation requires that gettimeofday.h
> + * provides:
> + * - __arch_get_vdso_data(): to get the vdso datapage.
> + * - __arch_get_hw_counter(): to get the hw counter based on the
> + *   clock_mode.
> + * - __arch_get_realtime_res(): to get the correct realtime res.
> + * - __arch_get_coarse_res(): to get the correct coarse res.
> + * - gettimeofday_fallback(): fallback for gettimeofday.
> + * - clock_gettime_fallback(): fallback for clock_gettime.
> + * - clock_getres_fallback(): fallback for clock_getres.
> + */
> +#include <asm/vdso/gettimeofday.h>
> +
> +#ifdef CONFIG_HAVE_HW_COUNTER

What the heck is this for?

> +static notrace int do_hres(const struct vdso_data *vd,
> +			   clockid_t clk,
> +			   struct __vdso_timespec *ts)
> +{
> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
> +	u64 cycles, last, sec, ns;
> +	u32 seq;
> +
> +	if (vd->use_syscall)
> +		return -1;

No. We optimize for the VDSO case and this extra conditional is really
pointless. If your platform does not support VDSO then why are you exposing
the VDSO at all?

> +	do {
> +		seq = vdso_read_begin(vd);
> +		cycles = __arch_get_hw_counter(vd->clock_mode) & vd->mask;
> +		ns = vdso_ts->nsec;
> +		last = vd->cycle_last;
> +		if (unlikely((s64)cycles < 0))
> +			return clock_gettime_fallback(clk, ts);
> +		if (cycles > last)
> +			ns += (cycles - last) * vd->mult;
> +		ns >>= vd->shift;
> +		sec = vdso_ts->sec;
> +	} while (unlikely(vdso_read_retry(vd, seq)));
> +
> +	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> +	ts->tv_nsec = ns;
> +
> +	return 0;
> +}
> +#else
> +static notrace int do_hres(const struct vdso_data *vd,
> +			   clockid_t clk,
> +			   struct __vdso_timespec *ts)
> +{
> +	return -1;

This is not only pointless, it's broken. You just return -1 to the
caller. What is the caller supposed to do with that information? If the
VDSO is there and there is no suitable clocksource then it has to fall back
to the syscall automatically.

> +#ifdef VDSO_HAS_TIME

Why do we need yet another conditional. If we standartize on a single
implementation then why don't we export all the same functionality?

> +static notrace time_t __cvdso_time(time_t *time)
> +{
> +	u32 seq;
> +	time_t t;
> +	const struct vdso_data *vd = __arch_get_vdso_data();
> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
> +
> +repeat:
> +	seq = vdso_read_begin(vd);
> +
> +	t = vdso_ts->sec;
> +
> +	if (unlikely(vdso_read_retry(vd, seq)))
> +		goto repeat;
> +
> +	if (unlikely(time != NULL))
> +		*time = t;
> +
> +	return t;

Uurgh. This is horrible code, really. Also why is the sequence count
required in the first place? Is there any 64bit architecture where the
access to vd->basetime[...].sec is not atomic?

> +}
> +#endif /* VDSO_HAS_TIME */
> +
> +static notrace int __cvdso_clock_getres(clockid_t clock,
> +					struct __vdso_timespec *res)
> +{

What's the point of exposing clock_getres() via the VDSO? It's not a
hotpath function in any way.

> +	u64 ns;
> +	u32 msk;
> +
> +	/* Check for negative values or invalid clocks */
> +	if (unlikely((u32) clock >= MAX_CLOCKS))
> +		goto fallback;
> +
> +	/*
> +	 * Convert the clockid to a bitmask and use it to check which
> +	 * clocks are handled in the VDSO directly.
> +	 */
> +	msk = 1U << clock;
> +	if (msk & VDSO_HRES)
> +		ns = __arch_get_realtime_res(clock);

And if at all, then why is this an arch function? The resolution
information is generic and in no way architecture specific.

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
