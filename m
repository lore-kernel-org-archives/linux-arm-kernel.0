Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50639C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:48:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2093C2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X630zWLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2093C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JmOincoRbqmwLPNAogDwqCgN+ywVOu504gJU4uGhcAo=; b=X630zWLjHeLF4r
	mzez8EHR5/fOtB3xiZRLTEdTmJMLDQmc3ctP4FOhdcZrBMNOSqRaIOnF0XkL0/zE8PRTKsr3x56Ys
	W+Nux+xI62knhEIzbJ1xcnx0XRMxlRbYcu2x1aAtZZoW4OU2RqLRW8ickXMpBnNvJ1Z9GInB40ITJ
	/vLBgpbbSRBs67l6UgIUeNL3tAz2bdy4D8rXXIbZsjWOlllJvotNBFSooRKtyeireQ3F9heFSbwf+
	3NyCMlvqL0quDX1XkKuyJkOwx6BReSZqw9bpY8enALvkXStg2xdJVzzXFEqR8FvTODDJbY0q2z+rP
	squq7UtbcZS0BSA9P9fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMqk-0007dp-V5; Mon, 10 Dec 2018 14:47:58 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMqh-0007dV-T1; Mon, 10 Dec 2018 14:47:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6D2592075BE7B; Mon, 10 Dec 2018 15:47:54 +0100 (CET)
Date: Mon, 10 Dec 2018 15:47:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
Message-ID: <20181210144754.GO5289@hirez.programming.kicks-ass.net>
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
 <20181210140703.GM5289@hirez.programming.kicks-ass.net>
 <9303a6cf-24af-2f31-9fbd-8c1ecdd5e4f4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9303a6cf-24af-2f31-9fbd-8c1ecdd5e4f4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, mingo@kernel.org, Qian Cai <cai@lca.pw>,
 longman@redhat.com, akpm@linux-foundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 02:19:53PM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 10/12/2018 14:07, Peter Zijlstra wrote:
> [...]
> > ---
> >  kernel/cpu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 91d5c38eb7e5..e1ee8caf28b5 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
> >  
> >  void lockdep_assert_cpus_held(void)
> >  {
> > +	if (system_state < SYSTEM_RUNNING)
> > +		return;
> >  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
> >  }
> >  
> 
> Kinda hijacking the thread here - is that something we'd want to replace 
> 
>     40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")
> 
> with?
>  

Possibly; and I have vague memories of other people running into this
same thing too.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
