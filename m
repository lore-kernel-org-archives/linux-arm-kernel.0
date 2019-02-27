Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:07:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A47A217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XZdEtaH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A47A217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8HL9ABkUGYdZabpSEE4hdln1Shw5MTwCEmFcP6QpMnc=; b=XZdEtaH5yMO86f
	54/SOrh3JdvwtcTwMWL2lhVUrhwYtq1gPjRCZg3pBHZ3ERzLPgC3dVaAFQ7/xHv86yGAfLizef5l0
	UWCXw+RwzA6CmUty4EXV8e3IiC7meiAx5xssIxedQgo2mqvOSsa27KagQ/gA3u0y3U7xcbJsfwE72
	ADDrFj7w3dn4hTx3TcpG1xHY8VEkLevQmKt7NYZs33r35tBvVkjSHd0w+cZAeJ1d/n1653Z81/+kL
	n+HwNulztdctpCEdiCc1eSpxJB7o8pdGEYobc/JztV5pX4F7uzkwu2fBIwpcOdJfWtvNmGkzDY7Z0
	nrrZH82H5x1Sb0WD/rVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz1jV-00012I-I7; Wed, 27 Feb 2019 16:06:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz1jS-00011V-C4
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:06:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38A3A1596;
 Wed, 27 Feb 2019 08:06:53 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1FCD3F738;
 Wed, 27 Feb 2019 08:06:50 -0800 (PST)
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
 <9c1da773-7fae-69ad-484b-224f3e76ea09@arm.com>
 <alpine.DEB.2.21.1902271640260.26197@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <65173128-04b3-fd03-247b-d090703244ac@arm.com>
Date: Wed, 27 Feb 2019 16:06:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902271640260.26197@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_080654_417477_0C01AE26 
X-CRM114-Status: GOOD (  15.53  )
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

On 27/02/2019 15:49, Thomas Gleixner wrote:
> Vincenzo,
> 
> On Wed, 27 Feb 2019, Vincenzo Frascino wrote:
>>
>> The clocksource array has two elements (CLOCKSOURCE_RAW, CLOCKSOURCE_MONO) and
>> the situation with my scheme should be the following:
> 
> Oops. I misread the patch, but still...
> 
>> 	u32		seq:			+    0
>> 	s32		clock_mode;		+    4
>> 	u64		cycle_last;		+    8
>> 	struct vdso_cs	cs[2];			+    16
>> 	struct vdso_ts	basetime[VDSO_BASES];	+    48
>>
>> which I agree makes still things a bit worse.
> 
>>> It's easy enough to benchmark these implementations and without trying I'm
>>> pretty sure that you can see the performance drop nicely. Please do so next
>>> time and provide the numbers in the changelogs.
>>>
>>
>> I did run some benchmarks this morning to quantify the performance impact and
>> seems that using vdsotest[1] the difference in between a stock linux kernel
>> 5.0.0-rc7 and one that has unified vDSO, running on my x86 machine (Xeon Gold
>> 5120T), is below 1%. Please find the results below, I will add them as well to
>> the next changelog.
> 
> I have some doubts about 1%.
> 			    	   NEW	STOCK
> clock-gettime-monotonic:    vdso:  31	 28    ~ 10% slower
> clock-gettime-realtime:     vdso:  32    29    ~ 10% slower
>

Sorry, there was an error in my script that I used to extract percentages. I
agree! Luckily I shared the numbers. Thanks Thomas.

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
