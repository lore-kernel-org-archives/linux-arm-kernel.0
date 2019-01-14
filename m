Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F010C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:03:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006BC20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XoRbM9kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006BC20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BiTCIx1c6Z/l+PWEPd3bGY3Nr4+oHF64XrCiBFVZNp4=; b=XoRbM9klH2aFXG
	TJuqg/azNt4S59t6ir6FQKrN3ruSgXR+OvwLZFSWnf2aL6th137pqNWQCAEopFiqRxo9x8S37OX5T
	arjZcCS2NOUfNPUBRePAwd8Y5fPhD/pqMOHOVrT8lkcNNpGSgSCs7OwF2eqn8IImaO3wb/p3uaP7M
	UNMvld2MPP4C1RR52ARqlCGKCvjEudwdc8ptt/ZdFW93GO8beXCRXZTGUrl8PnuJUDFNwu869xUeJ
	hZhxsYqUJ+5tAzNhYv1VoVs3pUHsiZg5FT362imWWcchgH8S2TLsfsXZsI7b6TyLsZyGnYZQR8Fl6
	k2b1SlDmAd1edYLLpgFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0xr-00057w-Pr; Mon, 14 Jan 2019 12:03:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0xo-000579-7K
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 12:03:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCFB280D;
 Mon, 14 Jan 2019 04:03:29 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE3F3F5BD;
 Mon, 14 Jan 2019 04:03:28 -0800 (PST)
Subject: Re: [RFC PATCH v2 1/2] uaccess: Check no rescheduling function is
 called in unsafe region
To: Julien Thierry <julien.thierry@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-2-git-send-email-julien.thierry@arm.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <907e51b7-10da-c5cb-058f-2c34ba2c8abd@arm.com>
Date: Mon, 14 Jan 2019 12:03:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543845318-24543-2-git-send-email-julien.thierry@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_040332_272212_E381FB1C 
X-CRM114-Status: GOOD (  27.76  )
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
Cc: peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
 mingo@redhat.com, james.morse@arm.com, hpa@zytor.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 03/12/2018 13:55, Julien Thierry wrote:
> While running a user_access regions, it is not supported to reschedule.
> Add an overridable primitive to indicate whether a user_access region is
> active and check that this is not the case when calling rescheduling
> functions.
> 
> Also, add a comment clarifying the behaviour of user_access regions.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> ---
>  include/linux/kernel.h  |  6 ++++--
>  include/linux/uaccess.h | 11 +++++++++++
>  kernel/sched/core.c     | 19 +++++++++++++++++++
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> I'm not sure these are the best locations to check this but I was hoping
> this patch could start the discussion.
> 
> Should I move the check? Should I add a config option to conditionally
> build those checks?
> 

I was going to say it's already under DEBUG_ATOMIC_SLEEP, but that's only
true for the __might_sleep() bit actually.

I think it'd make sense to blanket that under a config, but using
DEBUG_ATOMIC_SLEEP for that is a bit too much. What about a
DEBUG_UACCESS_SLEEP?

> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d6aac75..fe0e984 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -237,11 +237,13 @@
>  struct pt_regs;
>  struct user;
> 
> +extern void __might_resched(const char *file, int line);
>  #ifdef CONFIG_PREEMPT_VOLUNTARY
>  extern int _cond_resched(void);
> -# define might_resched() _cond_resched()
> +# define might_resched() \
> +	do { __might_resched(__FILE__, __LINE__); _cond_resched(); } while (0)
>  #else
> -# define might_resched() do { } while (0)
> +# define might_resched() __might_resched(__FILE__, __LINE__)>  #endif
> 
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index efe79c1..50adb84 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -266,6 +266,13 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
>  #define probe_kernel_address(addr, retval)		\
>  	probe_kernel_read(&retval, addr, sizeof(retval))
> 
> +/*
> + * user_access_begin() and user_access_end() define a region where
> + * unsafe user accessors can be used.
> + * During execution of this region, no sleeping functions should be called.
> + * Exceptions and interrupt shall exit the user_access region and re-enter it
> + * when returning to the interrupted context.
> + */

I would first have the bit about exceptions, then mention sleeping and add
something along the lines of

"[...] no sleeping functions should be called - we rely on exception
handling to take care of the user_access status for us, but that doesn't
happen when directly calling schedule()."

My wording's not the best but I just want something to point out *why*
sleeping ain't okay.

>  #ifndef user_access_begin
>  #define user_access_begin() do { } while (0)
>  #define user_access_end() do { } while (0)
> @@ -273,6 +280,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
>  #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
>  #endif
> 
> +#ifndef unsafe_user_region_active
> +#define unsafe_user_region_active()	false
> +#endif
> +
>  #ifdef CONFIG_HARDENED_USERCOPY
>  void usercopy_warn(const char *name, const char *detail, bool to_user,
>  		   unsigned long offset, unsigned long len);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6fedf3a..03f53c8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3289,6 +3289,13 @@ static inline void schedule_debug(struct task_struct *prev)
>  		__schedule_bug(prev);
>  		preempt_count_set(PREEMPT_DISABLED);
>  	}
> +
> +	if (unlikely(unsafe_user_region_active())) {
> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> +		       prev->comm, prev->pid, preempt_count());
> +		dump_stack();
> +	}
> +
>  	rcu_sleep_check();
> 
>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> @@ -6151,6 +6158,18 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  EXPORT_SYMBOL(___might_sleep);
>  #endif
> 
> +void __might_resched(const char *file, int line)
> +{
> +	if (!unsafe_user_region_active())
> +		return;
> +
> +	printk(KERN_ERR
> +		"BUG: rescheduling function called from user access context at %s:%d\n",
> +			file, line);
> +	dump_stack();
> +}

So this check is "careful, things might go bad" and the schedule_debug()
one is "things went bad". IIUC we'll always get this warning when we hit
the schedule_debug() one. I was going to suggest only keeping one of them,
but I think both hold value.

> +EXPORT_SYMBOL(__might_resched);
> +
>  #ifdef CONFIG_MAGIC_SYSRQ
>  void normalize_rt_tasks(void)
>  {
> --
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
