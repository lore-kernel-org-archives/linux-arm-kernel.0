From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 15:44:36 +0000
Subject: [PATCH] arm64: percpu: Make this_cpu accessors pre-empt safe
In-Reply-To: <1426776751-20526-1-git-send-email-steve.capper@linaro.org>
References: <1426776751-20526-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20150319154435.GC25967@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

Thanks for putting this together!

On Thu, Mar 19, 2015 at 02:52:31PM +0000, Steve Capper wrote:
> this_cpu operations were implemented for arm64 in:
>  5284e1b arm64: xchg: Implement cmpxchg_double
>  f97fc81 arm64: percpu: Implement this_cpu operations
> 
> Unfortunately, it is possible for pre-emption to take place between
> address generation and data access. This can lead to cases where data
> is being manipulated by this_cpu for a different CPU than it was
> called on. Which effectively breaks the spec.
> 
> This patch disables pre-emption for the this_cpu operations
> guaranteeing that address generation and data manipulation.

Shouldn't that last sentence end with "occur on the same CPU", or
something like that?

[...]

> +/*
> + * Modules aren't allowed to use preempt_enable_no_resched, and it is
> + * undef'ed. If we are unable to use preempt_enable_no_resched, then
> + * fallback to the standard preempt_enable.
> + */
> +#ifdef preempt_enable_no_resched
> +#define __pcp_preempt_enable()	preempt_enable_no_resched()
> +#else
> +#define __pcp_preempt_enable()	preempt_enable()
> +#endif /* preempt_enable_no_resched */

I think it would be worth mentioning in the comment why we want to use
preempt_enable_no_resched where possible (e.g. read-modify-cmpxchg
sequences where we want to have as few retries as possible).

Other than those points, the patch looks good to me, feel free to add:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

It's a shame there don't seem to be any this_cpu_* self-tests; I've
booted a kernel with this applied, but I didn't have anything that
exploded without this, so I'd feel uneasy giving a Tested-by.

Mark.
