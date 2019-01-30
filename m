Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08152C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26FD2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lvno6WU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26FD2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LGSgkvY5QbvxrioftU5oacFcn4I1ppXm1ESQvl+Z7uA=; b=lvno6WU3SLO9V8
	puo/vZmJL56DKO7nDvZUw6F/HYhlNsRCScrQYx0rx6WnE9peveWN4mzJKfcqcWw58SLlJgcEsDhTW
	j64Lr94ybnXOSAA0G36JGRS3ubGEAoIOWzuEFhivIFq9lv9agUIKP9y0W1kRttYeukaiJQtspqbrg
	+ZHjPV3pNT0Vf1Zwu42zHSS2+56D0/shouBIG+gh9+adGVDUO4uaYUHX7SRuH1xjgnIM2wHxNvQwu
	ltznLhWLgxjlDuKB8gABayT6+gdywBr66lBi9bA2a0LpQYtMBbZRbsQw5tClPh2I2oKkkroEkV6Jt
	bip/gVFaCbq5LhG0CXoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouUR-00019v-7y; Wed, 30 Jan 2019 18:21:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouUO-00019Z-GM
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:21:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A9E80D;
 Wed, 30 Jan 2019 10:21:31 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B51CE3F557;
 Wed, 30 Jan 2019 10:21:30 -0800 (PST)
Date: Wed, 30 Jan 2019 18:21:28 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Li, Meng" <Meng.Li@windriver.com>
Subject: Re: Could you please help to have a look a bug trace in pmu arm-cci.c
Message-ID: <20190130182128.GM18558@fuggles.cambridge.arm.com>
References: <529F9A9100AE8045A7A5B5A00A39FBB862099B8E@ALA-MBD.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529F9A9100AE8045A7A5B5A00A39FBB862099B8E@ALA-MBD.corp.ad.wrs.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_102132_544214_20D24C1B 
X-CRM114-Status: GOOD (  11.33  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, robin.murphy@arm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+Suzuki and Robin]

On Mon, Jan 28, 2019 at 07:19:20AM +0000, Li, Meng wrote:
> When enable kernel configure CONFIG_DEBUG_ATOMIC_SLEEP, there is below trace
> during pmu arm cci driver probe phase.
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
> Because get_cpu() is invoked, preempt is disable, finally, trace occurs when
> call might_sleep()

Hmm, the {get,put}_cpu() usage here looks very broken to me. There's the
fact that it might sleep, but also the assignment to g_cci_pmu is done after
we've re-enabled preemption, so there's a race with CPU hotplug there too.

I don't think we can simply register the hotplug notifier before registering
the PMU, because we can't call into perf_pmu_migrate_context() until the PMU
has been registered. Perhaps we need to use the _cpuslocked() versions of
the hotplug notifier registration functions.

I tried looking at some other drivers, but they all look broken to me, so
there's a good chance I'm missing something. Anybody know how this is
supposed to work?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
