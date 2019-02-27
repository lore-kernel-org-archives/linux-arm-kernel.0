Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:52:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A75720863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NmYe9vjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A75720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fOsMVBeyp8H8uL+EiymqQpKPyxgrbBFGXs28J358qXo=; b=NmYe9vjhIbQC+y
	ja97yYNTaJkXd2rYndJ9Ip6OPfy23VDBAg/N/2XiguzDargpkdwxEJFoH6oYai0QzjhIEc10LbDql
	Slsksk4zyW0RDFsJCRfnUShFFfXu26m0Swih4aDo98F2ZcsS9ispLIUI0syJhwoqP6SfpAhmXTbOA
	QsEc0Paaze+/tVuBqHgYfP1aTX07wQVDVIvhTHWziVb9SJFCgwTkou9vzWkcokDqweIevyd3lybIc
	AW3am39UqLg+rD64+TXtArpFkKLgOAYsqd6WbM3/HEoE6WbLmppTK0W+ugi/W1hlTHnZ4rCzHHahv
	HKfIN99hdh451sDU6xtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0ZT-0007OB-6r; Wed, 27 Feb 2019 14:52:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0ZK-0007Nn-Vm
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 14:52:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDC03374;
 Wed, 27 Feb 2019 06:52:21 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 622FE3F703;
 Wed, 27 Feb 2019 06:52:19 -0800 (PST)
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
To: Arnd Bergmann <arnd@arndb.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1f9b21cd-81f5-dfa9-70fb-af8228195cb4@arm.com>
Date: Wed, 27 Feb 2019 14:52:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_065227_447485_314739CC 
X-CRM114-Status: GOOD (  20.93  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

thank you for your review.

On 22/02/2019 13:49, Arnd Bergmann wrote:
> On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino
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
> 
> I don't think we need __vdso_timeval at all, just use
> __kernel_old_timeval everywhere. There is no generic
> 64-bit timeval type in the kernel, and there won't be because
> gettimeofday() is deprecated.
> 

Ok, I will update my implementation accordingly in v6.

> For __vdso_timespec, I see how you ended up with this
> redefinition, and it makes the current version of your patches
> easier, but I fear it will in turn make it harder to add the
> __kernel_old_timeval based variant.
> 

What is __kernel_old_timespec (based on you next email)? Why do you think it
will make harder to add the new variants?

-- 
Regards,
Vincenzo

> What I'd prefer to see here is to always use the fixed length
> types everywhere in the code, such as
> 
> static notrace int __cvdso_clock_gettime64(clockid_t clock,
>                                         struct __kernel_timespec *ts)
> {
> ... /* normal clock_gettime using 64-bit times */
> }
> 
> static notrace int __cvdso_clock_gettime32(clockid_t clock,
>                                         struct old_timespec32 *ts32)
> {
>      struct __kernel_timespec ts;
>      int ret = __cvdso_clock_gettime64(clock, &ts);
> 
>      ts32->tv_sec = ts->tv_sec;
>      ts32->tv_nsec = ts->tv_nsec;
> 
>      return ret;
> }
> 
> and then have two different versions for 32-bit and 64-bit
> architectures, calling one or the other function of the
> generic code.
> 
>         Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
