Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:03:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFB92084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E5DfAwmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFB92084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8bh9G7DXl0rmPU9Zr3BNgjAv/o5Zxr16pJB7yYEX8bU=; b=E5DfAwmwiE4Lgn
	yZ8RpNWD9bk1a5AS8F2cn722E4K2mVX1K7x/NK1ZdBnYGOp8gDJpVz8CE8O+EbRvrb2eQV7HO1BQ3
	iMUUxB5flLKOl+QFNAlm73bMEc21ZaIG/oLF3TOucgAsLVhN4UKW2cWNVqukUn8sqEVaxCthC4ZT0
	sDRavEcYFmag1t/dm0TRhQFRzLI0YnszJcv8la53cbh7fnb8LLf08LtE4uxvauEZ8K49lW1LgRSqi
	m8Z2PLnmNuOb9gl0XJ75Hq2QlmHuNmmV7lBEKocFV5h5kt/wAb/FqnJnByO6cPt56jJo9dNAJ2agq
	QxpanDWVPp7rHzoO3N9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWid6-0001S4-HA; Tue, 11 Dec 2018 14:03:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWicz-0001Pr-UJ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:03:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 599521596;
 Tue, 11 Dec 2018 06:03:03 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 678EB3F59C;
 Tue, 11 Dec 2018 06:03:01 -0800 (PST)
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
 <CAK8P3a1hmsf2CKWfQ60aUQMoC1YxWhkRKY3GBRusGnQ2cDCJpQ@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f374ad0f-18a8-d66e-00fa-cba4f25ed540@arm.com>
Date: Tue, 11 Dec 2018 14:02:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1hmsf2CKWfQ60aUQMoC1YxWhkRKY3GBRusGnQ2cDCJpQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_060313_987335_F601E366 
X-CRM114-Status: GOOD (  20.67  )
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
 Paul Burton <paul.burton@mips.com>, Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30/11/2018 14:29, Arnd Bergmann wrote:
> On Thu, Nov 29, 2018 at 11:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
>>> +if HAVE_GENERIC_VDSO
>>> +
>>> +config GENERIC_GETTIMEOFDAY
>>> +     bool
>>> +     help
>>> +       This is a generic implementation of gettimeofday vdso.
>>> +       Each architecture that enables this feature has to
>>> +       provide the fallback implementation.
>>> +
>>> +config GENERIC_VDSO_32
>>> +     bool
>>> +     depends on GENERIC_GETTIMEOFDAY && !64BIT
>>> +     help
>>> +       This config option helps to avoid possible performance issues
>>> +       in 32 bit only architectures.
>>> +
>>> +config HAVE_ARCH_TIMER
>>> +     bool
>>> +     depends on GENERIC_GETTIMEOFDAY
>>> +     help
>>> +       Select this configuration option if the architecture has an arch
>>> +       timer.
>>
>> Please don't add code which is architecture specific to the generic
>> implementation. There is really no reason to make ARCH_TIMER special.
> 
> I think it's just unfortunate naming based on what arm64 had, but
> conceptually it does the right thing, and just disable the clock_gettime
> fastpath on kernel builds that never have access to a clocksource
> from user space.
> 

I agree with Arnd here, that was the spirit of this option. I will find a better
name in v3.

>>> +static notrace int __cvdso_clock_getres(clockid_t clock_id,
>>> +                                     struct __vdso_timespec *res)
>>> +{
>>> +     u64 ns;
>>> +
>>> +     if (!__arch_valid_arg(res))
>>> +             return -EFAULT;
>>> +
>>> +     if (clock_id == CLOCK_REALTIME ||
>>> +         clock_id == CLOCK_TAI ||
>>> +         clock_id == CLOCK_BOOTTIME ||
>>> +         clock_id == CLOCK_MONOTONIC ||
>>> +         clock_id == CLOCK_MONOTONIC_RAW)
>>> +             ns = MONOTONIC_RES_NSEC;
>>
>> This is wrong. You cannot unconditionally set that. See what the syscall
>> based version does. You always need to verify that the syscall version and
>> the vdso version return the same information and not something randomly
>> different.
> 
> Do you think we actually need the fastpath here? If not, the
> easy way to do it would be to always fall back to calling
> the syscall based version. Or was this originally added
> to deal with the syscall and vdso clock_gettime having
> different resolutions (which would sound like a bad idea, but
> might have to stay for compatibility)?
> 

Running ./vdsotest-bench on getres, these are the results:

clock-getres-monotonic: syscall: 679 nsec/call
clock-getres-monotonic:    libc: 701 nsec/call (using syscall)
clock-getres-monotonic:    vdso: 14 nsec/call

hence I think the fastpath for getres seems justified.

>       Arnd
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
