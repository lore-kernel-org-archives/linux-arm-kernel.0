Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71D7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882D520836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R0tkGZqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882D520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4LGPWnKs9qR0y2fydWt0xriMXklcsSnagNmCPBDT7ok=; b=R0tkGZqGTt1c/2
	n/hJT7Vm4xvX2EFS4CtM2AqmhhNintOh7Sa4C6fgfCpS+z/FBJOblcOkH/XKeIOwy5n5m8Q9Y+C/6
	lGncvttZhULDaAO5fTe/XDWizEhhDD3j5HlyL1udy0nL0Ys9vS6J2HzxBS/kogr73Mm4bgh/mL8IW
	g8nWLf0jJx8sR6jJvFr/DiflSI0UBr9wFR32ZGtvzE17Us6fhaHm0TWEljfBoIAsmaWGLERLxqcYl
	kob+LMytYHTLA0JGIU6qI36FBd5QifxAF1vEJDTiHB03FmdpsRQXN8AbOKZr7gT4Vmyen2iVvMT1u
	H+kuBcav5IPdWi7WazPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtv5Y-0008EE-SS; Wed, 13 Feb 2019 14:00:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtv5U-0008A4-Sy
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:00:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E76DE80D;
 Wed, 13 Feb 2019 06:00:31 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B7C43F557;
 Wed, 13 Feb 2019 06:00:29 -0800 (PST)
Date: Wed, 13 Feb 2019 14:00:26 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213140025.GB6346@brain-police>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213131720.GU32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_060032_947872_1D68E9C6 
X-CRM114-Status: GOOD (  19.70  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, valentin.schneider@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Peter,

On Wed, Feb 13, 2019 at 02:17:20PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 10:50:21AM +0000, Julien Thierry wrote:
> > On 13/02/2019 10:35, Peter Zijlstra wrote:
> > > On Tue, Feb 12, 2019 at 09:15:13AM +0000, Julien Thierry wrote:
> > > 
> > >>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > >>>>> index a674c7db..b1bb7e9 100644
> > >>>>> --- a/kernel/sched/core.c
> > >>>>> +++ b/kernel/sched/core.c
> > >>>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
> > >>>>>  		__schedule_bug(prev);
> > >>>>>  		preempt_count_set(PREEMPT_DISABLED);
> > >>>>>  	}
> > >>>>> +
> > >>>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
> > >>>>> +	    unlikely(unsafe_user_region_active())) {
> > >>>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> > >>>>> +		       prev->comm, prev->pid, preempt_count());
> > >>>>> +		dump_stack();
> > >>>>> +	}
> > >>>>> +
> > >>>>>  	rcu_sleep_check();
> > >>>>>
> > >>>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> > > 
> > >> I guess I'll drop the might_resched() part of this patch if that sounds
> > >> alright.
> > > 
> > > I'm still confused by the schedule_debug() part. How is that not broken?
> > 
> > Hmmm, I am not exactly sure which part you expect to be broken, I guess
> > it's because of the nature of the uaccess unsafe accessor usage.
> > 
> > Basically, the following is a definite no:
> > 	if (user_access_begin(ptr, size)) {
> > 
> > 		[...]
> > 
> > 		//something that calls schedule
> > 
> > 		[...]
> > 
> > 		user_access_end();
> > 	}
> > 	
> > 
> > However the following is fine:
> > 
> > - user_access_begin(ptr, size)
> > - taking irq/exception
> > - get preempted
> 
> This; how is getting preempted fundamentally different from scheduling
> ourselves?

The difference is because getting preempted in the sequence above is
triggered off the back of an interrupt. On arm64, and I think also on x86,
the user access state (SMAP or PAN) is saved and restored across exceptions
but not across context switch. Consequently, taking an irq in a
user_access_{begin,end} section and then scheduling is fine, but calling
schedule directly within such a section is not.

Julien -- please yell if I've missed some crucial detail, but I think that's
the gist of what we're trying to describe here.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
