Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31654C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:10:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D2C2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TpKEAEm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D2C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+OcBJVxh7CzNAkOodLAZJfuh1aJF+bFs1CX7n1I9XdY=; b=TpKEAEm7buwKQ+1f0/4nO9LhG
	kj7iv4cd5j3O+zQR5i5TG+c4X5HFUoYBLlgsAFwCwpG+1pdXluWklqBkFf0uJbOlEgbG95LuQjvKs
	Z1ANM9tyUvfbQybDsFqYpyZ69EyYDgUxUg653e0mZkas+LjqmASY2Usxw64KFF+1M1uBlI002g0Xd
	Y5+Qfc9PuLxY9CD9N66W+qmDUxLlVjZuAhekUYW37J2j3BbqnZAvjtFsqdxJmawUnWB2/XsIhKJKy
	L5TjIc6g8xfYgyaML0FeTT6HUllMiFB1APtMl4gN/L5OoULpehdZUV5vHsHwk0p0ETVYGNHACzKs/
	DYGVKW3eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govFB-0006us-G8; Wed, 30 Jan 2019 19:09:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govF7-0006ty-PD
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:09:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52550EBD;
 Wed, 30 Jan 2019 11:09:46 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B518E3F557;
 Wed, 30 Jan 2019 11:09:44 -0800 (PST)
Subject: Re: Could you please help to have a look a bug trace in pmu arm-cci.c
To: Will Deacon <will.deacon@arm.com>, "Li, Meng" <Meng.Li@windriver.com>
References: <529F9A9100AE8045A7A5B5A00A39FBB862099B8E@ALA-MBD.corp.ad.wrs.com>
 <20190130182128.GM18558@fuggles.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e28ec0ff-aaab-da22-44c3-19b5eaba0f32@arm.com>
Date: Wed, 30 Jan 2019 19:09:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130182128.GM18558@fuggles.cambridge.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_110949_832206_9C24CC58 
X-CRM114-Status: GOOD (  21.71  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 suzuki.poulose@arm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-30 6:21 pm, Will Deacon wrote:
> [+Suzuki and Robin]
> 
> On Mon, Jan 28, 2019 at 07:19:20AM +0000, Li, Meng wrote:
>> When enable kernel configure CONFIG_DEBUG_ATOMIC_SLEEP, there is below trace
>> during pmu arm cci driver probe phase.
>>
>> [ 1.983337] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
>> [ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
>> [ 1.983342] Preemption disabled at:
>> [ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
>> [ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-preempt-rt #1
>> [ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
>> [ 1.983364] Call trace:
>> [ 1.983369] dump_backtrace+0x0/0x158
>> [ 1.983372] show_stack+0x24/0x30
>> [ 1.983378] dump_stack+0x80/0xa4
>> [ 1.983383] ___might_sleep+0x138/0x160
>> [ 1.983386] __might_sleep+0x58/0x90
>> [ 1.983391] __rt_mutex_lock_state+0x30/0xc0
>> [ 1.983395] _mutex_lock+0x24/0x30
>> [ 1.983400] perf_pmu_register+0x2c/0x388
>> [ 1.983404] cci_pmu_probe+0x2bc/0x488
>> [ 1.983409] platform_drv_probe+0x58/0xa8
>>
>> Because get_cpu() is invoked, preempt is disable, finally, trace occurs when
>> call might_sleep()
> 
> Hmm, the {get,put}_cpu() usage here looks very broken to me. There's the
> fact that it might sleep, but also the assignment to g_cci_pmu is done after
> we've re-enabled preemption, so there's a race with CPU hotplug there too.

Hmm, looks like I failed to appreciate that particular race at the time 
- indeed the global should probably be assigned immediately after 
cci_pmu_init() has succeeded.

> I don't think we can simply register the hotplug notifier before registering
> the PMU, because we can't call into perf_pmu_migrate_context() until the PMU
> has been registered. Perhaps we need to use the _cpuslocked() versions of
> the hotplug notifier registration functions.
> 
> I tried looking at some other drivers, but they all look broken to me, so
> there's a good chance I'm missing something. Anybody know how this is
> supposed to work?

As I understand the general pattern, we register the notifier last to 
avoid taking a hotplug callback with a partly-initialised PMU state, 
however since the CPU we've picked is part of that PMU state, we also 
want to avoid getting migrated off that CPU before the notifier is in 
place lest things get out of sync, hence disabling preemption. As far as 
the correctness of implementing that logic, though, it was like that 
when I got here so I've always just assumed it was fine :)

I guess the question is whether we actually need to pick our nominal CPU 
before perf_pmu_register(), or if something like the below would suffice 
- what do you reckon?

Robin.

----->8-----
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1bfeb160c5b1..da9309ff80d7 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1692,19 +1692,18 @@ static int cci_pmu_probe(struct platform_device 
*pdev)
         raw_spin_lock_init(&cci_pmu->hw_events.pmu_lock);
         mutex_init(&cci_pmu->reserve_mutex);
         atomic_set(&cci_pmu->active_events, 0);
-       cci_pmu->cpu = get_cpu();
+       cci_pmu->cpu = -1; /* Avoid races until hotplug notifier is alive */

         ret = cci_pmu_init(cci_pmu, pdev);
-       if (ret) {
-               put_cpu();
+       if (ret)
                 return ret;
-       }
+       g_cci_pmu = cci_pmu;

         cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_CCI_ONLINE,
                                   "perf/arm/cci:online", NULL,
                                   cci_pmu_offline_cpu);
-       put_cpu();
-       g_cci_pmu = cci_pmu;
+       cci_pmu->cpu = smp_processor_id();
+
         pr_info("ARM %s PMU driver probed", cci_pmu->model->name);
         return 0;
  }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
