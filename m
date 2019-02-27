Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:23:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229842133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JaepHl27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229842133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qMs1RhHcNPiEu+FZK3HIKTmmcaMbD0It9Z8zLSsE8Jg=; b=JaepHl27yD7Lsl
	GsLTJn9qyfU5wcSkji5nW8BenveV8UugIAUuu5NRdxBSRM7b1UUOCRnC0ojYGrNIUCYI17QqA69wf
	zjws6XlpSTvbeoMkOgjz1iMhvzUgVSucUA7OHPjwCY0MbVtSCyGcP1KXSlosEtncaWilcc3lIvHFj
	vsBDw40OlfCI2wfGVvpIqaj5L7oP4kIXnK81AImVz5VBkPBQK8dcI+g1M4BSgr+0SCDNSUlBH/iJV
	KqgkuZ39812RxLy9ESx3YxbblJx15a7XwRtjStxe8ZyIKHNKUcLge9cTXW6Wsq0n1N2b74GrRc+Yo
	/86UH8uh9xePc28bkj4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz074-0003Qf-2g; Wed, 27 Feb 2019 14:23:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz070-0003QG-SG
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 14:23:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5290A374;
 Wed, 27 Feb 2019 06:23:06 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25FC3F5C1;
 Wed, 27 Feb 2019 06:23:03 -0800 (PST)
Subject: Re: [PATCH v5 01/23] kernel: Standardize vdso_datapage
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3f7238b5-3357-3635-38f4-9eaa14e400c9@arm.com>
Date: Wed, 27 Feb 2019 14:23:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_062306_919529_E59ACCE5 
X-CRM114-Status: GOOD (  20.61  )
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

On 23/02/2019 16:51, Thomas Gleixner wrote:
> On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>> +/*
>> + * There is one vdso_clocksource object in vvar for each vDSO clocksource
>> + * (mono, raw). This struct is designed to keep vdso_data "cache-line friendly"
>> + * and optimal in terms of access pattern.
>> + *
>> + * Note that mask and shift are the same for mono and raw.
>> + */
>> +struct vdso_clocksource {
>> +	u64 mask;		/* Clocksource mask */
>> +	u32 mult;		/* Clocksource multiplier */
>> +	u32 shift;		/* Clocksource shift */
> 
> Can you please get rid of the tail comments and use proper kerneldoc
> format?
>

I will fix it in v6, thanks.

>> +/*
>> + * vdso_data will be accessed by 32 and 64 bit code at the same time
>> + * so we should be careful before modifying this structure.
>> + */
>> +struct vdso_data {
>> +	u32 seq;		/* Timebase sequence counter */
>> +
>> +	s32 clock_mode;
>> +	u64 cycle_last;		/* Timebase at clocksource init */
>> +
>> +	struct vdso_clocksource cs[CLOCKSOURCE_BASES];
> 
> Why would you need different clocksource parameters? That really bloats the
> data structure and makes the cache access pattern worse. Also the vdso
> update needs to copy the same data over and over for no value.
> 
> The only clock ID which needs a different mult/shift would be
> MONOTONIC_RAW, but if we expose that through the VDSO then we really can be
> smarter than this. See incomplete and uncompilable patch below for
> reference. You get the idea.
> 

Ok, thank you for providing the reference code. I will update my patches in v6
accordingly.

...

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
