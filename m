Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF2CC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:50:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E195821901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hTJyR1aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E195821901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ekBshGQoka3kDNBsCeyYrSYIUGhrIZDYZcfAbDfHTaU=; b=hTJyR1aUpzE10z
	m9Q0ZsCszAz9Yk1wdAntrmj1p3dIwR0dVaKyldmcO0u84FAmmstcugWVP/U+0vBOGiKAg9Y2+SHz/
	ig1KQMOWslGaBc0SmbYYF9LeoYIXae2L34DRpOFjiJaA86wA9eqnCV6r/rD76ztvMXX6ucLTCF6zP
	9D1F2l+n/VP7TsQGJqGsmiLFe2s6/b36HD8QGH7dgWA5/UzEBhdTRfWXVQ7a96mt+JHJx2d+d6I3f
	g3qo8JyXhNjji+2SyYe3ZG/eX1C0eauWLE3NLwTrZKyIGoxBjWGmE26hsX2/t2pA4pA1m4N4qDUZH
	XKulMbVtS1ZhtyL4zCAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gts7c-0001Ra-9E; Wed, 13 Feb 2019 10:50:32 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gts7Y-0001RE-OT
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:50:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F295A78;
 Wed, 13 Feb 2019 02:50:27 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45F683F575;
 Wed, 13 Feb 2019 02:50:24 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To: Peter Zijlstra <peterz@infradead.org>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
Date: Wed, 13 Feb 2019 10:50:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213103553.GO32494@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_025028_801480_DAF738C5 
X-CRM114-Status: GOOD (  16.51  )
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
 valentin.schneider@arm.com, mingo@redhat.com, james.morse@arm.com,
 hpa@zytor.com, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 13/02/2019 10:35, Peter Zijlstra wrote:
> On Tue, Feb 12, 2019 at 09:15:13AM +0000, Julien Thierry wrote:
> 
>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>> index a674c7db..b1bb7e9 100644
>>>>> --- a/kernel/sched/core.c
>>>>> +++ b/kernel/sched/core.c
>>>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
>>>>>  		__schedule_bug(prev);
>>>>>  		preempt_count_set(PREEMPT_DISABLED);
>>>>>  	}
>>>>> +
>>>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
>>>>> +	    unlikely(unsafe_user_region_active())) {
>>>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
>>>>> +		       prev->comm, prev->pid, preempt_count());
>>>>> +		dump_stack();
>>>>> +	}
>>>>> +
>>>>>  	rcu_sleep_check();
>>>>>
>>>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> 
>> I guess I'll drop the might_resched() part of this patch if that sounds
>> alright.
> 
> I'm still confused by the schedule_debug() part. How is that not broken?

Hmmm, I am not exactly sure which part you expect to be broken, I guess
it's because of the nature of the uaccess unsafe accessor usage.

Basically, the following is a definite no:
	if (user_access_begin(ptr, size)) {

		[...]

		//something that calls schedule

		[...]

		user_access_end();
	}
	

However the following is fine:

- user_access_begin(ptr, size)
- taking irq/exception
- get preempted
- get resumed at some point in time
- restore state + eret
- user_access_end()

That's because exceptions/irq implicitly "suspend" the user access
region. (That's what I'm trying to clarify with the comment)
So, unsafe_user_region_active() should return false in a irq/exception
context.

Is this what you were concerned about? Or there still something that
might be broken?

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
