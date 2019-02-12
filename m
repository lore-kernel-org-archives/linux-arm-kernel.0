Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55602C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242A621773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xc1wtDkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242A621773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bsUUUIFvTfgrBg9au/slemVKsu7wb+27OsMnqfUhOGc=; b=Xc1wtDkm8AlBz+
	pgdutJd0UaVqwEYl+O3GNeuesMnK3XQE+Vv8ymh4X5bHq89DOvuZenZ4/4FpdJ2WUws2wvXYbC5eb
	h9y0fuuJb4odkbyVSVi5P/0GhqaDK06IG1A1H18R5MgF0Rrr6nCXFfxSnk2U2tmKKivNc+SECDo66
	qvdzjBOqKIcbB/3ZLj1cq15OiOF0nO4dmbIDF4QCAT7qN5smXTiZ22g4wqfmbn2FQSWoeb+se4qeC
	W5Q1SgCG0gjZ8YtOJy+XHb4gkKdEtROMqejcbxTMerQnba7RW9nNWpK7Is9ATUwRmC48NnXFavM5J
	Usszr4K/JNy3JnT97M4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUA5-0007k9-F4; Tue, 12 Feb 2019 09:15:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUA1-0007ij-Vn
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:15:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF72DEBD;
 Tue, 12 Feb 2019 01:15:18 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6843F557;
 Tue, 12 Feb 2019 01:15:16 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
Date: Tue, 12 Feb 2019 09:15:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190211135159.GC32511@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_011526_044629_3F92A809 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, james.morse@arm.com, hpa@zytor.com,
 valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 11/02/2019 13:51, Peter Zijlstra wrote:
> On Mon, Feb 11, 2019 at 02:45:27PM +0100, Ingo Molnar wrote:
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index a674c7db..b1bb7e9 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
>>>  		__schedule_bug(prev);
>>>  		preempt_count_set(PREEMPT_DISABLED);
>>>  	}
>>> +
>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
>>> +	    unlikely(unsafe_user_region_active())) {
>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
>>> +		       prev->comm, prev->pid, preempt_count());
>>> +		dump_stack();
>>> +	}
>>> +
>>>  	rcu_sleep_check();
>>>
>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
>>> @@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>>>  EXPORT_SYMBOL(___might_sleep);
>>>  #endif
>>>
>>> +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
>>> +void __might_resched(const char *file, int line)
>>> +{
>>> +	if (!unsafe_user_region_active())
>>> +		return;
>>
>> Could you please more clearly explain why you want/need an exception from 
>> the __might_resched() debug warning?

So, the scenarios I'm trying to avoid are of the following flavour:

	if (user_access_begin(ptr, size)) {

		[...]

		// Calling a function that might call schedule()

		[...]
		user_access_end();
	}


The thing is, as I understand, not all function that call schedule() are
annotated with might_resched(), and on the other hand, not every time we
call a function that might_resched() will it call schedule().

Now with Peter's remark I think I might have been overzealous.

> 
> In specific; how is the addition in schedule_debug() not triggering on
> PREEMPT=y kernels?
> 
> If code is preemptible, you can (get) schedule(d). If it is not
> preemptible; you do not need these additional tests.
> 

Yes that sounds right, might_resched() only potentially reschedules if
in a suitable context, so best case I issue two warnings, worst case I
actually be warn when the caller took care to disable preemption or
interrupts before calling a might_resched().

I guess I got a bit confused with might_sleep() which is "if you call
this in the wrong context I warn" whereas might_resched() is just "if
you call this in preemptible context, lets resched".

I guess I'll drop the might_resched() part of this patch if that sounds
alright.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
