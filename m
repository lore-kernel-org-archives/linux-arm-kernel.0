Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB1C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:07:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FB2222C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uWrNHdlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FB2222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CiX8lW9UrtJz/eEqKdj8YeUghLvcCGgf7cXd1gZLttk=; b=uWrNHdlgSmQLTP
	XJZFy9pXC8ctjRCupgSTLHUpY/+QNW+Ho/hIChcFHVOH0+XkI0J6q9aBtKtadPOdRGvwArds8NmHJ
	Ka9eYGYl+PsR1N+b0oWKoyoaSSqZD7ktOzEw2TTlEPJb7VftpBD8gOuzfvSOc07rpxZvHPkMGcIRT
	+JAXV4ahYdMIqfnLs799Vadl6WV4lVU4CaXcohwXCnj1mbG5ylTa8jeerBFJDRZZ0JdE4S+geXdFJ
	vafGvWu+oZR9kVhbhDLPdBZGN7yvQm1nkCuG779kSGZT/C8EVwoQe1qwjZ5HuLyF1BrM0l9vcq6cu
	bv/sFAP3024w+TTGqRzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvCI-0002bX-GH; Wed, 13 Feb 2019 14:07:34 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvCF-0002ax-5G
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:07:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B8D080D;
 Wed, 13 Feb 2019 06:07:30 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 111273F557;
 Wed, 13 Feb 2019 06:07:25 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <01b58beb-c1e7-3205-031a-39a25e94e11e@arm.com>
Date: Wed, 13 Feb 2019 14:07:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213140025.GB6346@brain-police>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_060731_209598_4DA00F87 
X-CRM114-Status: GOOD (  20.02  )
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
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 valentin.schneider@arm.com, mingo@redhat.com, james.morse@arm.com,
 hpa@zytor.com, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 13/02/2019 14:00, Will Deacon wrote:
> Hi Peter,
> 
> On Wed, Feb 13, 2019 at 02:17:20PM +0100, Peter Zijlstra wrote:
>> On Wed, Feb 13, 2019 at 10:50:21AM +0000, Julien Thierry wrote:
>>> On 13/02/2019 10:35, Peter Zijlstra wrote:
>>>> On Tue, Feb 12, 2019 at 09:15:13AM +0000, Julien Thierry wrote:
>>>>
>>>>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>>>>> index a674c7db..b1bb7e9 100644
>>>>>>>> --- a/kernel/sched/core.c
>>>>>>>> +++ b/kernel/sched/core.c
>>>>>>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
>>>>>>>>  		__schedule_bug(prev);
>>>>>>>>  		preempt_count_set(PREEMPT_DISABLED);
>>>>>>>>  	}
>>>>>>>> +
>>>>>>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
>>>>>>>> +	    unlikely(unsafe_user_region_active())) {
>>>>>>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
>>>>>>>> +		       prev->comm, prev->pid, preempt_count());
>>>>>>>> +		dump_stack();
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>>  	rcu_sleep_check();
>>>>>>>>
>>>>>>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
>>>>
>>>>> I guess I'll drop the might_resched() part of this patch if that sounds
>>>>> alright.
>>>>
>>>> I'm still confused by the schedule_debug() part. How is that not broken?
>>>
>>> Hmmm, I am not exactly sure which part you expect to be broken, I guess
>>> it's because of the nature of the uaccess unsafe accessor usage.
>>>
>>> Basically, the following is a definite no:
>>> 	if (user_access_begin(ptr, size)) {
>>>
>>> 		[...]
>>>
>>> 		//something that calls schedule
>>>
>>> 		[...]
>>>
>>> 		user_access_end();
>>> 	}
>>> 	
>>>
>>> However the following is fine:
>>>
>>> - user_access_begin(ptr, size)
>>> - taking irq/exception
>>> - get preempted
>>
>> This; how is getting preempted fundamentally different from scheduling
>> ourselves?
> 
> The difference is because getting preempted in the sequence above is
> triggered off the back of an interrupt. On arm64, and I think also on x86,
> the user access state (SMAP or PAN) is saved and restored across exceptions
> but not across context switch. Consequently, taking an irq in a
> user_access_{begin,end} section and then scheduling is fine, but calling
> schedule directly within such a section is not.
> 
> Julien -- please yell if I've missed some crucial detail, but I think that's
> the gist of what we're trying to describe here.
> 

Yes, this summarizes things correctly. Thanks!

I might also stress out that this limitation is already existing for x86
(and is in the arm64 patches picked by Catalin for 5.1), as was
discussed in here:

https://lkml.org/lkml/2018/11/23/430

So this patch is not introducing new semantics, it is only making
existing ones explicit.

If the current state is not good, we need to re-discuss the semantics of
user_access regions.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
