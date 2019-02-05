Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF7C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:04:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E584E217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gRTzIT2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E584E217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3rwW792C9KXU/v2ZByeGbPyCYLFohu3iQ6o8LFTEypI=; b=gRTzIT2XJaP2D/JcOaBsLz9cG
	NY7xPUEMrTtCUVYge4d10OaRi8GRWZ3ZA0yiKc0HXXn9sApSaG0qO9AFl6VXxKZdaWG/RM5alWzKR
	YAIT5TIa8s2aUBAH6V2Zrr6z3G2BVW+kzUJdAtkKem2YF8zD1p56UXHzk6SI/y3asIHZVXwPByAEz
	LnZWoPAtlbI9O3B9ZGlEl8ZQx3IBXsTrkR7hteCLNt4QaSsyo7K6KZwg9sh/Bo0VlY8JyLYmA2GJ0
	JhthvQkYXEHe0uzqinU6GoNZZaFXyGdH80JxrAv8eW9l4/yGuhH1x2ufhm71nL64ys36XV2N5sZ/+
	pKEar7AmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0Os-00055R-U4; Tue, 05 Feb 2019 13:04:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0Op-00054Z-P5
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 13:04:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B30180D;
 Tue,  5 Feb 2019 05:04:26 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BDB3F675;
 Tue,  5 Feb 2019 05:04:24 -0800 (PST)
Subject: Re: [PATCH 5/5] perf/arm_dsu: Fix CPU hotplug races
To: Suzuki K Poulose <suzuki.poulose@arm.com>, will.deacon@arm.com,
 mark.rutland@arm.com
References: <cover.1549299188.git.robin.murphy@arm.com>
 <d376f6bbd5804616b38145780789785b19a37543.1549299188.git.robin.murphy@arm.com>
 <9fcf862c-0d07-cece-852f-6c09128aa0c5@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <84bdba44-9ce1-906c-0575-f931435de886@arm.com>
Date: Tue, 5 Feb 2019 13:04:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9fcf862c-0d07-cece-852f-6c09128aa0c5@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_050427_820816_9A63C2EA 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Suzuki,

On 05/02/2019 11:40, Suzuki K Poulose wrote:
> On 04/02/2019 17:09, Robin Murphy wrote:
>> Like other system PMUs which associate themselves with an arbitrary CPU
>> for housekeeping purposes, arm_dsu has a race between registering the
>> hotplug notifier and registering the PMU device, such that the hotplug
>> niotifier can potentially fire and attempt to migrate the PMU context
>> before the latter is valid. This is easily resolved by inhibiting
>> hotplug until both the notifier and PMU device are successfully set up.
>>
>> For the same reason, also suppress any synchronous notifier calls in the
>> cleanup path if PMU registration fails.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Should we add :
> 
> Fixes: commit 7520fa99246dade7ab6 ("perf: ARM DynamIQ Shared Unit PMU 
> support")
> 
> Either way:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks for the reviews! I think this patch is worthwhile for cleanliness 
and consistency, but since it's neither self-contained (with the 
dependency on #4) nor "fix[ing] a real bug that bothers people" I'm not 
convinced it really deserves backporting - unlike the preemption issue, 
actually getting a crash from this race in practice is unlikely enough 
that it would probably require some determined, deliberate effort to 
trigger it with just the right conditions.

Cheers,
Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
