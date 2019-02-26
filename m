Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575E5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:43:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BBD21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j6zpBYbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BBD21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sSYB1dBLd/ZvlsmNRIHWv6d1u0k+SfvGEwJkjqS0i/0=; b=j6zpBYbsbl88cEXWGrP9zQj3Y
	KpqYncpzMLakpylCTlWHQIC2yNefYSqsDOPL35lP5Y1K55tXmphzy1KUBJi7ATEzXSfjib8TnyK7e
	jPknFGIIhAT5hnPcbSIi061olXlXyXbjo2CUnr5gZlVOf8Qx7RsZ7lr7nqJpxQwSHGOFMy9s3e9c8
	hJRtih1RfO0dWGjFQgGgCDOGm8DCqVGBCWSigWjq/CxMj8hawJi6nNCaj1sP32fI2E6siDFEOZJ3A
	3SS3p7Xgsgo+kpzpFl4/N/zejmGYID36NZp44xLgCMZR+smTyiMF9aIQzcTFs+Iexo2LhXBLKPdl9
	TWUgctBzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyesy-000098-ON; Tue, 26 Feb 2019 15:43:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyesw-00008l-BL
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 15:43:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1108D80D;
 Tue, 26 Feb 2019 07:43:10 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420D63F575;
 Tue, 26 Feb 2019 07:43:08 -0800 (PST)
Subject: Re: [PATCH v5 06/26] arm64/sve: Check SVE virtualisability
To: Dave Martin <Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-7-git-send-email-Dave.Martin@arm.com>
 <ea9a0255-5829-883c-d28c-0c34716bbbdb@arm.com>
 <20190226120647.GI3567@e103592.cambridge.arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <a313827f-ccb3-fb26-6e06-26665c1e436b@arm.com>
Date: Tue, 26 Feb 2019 15:43:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226120647.GI3567@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_074310_392105_46EFF11E 
X-CRM114-Status: GOOD (  16.73  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 26/02/2019 12:06, Dave Martin wrote:
> On Thu, Feb 21, 2019 at 01:36:26PM +0000, Julien Grall wrote:
>> Hi Dave,
>>
>> On 18/02/2019 19:52, Dave Martin wrote:
>>> +	/*
>>> +	 * Mismatches above sve_max_virtualisable_vl are fine, since
>>> +	 * no guest is allowed to configure ZCR_EL2.LEN to exceed this:
>>> +	 */
>>> +	if (sve_vl_from_vq(bit_to_vq(b)) <= sve_max_virtualisable_vl) {
>>> +		pr_warn("SVE: cpu%d: Unsupported vector length(s) present\n",
>>> +			smp_processor_id());
>>
>> Would it be worth to print the unsupported vector length?
> 
> Possibly not, but admittedly the intent is a bit unclear in this patch.
> 
> See my reply to Julien Thierry (and respond on that subthread if you
> have comments, so that we don't end up with two subthreads discussing
> the same thing...)

I will have a look at the thread.

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
