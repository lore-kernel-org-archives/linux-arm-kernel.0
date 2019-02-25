Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4047EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:10:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D40520663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mgb0ScHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D40520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ei9hibwLETo3M2JiH8esk6m9KMDIxwGWTAd6g6GmKs0=; b=mgb0ScHB1aLki7
	Srk3lLceMCT9GUSF032BNSj8UbGA2nwZJi/aIUr68/t9JHCuy1MGfNEVkw8QuznTxrJZcpcpF4pt8
	lKVTF8VuKBQ5ncC32giQoQsw8oVb1aBCSMVkadxTIz8NR9LQQ04zIJFjvLfDNLg7BKvpRPrAvovG0
	N5BDzVTGjYJo4VDfHBmw1ApGNDCoNZE8yOmraEFHUdXuh4u7Rbw+yasNiH2J2Qbvo3LqY6zEnP3EB
	uqETttVJ2rIkG+mgsLhajzUY0WXrZ+uEPkrkS+iRX/nnggkRZTtmyH19uQUNLbCull8QFWFCAP+Pj
	qefWWOEocq9rN5w49Qiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGxO-0004r6-RD; Mon, 25 Feb 2019 14:10:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGxH-0003ef-2V
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:10:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D008780D;
 Mon, 25 Feb 2019 06:09:59 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7333F3F575;
 Mon, 25 Feb 2019 06:09:57 -0800 (PST)
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231123030.1666@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <025bc260-85aa-a04e-b29b-b664f50abc3c@arm.com>
Date: Mon, 25 Feb 2019 14:09:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902231123030.1666@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_061003_125140_25B88D43 
X-CRM114-Status: GOOD (  22.36  )
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
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Thomas,

thank you for your review.

On 23/02/2019 10:34, Thomas Gleixner wrote:
> On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>> +static notrace int __cvdso_clock_getres(clockid_t clock,
>> +					struct __vdso_timespec *res)
>> +{
>> +	u64 sec, ns;
>> +	u32 msk;
>> +
>> +	/* Check for negative values or invalid clocks */
>> +	if (unlikely((u32) clock >= MAX_CLOCKS))
>> +		goto fallback;
>> +
>> +	/*
>> +	 * Convert the clockid to a bitmask and use it to check which
>> +	 * clocks are handled in the VDSO directly.
>> +	 */
>> +	msk = 1U << clock;
>> +	if (msk & VDSO_HRES) {
>> +		/*
>> +		 * Preserves the behaviour of posix_get_hrtimer_res().
>> +		 */
> 
> So much for the theory.
> 
>> +		sec = 0;
>> +		ns = MONOTONIC_RES_NSEC;
> 
> posix_get_hrtimer_res() does:
> 
> 	sec = 0;
> 	ns = hrtimer_resolution;
> 
> and hrtimer_resolution depends on the enablement of high resolution timers
> either compile or run time.
> 
> So you need to have a copy of hrtimer_resolution in the vdso data and use
> that.
> 

I agree, MONOTONIC_RES_NSEC can be HIGH_RES_NSEC or LOW_RES_NSEC depending on
the HIGH_RES_TIMERS configuration option, but does not cover the run time
switch. I will add a copy of hrtimer_resolution in the vdso data in the next
iteration of the patches.

I had a look at the other implementations as well, and it seems that all the
architectures that currently implement getres() make the same wrong assumption I
made. I am going to provide a separate patch set that targets this.

>> +	} else if (msk & VDSO_COARSE) {
>> +		/*
>> +		 * Preserves the behaviour of posix_get_coarse_res().
>> +		 */
>> +		ns = LOW_RES_NSEC;
>> +		sec = __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> 
> Do we allow CONFIG_HZ = 1?
> 

I had a closer look at it today and seems that jiffies.h supports CONFIG_HZ=12
as a minimum case. Hence I think it should be safe to remove __iter_div_u64_rem
and set sec=0 in this case.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
