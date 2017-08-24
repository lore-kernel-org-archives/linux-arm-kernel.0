From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 24 Aug 2017 10:49:06 +0200
Subject: [RFC 3/3] sched: depend on 64BIT_ATOMIC_ACCESS to determine if
 to use min_vruntime_copy
In-Reply-To: <1503553377-3646-4-git-send-email-hoeun.ryu@gmail.com>
References: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
 <1503553377-3646-4-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <20170824084906.mtmj6rz4igo63dl5@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 02:42:57PM +0900, Hoeun Ryu wrote:
> +#ifndef CONFIG_64BIT_ATOMIC_ALIGNED_ACCESS
>  	u64 min_vruntime;
> -#ifndef CONFIG_64BIT
> +#else
> +	u64 min_vruntime __attribute__((aligned(sizeof(u64))));
> +#endif

That's stupid, just make sure your platform defines u64 as naturally
aligned when you have this 64BIT_ATOMIC foo.

Also, please try and dig out more 32bit archs that can use this and make
sure to include performance numbers to justify this extra cruft.
