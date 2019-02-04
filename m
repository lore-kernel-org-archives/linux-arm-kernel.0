Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AEEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:26:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1436820820
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="chZHwMJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1436820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5lj4nMdF6QO2el0bHzoJLnopNlArk3wD+yr49RJuU04=; b=chZHwMJhM2pxiJ
	GpyPPFis/cCe+b+KcmTOd4bxrGiVpfs6DqnPmRJfDTmVIxym7SdMWuNYW4C9JtfLTKuJFN1Aj5Ykn
	0ndbWsuO/BWkLnnfzV8MgdYoxzc3I7FlTxJHc0MYUz5Im0v3uB2IFhArW4ubkg8LWpGLrIDK4WS55
	1sObDXDImyGVxiUPT36Zcy3lc+fTJbuiuhK7UgoW9UGsXYwFxjElJn2Xud7XNcPX1Yb4etToAG4XA
	oDwFyGZRLejNcNMIbmVibB2tqrnCZTTk+nBwZdNw/untM0jJiS0Qqe43R83ckIXb5MpiEGy/UM7Ht
	3E1xClFTgZffrQH/4qCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqaWW-0004ID-HJ; Mon, 04 Feb 2019 09:26:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqaWT-0004HV-JP
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:26:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8046FA78;
 Mon,  4 Feb 2019 01:26:34 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C8E13F557;
 Mon,  4 Feb 2019 01:26:33 -0800 (PST)
Date: Mon, 4 Feb 2019 09:26:28 +0000
From: Will Deacon <will.deacon@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Could you please help to have a look a bug trace in pmu arm-cci.c
Message-ID: <20190204092628.GA20586@fuggles.cambridge.arm.com>
References: <529F9A9100AE8045A7A5B5A00A39FBB862099B8E@ALA-MBD.corp.ad.wrs.com>
 <20190130182128.GM18558@fuggles.cambridge.arm.com>
 <e28ec0ff-aaab-da22-44c3-19b5eaba0f32@arm.com>
 <20190201180112.GA14755@fuggles.cambridge.arm.com>
 <1d06152a-44ee-a786-41b9-25085a6643de@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d06152a-44ee-a786-41b9-25085a6643de@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_012637_650580_9143CC1A 
X-CRM114-Status: GOOD (  31.83  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "Li,
 Meng" <Meng.Li@windriver.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 06:42:46PM +0000, Robin Murphy wrote:
> On 01/02/2019 18:01, Will Deacon wrote:
> > On Wed, Jan 30, 2019 at 07:09:42PM +0000, Robin Murphy wrote:
> > > On 2019-01-30 6:21 pm, Will Deacon wrote:
> > > > [+Suzuki and Robin]
> > > > 
> > > > On Mon, Jan 28, 2019 at 07:19:20AM +0000, Li, Meng wrote:
> > > > > When enable kernel configure CONFIG_DEBUG_ATOMIC_SLEEP, there is below trace
> > > > > during pmu arm cci driver probe phase.
> > > > > 
> > > > > [ 1.983337] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
> > > > > [ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
> > > > > [ 1.983342] Preemption disabled at:
> > > > > [ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
> > > > > [ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-preempt-rt #1
> > > > > [ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> > > > > [ 1.983364] Call trace:
> > > > > [ 1.983369] dump_backtrace+0x0/0x158
> > > > > [ 1.983372] show_stack+0x24/0x30
> > > > > [ 1.983378] dump_stack+0x80/0xa4
> > > > > [ 1.983383] ___might_sleep+0x138/0x160
> > > > > [ 1.983386] __might_sleep+0x58/0x90
> > > > > [ 1.983391] __rt_mutex_lock_state+0x30/0xc0
> > > > > [ 1.983395] _mutex_lock+0x24/0x30
> > > > > [ 1.983400] perf_pmu_register+0x2c/0x388
> > > > > [ 1.983404] cci_pmu_probe+0x2bc/0x488
> > > > > [ 1.983409] platform_drv_probe+0x58/0xa8
> > > > > 
> > > > > Because get_cpu() is invoked, preempt is disable, finally, trace occurs when
> > > > > call might_sleep()
> > > > 
> > > > Hmm, the {get,put}_cpu() usage here looks very broken to me. There's the
> > > > fact that it might sleep, but also the assignment to g_cci_pmu is done after
> > > > we've re-enabled preemption, so there's a race with CPU hotplug there too.
> > > 
> > > Hmm, looks like I failed to appreciate that particular race at the time -
> > > indeed the global should probably be assigned immediately after
> > > cci_pmu_init() has succeeded.
> > > 
> > > > I don't think we can simply register the hotplug notifier before registering
> > > > the PMU, because we can't call into perf_pmu_migrate_context() until the PMU
> > > > has been registered. Perhaps we need to use the _cpuslocked() versions of
> > > > the hotplug notifier registration functions.
> > > > 
> > > > I tried looking at some other drivers, but they all look broken to me, so
> > > > there's a good chance I'm missing something. Anybody know how this is
> > > > supposed to work?
> > > 
> > > As I understand the general pattern, we register the notifier last to avoid
> > > taking a hotplug callback with a partly-initialised PMU state, however since
> > > the CPU we've picked is part of that PMU state, we also want to avoid
> > > getting migrated off that CPU before the notifier is in place lest things
> > > get out of sync, hence disabling preemption. As far as the correctness of
> > > implementing that logic, though, it was like that when I got here so I've
> > > always just assumed it was fine :)
> > > 
> > > I guess the question is whether we actually need to pick our nominal CPU
> > > before perf_pmu_register(), or if something like the below would suffice -
> > > what do you reckon?
> > > 
> > > Robin.
> > > 
> > > ----->8-----
> > > diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> > > index 1bfeb160c5b1..da9309ff80d7 100644
> > > --- a/drivers/perf/arm-cci.c
> > > +++ b/drivers/perf/arm-cci.c
> > > @@ -1692,19 +1692,18 @@ static int cci_pmu_probe(struct platform_device
> > > *pdev)
> > >          raw_spin_lock_init(&cci_pmu->hw_events.pmu_lock);
> > >          mutex_init(&cci_pmu->reserve_mutex);
> > >          atomic_set(&cci_pmu->active_events, 0);
> > > -       cci_pmu->cpu = get_cpu();
> > > +       cci_pmu->cpu = -1; /* Avoid races until hotplug notifier is alive */
> > > 
> > >          ret = cci_pmu_init(cci_pmu, pdev);
> > 
> > So at this point we've registered the PMU with perf, so I think we're open
> > to userspace. Given that things like pmu_cpumask_attr_show() call
> > cpumask_of(cci_pmu->cpu), having a cpu of -1 seems like a bad idea.
> > 
> > Why not just use the _cpuslocked() notifier registration functions so that
> > we don't need to disable preemption?
> 
> Because that alone doesn't necessarily help, but what I failed to grasp is
> the implication that in order to do it you need to manually take the hotplug
> lock, and if you do *that* in the right places, it removes the race
> condition altogether. Now that I've made sense of it, I think that's
> actually the only valid way to solve the problem. Let me spin a proper
> patch...

Yeah, sorry for being unhelpfully vague there. I meant using the
_cpuslocked() calls in conjunction with cpus_read_lock().

I think at least the DSU PMU driver is also broken in this area.

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
