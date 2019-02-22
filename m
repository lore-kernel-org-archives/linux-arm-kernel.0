Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE24C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:34:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF6E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lXQoPcA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF6E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f6Oin1l++58qAGi7SMFcEY1Evpvq3Ok1E7mlRs37bBU=; b=lXQoPcA2KJXOYs
	mSGbI8NNqGEJLmeY6iOWB+MN3a0NnRQWmnT1NEpnwVoSrBhfG2y30eQsl7Z8phR7mJ1J3MSjsBHwU
	FPJY0PEmGkSNOsUcDLADZ0Qfbhqn7InaxTfeXuaBbjRSPTdanfgliqQ0h176JeUkf38fb5NHsXLWq
	95YJbwrrR4G49c0KPnKXQvR/7CtwTKgw9m9J9DWj3hej4Vvly/FsOsvVUDIn0czUUJhp4h00ElEv0
	+JPvQWvPVEFDRTZQUL46E0gLDwKWxusvbrXx7hGpr7SGua0svMZH6BIRAHTHZZf0UvHFpiQzXcErA
	QxCpFLURMh2162J2lKwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAyH-0007s9-Ad; Fri, 22 Feb 2019 13:34:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAyD-0007re-7p
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 13:34:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71177A78;
 Fri, 22 Feb 2019 05:34:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C45893F690;
 Fri, 22 Feb 2019 05:34:25 -0800 (PST)
Date: Fri, 22 Feb 2019 13:34:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
Message-ID: <20190222133423.GG42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-3-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_053429_292364_580EA1E3 
X-CRM114-Status: GOOD (  27.51  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 12:24:09PM +0000, Vincenzo Frascino wrote:
> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
> 
> Try to unify the gettimeofday vdso implementation introducing
> lib/vdso. The code contained in this library can ideally be
> reused by all the architectures avoiding, where possible, code
> duplication.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/vdso/datapage.h |   1 +
>  include/vdso/helpers.h  |  52 ++++++++++++
>  include/vdso/types.h    |  39 +++++++++
>  lib/Kconfig             |   5 ++
>  lib/vdso/Kconfig        |  37 +++++++++
>  lib/vdso/Makefile       |  22 +++++
>  lib/vdso/gettimeofday.c | 175 ++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 331 insertions(+)
>  create mode 100644 include/vdso/helpers.h
>  create mode 100644 include/vdso/types.h
>  create mode 100644 lib/vdso/Kconfig
>  create mode 100644 lib/vdso/Makefile
>  create mode 100644 lib/vdso/gettimeofday.c
> 
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index da346ad02b03..ff332fcba73c 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -9,6 +9,7 @@
>  #include <linux/bits.h>
>  #include <linux/types.h>
>  #include <linux/time.h>
> +#include <vdso/types.h>
>  
>  #define VDSO_BASES	(CLOCK_TAI + 1)
>  #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
> diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
> new file mode 100644
> index 000000000000..511dea979f6b
> --- /dev/null
> +++ b/include/vdso/helpers.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_HELPERS_H
> +#define __VDSO_HELPERS_H
> +
> +#ifdef __KERNEL__

Nit: __KERNEL__ guards can go.

> +
> +#ifndef __ASSEMBLY__
> +
> +#include <vdso/datapage.h>
> +
> +static __always_inline notrace u32 vdso_read_begin(const struct vdso_data *vd)

Rather than explicitly annotating all functions with notrace, can't we
disable instrumentation for all C files used for the vDSO using compiler
flags?

That would be more robust, and make the code less noisy to read.

> +{
> +	u32 seq;
> +
> +repeat:
> +	seq = READ_ONCE(vd->seq);
> +	if (seq & 1) {
> +		cpu_relax();
> +		goto repeat;
> +	}
> +
> +	smp_rmb();
> +	return seq;
> +}

You could simplify the repeat loop as:

	while ((seq = READ_ONCE(vd->seq)) & 1)
		cpu_relax();

> +
> +static __always_inline notrace u32 vdso_read_retry(const struct vdso_data *vd,
> +						   u32 start)
> +{
> +	u32 seq;
> +
> +	smp_rmb();
> +	seq = READ_ONCE(vd->seq);
> +	return seq != start;
> +}
> +
> +static __always_inline notrace void vdso_write_begin(struct vdso_data *vd)
> +{
> +	++vd->seq;
> +	smp_wmb();
> +}
> +
> +static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
> +{
> +	smp_wmb();
> +	++vd->seq;
> +}

I realise this is what existing vDSO update code does, but I do think
that these should be using WRITE_ONCE() to perform the update, to ensure
that the write is not torn.

e.g. these should be:

static __always_inline notrace void vdso_write_begin(struct vdso_data *vd)
{
	WRITE_ONCE(vd->seq, vd->seq + 1);
	smp_wmb();
}

static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
{
	smp_wmb();
	WRITE_ONCE(vd->seq, vd->seq + 1);
}

Otherwise, the compiler can validly tear updates to vd->seq, and there's
the possibility that a reader sees an inconsistent value for vd->seq,
and consequently uses inconsistent data read from the vdso data page.

[...]

> +#include <linux/types.h>
> +#include <linux/time.h>

Nit: please order headers alphabetically>

> +
> +/*
> + * The definitions below are required to overcome the limitations
> + * of time_t on 32 bit architectures, which overflows in 2038.
> + * The new code should use the replacements based on time64_t and
> + * timespec64.
> + *
> + * The abstraction below will be updated once the migration to
> + * time64_t is complete.
> + */
> +#ifdef CONFIG_GENERIC_VDSO_32
> +#define __vdso_timespec		old_timespec32
> +#define __vdso_timeval		old_timeval32
> +#else
> +#ifdef ENABLE_COMPAT_VDSO
> +#define __vdso_timespec		old_timespec32
> +#define __vdso_timeval		old_timeval32
> +#else
> +#define __vdso_timespec		__kernel_timespec
> +#define __vdso_timeval		__kernel_old_timeval
> +#endif /* CONFIG_COMPAT_VDSO */
> +#endif /* CONFIG_GENERIC_VDSO_32 */

I'm not sure what the comment is trying to say.

For a 64-bit kernel, does this affec the native vDSO, or just the compat
vDSO?

[...]
> +config HAVE_GENERIC_VDSO
> +	bool
> +	default n

IIRC, 'n' is the implicit default.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
