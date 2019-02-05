Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79859C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAAA2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r+W2t6V8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAAA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nmy+sO1u4hHoIAAkBUk4kJhHO166mRiUlj83N8H41x0=; b=r+W2t6V8pwEzKzm1AvglEzIqn
	uyrUM4za6wcg+/zCXKaKI5dVXX72RpEujiHQYh7xeKtX/fe+KYv8ZALIleZDW+HTJy4b6LTKeKhZB
	fpDZcaQH7ytx/rUq7HrVuclb32XWfuOb7jkmam0u/aijAwSWszp8XHu5koEJkhSljYIy5q8c58pOc
	Co6Rl0iIOGo07ZCbOhvO39NxfnvwqtTBZ2Ctmc91ifkrmBjTbp0ycwzb9lJhkeIe6sC+hdKh91SsV
	IAl7iKlasEsoWnBJRpzYVUvRQQUI+qaiG0wi/XyJqgv2ThS0f8+ShMYYvf63NULPX/awPEwMG+7A+
	QinPUw5uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqz3R-0003js-HZ; Tue, 05 Feb 2019 11:38:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqz3P-0003jX-A1
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 11:38:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32C1C80D;
 Tue,  5 Feb 2019 03:38:14 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58DBE3F675;
 Tue,  5 Feb 2019 03:38:12 -0800 (PST)
Subject: Re: [PATCH 3/5] perf/arm-ccn: Fix CPU hotplug race avoidance
To: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com
References: <cover.1549299188.git.robin.murphy@arm.com>
 <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a09e5e4c-f663-8797-0384-fae493ddf29d@arm.com>
Date: Tue, 5 Feb 2019 11:38:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_033815_348967_77C676AD 
X-CRM114-Status: GOOD (  11.92  )
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



On 04/02/2019 17:09, Robin Murphy wrote:
> Like arm-cci, arm-ccn has the same issue where disabling preemption to
> avoid races between registering the PMU device and the hotplug notifier
> can lead to those operations taking mutexes in an invalid context. Fix
> it the same way by disabling hotplug instead of preemption. Since we
> only ever associate the PMU instance with a single CPU, we can also take
> the opportunity to slightly simplify the hotplug handling to track just
> that CPU number instead of a full cpumask.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Suzuki K Poulse <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
