Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F9C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:20:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9B92070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MV02CAmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9B92070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SeS+yh45ZLupB4v4eOlq9p/I6o/ZkjP7kCbBMw07JMs=; b=MV02CAmUpweZfnRcVDxFU8YzV
	TYFJgwbvALSW1wbR87HsUpZCN5alpE7AUrTIR0hV/UUopzhGuaaRf1RM8M2oF9WVOul8zoPz1E37P
	tbxVfHdNAtl00ZidR9IHOAKlowXjvM94x3Vb73JvlQ132c2kM9GHxIDsoCDA7C13g4yv/l94+iFlb
	d7UYZ+IJ52Udnnj+Oev+G/C1rWLx4SIMON8CY4i4tqQhK7nndCk9aI91ivV7PtNarr9xseHA/3xGS
	FzY6DzeyYRCf4Zs5vzYac7bTapYC7g9qmHljbOjPZ4ePDZ3FVzAVtnpg8xjePPdeBZNu0Rjc9JcvE
	vYozY8E1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqylt-0004et-7N; Tue, 05 Feb 2019 11:20:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqylo-0003eR-Qv
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 11:20:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B2E480D;
 Tue,  5 Feb 2019 03:20:01 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A05A73F675;
 Tue,  5 Feb 2019 03:19:59 -0800 (PST)
Subject: Re: [PATCH 1/5] perf/arm-cci: Fix CPU hotplug race avoidance
To: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com
References: <cover.1549299188.git.robin.murphy@arm.com>
 <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3ebabec2-5423-9aca-19aa-7cd96353efd6@arm.com>
Date: Tue, 5 Feb 2019 11:19:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_032004_885054_7E3704CB 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: peterz@infradead.org, bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, Meng.Li@windriver.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Robin,

On 04/02/2019 17:09, Robin Murphy wrote:
> The arm-cci probe logic faces a cyclic dependency wherein it has to pick
> a valid CPU to associate with before registering the PMU device, has to
> have the PMU state initialised before handling hotplug events in case it
> must be migrated, but has to have the hotplug notifier registered before
> the chosen CPU may go offline lest things get out of sync. The present
> code has tried to solve the races by using get_cpu() to pick the current
> CPU and prevent it from disappearing while the other two registrations
> are performed, but that results in taking mutexes with preemption
> disabled, which makes certain configurations very unhappy:
> 
> [ 1.983337] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
> [ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
> [ 1.983342] Preemption disabled at:
> [ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
> [ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-preempt-rt #1
> [ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [ 1.983364] Call trace:
> [ 1.983369] dump_backtrace+0x0/0x158
> [ 1.983372] show_stack+0x24/0x30
> [ 1.983378] dump_stack+0x80/0xa4
> [ 1.983383] ___might_sleep+0x138/0x160
> [ 1.983386] __might_sleep+0x58/0x90
> [ 1.983391] __rt_mutex_lock_state+0x30/0xc0
> [ 1.983395] _mutex_lock+0x24/0x30
> [ 1.983400] perf_pmu_register+0x2c/0x388
> [ 1.983404] cci_pmu_probe+0x2bc/0x488
> [ 1.983409] platform_drv_probe+0x58/0xa8
> 
> However, we don't actually mind being preempted or migrated at this
> point; all that really matters is that whichever CPU we pick does not
> get offlined before we're done. Thus, do the robust thing and instead
> take the lock to inhibit CPU hotplug for the duration. This also
> revealed an additional race in assigning the global pointer too late
> relative to the hotplug notifier, so that gets fixed in the process.
> 
> Reported-by: "Li, Meng" <Meng.Li@windriver.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for fixing the issues.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
