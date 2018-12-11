Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A967EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:40:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B45F2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G98tvf0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B45F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n5j5ja4zUtddB7ed83jAXXPiy/iUYja/Hr8Tz9SM3bY=; b=G98tvf0WbQJhQR
	KhaCBAAGDfmihWYOvBqABvQIQNSA9/0AR5fCu8HEZKx5Rp/USRfBJL/QIbtnKrl94Zc4OktVlgTRj
	jTF1QmykJzomK3ya7NHc1TV3HFMvOsCxRd8lKWqbyQD6UPz4K2nuH1RRM4EqDssoAtzGx8dg6eItV
	XNG/GwNoUBoFpdDIEtxlWX4dxuKBJDaOi540KCI4RFwHpoGGnXoci228z8RyITHYrejOj4cT5Hj4P
	PR7WyFhtNs4rXiJuchN/5chKJFBYz3zyNMRlxUCfgzglfBOI4baaD8zCpGrfdhyYJ65CyQizamHDJ
	0QjhzEHWuFoL8i9dV4dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiGn-0006h5-1q; Tue, 11 Dec 2018 13:40:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiGa-0005PF-Pz
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:40:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E37961596;
 Tue, 11 Dec 2018 05:39:53 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1AF73F59C;
 Tue, 11 Dec 2018 05:39:51 -0800 (PST)
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
To: Arnd Bergmann <arnd@arndb.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <CAK8P3a1njNBWiMExBevqbT+AuUHdU4T2sc1o1rRTn+Ji=y2SbA@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <64ff3b50-ce55-ff69-ac3a-61f221299895@arm.com>
Date: Tue, 11 Dec 2018 13:39:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1njNBWiMExBevqbT+AuUHdU4T2sc1o1rRTn+Ji=y2SbA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_054005_175622_3113012B 
X-CRM114-Status: GOOD (  24.83  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

thank you for reviewing my patches.

On 29/11/2018 20:42, Arnd Bergmann wrote:
> On Thu, Nov 29, 2018 at 6:06 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> 
>> +/*
>> + * The definitions below are required to overcome the limitations
>> + * of time_t on 32 bit architectures, which overflows in 2038.
>> + * The new code should use the replacements based on time64_t and
>> + * timespec64.
>> + *
>> + * The abstraction below will be updated once the migration to
>> + * time64_t is complete.
>> + */
>> +#ifdef CONFIG_GENERIC_VDSO_32
>> +#define __vdso_timespec                old_timespec32
>> +#define __vdso_timeval         old_timeval32
>> +#else
>> +#ifdef ENABLE_COMPAT_VDSO
>> +#define __vdso_timespec                old_timespec32
>> +#define __vdso_timeval         old_timeval32
>> +#else
>> +#define __vdso_timespec                __kernel_timespec
>> +#define __vdso_timeval         __kernel_old_timeval
>> +#endif /* CONFIG_COMPAT_VDSO */
>> +#endif /* CONFIG_GENERIC_VDSO_32 */
>>
> 
> Have you considered doing this in the reverse way, by including
> the common parts from multiple implementations (32 and 64
> bit), instead of compiling the same source file multiple
> times with different macros set? I think that would make it
> easier to understand.
> 

The common code is never compiled as standalone. It includes arch specific code
(for the fallbacks) and it is included in the arch specific vdso library (for
both 32 and 64 bit where it makes sense). Hence it is built once or twice.

If I understand correctly your question, seems inline with what I am doing.

>> +
>> +#ifdef CONFIG_HAVE_ARCH_TIMER
>> +static __always_inline notrace int __do_realtime_or_tai(
>> +               const struct vdso_data *vd,
>> +               struct __vdso_timespec *ts,
>> +               bool is_tai)
>> +{
>> +       u32 seq, cs_mono_mult, cs_shift;
>> +       u64 ns, sec;
>> +       u64 cycle_last, cs_mono_mask;
>> +
>> +       if (vd->use_syscall)
>> +               return -1;
>> +repeat:
> 
> Maybe instead of the #ifdef, do it like
> 
>      if (!IS_ENABLED(CONFIG_HAVE_ARCH_TIMER) ||
>          vd->use_syscall)
>                 return -1;
> 

Ok, thanks. I will change this in v3.

>> +static notrace int __cvdso_clock_gettime(clockid_t clock,
>> +                                        struct __vdso_timespec *ts)
>> +{
>> +       const struct vdso_data *vd = __arch_get_vdso_data();
>> +
>> +       if (!__arch_valid_arg(ts))
>> +               return -EFAULT;
>> +
>> +       switch (clock) {
>> +       case CLOCK_REALTIME:
>> +               if (do_realtime(vd, ts))
>> +                       goto fallback;
>> +               break;
>> +       case CLOCK_TAI:
>> +               if (do_tai(vd, ts))
>> +                       goto fallback;
>> +               break;
>> +       case CLOCK_MONOTONIC:
>> +               if (do_monotonic(vd, ts))
>> +                       goto fallback;
>> +               break;
>> +       case CLOCK_MONOTONIC_RAW:
>> +               if (do_monotonic_raw(vd, ts))
>> +                       goto fallback;
>> +               break;
> 
> Please sync this up with the latest x86 version in
> arch/x86/entry/vdso/vclock_gettime.c, that version has
> seen a lot of improvements recently, so I'd recommend
> using a copy of that file as the base, and then
> modifying it as needed to make it work on the other
> architectures.
>

Thomas commented on my patches and from v3 I am going to port the recent
improvements to the vdso common code.

>       Arnd
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
