From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 13 Apr 2017 20:12:12 +0200
Subject: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
In-Reply-To: <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 01:35:04AM +0400, Yury Norov wrote:

> +++ b/arch/arm64/include/asm/qspinlock.h
> @@ -0,0 +1,20 @@
> +#ifndef _ASM_ARM64_QSPINLOCK_H
> +#define _ASM_ARM64_QSPINLOCK_H
> +
> +#include <asm-generic/qspinlock_types.h>
> +
> +#define	queued_spin_unlock queued_spin_unlock
> +/**
> + * queued_spin_unlock - release a queued spinlock
> + * @lock : Pointer to queued spinlock structure
> + *
> + * A smp_store_release() on the least-significant byte.
> + */
> +static inline void queued_spin_unlock(struct qspinlock *lock)
> +{
> +	smp_store_release((u8 *)lock, 0);
> +}

I'm afraid this isn't enough for arm64. I suspect you want your own
variant of queued_spin_unlock_wait() and queued_spin_is_locked() as
well.

Much memory ordering fun to be had there.
